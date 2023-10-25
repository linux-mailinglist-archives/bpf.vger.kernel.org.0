Return-Path: <bpf+bounces-13281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C882F7D773C
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71311C20E48
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3A37153;
	Wed, 25 Oct 2023 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGLObOGo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AF522C
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:59:27 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD94123;
	Wed, 25 Oct 2023 14:59:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507be298d2aso270713e87.1;
        Wed, 25 Oct 2023 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698271162; x=1698875962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DuyF/lRbL5SvPnzG62GxfFH6H2R7m3x5OE8B90lQvIA=;
        b=BGLObOGoBS/2hf3ktgvl3rzDqFcRl9LvCZBLLYxZ07fNl5ho7b2J+jQTMU6VJDiVIA
         3twzZE2R8aYQR21W80Xc2a6CnqzT/W5R+jogaaxnY8G2jRCJgqdkBO1IgsIR5uW/Br5K
         pV1CuWuQlE80O3Ps7EXAaPyGmlSqoROjFk+HAJsGt+IrgVS8RYEHBXoXf88/iqy0z27f
         ZsRt/jda0p1iAb2lOUtzZsUuB0Xo+wX66e3nhvgEOYXvVNvlB4ROSKWzoEjwU5joWWV2
         ctLVUZs6kOhswHj/yu+rjW3rEGvPeCWdkK6f5h7GVBsrI9dSbRLaHw+hNwGM3GKbnSYX
         TxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698271162; x=1698875962;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuyF/lRbL5SvPnzG62GxfFH6H2R7m3x5OE8B90lQvIA=;
        b=nob6bGn7e9owlQ7YVtlDd5L/fKcxXiQdjU+oiZ7MtcwZRq0WvpC+SzfYR+KMulfepj
         JLojywDnH+TFKC/TwjiuD61CXfZLL+awdSTIhKV2a2TVA2LadJLewUXf5QCg7RC9XtxR
         /Fiy5/qWz7b9psLDCDaw6tOf4Ke3VaNLcygiuPSYYi24+dKbDD3HleCb63Arbvm0YcvT
         t/eogloT06jrNKcbqFJdJXEenpzvfmKPU6tom87xMrAH4CwMsRCiakErkKHElv/Pv1H5
         KbZ2xyWxDMwGBBpk7sYfYK6s+bTIgec4PUTQq44Rasa7UwY6gT82ZwXXc6H6Uk/NNzzJ
         nTiQ==
X-Gm-Message-State: AOJu0YyAA4enhuRbEJRMLjuDAXXynpNP8nJWF4gftRkLMhy+/7GPlHjF
	a6FSOteBG6vnCxrA5hSsics=
X-Google-Smtp-Source: AGHT+IHntOHVFgOGCg+hWzQVizNswTYrx9kvC2HHKuj+3rySt+GyIFw1LaRFMEEDczaE7UIc02k1cw==
X-Received: by 2002:a19:7418:0:b0:507:a6a5:a87b with SMTP id v24-20020a197418000000b00507a6a5a87bmr12258847lfe.51.1698271161355;
        Wed, 25 Oct 2023 14:59:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 22-20020a508756000000b00532eba07773sm10364499edv.25.2023.10.25.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:59:20 -0700 (PDT)
Message-ID: <8731196c9a847ff35073a2034662d3306cea805f.camel@gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Thu, 26 Oct 2023 00:59:19 +0300
In-Reply-To: <ZTkhlwP-LkPkOjK2@u94a>
References: 
	<CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
	 <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
	 <ZTkhlwP-LkPkOjK2@u94a>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-25 at 22:09 +0800, Shung-Hsi Yu wrote:
