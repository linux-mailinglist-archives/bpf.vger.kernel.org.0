Return-Path: <bpf+bounces-9332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE584793CE0
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 14:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3331C20AA0
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37292DF66;
	Wed,  6 Sep 2023 12:40:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31016AB3;
	Wed,  6 Sep 2023 12:40:33 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B3171F;
	Wed,  6 Sep 2023 05:40:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500cd6261fdso6243650e87.3;
        Wed, 06 Sep 2023 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694004029; x=1694608829; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C/7k9pana45Zio26+3zpMV57EDCwLx3Ng0yJJXyf70=;
        b=BnvYrOAtCtzkXb0MS0cizmatKkQ11XyO7PMjymO/5NYidgsR/FAsDZ6pn5VCAszPtZ
         w+njGl+fFtLVA9RjJI/+yWmuJ7EFzulL5uuclgWATNTvrFG6zX6tNRrO1/x+FudaVMqs
         PnmM7zmilg+H4vYZwTz8ecNFbyb+2lUMxqPhdqzClkK60D87BI+2L5kd1AowZejxIqwN
         0NGshp3cK4m+gL21aA+P4oU3RQi7lmC7fJ/M0rgU3S+h+04OSXaQYBgqmVlW2yMvpXC8
         HkUee4jCQZ+7T8I9JRxOnnKoWKw0adaVXit5OeFae2ZMePCBxXO76wdLXknMxMtQ9Jdr
         Ut7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694004029; x=1694608829;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2C/7k9pana45Zio26+3zpMV57EDCwLx3Ng0yJJXyf70=;
        b=P/pShfm7oc3qNDEusISPBDOrXoNVxzkUTRk02k85UBI6kWknU9aM80MVmk9RzjccXT
         ATR6sw2hqNWJ+8Ho+dhriUr3+1oi0+CKmJB7Q9ThpJQYJPqs3sleZLQl2wNaWRPCAdtQ
         B0aXAU8r8o0BxzSF7sywktTfP1NK8Lj0FInNN8LYY2nAiBIkmEoBhz7hBgwWTxhfxO8h
         UVpo0AP2a0fUXMEpW/q5V7HK8axL8d0yRKQjzTYGTcxNgMLwV7VIKO4/kc8zL6JbF6Ic
         fQZQFMbNwyeTilFfUJkYyypyAhPnWc0vNHHDj8UViMg3E4A6Zuu2hPZYGLO5aS4dR/Of
         cdQw==
X-Gm-Message-State: AOJu0YwrGWOjwkz80Cv4f4jWv4L7PPXTh7oHRD30sKGtBBJ1p7NjRHZ0
	wI88eUyNXU385s4Q5i/s+vc=
X-Google-Smtp-Source: AGHT+IFD5tPalf9LIi3rZExwSiPWV5gPvtW4Tnkk8yebf95W7h2qdYGQ6yEQnyX+BevBeA8ExwXkQQ==
X-Received: by 2002:a05:6512:401e:b0:501:c996:1996 with SMTP id br30-20020a056512401e00b00501c9961996mr1795830lfb.67.1694004028402;
        Wed, 06 Sep 2023 05:40:28 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x18-20020aa7d6d2000000b0052718577668sm8361423edr.11.2023.09.06.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:40:27 -0700 (PDT)
Message-ID: <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
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
Date: Wed, 06 Sep 2023 15:40:26 +0300
In-Reply-To: <000000000000d97f3c060479c4f8@google.com>
References: <000000000000d97f3c060479c4f8@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-09-03 at 12:55 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    fa09bc40b21a igb: disable virtualization features on 8258=
0
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13382fa868000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D634e05b4025da=
9da
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D291100dcb32190e=
c02a8
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1529c448680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15db024868000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7ab461d84992/dis=
k-fa09bc40.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3ac6d43ab2db/vmlinu=
x-fa09bc40.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/778d096a134e/b=
zImage-fa09bc40.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
>=20
> general protection fault, probably for non-canonical address 0xdffffc0000=
000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 5055 Comm: syz-executor625 Not tainted 6.5.0-syzkaller-04012-=
gfa09bc40b21a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/26/2023
> RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.c:=
295
> Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48 b=
8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f=
 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
> RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
> R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
> FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bpf_check+0x52f3/0xabd0 kernel/bpf/verifier.c:19762
>  bpf_prog_load+0x153a/0x2270 kernel/bpf/syscall.c:2708
>  __sys_bpf+0xbb6/0x4e90 kernel/bpf/syscall.c:5335
>  __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5437
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f7c0df78ea9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffde3592128 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7c0df78ea9
> RDX: 0000000000000090 RSI: 0000000020000940 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000100000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.c:=
295
> Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48 b=
8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f=
 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
> RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
> R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
> FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 3 bytes skipped:
>    0:	df 48 89             	fisttps -0x77(%rax)
>    3:	fa                   	cli
>    4:	48 c1 ea 03          	shr    $0x3,%rdx
>    8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>    c:	0f 85 a1 00 00 00    	jne    0xb3
>   12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   19:	fc ff df
>   1c:	4c 8b 65 10          	mov    0x10(%rbp),%r12
>   20:	4c 89 e2             	mov    %r12,%rdx
>   23:	48 c1 ea 03          	shr    $0x3,%rdx
> * 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instru=
ction
>   2b:	0f 85 93 00 00 00    	jne    0xc4
>   31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   38:	fc ff df
>   3b:	4d                   	rex.WRB
>   3c:	8b                   	.byte 0x8b
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20

I have an explanation of why this error occurs, but I need an advice
on how to fix it.

