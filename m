Return-Path: <bpf+bounces-9334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57E793E0E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514752813F7
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B310792;
	Wed,  6 Sep 2023 13:50:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9B4417;
	Wed,  6 Sep 2023 13:50:33 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B6CF1;
	Wed,  6 Sep 2023 06:50:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500b66f8b27so6226265e87.3;
        Wed, 06 Sep 2023 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694008226; x=1694613026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0rHMbb28JEVAvppiCwj0pMeYOLoPvRIexSJL5HjCFQc=;
        b=W8xjLpIViGri+BHMhPIKWZXE/osoMieecCoF0S+5/d4dw/LUiZs+x8EcD6WPuK7iMa
         BabP3UfmfeHOujivF92RNtRwpW3rR2vO6RFcYNPGJnssGM3+FLYd8SKMyX85CJZQ4Mrx
         DpF5VMcDuz1UfMWmVUzVBzfcOI+CkeJbz+7ger9koukQjOAlmSJ2PBxDCBGeuV+Cbv2I
         SmJdyE44etx38LLFFxnB5FC9TBKL9Uet6A6JiOGtv30SWRwop9XJN3u6VuhGcfB8Ai4y
         3vP3Iw8qxKTt9hqEw9peMzvb0Fn2Z+I3y+EBhF95pbv919ft7qpZHmWoESlZq70973d4
         Z5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694008226; x=1694613026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rHMbb28JEVAvppiCwj0pMeYOLoPvRIexSJL5HjCFQc=;
        b=fgqws8uac49LKJFoyDayE8C7+3VbPaLW82SX4Fr48knvs5qU2NsFPgJ+f1MIX8NXNt
         FD1R+hwPSZbwtHHBSGrucLyWN0kTnQfvarYcm5iXJNScnr/44w3mqhEw7if6Gh0Uw3KF
         /laU4vrtbbhAUThL8AwMlsnZwNxQTBD31r31GN4xCczhq/sdAkb4Z2peMgMYYP8tjOqZ
         L6eQTiXNuyZbZT4xafU7T/EdDeeiXFgJ1m/lq1fyLVK86jgxZcqK+RJFv3m9EqgkE/50
         vTLCBvjhNbrv2eWkHFu3i367tnZbGDEFMEUGFoeGaH471qqTCmcV8F6VmRN4++djxfaw
         amHw==
X-Gm-Message-State: AOJu0YyStGrf8+K4sIPgnoEosgy/RnH4/q4GSYpjZ+eqQqeQVnD8JD93
	fNH4DQx2ghndWAeXcIXC/DE=
X-Google-Smtp-Source: AGHT+IHw41GBv8+hiiZ0XWyP6/M6cC3bLtXHzwG2WFgLJkg2VHGW5EO6ZGn6GYAE4BK4vyp1SV6i5g==
X-Received: by 2002:a05:6512:3d26:b0:4fb:8616:7a03 with SMTP id d38-20020a0565123d2600b004fb86167a03mr3274182lfv.4.1694008225838;
        Wed, 06 Sep 2023 06:50:25 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w4-20020aa7da44000000b0052241b8fd0bsm8442154eds.29.2023.09.06.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:50:25 -0700 (PDT)
Message-ID: <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] general protection fault in
 bpf_prog_offload_verifier_prep
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>, 
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  davem@davemloft.net, haoluo@google.com,
 hawk@kernel.org, john.fastabend@gmail.com,  jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org,  linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org,  sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com,  yonghong.song@linux.dev
Cc: sdf@google.com
Date: Wed, 06 Sep 2023 16:50:23 +0300
In-Reply-To: <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
References: <000000000000d97f3c060479c4f8@google.com>
	 <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-06 at 15:40 +0300, Eduard Zingerman wrote:
> On Sun, 2023-09-03 at 12:55 -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    fa09bc40b21a igb: disable virtualization features on 82=
580
> > git tree:       net
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13382fa8680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D634e05b4025=
da9da
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D291100dcb3219=
0ec02a8
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1529c4486=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15db0248680=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7ab461d84992/d=
isk-fa09bc40.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3ac6d43ab2db/vmli=
nux-fa09bc40.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/778d096a134e=
/bzImage-fa09bc40.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
> >=20
> > general protection fault, probably for non-canonical address 0xdffffc00=
00000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 1 PID: 5055 Comm: syz-executor625 Not tainted 6.5.0-syzkaller-0401=
2-gfa09bc40b21a #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/26/2023
> > RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.=
c:295
> > Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48=
 b8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 =
