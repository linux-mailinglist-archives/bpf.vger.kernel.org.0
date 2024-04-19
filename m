Return-Path: <bpf+bounces-27255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142D78AB5ED
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFE128283A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B9513CFA8;
	Fri, 19 Apr 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="jJDRjB6h"
X-Original-To: bpf@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B21F954;
	Fri, 19 Apr 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557437; cv=none; b=RBZX7U8vErAeTow9K4ATicaLawTc5XC+qYzTdij2i5gpfqMQJla/VDX2NKquE+eHNVcK7wFwDvJBTCZT+6rARHSSYOa/fviw/xipp7dVIvAB4xILuqoWHFfHuHmsJYJoogdZ1qY9Sbp55N/U+i4YoRIFCZyv3mVKE1qmnIKjFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557437; c=relaxed/simple;
	bh=ni415vXBSQWpxHe1qmv5NC8IZZQ/8VhKbkgw8RHVt20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOxVh3LWFUh/QS2ZcjJ0OZBGZPrgA0JThPizfFLgXMYVoxsEvyWf+xtlfgrMTQi1U1QX4exoLfzWvNC+U+2fKfFSvtU2Pvu/DcWctco2bLx1HWKRtMh5EovQtObkTGmjjUyr34IDi5/YtSELgQtRvwifiGysy5hzA8nOeiD58nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=jJDRjB6h; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Date: Fri, 19 Apr 2024 23:01:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1713556871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAdcR3T0V7JcxVXoeeTyJ39EbDgLKFV2olueuASaQ9Y=;
	b=jJDRjB6h4NzzcxMljJYYa1PsI5ExoTfIrt0m4No5jVaNOWHVPf2USdZKZTCYLQPuIdpfnA
	91brI4cegABsQa6HljAjr4nhHsKZEbM4Mab4TAkaY7uz0nu8uydyBGs46cVmv+3nLxhYT4
	kzV4ygqlKUxXOytErs2mPPwFu5kvA98=
From: Andrey Kalachev <kalachev@swemel.ru>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>,
	andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, jmorris@namei.org, john.fastabend@gmail.com,
	kafai@fb.com, kpsingh@chromium.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	serge@hallyn.com, songliubraving@fb.com,
	syzkaller-bugs@googlegroups.com, yhs@fb.com, miklos@szeredi.hu,
	linux-unionfs@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: general protection fault in security_inode_getattr
Message-ID: <ZiLNhuh0v1F9+lns@ural>
References: <0000000000008caae305ab9a5318@google.com>
 <ZgrwugCEDH2fLJXK@ural>
 <CAOQ4uxj4E1_iDn9oeP71sbs01RNs5LojDpuPdvwHyYc55fKHHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cXhKTs48z7E85Dwm"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj4E1_iDn9oeP71sbs01RNs5LojDpuPdvwHyYc55fKHHQ@mail.gmail.com>