Then NULL pointer deference occurs in the following function from offload.c=
:

    int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
    {
        struct bpf_prog_offload *offload;
        int ret =3D -ENODEV;
   =20
        down_read(&bpf_devs_lock);
        offload =3D prog->aux->offload;
        if (offload) {
            ret =3D offload->offdev->ops->prepare(prog);
                           ^^^^^^
                           this pointer is NULL
            offload->dev_state =3D !ret;
        }
        up_read(&bpf_devs_lock);
   =20
        return ret;
    }

# Short explanation

(a) call chain bpf_prog_load -> bpf_prog_dev_bound_init -> __bpf_prog_dev_b=
ound_init
               -> __bpf_offload_dev_netdev_register
    might insert an instance of struct bpf_offload_netdev with {.offdev =3D=
=3D NULL}
    into hash table offload.c:offdevs;
(b) call chain bpf_prog_load -> bpf_check -> bpf_prog_offload_verifier_prep
    assumes that from (prog->aux->offload !=3D NULL)
              follows (prog->aux->offload->offdev !=3D NULL)
    which is not the case because of (a).

# Long explanation

The reproducer generated by testbot has the following structure:
- in a loop call function execute_one(), which does the following
  system calls in sequence:
  - socket(AF_INET6, SOCK_RAW, IPPROTO_IGMP) =3D <some fd>
  - ioctl(3, SIOCGIFINDEX, {ifr_name=3D"batadv_slave_1"}) =3D 0
  - bpf(BPF_PROG_LOAD,
        {prog_type=3DBPF_PROG_TYPE_XDP, ... prog_flags=3D0x40, prog_ifindex=
=3D29, ...}) =3D -1 EINVAL
    (referred to as program #1 below)
  - socket(AF_INET6, SOCK_RAW, IPPROTO_IGMP) =3D <some fd>
  - ioctl(4, SIOCGIFINDEX, {ifr_name=3D"batadv_slave_1"}) =3D 0
  - bpf(BPF_PROG_LOAD,
        {prog_type=3DBPF_PROG_TYPE_XDP, ... prog_flags=3D0, ... prog_ifinde=
x=3D29}) =3D -1 EINVAL
    (referred to as program #2 below)

The error occurs when second bpf call is processed.
Interestingly, if sleep(1) is inserted somewhere between first and
second bpf calls error does not occur:

    @@ -1246,6 +1246,7 @@ void execute_one(void)
       *(uint32_t*)0x200009cc =3D 4;
       syscall(__NR_bpf, /*cmd=3D*/5ul, /*arg=3D*/0x20000940ul, /*size=3D*/=
0x90ul);
       res =3D syscall(__NR_socket, /*domain=3D*/0xaul, /*type=3D*/3ul, /*p=
roto=3D*/2);
    +  // sleep(1); /* uncomment to hide the error */
       if (res !=3D -1)
         r[2] =3D res;
       memcpy((void*)0x20000100, "batadv_slave_1\000\000", 16);

## Control flow when error occurs

For program #1:
- bpf_prog_load():
  - bpf_prog_is_dev_bound(prog->aux) is true
    - bpf_prog_dev_bound_init
      - prog->aux->offload_requested is 0 (because of 0x40 prog_flags)
      - __bpf_prog_dev_bound_init
        - netdev is "batadv_slave_1"
        - bpf_offload_find_netdev(offload->netdev) =3D=3D NULL,
          (this is a lookup in hash table offload.c:offdevs)
          which triggers a call to __bpf_offload_dev_netdev_register
          - __bpf_offload_dev_netdev_register(NULL, offload->netdev)
            registers struct bpf_offload_netdev with {.offdev =3D NULL}
            for netdev "batadv_slave_1" in offload.c:offdevs hash table.

For program #2:
- bpf_prog_load():
  - bpf_prog_is_dev_bound(prog->aux) is true
    - bpf_prog_dev_bound_init
      - prog->aux->offload_requested is 1 (because of 0x0 prog_flags)
      - __bpf_prog_dev_bound_init
        - netdev is "batadv_slave_1"
        - bpf_offload_find_netdev(offload->netdev) !=3D NULL,
          this is struct bpf_offload_netdev with {.offdev =3D NULL}
          created for program #1
        - prog->aux->offload =3D struct bpf_prog_offload {.offload -> {.off=
dev =3D NULL}},
          The bpf_prog_offload remembered for prog points to bpf_offload_ne=
tdev
          with .offdev =3D=3D NULL.
  - ...
  - bpf_check
    - bpf_prog_offload_verifier_prep
      - prog->aux->offload !=3D NULL, but prog->aux->offload->offdev =3D=3D=
 NULL
        =3D> null pointer deference.

## Control flow when error does not occur

For program #1:
- ... all as in the previous case ...

Some worker thread:
- kernel/bpf/core.c:bpf_prog_free_deferred, registered for program #1:
  - bpf_prog_is_dev_bound(aux) is true
  - bpf_prog_dev_bound_destroy
    - netdev is "batadv_slave_1"
    - (!ondev->offdev && list_empty(&ondev->progs)) is true
      - __bpf_offload_dev_netdev_unregister
        this removes struct bpf_offload_netdev with {.offdev =3D NULL}
        from offload.c:offdevs hash table.

For program #2:
- bpf_prog_load():
  - bpf_prog_is_dev_bound(prog->aux) is true
    - bpf_prog_dev_bound_init
      - prog->aux->offload_requested is 1 (because of 0x0 prog_flags)
      - __bpf_prog_dev_bound_init
        - netdev is "batadv_slave_1"
        - bpf_offload_find_netdev(offload->netdev) =3D=3D NULL
        - bpf_prog_is_offloaded(prog->aux) is true
        - -EINVAL is returned.