0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> > RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
> > RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
> > R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
> > FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  bpf_check+0x52f3/0xabd0 kernel/bpf/verifier.c:19762
> >  bpf_prog_load+0x153a/0x2270 kernel/bpf/syscall.c:2708
> >  __sys_bpf+0xbb6/0x4e90 kernel/bpf/syscall.c:5335
> >  __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
> >  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5437
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f7c0df78ea9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffde3592128 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7c0df78ea9
> > RDX: 0000000000000090 RSI: 0000000020000940 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000100000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.=
c:295
> > Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48=
 b8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 =
0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> > RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
> > RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
> > R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
> > FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess), 3 bytes skipped:
> >    0:	df 48 89             	fisttps -0x77(%rax)
> >    3:	fa                   	cli
> >    4:	48 c1 ea 03          	shr    $0x3,%rdx
> >    8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
> >    c:	0f 85 a1 00 00 00    	jne    0xb3
> >   12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
> >   19:	fc ff df
> >   1c:	4c 8b 65 10          	mov    0x10(%rbp),%r12
> >   20:	4c 89 e2             	mov    %r12,%rdx
> >   23:	48 c1 ea 03          	shr    $0x3,%rdx
> > * 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping inst=
ruction
> >   2b:	0f 85 93 00 00 00    	jne    0xc4
> >   31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
> >   38:	fc ff df
> >   3b:	4d                   	rex.WRB
> >   3c:	8b                   	.byte 0x8b
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >=20
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >=20
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >=20
> > If you want to overwrite bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >=20
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >=20
> > If you want to undo deduplication, reply with:
> > #syz undup
> >=20
>=20
> I have an explanation of why this error occurs, but I need an advice
> on how to fix it.

I think the fix should look as follows:

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3e4f2ec1af06..302e38bffffa 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -199,12 +199,11 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog =
*prog, struct net_device *n
        offload->netdev =3D netdev;
=20
        ondev =3D bpf_offload_find_netdev(offload->netdev);