--cXhKTs48z7E85Dwm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 02, 2024 at 07:01:57PM +0300, Amir Goldstein wrote:
>On Mon, Apr 1, 2024 at 8:43 PM Andrey Kalachev <kalachev@swemel.ru> wrote:
>>
>> On Wed, Jul 29, 2020 at 01:23:18PM -0700, syzbot wrote:
>> >Hello,
>> >
>> >syzbot found the following issue on:
>> >
>> >HEAD commit:    92ed3019 Linux 5.8-rc7
>> >git tree:       upstream
>> >console output: https://syzkaller.appspot.com/x/log.txt?x=140003ac900000
>> >kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
>> >dashboard link: https://syzkaller.appspot.com/bug?extid=f07cc9be8d1d226947ed
>> >compiler:       gcc (GCC) 10.1.0-syz 20200507
>> >
>> >Unfortunately, I don't have any reproducer for this issue yet.
>> >
>> >IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> >Reported-by: syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com
>> >
>> >general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
>> >KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>> >CPU: 0 PID: 9214 Comm: syz-executor.3 Not tainted 5.8.0-rc7-syzkaller #0
>> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> >RIP: 0010:d_backing_inode include/linux/dcache.h:549 [inline]
>> >RIP: 0010:security_inode_getattr+0x46/0x140 security/security.c:1276
>> >Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 04 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 08 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
>> >RSP: 0018:ffffc9000d41f638 EFLAGS: 00010206
>> >RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f539000
>> >RDX: 000000000000000c RSI: ffffffff8354f8ee RDI: 0000000000000060
>> >RBP: ffffc9000d41f810 R08: 0000000000000001 R09: ffff88804edc2dc8
>> >R10: 0000000000000000 R11: 00000000000ebc58 R12: ffff888089f10170
>> >R13: ffffc9000d41f810 R14: 00000000000007ff R15: 0000000000000000
>> >FS:  00007f3599717700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
>> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >CR2: 0000001b2c12c000 CR3: 0000000099919000 CR4: 00000000001406f0
>> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >Call Trace:
>> > vfs_getattr+0x22/0x60 fs/stat.c:121
>> > ovl_copy_up_one+0x13b/0x1870 fs/overlayfs/copy_up.c:850
>> > ovl_copy_up_flags+0x14b/0x1d0 fs/overlayfs/copy_up.c:931
>> > ovl_maybe_copy_up+0x140/0x190 fs/overlayfs/copy_up.c:963
>> > ovl_open+0xba/0x270 fs/overlayfs/file.c:147
>> > do_dentry_open+0x501/0x1290 fs/open.c:828
>> > do_open fs/namei.c:3243 [inline]
>> > path_openat+0x1bb9/0x2750 fs/namei.c:3360
>> > do_filp_open+0x17e/0x3c0 fs/namei.c:3387
>> > file_open_name+0x290/0x400 fs/open.c:1124
>> > acct_on+0x78/0x770 kernel/acct.c:207
>> > __do_sys_acct kernel/acct.c:286 [inline]
>> > __se_sys_acct kernel/acct.c:273 [inline]
>> > __x64_sys_acct+0xab/0x1f0 kernel/acct.c:273
>> > do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
>> > entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> >RIP: 0033:0x45c369
>> >Code: 8d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> >RSP: 002b:00007f3599716c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
>> >RAX: ffffffffffffffda RBX: 0000000000000700 RCX: 000000000045c369
>> >RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000440
>> >RBP: 000000000078bf30 R08: 0000000000000000 R09: 0000000000000000
>> >R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
>> >R13: 00007ffda41ffbef R14: 00007f35997179c0 R15: 000000000078bf0c
>> >Modules linked in:
>> >---[ end trace d1398a63985d3915 ]---
>> >RIP: 0010:d_backing_inode include/linux/dcache.h:549 [inline]
>> >RIP: 0010:security_inode_getattr+0x46/0x140 security/security.c:1276
>> >Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 04 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 08 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
>> >RSP: 0018:ffffc9000d41f638 EFLAGS: 00010206
>> >RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f539000
>> >RDX: 000000000000000c RSI: ffffffff8354f8ee RDI: 0000000000000060
>> >RBP: ffffc9000d41f810 R08: 0000000000000001 R09: ffff88804edc2dc8
>> >R10: 0000000000000000 R11: 00000000000ebc58 R12: ffff888089f10170
>> >R13: ffffc9000d41f810 R14: 00000000000007ff R15: 0000000000000000
>> >FS:  00007f3599717700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
>> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >CR2: 0000000020000440 CR3: 0000000099919000 CR4: 00000000001406f0
>> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >
>> >
>> >---
>> >This report is generated by a bot. It may contain errors.
>> >See https://goo.gl/tpsmEJ for more information about syzbot.
>> >syzbot engineers can be reached at syzkaller@googlegroups.com.
>> >
>> >syzbot will keep track of this issue. See:
>> >https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> Hello,
>>
>> I've found that the bug fixed by commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0af950f57fefabab628f1963af881e6b9bfe7f38
>> merged with mainline here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=be3c213150dc4370ef211a78d78457ff166eba4e
>>
>> Kernel release 6.5 include the fixed code.
>>
>> Hence, the stable kernels up to 6.5 still affected.
>> I've got early version (4.19.139) from syzbot report, here is the first time when been reported.
>> Maybe previous versions are also affected, I haven't checked it.
>>
>> I've only deal with stable 5.10 and 6.1, here I can confirm the issue.
>>
>> The tracing results showed that GPF caused by the dentry shared between two processes.
>> Suppose we have a regular file `A` onto lower overlayfs layer, metacopy=on.
>> P1 execute link syscall ( `A` link to `B`), P2 do open `B`.
>>
>>    P1          P2
>>
>>    sys_link
>>                sys_open
>>                  ovl_lookup B -- lookup non existent `B`, alloc `B` dentry
>>                    ovl_alloc_entry -- non existent file, zero filled ovl_entry
>>
>>      ovl_link -- link A to B, use same dentry `B`, dentry associated with
>>      `A`, lower layer file now.
>>
>>    sys_link -- return to userspace, zero filled ovl_entry `B` untouched
>>
>>                      ovl_open B, reuse the same dentry `B`
>>                        ovl_copy_up_one
>>                          ovl_path_lower
>>                            ovl_numlower(oe) -- return 0, numlower in zero filled ovl_entry `oe`
>>                          ovl_path_lower -- return zero filled `struct path`
>>                          vfs_getattr(struct path, ..)
>>                            security_inode_getattr(struct path, ...)
>>                              d_backing_inode(path->dentry) -- NULL dereference, GPF
>>
>> Stable kernel v6.1 can be easy fixed by 4 mainline commits transfer:
>>
>> 0af950f57fef ovl: move ovl_entry into ovl_inode
>> 163db0da3515 ovl: factor out ovl_free_entry() and ovl_stack_*() helpers
>> 5522c9c7cbd2 ovl: use ovl_numlower() and ovl_lowerstack() accessors
>> a6ff2bc0be17 ovl: use OVL_E() and OVL_E_FLAGS() accessors
>>
>> Just commit 5522c9c7cbd2 has conflict caused by
>> 4609e1f18e19c ("fs: port ->permission() to pass mnt_idmap").
>> It is enough to change mnt_idmap() call to mnt_user_ns(),
>> in the rejected hunk.
>
>Hi Andrey,
>
>I don't have time to review this backport series, but in my memory,
>these few commits were part of a much larger refactoring and
>I am almost positive that there are fix commits that mention
>Fixes: 0af950f57fef ("ovl: move ovl_entry into ovl_inode") in upstream kernel.
>
>If you do want to backport overlayfs changes to stable kernels, you should
>specify how you tested them and that should include at least running
>the latest fstests overlayfs tests.
>
>Thanks,
>Amir.