> Hi Hao,
>=20
> On Wed, Oct 25, 2023 at 02:31:02PM +0200, Hao Sun wrote:
> > On Tue, Oct 24, 2023 at 2:40=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> w=
rote:
> > >=20
> > > Hi,
> > >=20
> > > The following program can trigger a shift-out-of-bounds in
> > > tnum_rshift(), called by scalar32_min_max_rsh():
> > >=20
> > > 0: (bc) w0.
> =3D w1
> > > 1: (bf) r2 =3D r0
> > > 2: (18) r3 =3D 0xd
> > > 4: (bc) w4 =3D w0
> > > 5: (bf) r5 =3D r0
> > > 6: (bf) r7 =3D r3
> > > 7: (bf) r8 =3D r4
> > > 8: (2f) r8 *=3D r5
> > > 9: (cf) r5 s>>=3D r5
> > > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > 11: (1f) r7 -=3D r5
> > > 12: (71) r6 =3D *(u8 *)(r1 +17)
> > > 13: (5f) r3 &=3D r8
> > > 14: (74) w2 >>=3D 30
> > > 15: (1f) r7 -=3D r5
> > > 16: (5d) if r8 !=3D r6 goto pc+4
> > > 17: (c7) r8 s>>=3D 5
> > > 18: (cf) r0 s>>=3D r0
> > > 19: (7f) r0 >>=3D r0
> > > 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> > > 21: exit
> > >=20
> >=20
> > Here are the c macros for the above program in case anyone needs this:
> >=20
> >         // 0: (bc) w0 =3D w1
> >         BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
> >         // 1: (bf) r2 =3D r0
> >         BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
> >         // 2: (18) r3 =3D 0xd
> >         BPF_LD_IMM64(BPF_REG_3, 0xd),
> >         // 4: (bc) w4 =3D w0
> >         BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
> >         // 5: (bf) r5 =3D r0
> >         BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
> >         // 6: (bf) r7 =3D r3
> >         BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
> >         // 7: (bf) r8 =3D r4
> >         BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
> >         // 8: (2f) r8 *=3D r5
> >         BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
> >         // 9: (cf) r5 s>>=3D r5
> >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
> >         // 10: (a6) if w8 < 0xfffffffb goto pc+10
> >         BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
> >         // 11: (1f) r7 -=3D r5
> >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> >         // 12: (71) r6 =3D *(u8 *)(r1 +17)
> >         BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
> >         // 13: (5f) r3 &=3D r8
> >         BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
> >         // 14: (74) w2 >>=3D 30
> >         BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
> >         // 15: (1f) r7 -=3D r5
> >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> >         // 16: (5d) if r8 !=3D r6 goto pc+4
> >         BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
> >         // 17: (c7) r8 s>>=3D 5
> >         BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
> >         // 18: (cf) r0 s>>=3D r0
> >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
> >         // 19: (7f) r0 >>=3D r0
> >         BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
> >         // 20: (7c) w5 >>=3D w8
> >         BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
> >         BPF_EXIT_INSN()
> >=20
> > > After load:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> > > shift exponent 255 is too large for 64-bit type 'long long unsigned i=
nt'
> > > CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> > > 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
> > >  ubsan_epilogue lib/ubsan.c:217 [inline]
> > >  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
> > >  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
> > >  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
> > >  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
> > >  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
> > >  do_check kernel/bpf/verifier.c:16890 [inline]
> > >  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
> > >  do_check_main kernel/bpf/verifier.c:19626 [inline]
> > >  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
> > >  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
> > >  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
> > >  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
> > >  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x5610511e23cd
> > > Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> > > 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> > > RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 000000000000014=
1
> > > RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> > > RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> > > RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> > > R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
> > >  </TASK>
> > >=20
> > > If remove insn #20, the verifier gives:
> > >  -------- Verifier Log --------
> > >  func#0 @0
> > >  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > >  0: (bc) w0 =3D w1                       ;
> > > R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xfff=
fffff))
> > > R1=3Dctx(off=3D0,
> > >  imm=3D0)
> > >  1: (bf) r2 =3D r0                       ;
> > > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0=
;
> > > 0xffffffff))
> > >  R2_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x=
0; 0xffffffff))
> > >  2: (18) r3 =3D 0xd                      ; R3_w=3D13
> > >  4: (bc) w4 =3D w0                       ;
> > > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0=
;
> > > 0xffffffff))
> > >  R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x=
0; 0xffffffff))
> > >  5: (bf) r5 =3D r0                       ;
> > > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0=
;
> > > 0xffffffff))
> > >  R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x=
0; 0xffffffff))
> > >  6: (bf) r7 =3D r3                       ; R3_w=3D13 R7_w=3D13
> > >  7: (bf) r8 =3D r4                       ;
> > > R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0=
;
> > > 0xffffffff))
> > >  R8_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x=
0; 0xffffffff))
> > >  8: (2f) r8 *=3D r5                      ;
> > > R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0=
;
> > > 0xffffffff))
> > >  R8_w=3Dscalar()
> > >  9: (cf) r5 s>>=3D r5                    ; R5_w=3Dscalar()
> > >  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> > > R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=3D=
-5,smax32=3D-1,
> > >  umin32=3D4294967291,var_off=3D(0xfffffff8; 0xffffffff00000007))
> > >  11: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dsca=
lar()
> > >  12: (71) r6 =3D *(u8 *)(r1 +17)         ; R1=3Dctx(off=3D0,imm=3D0)
> > > R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,
> > >  var_off=3D(0x0; 0xff))
> > >  13: (5f) r3 &=3D r8                     ;
> > > R3_w=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D8,smax=3Dumax=3Dsmax32=
=3Dumax32=3D13,var_off=3D(0x8;
> > >  0x5)) R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,sm=
in32=3D-5,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
> > >  14: (74) w2 >>=3D 30                    ;
> > > R2_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D3,var=
_off=3D(0x0;
> > > 0x3))
> > >  15: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dsca=
lar()
> > >  16: (5d) if r8 !=3D r6 goto pc+3        ;
> > > R6_w=3Dscalar(smin=3Dumin=3Dumin32=3D4294967288,smax=3Dumax=3Dumax32=
=3D255,smin32=3D-8,smax32=3D-1,
> > >  var_off=3D(0xfffffff8; 0x7))
> > > R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=3D-5,=
smax32=3D-1,umin32=3D4294967291)
>=20
> Seems like the root cause is a bug with range tracking, before instructio=
n
> 16, R8_w was
>=20
>   R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=3D-5=
,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
>=20
> But after instruction 16 it becomes
>=20
>   R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=3D-5,sm=
ax32=3D-1,umin32=3D4294967291)
>=20
> Where smin_value > smax_value, and umin_value > umax_value (among other
> things). This should be the main problem.
>=20
> The verifier operates on the assumption that smin_value <=3D smax_value a=
nd
> umin_value <=3D umax_value, and if that assumption is not upheld then all=
 kind
