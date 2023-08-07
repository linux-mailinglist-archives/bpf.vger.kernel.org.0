Return-Path: <bpf+bounces-7161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA4772525
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF232281081
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8010797;
	Mon,  7 Aug 2023 13:11:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71728101FE;
	Mon,  7 Aug 2023 13:11:19 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78F99;
	Mon,  7 Aug 2023 06:11:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso612432166b.1;
        Mon, 07 Aug 2023 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691413876; x=1692018676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ9/+uqc4LD3vJxBlfQv0jPxDYwQJpSkgZcRtt8Hekk=;
        b=EbxHOSTQ+593ktHrumJoPXkabz7HwS5V4ezBQ6DjhBJyokw6sCO4qF4iFtEJ1bJzBc
         0bwu54uts/dO9jh1gBGRfJJkuM037urL5rnXwsON3BmO4Buf7k66KfLJXxXblw//ie4F
         RIqCDXC6FqkQ0qNjGpw1zpF7c8VJeTzerAh8VSfE9sV2TH+9qwSmLnTWIly61M4H2YNE
         sEg4gqIgfsYbKL3rtWjnsxRztGw7XAlC09b7xPYv1BjAGuGqDraOp+tYo/GjUNfNasje
         CNP6jbmzfhSqsUZ2sJjqC11D5KUE43CT5f/KRA5rEfaONpunP1HgodS1y/i79QUbwnHa
         QP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413876; x=1692018676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fQ9/+uqc4LD3vJxBlfQv0jPxDYwQJpSkgZcRtt8Hekk=;
        b=DWn+k9rXKevUv8DMOeCgCZNRvxWNQEg02UzD5SD1JpiVtMGUBCaOIAz678bo16IaY8
         HNtaQBlijHoHhGXE9OeYZIRT7rm6PXf2qcLssQgdrKfPnSYkQP2cQ7JDgHMHZbQ9sfA0
         URDViSfrF9wJX0zFZE5Z6avywDI20sfzv40hUaDjuKuIMWpmNvKkJASAfQzLP2LgLELt
         ER8Vuklxk2UfJo+oXUpwwKsQlrLyi+MuNq1LLfJRvMlfMuOrnloeU6NRqp5aUKNYrLUl
         SSqdcQRo0gPxaV6vusxTxpimBJ9hp/Nm2OBAPAMvpk432MRK7e4+Smy/cJNbDMfOwclp
         1bGQ==
X-Gm-Message-State: AOJu0YxqN+at5Yx1BS7H/QlnnSMWk62kDy82lxSGIk8PoEXaXSSzWS3B
	WrdFyBe8fwJX4Bl7jIFHOWU=
X-Google-Smtp-Source: AGHT+IHN9ItUZRFCRufHaF2koU+5Xb7zt80AozHb4R279jeTC7TwsJtaq1FVWEXjN0xC2K7FuqLsqg==
X-Received: by 2002:a17:906:3049:b0:98e:419b:4cc6 with SMTP id d9-20020a170906304900b0098e419b4cc6mr7647525ejd.70.1691413875509;
        Mon, 07 Aug 2023 06:11:15 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906b09100b0098f99048053sm5302347ejy.148.2023.08.07.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:11:14 -0700 (PDT)
Message-ID: <9c8f04a0bf90db4bb8e6192824ab71f58244b74b.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 ieee802154_subif_start_xmit
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, syzbot
 <syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com>, andrii@kernel.org,
  ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net,  haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org,  kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,  martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
 syzkaller-bugs@googlegroups.com
Date: Mon, 07 Aug 2023 16:11:13 +0300
In-Reply-To: <d520bd6c-bfd3-47f1-c794-ab451905256b@linux.dev>
References: <0000000000002098bc0602496cc3@google.com>
	 <d520bd6c-bfd3-47f1-c794-ab451905256b@linux.dev>
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
	FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-08-06 at 23:40 -0700, Yonghong Song wrote:
