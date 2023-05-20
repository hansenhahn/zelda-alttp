ZELDA: Four Swords Script Editor (ZFSEditor) - Beta 1.1
+++++++++++++++++++++++++++++++++++++++++++++++++

ZFSEditor is a script editor for the game "The Legend of Zelda - A Link to the Past & Four Swords" for Gameboy Advance. It allows editing texts only for the "Four Swords" multiplayer game, not working for the texts from "A Link to the Past".

It features the following functionalities:

- Allows editing "Four Swords" scripts without any limitations, since its pointers are automatically updated;
- Live preview support, rendering a preview of text blocks whenever they're focused. Useful for checking whether texts passed the bounds of the dialog box;
- Compare with the reference ROM, where you can open both original and edited roms simultaneously, and see their differences. Useful for revisions;
- Search and replace functionalities, in case you want to edit specific words globally;
- UI miscellaneus customizations, such as customizing dialog box appearance and size, changing preview zoom levels, etc.

It was developed by Joapeer, and tested by Solid One (the person writing this readme). Its main purpose was for helping us adding a Four Swords portuguese brazilian translation counterpart to an existing "A Link to the Past" GBA translation, released back in 2013. We're also releasing it to the community, in the hopes that it might help someone else translating this game to other languages.

Works only for the american ROM "Legend of Zelda, The - A Link to the Past & Four Swords (USA)", with CRC32 of 8E91CD13.



Dependencies
+++++++++++++++++++++++++++++++++++++++++++++++++

Since this tool was developed in Java, the only dependency is having Java JRE installed, so you can open .jar files. I tried with Oracle Java 8 on Windows 10/11 and it worked just fine for me, but it should also work fine for other JVMs, such as OpenJDK.

That also means the tool is cross platform, so it should work fine on any operating system (Windows, Mac, Linux), as long as Java JRE is installed to it.



How to use it
+++++++++++++++++++++++++++++++++++++++++++++++++

Firstly, open ZFSEditor.jar, click on the "Open ROM" button, and open the american ROM. If you provided a valid rom (should be the american one), then you should see all its 10 internal scripts, each having a few dialog blocks.

Once you opened the rom, you can edit its texts freely. Whenever any text changes are made, the live preview at the right is updated accordingly. You can also adjust preview appearance, by changing its zoom levels, increasing/reducing numbers of columns and rows, and even change the border type.

The preview uses the same font used ingame, taking into consideration even changes made into its VWF routines. In theory, if you edit both the font and VWF in order to add, for example, chinese or vietnamese characters, the preview should work just like it is ingame.

During translations or revisions, you can also quick switch over different blocks by using shortcuts such as Ctrl+Tab to advance to the next block, or Ctrl+Shift+Tab to go back to the previous block. Useful for revisions where you want to move between multiple blocks without having to click on each of them with the mouse cursor.

You can also search and replace texts inside all scripts/blocks. To do so, simply click on either the "Find" or the "Replace" buttons. You can change search scope, change search direction between forward or backward, etc. The search/replace is case-sensitive, so searching for "this" or "This" will bring different results.

To save the changes you made, simply click on the "Save Changes" button. It'll automatically edit the text inside the rom, updating its text pointers accordingly.

Lastly, you can compare your edited ROM with the original one. To do so, click on the "Open Reference ROM" button, and open the original file. If done correctly, for each text block you'll see the original block on the left, and the edited one on the right. The tool also makes sure the original file remains untouched, so the left text fields are readonly. Might help a lot when reviewing translations from multiple translators and making sure everything is correct.



Contact
+++++++++++++++++++++++++++++++++++++++++++++++++

- Joapeer (joapeer@gmail.com)
- Solid_One (thesolidone@gmail.com)

You can also search for any of us on RH.net, either on discord or in their forums.