> of things can go wrong.
>=20
> Maybe Andrii may already has this worked out in the range-vs-range that h=
e
> has mentioned[1] he'll be sending soon.
>=20
> 1: https://lore.kernel.org/bpf/CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou=
_RaQV7B8A@mail.gmail.com/
>=20
> > >  17: (c7) r8 s>>=3D 5                    ; R8_w=3D134217727
> > >  18: (cf) r0 s>>=3D r0                   ; R0_w=3Dscalar()
> > >  19: (7f) r0 >>=3D r0                    ; R0=3Dscalar()
> > >  20: (95) exit
> > >=20
> > >  from 16 to 20: safe
> > >=20
> > >  from 10 to 20: safe
> > >  processed 22 insns (limit 1000000) max_states_per_insn 0 total_state=
s
> > > 1 peak_states 1 mark_read 1
> > > -------- End of Verifier Log --------
> > >=20
> > > In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> > > the check here:
> > >          if (umax_val >=3D insn_bitness) {
> > >              /* Shifts greater than 31 or 63 are undefined.
> > >               * This includes shifts by a negative number.
> > >               */
> > >              mark_reg_unknown(env, regs, insn->dst_reg);
> > >              break;
> > >          }
> > >=20
> > > However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> > > src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
> > >=20
> > > Should we check if(src_reg->u32_max_value < insn_bitness) before call=
ing
> > > scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> > > because issues somewhere else, incorrectly setting u32_min_value to
> > > 34217727
>=20
> Checking umax_val alone is be enough and we don't need to add a check for
> u32_max_value, because (when we have correct range tracking) u32_max_valu=
e
> should always be smaller than u32_value. So the fix needed here is to hav=
e
> correct range tracking.

Hello,

Sorry, I haven't noticed your reply when replying in a sibling thread.
I agree with your analysis, I think the culprit here is inability of
__reg_combine_min_max() to deal with non-overlapping ranges.

Consider example below:

SEC("?tp")
__success __retval(0)
__naked void large_shifts(void)
{
        asm volatile ("                 \
        call %[bpf_get_prandom_u32];    \
        r8 =3D r0;                        \
        r6 =3D r0;                        \
        r6 &=3D 0x00f;                    \
        r8 &=3D 0xf00;                    \
        r8 |=3D 0x0ff;                    \
        if r8 !=3D r6 goto +1;            \
        w0 >>=3D w8;       /* shift-out-bounds here */    \
        exit;                           \
"       :
        : __imm(bpf_get_prandom_u32)
        : __clobber_all);
}

Here the ranges before 'if' are {0,15} for R6 and {255,4095} for R8.
And here is the code of __reg_combine_min_max():

	...
	src_reg->umin_value =3D dst_reg->umin_value =3D max(src_reg->umin_value,
							dst_reg->umin_value);
	src_reg->umax_value =3D dst_reg->umax_value =3D min(src_reg->umax_value,
							dst_reg->umax_value);
	...

This code would be executed when 'if' is processed from the following call-=
chain:
- check_cond_jmp_op
  - reg_combine_min_max
    - __reg_combine_min_max

The src_reg is R6 and dst_reg is R8, the min/max assignments above
would produce umin_value > umax_value for any ranges {a,b}, {c,d}
where a < b < c < d.

Non-overlapping ranges can get to reg_combine_min_max() because
check_cond_jmp_op() does predictions only when one of the operands of
the comparison is constant.

I think the way to fix this bug is to:
- teach check_cond_jmp_op() to do predictions when ranges of operands
  do not overlap;
- add assertion to __reg_combine_min_max() to make sure that only
  operands with overlapping ranges are passed as arguments.

wdyt?