>=20
> On 8/6/23 4:23 PM, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    25ad10658dc1 riscv, bpf: Adapt bpf trampoline to optimi=
zed..
> > git tree:       bpf-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D147cbb29a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8acaeb93ad7=
c6aaa
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd61b595e92055=
73133b3
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d73ccea=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1276aedea80=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3d378cc13d42/d=
isk-25ad1065.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/44580fd5d1af/vmli=
nux-25ad1065.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/840587618b41=
/bzImage-25ad1065.xz
> >=20
> > The issue was bisected to:
> >=20
> > commit 8100928c881482a73ed8bd499d602bab0fe55608
> > Author: Yonghong Song <yonghong.song@linux.dev>
> > Date:   Fri Jul 28 01:12:02 2023 +0000
> >=20
> >      bpf: Support new sign-extension mov insns
>=20
> Thanks for reporting. I will look into this ASAP.

Hi Yonghong,

I guess it's your night and my morning, so I did some initial assessment.
The BPF program being loaded is:

  0 : (62) *(u32 *)(r10 -8) =3D 553656332=20
  1 : (bf) r1 =3D (s16)r10=20
  2 : (07) r1 +=3D -8=20
  3 : (b7) r2 =3D 3=20
  4 : (bd) if r2 <=3D r1 goto pc+0=20
  5 : (85) call bpf_trace_printk#6=20
  6 : (b7) r0 =3D 0=20
  7 : (95) exit=20

