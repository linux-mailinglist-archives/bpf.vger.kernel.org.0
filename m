Return-Path: <bpf+bounces-13436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81F7D9F09
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0421C210A3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8403B297;
	Fri, 27 Oct 2023 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT1b4/5v"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B01946F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:51:33 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB937F4;
	Fri, 27 Oct 2023 10:51:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98377c5d53eso367215566b.0;
        Fri, 27 Oct 2023 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698429089; x=1699033889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAmazBhiHKW0gRd7/Z3gWh1LqDNwWCGKSstajyT9RfM=;
        b=dT1b4/5vhdnN6+VIWOT9+b6ZMRceq9b2MeKVAyc/6khw03nsucwxdN30CNL/HhbbHh
         AqTOnZ8hG0YWf9bS0eWH1/ojRyA1dF9lLR5gVGUusF2LmpIQA11CzUbWqXXS3NN3IWG/
         wcX1qavwU1XLCdzNkHNd2ibloAtIDomkE92HdiqMi4v8u9zVazFRtddKdt93iMsFFdSi
         yqHlQBtur4najLcptmcl5q774Jpa+8Ykgmy7Usd0P9FewCwpURVgkfeiEBAaaEx2XkmA
         DpVQux1odGOmOT402/E8E1h6ylzpxuopqCp0UDY8CPQw+lXMfpXV88VBBDVjOxOO+eJr
         9EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698429089; x=1699033889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAmazBhiHKW0gRd7/Z3gWh1LqDNwWCGKSstajyT9RfM=;
        b=QkxnTbz30uUVAiS1q+3mJ1Kz8rQDaYVPRpWAEelxF6cukqkTggs60+pl68WPjIi3HM
         VgDAzUDq8SQocCCVUrqhlDBP2p11uizl5eW/qEGOYMmEAboH92TYNoJN1UIwRXdbXPhl
         QXeHxVgEPZS7gGorleQWEbRk5hTnn4IIMu1NKUoBea6VM/aV0Cw6MgFjsxzlHNq2qet0
         C9LZYoVChYsIL+Kf0q62sMvi0Ub71LjGkl0NeQzMvMXkuskn+EZxzN//fWK/rN6ExR9G
         mwYJGosdS3L0N2bucwFUytVjkhI1oJiNCW1dbr4bC4UZPNXNwwJBa8OStYAySugHe6zB
         DQfw==
X-Gm-Message-State: AOJu0Yz07BksRO2IRhky1NlKx17b5XMRFvYK7JTNcm83CBmv6pfRCwjQ
	MLgVAcqfqyFkleRw8nj5YTzJVCaNsla0fGJ9Zvc=
X-Google-Smtp-Source: AGHT+IFiKOlIbTbW0U+QIXH4yptevFIPwtmAekuVDcs9BECyPBTaSPd8W5kBfeFyZg75P3RU/47O8kxUEKSUU9mbmQw=
X-Received: by 2002:a17:907:7fa1:b0:9be:dce3:6e07 with SMTP id
 qk33-20020a1709077fa100b009bedce36e07mr2988612ejc.32.1698429089013; Fri, 27
 Oct 2023 10:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <4b354d05b1bb4aa681fff5baca3455d90233951d.camel@gmail.com>
In-Reply-To: <4b354d05b1bb4aa681fff5baca3455d90233951d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Oct 2023 10:51:17 -0700
Message-ID: <CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2023-10-24 at 14:40 +0200, Hao Sun wrote:
> > Hi,
> >
> > The following program can trigger a shift-out-of-bounds in
> > tnum_rshift(), called by scalar32_min_max_rsh():
> >
> > 0: (bc) w0 =3D w1
> > 1: (bf) r2 =3D r0
> > 2: (18) r3 =3D 0xd
> > 4: (bc) w4 =3D w0
> > 5: (bf) r5 =3D r0
> > 6: (bf) r7 =3D r3
> > 7: (bf) r8 =3D r4
> > 8: (2f) r8 *=3D r5
> > 9: (cf) r5 s>>=3D r5
> > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > 11: (1f) r7 -=3D r5
> > 12: (71) r6 =3D *(u8 *)(r1 +17)
> > 13: (5f) r3 &=3D r8
> > 14: (74) w2 >>=3D 30
> > 15: (1f) r7 -=3D r5
> > 16: (5d) if r8 !=3D r6 goto pc+4
> > 17: (c7) r8 s>>=3D 5
> > 18: (cf) r0 s>>=3D r0
> > 19: (7f) r0 >>=3D r0
> > 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> > 21: exit
>
> Here is a simplified example:
>
> SEC("?tp")
> __success __retval(0)
> __naked void large_shifts(void)
> {
>         asm volatile ("                 \
>         call %[bpf_get_prandom_u32];    \n\
>         r8 =3D r0;                        \n\
>         r6 =3D r0;                        \n\
>         r6 &=3D 0xf;                      \n\
>         if w8 < 0xffffffff goto +2;     \n\
>         if r8 !=3D r6 goto +1;            \n\
>         w0 >>=3D w8;       /* shift-out-bounds here */    \n\
>         exit;                           \n\
> "       :
>         : __imm(bpf_get_prandom_u32)
>         : __clobber_all);
> }
>