+       if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev))=
 {
+               err =3D -EINVAL;
+               goto err_free;
+       }
        if (!ondev) {
-               if (bpf_prog_is_offloaded(prog->aux)) {
-                       err =3D -EINVAL;
-                       goto err_free;
-               }
-
                /* When only binding to the device, explicitly
                 * create an entry in the hashtable.
                 */

With the following reasoning: for offloaded programs offload device
should exist and it should not be a fake device create in !ondev branch.

Stanislav, could you please take a look? I think this is related to commit:
2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
=20
> Then NULL pointer deference occurs in the following function from offload=
.c:
>=20
>     int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
>     {
>         struct bpf_prog_offload *offload;
>         int ret =3D -ENODEV;
>    =20
>         down_read(&bpf_devs_lock);
>         offload =3D prog->aux->offload;
>         if (offload) {
>             ret =3D offload->offdev->ops->prepare(prog);
>                            ^^^^^^
>                            this pointer is NULL
>             offload->dev_state =3D !ret;
>         }
>         up_read(&bpf_devs_lock);
>    =20
>         return ret;
>     }
>=20
> # Short explanation
>=20
> (a) call chain bpf_prog_load -> bpf_prog_dev_bound_init -> __bpf_prog_dev=
_bound_init
>                -> __bpf_offload_dev_netdev_register
>     might insert an instance of struct bpf_offload_netdev with {.offdev =
=3D=3D NULL}
>     into hash table offload.c:offdevs;
> (b) call chain bpf_prog_load -> bpf_check -> bpf_prog_offload_verifier_pr=
ep
>     assumes that from (prog->aux->offload !=3D NULL)
>               follows (prog->aux->offload->offdev !=3D NULL)
>     which is not the case because of (a).
>=20
> # Long explanation
>=20
> The reproducer generated by testbot has the following structure:
> - in a loop call function execute_one(), which does the following
>   system calls in sequence:
>   - socket(AF_INET6, SOCK_RAW, IPPROTO_IGMP) =3D <some fd>
>   - ioctl(3, SIOCGIFINDEX, {ifr_name=3D"batadv_slave_1"}) =3D 0
>   - bpf(BPF_PROG_LOAD,
>         {prog_type=3DBPF_PROG_TYPE_XDP, ... prog_flags=3D0x40, prog_ifind=
ex=3D29, ...}) =3D -1 EINVAL
>     (referred to as program #1 below)
>   - socket(AF_INET6, SOCK_RAW, IPPROTO_IGMP) =3D <some fd>
>   - ioctl(4, SIOCGIFINDEX, {ifr_name=3D"batadv_slave_1"}) =3D 0
>   - bpf(BPF_PROG_LOAD,
>         {prog_type=3DBPF_PROG_TYPE_XDP, ... prog_flags=3D0, ... prog_ifin=
dex=3D29}) =3D -1 EINVAL
>     (referred to as program #2 below)
>=20
> The error occurs when second bpf call is processed.
> Interestingly, if sleep(1) is inserted somewhere between first and
> second bpf calls error does not occur:
>=20
>     @@ -1246,6 +1246,7 @@ void execute_one(void)
>        *(uint32_t*)0x200009cc =3D 4;
>        syscall(__NR_bpf, /*cmd=3D*/5ul, /*arg=3D*/0x20000940ul, /*size=3D=
*/0x90ul);
>        res =3D syscall(__NR_socket, /*domain=3D*/0xaul, /*type=3D*/3ul, /=
*proto=3D*/2);
>     +  // sleep(1); /* uncomment to hide the error */
>        if (res !=3D -1)
>          r[2] =3D res;
>        memcpy((void*)0x20000100, "batadv_slave_1\000\000", 16);
>=20
> ## Control flow when error occurs
>=20
> For program #1:
> - bpf_prog_load():
>   - bpf_prog_is_dev_bound(prog->aux) is true
>     - bpf_prog_dev_bound_init
>       - prog->aux->offload_requested is 0 (because of 0x40 prog_flags)
>       - __bpf_prog_dev_bound_init
>         - netdev is "batadv_slave_1"
>         - bpf_offload_find_netdev(offload->netdev) =3D=3D NULL,
>           (this is a lookup in hash table offload.c:offdevs)
>           which triggers a call to __bpf_offload_dev_netdev_register
>           - __bpf_offload_dev_netdev_register(NULL, offload->netdev)
>             registers struct bpf_offload_netdev with {.offdev =3D NULL}
>             for netdev "batadv_slave_1" in offload.c:offdevs hash table.
>=20
> For program #2:
> - bpf_prog_load():
>   - bpf_prog_is_dev_bound(prog->aux) is true
>     - bpf_prog_dev_bound_init
>       - prog->aux->offload_requested is 1 (because of 0x0 prog_flags)
>       - __bpf_prog_dev_bound_init
>         - netdev is "batadv_slave_1"
>         - bpf_offload_find_netdev(offload->netdev) !=3D NULL,
>           this is struct bpf_offload_netdev with {.offdev =3D NULL}
>           created for program #1
>         - prog->aux->offload =3D struct bpf_prog_offload {.offload -> {.o=
ffdev =3D NULL}},
>           The bpf_prog_offload remembered for prog points to bpf_offload_=
netdev
>           with .offdev =3D=3D NULL.
>   - ...
>   - bpf_check
>     - bpf_prog_offload_verifier_prep
>       - prog->aux->offload !=3D NULL, but prog->aux->offload->offdev =3D=
=3D NULL
>         =3D> null pointer deference.
>=20
> ## Control flow when error does not occur
>=20
> For program #1:
> - ... all as in the previous case ...
>=20
> Some worker thread:
> - kernel/bpf/core.c:bpf_prog_free_deferred, registered for program #1:
>   - bpf_prog_is_dev_bound(aux) is true
>   - bpf_prog_dev_bound_destroy
>     - netdev is "batadv_slave_1"
>     - (!ondev->offdev && list_empty(&ondev->progs)) is true
>       - __bpf_offload_dev_netdev_unregister
>         this removes struct bpf_offload_netdev with {.offdev =3D NULL}
>         from offload.c:offdevs hash table.
>=20
> For program #2:
> - bpf_prog_load():
>   - bpf_prog_is_dev_bound(prog->aux) is true
>     - bpf_prog_dev_bound_init
>       - prog->aux->offload_requested is 1 (because of 0x0 prog_flags)
>       - __bpf_prog_dev_bound_init
>         - netdev is "batadv_slave_1"
>         - bpf_offload_find_netdev(offload->netdev) =3D=3D NULL
>         - bpf_prog_is_offloaded(prog->aux) is true
>         - -EINVAL is returned.