(Note: when using bpftool (prog dump xlated id <some-id>) the disassembly
 of the instruction #1 is incorrectly printed as "1: (bf) r1 =3D r10")
=20
The error occurs when instruction #5 (call to printk) is executed.
An incorrect address for the format string is passed to printk.
Disassembly of the jited program looks as follows:

  $ bpftool prog dump jited id <some-id>
  bpf_prog_ebeed182d92b487f:
     0: nopl    (%rax,%rax)
     5: nop
     7: pushq   %rbp
     8: movq    %rsp, %rbp
     b: subq    $8, %rsp
    12: movl    $553656332, -8(%rbp)
    19: movswq  %bp, %rdi            ; <---- Note movswq %bp !
    1d: addq    $-8, %rdi
    21: movl    $3, %esi
    26: cmpq    %rdi, %rsi
    29: jbe 0x2b
    2b: callq   0xffffffffe11c484c
    30: xorl    %eax, %eax
    32: leave
    33: retq

Note jit instruction #19 corresponding to BPF instruction #1, which
loads truncated and sign-extended value of %rbp's first byte as an
address of format string.

Here is how verifier log looks for (slightly modified) program:

  func#0 @0
  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  ; asm volatile ("			\n\
  0: (b7) r1 =3D 553656332                ; R1_w=3D553656332
  1: (63) *(u32 *)(r10 -8) =3D r1         ; R1_w=3D553656332 R10=3Dfp0 fp-8=
=3D553656332
  2: (bf) r1 =3D (s16)r10                 ; R1_w=3Dfp0 R10=3Dfp0
  3: (07) r1 +=3D -8                      ; R1_w=3Dfp-8
  4: (b7) r2 =3D 3                        ; R2_w=3D3
  5: (bd) if r2 <=3D r1 goto pc+0         ; R1_w=3Dfp-8 R2_w=3D3
  6: (85) call bpf_trace_printk#6
  mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1=20
  ...
  mark_precise: frame0: falling back to forcing all scalars precise
  7: R0=3Dscalar()
  7: (b7) r0 =3D 0                        ; R0_w=3D0
  8: (95) exit
 =20
  from 5 to 6: R1_w=3Dfp-8 R2_w=3D3 R10=3Dfp0 fp-8=3D553656332
  6: (85) call bpf_trace_printk#6
  mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1=20
  ...
  mark_precise: frame0: falling back to forcing all scalars precise
  7: safe

Note the following line:

  2: (bf) r1 =3D (s16)r10                 ; R1_w=3Dfp0 R10=3Dfp0

Verifier incorrectly marked r1 as fp0, hence not noticing the problem
with address passed to printk.

Thanks,
Eduard.

> >=20
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17970c5d=
a80000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14570c5d=
a80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10570c5da80=
000
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com
> > Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
> >=20
> > general protection fault, probably for non-canonical address 0xdffffc00=
00000f4f: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: probably user-memory-access in range [0x0000000000007a78-0x00000=
00000007a7f]
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc2-syzkaller-00619-g25=
ad10658dc1 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/12/2023
> > RIP: 0010:strnchr+0x25/0x80 lib/string.c:403
> > Code: 00 00 00 00 90 f3 0f 1e fa 53 48 01 fe 48 bb 00 00 00 00 00 fc ff=
 df 48 83 ec 18 eb 28 48 89 f8 48 89 f9 48 c1 e8 03 83 e1 07 <0f> b6 04 18 =
38 c8 7f 04 84 c0 75 25 0f b6 07 38 d0 74 15 48 83 c7
> > RSP: 0018:ffffc90000177848 EFLAGS: 00010046
> > RAX: 0000000000000f4f RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000007a7b RDI: 0000000000007a78
> > RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000007a78
> > R13: ffffc900001779b0 R14: 0000000000000000 R15: 0000000000000003
> > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005611db5094b8 CR3: 0000000028ef0000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   bpf_bprintf_prepare+0x127/0x1490 kernel/bpf/helpers.c:823
> >   ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
> >   bpf_trace_printk+0xdb/0x180 kernel/trace/bpf_trace.c:375
> >   bpf_prog_ebeed182d92b487f+0x38/0x3c
> >   bpf_dispatcher_nop_func include/linux/bpf.h:1180 [inline]
> >   __bpf_prog_run include/linux/filter.h:609 [inline]
> >   bpf_prog_run include/linux/filter.h:616 [inline]
> >   __bpf_trace_run kernel/trace/bpf_trace.c:2269 [inline]
> >   bpf_trace_run1+0x148/0x400 kernel/trace/bpf_trace.c:2307
> >   __bpf_trace_rcu_utilization+0x8e/0xc0 include/trace/events/rcu.h:27
> >   trace_rcu_utilization+0xcd/0x120 include/trace/events/rcu.h:27
> >   rcu_note_context_switch+0x6c/0x1ac0 kernel/rcu/tree_plugin.h:318
> >   __schedule+0x293/0x59f0 kernel/sched/core.c:6610
> >   schedule_idle+0x5b/0x80 kernel/sched/core.c:6814
> >   do_idle+0x288/0x3f0 kernel/sched/idle.c:310
> >   cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
> >   start_secondary+0x200/0x290 arch/x86/kernel/smpboot.c:326
> >   secondary_startup_64_no_verify+0x167/0x16b
> >   </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:strnchr+0x25/0x80 lib/string.c:403
> > Code: 00 00 00 00 90 f3 0f 1e fa 53 48 01 fe 48 bb 00 00 00 00 00 fc ff=
 df 48 83 ec 18 eb 28 48 89 f8 48 89 f9 48 c1 e8 03 83 e1 07 <0f> b6 04 18 =
38 c8 7f 04 84 c0 75 25 0f b6 07 38 d0 74 15 48 83 c7
> > RSP: 0018:ffffc90000177848 EFLAGS: 00010046
> >=20
> > RAX: 0000000000000f4f RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000007a7b RDI: 0000000000007a78
> > RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000007a78
> > R13: ffffc900001779b0 R14: 0000000000000000 R15: 0000000000000003
> > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005611db5094b8 CR3: 0000000028ef0000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >     0:	00 00                	add    %al,(%rax)
> >     2:	00 00                	add    %al,(%rax)
> >     4:	90                   	nop
> >     5:	f3 0f 1e fa          	endbr64
> >     9:	53                   	push   %rbx
> >     a:	48 01 fe             	add    %rdi,%rsi
> >     d:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
> >    14:	fc ff df
> >    17:	48 83 ec 18          	sub    $0x18,%rsp
> >    1b:	eb 28                	jmp    0x45
> >    1d:	48 89 f8             	mov    %rdi,%rax
> >    20:	48 89 f9             	mov    %rdi,%rcx
> >    23:	48 c1 e8 03          	shr    $0x3,%rax
> >    27:	83 e1 07             	and    $0x7,%ecx
> > * 2a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax <-- trapping inst=
ruction
> >    2e:	38 c8                	cmp    %cl,%al
> >    30:	7f 04                	jg     0x36
> >    32:	84 c0                	test   %al,%al
> >    34:	75 25                	jne    0x5b
> >    36:	0f b6 07             	movzbl (%rdi),%eax
> >    39:	38 d0                	cmp    %dl,%al
> >    3b:	74 15                	je     0x52
> >    3d:	48                   	rex.W
> >    3e:	83                   	.byte 0x83
> >    3f:	c7                   	.byte 0xc7
> >=20
> >=20
> [...]