With my changes the verifier does correctly derive that r8 !=3D r6 will
always happen, and thus skips w0 >>=3D w8. But the test itself with
__retval(0) is not a valid test, so it would be good to construct
something that will correctly return 0 at runtime (or use some other
check). So I won't put this test into my patch set and will live it as
a follow up for someone. But here's the log for anyone curious:

VERIFIER LOG:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
func#0 @0
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
; asm volatile ("                                       \
0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
1: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3Dscal=
ar(id=3D1)
2: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3Dscal=
ar(id=3D1)
3: (57) r6 &=3D 15                      ;
R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=
=3D(0x0;
0xf))
4: (a6) if w8 < 0xffffffff goto pc+2          ;
R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808513,umin=3Dumin32=3D4294967295=
,smin32=3D-1,smax32=3D-1,var_off=3D(0xffffffff;
0xffffffff00000000))
5: (5d) if r8 !=3D r6 goto pc+1
mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=3Dr0,r8 stack=3D before 4: (a6) if w8 <
0xffffffff goto pc+2
mark_precise: frame0: regs=3Dr0,r8 stack=3D before 3: (57) r6 &=3D 15
mark_precise: frame0: regs=3Dr0,r8 stack=3D before 2: (bf) r6 =3D r0
mark_precise: frame0: regs=3Dr0,r8 stack=3D before 1: (bf) r8 =3D r0
mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_prando=
m_u32#7
mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=3Dr6 stack=3D before 4: (a6) if w8 < 0xffffffff =
goto pc+2
mark_precise: frame0: regs=3Dr6 stack=3D before 3: (57) r6 &=3D 15
mark_precise: frame0: regs=3Dr6 stack=3D before 2: (bf) r6 =3D r0
mark_precise: frame0: regs=3Dr0 stack=3D before 1: (bf) r8 =3D r0
mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_prando=
m_u32#7
5: R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_o=
ff=3D(0x0;
0xf)) R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808513,umin=3Dumin32=3D4294=
967295,smin32=3D-1,smax32=3D-1,var_off=3D(0xffffffff;
0xffffffff00000000))
7: (95) exit

from 4 to 7: R0=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D184467440=
73709551614,umax32=3D4294967294)
R6=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D=
(0x0; 0xf))
R8=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D18446744073709551614,u=
max32=3D4294967294)
R10=3Dfp0
7: R0=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D1844674407370955161=
4,umax32=3D4294967294)
R6=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D=
(0x0; 0xf))
R8=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D18446744073709551614,u=
max32=3D4294967294)
R10=3Dfp0
7: (95) exit
processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1
peak_states 1 mark_read 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

at insn #4, simulating a FALSE condition, verifier knows that r6 is
[0, 15], while w8 is exactly 0xffffffff, so at insn #5 it can tell
that 0xffffffff can never be equal to a value in [0, 15] range, and
thus skips the shift instruction.


> The issue is caused by an invalid range assigned to R8 after R8 !=3D R6
> check, here is GDB log:
>
> (gdb) bt
> #0  scalar32_min_max_rsh ... at kernel/bpf/verifier.c:13368
> #1  0xffffffff81295236 in adjust_scalar_min_max_vals ... at kernel/bpf/ve=
rifier.c:13592
> #2  adjust_reg_min_max_vals .... at kernel/bpf/verifier.c:13706
> #3  0xffffffff8128701f in check_alu_op ... at kernel/bpf/verifier.c:13938
> #4  do_check ... at kernel/bpf/verifier.c:17327
> (gdb) p *src_reg
> $2 =3D {
>   type =3D SCALAR_VALUE,
>   ...
>   smin_value =3D 4294967295,
>   smax_value =3D 15,
>   umin_value =3D 4294967295,
>   umax_value =3D 15,
>   s32_min_value =3D -1,
>   s32_max_value =3D -1,
>   u32_min_value =3D 4294967295,
>   u32_max_value =3D 4294967295,
>   ...
> }
>
> The invalid range is assigned within reg_combine_min_max() function in
> BPF_JNE branch. The following diff removes the error:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 857d76694517..3d140bf85282 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14485,7 +14485,7 @@ static void reg_combine_min_max(struct bpf_reg_st=
ate *true_src,
>                 __reg_combine_min_max(true_src, true_dst);
>                 break;
>         case BPF_JNE:
> -               __reg_combine_min_max(false_src, false_dst);
> +               //__reg_combine_min_max(false_src, false_dst);
>                 break;
>         }
>  }
>
> I do not understand what BPF_JNE branch logically means in
> reg_combine_min_max(), does anyone has any insight?