Hi Amir,

I gave up the idea of making backports series of upstream patches, I just did what Hillf Danton suggested here:

https://groups.google.com/g/syzkaller-bugs/c/xDcxFKSppfE/m/b38Tv7LoAAAJ .

This looks like a more universal solution, suitable for previous kernel versions, especially since the likelihood of such an error occurring is quite low.

I did regression testing with xfstests-dev + unionmount-testsuite on version 5.10.208 and found no additional failures.

Please take a look at the attached patch.

Thanks,
Andrey. 

--cXhKTs48z7E85Dwm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ovl-fix-general-protection-fault-in-security_inode_g.patch"

From: Andrey Kalachev <kalachev@swemel.ru>
Date: Fri, 19 Apr 2024 20:55:10 +0300
Subject: [PATCH] ovl: fix general protection fault in security_inode_getattr

general protection fault caused by dentry shared between two processes.
Suppose we have a regular file `A` onto lower overlayfs layer, metacopy=on.

Process P1 execute link syscall ( `A` link to `B`), P2 do open `B`.

P1         |  P2
-----------+--------------
sys_link   |
           | sys_open
           |   ovl_lookup B      (1)
           |     ovl_alloc_entry (2)
           |
  ovl_link |                     (3)
           |
           |
sys_link   |                     (4)
           |
           |     ovl_open B      (5)
           |       ovl_copy_up_one
           |         ovl_path_lower
           |           ovl_numlower(oe) (6)
           |         ovl_path_lower     (7)
           |           vfs_getattr(struct path, ..)
           |             security_inode_getattr(struct path, ...)
           |               d_backing_inode(path->dentry)

(1) P2 call ovl_lookup B, lookup non existent file `B`,
       new `B` dentry allocated.
(2) P2 call ovl_alloc_entry() in `non existent file` context,
       return zero filled ovl_entry.
(3) P1 make hardlink A -> B,
       now `B` dentry associated with lower layer file `A`.
(4) P1 return to userspace from `sys_link`,
       leave ovl_entry `B` unchanged (zeros).
(5) P2 continue open file behind dentry `B`.
(6) P2 ovl_numlower(oe) return 0,
       taken from zero filled ovl_entry `oe`
(7) P2 ovl_path_lower() return zero filled `struct path`, due numlower=0.
(8) P2 NULL dereference in d_backing_inode()

Since release v6.5 `ovl_entry` associated with inode and placed into
the `struct ovl_inode_params`.

Issue fixed at:
commit 0af950f57fef ("ovl: move ovl_entry into ovl_inode")

Solution, proposed by Hillf Danton, most common and suitable for
stable kernels before v6.5. The patch code is based on it.

Reported-by: syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/0000000000008caae305ab9a5318@google.com
Link: https://syzkaller.appspot.com/bug?extid=f07cc9be8d1d226947ed
Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
---
 fs/overlayfs/copy_up.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 65ac504595ba..b7352c43b673 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -879,6 +879,13 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 		return -EROFS;
 
 	ovl_path_lower(dentry, &ctx.lowerpath);
+
+	if (unlikely(!ctx.lowerpath.dentry)) {
+		/* syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com */
+		pr_err("prevention GPF in security_inode_getattr()\n");
+		return -EIO;
+	}
+
 	err = vfs_getattr(&ctx.lowerpath, &ctx.stat,
 			  STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
 	if (err)
-- 
2.30.2


--cXhKTs48z7E85Dwm--