Not equal check? When you have either `if r1 =3D=3D r2 goto ` or `if r1 !=
=3D
r2`, verifier simulates both TRUE and FALSE conditions, so basically
both BPF_JEQ and BPF_JNE, depending on the branch.

>
> > After load:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> > shift exponent 255 is too large for 64-bit type 'long long unsigned int=
'
> > CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> > 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
> >  ubsan_epilogue lib/ubsan.c:217 [inline]
> >  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
> >  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
> >  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
> >  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
> >  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
> >  do_check kernel/bpf/verifier.c:16890 [inline]
> >  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
> >  do_check_main kernel/bpf/verifier.c:19626 [inline]
> >  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
> >  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
> >  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
> >  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
> >  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x5610511e23cd
> > Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> > 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> > RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> > RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> > R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
> >  </TASK>
> >
> > If remove insn #20, the verifier gives:
> >  -------- Verifier Log --------
> >  func#0 @0
> >  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >  0: (bc) w0 =3D w1                       ;
> > R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xfffff=
fff))
> > R1=3Dctx(off=3D0,
> >  imm=3D0)
> >  1: (bf) r2 =3D r0                       ;
> > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> > 0xffffffff))
> >  R2_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;=
 0xffffffff))
> >  2: (18) r3 =3D 0xd                      ; R3_w=3D13
> >  4: (bc) w4 =3D w0                       ;
> > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> > 0xffffffff))
> >  R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;=
 0xffffffff))
> >  5: (bf) r5 =3D r0                       ;
> > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> > 0xffffffff))
> >  R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;=
 0xffffffff))
> >  6: (bf) r7 =3D r3                       ; R3_w=3D13 R7_w=3D13
> >  7: (bf) r8 =3D r4                       ;
> > R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> > 0xffffffff))
> >  R8_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;=
 0xffffffff))
> >  8: (2f) r8 *=3D r5                      ;
> > R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> > 0xffffffff))
> >  R8_w=3Dscalar()
> >  9: (cf) r5 s>>=3D r5                    ; R5_w=3Dscalar()
> >  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> > R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=3D-5=
,smax32=3D-1,
> >  umin32=3D4294967291,var_off=3D(0xfffffff8; 0xffffffff00000007))
> >  11: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dscala=
r()
> >  12: (71) r6 =3D *(u8 *)(r1 +17)         ; R1=3Dctx(off=3D0,imm=3D0)
> > R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,
> >  var_off=3D(0x0; 0xff))
> >  13: (5f) r3 &=3D r8                     ;
> > R3_w=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D8,smax=3Dumax=3Dsmax32=3D=
umax32=3D13,var_off=3D(0x8;
> >  0x5)) R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin=
32=3D-5,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
> >  14: (74) w2 >>=3D 30                    ;
> > R2_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D3,var_o=
ff=3D(0x0;
> > 0x3))
> >  15: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dscala=
r()
> >  16: (5d) if r8 !=3D r6 goto pc+3        ;
> > R6_w=3Dscalar(smin=3Dumin=3Dumin32=3D4294967288,smax=3Dumax=3Dumax32=3D=
255,smin32=3D-8,smax32=3D-1,
> >  var_off=3D(0xfffffff8; 0x7))
> > R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=3D-5,sm=
ax32=3D-1,umin32=3D4294967291)
> >  17: (c7) r8 s>>=3D 5                    ; R8_w=3D134217727
> >  18: (cf) r0 s>>=3D r0                   ; R0_w=3Dscalar()
> >  19: (7f) r0 >>=3D r0                    ; R0=3Dscalar()
> >  20: (95) exit
> >
> >  from 16 to 20: safe
> >
> >  from 10 to 20: safe
> >  processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
> > 1 peak_states 1 mark_read 1
> > -------- End of Verifier Log --------
> >
> > In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> > the check here:
> >          if (umax_val >=3D insn_bitness) {
> >              /* Shifts greater than 31 or 63 are undefined.
> >               * This includes shifts by a negative number.
> >               */
> >              mark_reg_unknown(env, regs, insn->dst_reg);
> >              break;
> >          }
> >
> > However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> > src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
> >
> > Should we check if(src_reg->u32_max_value < insn_bitness) before callin=
g
> > scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> > because issues somewhere else, incorrectly setting u32_min_value to
> > 34217727
> >
> > Best
> > Hao Sun
> >
>

