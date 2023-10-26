Return-Path: <bpf+bounces-13360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC767D8AE7
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61F2B2132C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096C3E460;
	Thu, 26 Oct 2023 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibi+7qkj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458FE3D989
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:53:31 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94ACAB;
	Thu, 26 Oct 2023 14:53:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso2354110a12.3;
        Thu, 26 Oct 2023 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698357207; x=1698962007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNH469prBRG4lBMt5BLrCZWIJ7ZH1sUOy+ueJ1L3JE8=;
        b=ibi+7qkjPAEFcSyiauBetsqE5RfAEmd5QqViu+a198yqaZsPKlAYGUsA/yFyBO1Ad0
         zp+g6W43hgF+ev84YPogVMVy8ngQ3P0fP9G1ykeLq913oFlafvKFxj326uxdV86L8l//
         2tC0VYaA6SQuguAbKrKG9YdCsKQ3HEn0oBK3kGRqNFMnThLTA4VwMr0ViRD7CEgiMHlv
         Xl+hnLhwyUfpJRKLHCf4+WOikzZYtmNKr22N2s5KrV5inCzTHdSBZDTzmIQXfAKUKIHJ
         ThFRditcrKxFniZglIgeSc2eYEWmWB8yvy0wLzsOArkLgsi3gXO87NaInAoFo5omzsac
         QokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357207; x=1698962007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNH469prBRG4lBMt5BLrCZWIJ7ZH1sUOy+ueJ1L3JE8=;
        b=KeCa8JG44Vfvr82jZN1yRU1QF1SVZ5yO2P/+i6Zn6MMJpDoYDGEfKT9SPJHerMEilz
         LnQv9bgbFH962rpcbTGNi2vp7twyAJX+xyAXfri4aIDgJ2C22AMn8wGl14zc4/vIR6S1
         Xw1Gm2/GNn9WaFwg58wPsNJcdh6CUiTFBGUWZpYmtHCUw9xZawsuQ0kNfxWAdbANrUiM
         CfeAJPf5eWcAk8ZgOfnmW+D9lGWioHWodLL+aximJwJzW3IrSvGwzPGHXFD5fNB8H8Tr
         K2n/sS2bZaLwEudzXmZF7lSbcEFxYUIlRaEWci+wGWvTkEX4qupuoh03ybjPQaGhHLIi
         jYxA==
X-Gm-Message-State: AOJu0Yx/GbUu0zYBn2EeK0xjBt4B2PzyP1U8N4qFg95Y7Q5G0xZcZKNa
	X4bU+TbVK/o1pfydaxxqgYJRDJ2/GlGEhavyd57PeffS
X-Google-Smtp-Source: AGHT+IGNMC83R+q47uX04Y2/j/IeIiVi+4yhJFvpyRasRk9+tvwqvFmuK6PzpNmFnSq5gJWsbjcn1gRyMbG7kaZoUkM=
X-Received: by 2002:a17:907:9341:b0:9b2:b71f:83be with SMTP id
 bv1-20020a170907934100b009b2b71f83bemr771116ejc.1.1698357206954; Thu, 26 Oct
 2023 14:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
 <ZTkhlwP-LkPkOjK2@u94a> <8731196c9a847ff35073a2034662d3306cea805f.camel@gmail.com>
 <ZToKz8NOLK-yV8dt@u94a>
In-Reply-To: <ZToKz8NOLK-yV8dt@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Oct 2023 14:53:15 -0700
Message-ID: <CAEf4Bza+PkDN+rChAEBK7TcR7r_-xVSW5_cQcRXEzmF0wSt_WQ@mail.gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao Sun <sunhao.th@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:44=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> Hi Andrii,
>
> The fix needed here to address the "non-overlapping ranges in
> __reg_combine_min_max()" issue sounds like something you'd already have i=
n
> the range-vs-range series you mentioned previously. Maybe you've already =
got
> a patch for this?
>
> On Thu, Oct 26, 2023 at 12:59:19AM +0300, Eduard Zingerman wrote:
> > On Wed, 2023-10-25 at 22:09 +0800, Shung-Hsi Yu wrote:
> > > Hi Hao,
> > > On Wed, Oct 25, 2023 at 02:31:02PM +0200, Hao Sun wrote:
> > > > On Tue, Oct 24, 2023 at 2:40=E2=80=AFPM Hao Sun <sunhao.th@gmail.co=
m> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > The following program can trigger a shift-out-of-bounds in
> > > > > tnum_rshift(), called by scalar32_min_max_rsh():
> > > > >
> > > > > 0: (bc) w0.
> > > =3D w1
> > > > > 1: (bf) r2 =3D r0
> > > > > 2: (18) r3 =3D 0xd
> > > > > 4: (bc) w4 =3D w0
> > > > > 5: (bf) r5 =3D r0
> > > > > 6: (bf) r7 =3D r3
> > > > > 7: (bf) r8 =3D r4
> > > > > 8: (2f) r8 *=3D r5
> > > > > 9: (cf) r5 s>>=3D r5
> > > > > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > > > 11: (1f) r7 -=3D r5
> > > > > 12: (71) r6 =3D *(u8 *)(r1 +17)
> > > > > 13: (5f) r3 &=3D r8
> > > > > 14: (74) w2 >>=3D 30
> > > > > 15: (1f) r7 -=3D r5
> > > > > 16: (5d) if r8 !=3D r6 goto pc+4
> > > > > 17: (c7) r8 s>>=3D 5
> > > > > 18: (cf) r0 s>>=3D r0
> > > > > 19: (7f) r0 >>=3D r0
> > > > > 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> > > > > 21: exit
> > > > >
> > > >
> > > > Here are the c macros for the above program in case anyone needs th=
is:
> > > >
> > > >         // 0: (bc) w0 =3D w1
> > > >         BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
> > > >         // 1: (bf) r2 =3D r0
> > > >         BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
> > > >         // 2: (18) r3 =3D 0xd
> > > >         BPF_LD_IMM64(BPF_REG_3, 0xd),
> > > >         // 4: (bc) w4 =3D w0
> > > >         BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
> > > >         // 5: (bf) r5 =3D r0
> > > >         BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
> > > >         // 6: (bf) r7 =3D r3
> > > >         BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
> > > >         // 7: (bf) r8 =3D r4
> > > >         BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
> > > >         // 8: (2f) r8 *=3D r5
> > > >         BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
> > > >         // 9: (cf) r5 s>>=3D r5
> > > >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
> > > >         // 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > >         BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
> > > >         // 11: (1f) r7 -=3D r5
> > > >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> > > >         // 12: (71) r6 =3D *(u8 *)(r1 +17)
> > > >         BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
> > > >         // 13: (5f) r3 &=3D r8
> > > >         BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
> > > >         // 14: (74) w2 >>=3D 30
> > > >         BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
> > > >         // 15: (1f) r7 -=3D r5
> > > >         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
> > > >         // 16: (5d) if r8 !=3D r6 goto pc+4
> > > >         BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
> > > >         // 17: (c7) r8 s>>=3D 5
> > > >         BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
> > > >         // 18: (cf) r0 s>>=3D r0
> > > >         BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
> > > >         // 19: (7f) r0 >>=3D r0
> > > >         BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
> > > >         // 20: (7c) w5 >>=3D w8
> > > >         BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
> > > >         BPF_EXIT_INSN()
> > > >
> > > > > After load:
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> > > > > shift exponent 255 is too large for 64-bit type 'long long unsign=
ed int'
> > > > > CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> > > > > 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.=
0-1 04/01/2014
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > >  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
> > > > >  ubsan_epilogue lib/ubsan.c:217 [inline]
> > > > >  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
> > > > >  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
> > > > >  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
> > > > >  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
> > > > >  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:1333=
8
> > > > >  do_check kernel/bpf/verifier.c:16890 [inline]
> > > > >  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
> > > > >  do_check_main kernel/bpf/verifier.c:19626 [inline]
> > > > >  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
> > > > >  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
> > > > >  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
> > > > >  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
> > > > >  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
> > > > >  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
> > > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > RIP: 0033:0x5610511e23cd
> > > > > Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01=
 00
> > > > > 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> > > > > RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00141
> > > > > RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> > > > > RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> > > > > RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> > > > > R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
> > > > >  </TASK>
> > > > >
> > > > > If remove insn #20, the verifier gives:
> > > > >  -------- Verifier Log --------
> > > > >  func#0 @0
> > > > >  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > > >  0: (bc) w0 =3D w1                       ;
> > > > > R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
> > > > > R1=3Dctx(off=3D0,
> > > > >  imm=3D0)
> > > > >  1: (bf) r2 =3D r0                       ;
> > > > > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D=
(0x0;
> > > > > 0xffffffff))
> > > > >  R2_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=
=3D(0x0; 0xffffffff))
> > > > >  2: (18) r3 =3D 0xd                      ; R3_w=3D13
> > > > >  4: (bc) w4 =3D w0                       ;
> > > > > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D=
(0x0;
> > > > > 0xffffffff))
> > > > >  R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=
=3D(0x0; 0xffffffff))
> > > > >  5: (bf) r5 =3D r0                       ;
> > > > > R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D=
(0x0;
> > > > > 0xffffffff))
> > > > >  R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=
=3D(0x0; 0xffffffff))
> > > > >  6: (bf) r7 =3D r3                       ; R3_w=3D13 R7_w=3D13
> > > > >  7: (bf) r8 =3D r4                       ;
> > > > > R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D=
(0x0;
> > > > > 0xffffffff))
> > > > >  R8_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=
=3D(0x0; 0xffffffff))
> > > > >  8: (2f) r8 *=3D r5                      ;
> > > > > R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D=
(0x0;
> > > > > 0xffffffff))
> > > > >  R8_w=3Dscalar()
> > > > >  9: (cf) r5 s>>=3D r5                    ; R5_w=3Dscalar()
> > > > >  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> > > > > R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin3=
2=3D-5,smax32=3D-1,
> > > > >  umin32=3D4294967291,var_off=3D(0xfffffff8; 0xffffffff00000007))
> > > > >  11: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=
=3Dscalar()
> > > > >  12: (71) r6 =3D *(u8 *)(r1 +17)         ; R1=3Dctx(off=3D0,imm=
=3D0)
> > > > > R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2=
55,
> > > > >  var_off=3D(0x0; 0xff))
> > > > >  13: (5f) r3 &=3D r8                     ;
> > > > > R3_w=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D8,smax=3Dumax=3Dsma=
x32=3Dumax32=3D13,var_off=3D(0x8;
> > > > >  0x5)) R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D429496728=
8,smin32=3D-5,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
> > > > >  14: (74) w2 >>=3D 30                    ;
> > > > > R2_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D3=
,var_off=3D(0x0;
> > > > > 0x3))
> > > > >  15: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=
=3Dscalar()
> > > > >  16: (5d) if r8 !=3D r6 goto pc+3        ;
> > > > > R6_w=3Dscalar(smin=3Dumin=3Dumin32=3D4294967288,smax=3Dumax=3Duma=
x32=3D255,smin32=3D-8,smax32=3D-1,
> > > > >  var_off=3D(0xfffffff8; 0x7))
> > > > > R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=
=3D-5,smax32=3D-1,umin32=3D4294967291)
> > >
> > > Seems like the root cause is a bug with range tracking, before instru=
ction
> > > 16, R8_w was
> > >
> > >   R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=
=3D-5,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
> > >
> > > But after instruction 16 it becomes
> > >
> > >   R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=3D-=
5,smax32=3D-1,umin32=3D4294967291)
> > >
> > > Where smin_value > smax_value, and umin_value > umax_value (among oth=
er
> > > things). This should be the main problem.
> > >
> > > The verifier operates on the assumption that smin_value <=3D smax_val=
ue and
> > > umin_value <=3D umax_value, and if that assumption is not upheld then=
 all kind
> > > of things can go wrong.
> > >
> > > Maybe Andrii may already has this worked out in the range-vs-range th=
at he
> > > has mentioned[1] he'll be sending soon.

Yes, I think so. I did add few more conditions to BPF_JEQ/BPF_JNE to
prevent situations where we have to "combine" non-overlapping regions.
I don't know if my changes fix this specific condition, so having a
nice and short repro from Eduard is great.

I intend to submit a full series for reg bounds improvements in the
next few working days.

> > >
> > > 1: https://lore.kernel.org/bpf/CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7=
-9ou_RaQV7B8A@mail.gmail.com/
> > >
> > > > >  17: (c7) r8 s>>=3D 5                    ; R8_w=3D134217727
> > > > >  18: (cf) r0 s>>=3D r0                   ; R0_w=3Dscalar()
> > > > >  19: (7f) r0 >>=3D r0                    ; R0=3Dscalar()
> > > > >  20: (95) exit
> > > > >
> > > > >  from 16 to 20: safe
> > > > >
> > > > >  from 10 to 20: safe
> > > > >  processed 22 insns (limit 1000000) max_states_per_insn 0 total_s=
tates
> > > > > 1 peak_states 1 mark_read 1
> > > > > -------- End of Verifier Log --------
> > > > >
> > > > > In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pa=
ss
> > > > > the check here:
> > > > >          if (umax_val >=3D insn_bitness) {
> > > > >              /* Shifts greater than 31 or 63 are undefined.
> > > > >               * This includes shifts by a negative number.
> > > > >               */
> > > > >              mark_reg_unknown(env, regs, insn->dst_reg);
> > > > >              break;
> > > > >          }
> > > > >
> > > > > However in scalar32_min_max_rsh(), both src_reg->u32_min_value an=
d
> > > > > src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 2=
55.
> > > > >
> > > > > Should we check if(src_reg->u32_max_value < insn_bitness) before =
calling
> > > > > scalar32_min_max_rsh(), rather than only checking umax_val? Or, i=
s it
> > > > > because issues somewhere else, incorrectly setting u32_min_value =
to
> > > > > 34217727
> > >
> > > Checking umax_val alone is be enough and we don't need to add a check=
 for
> > > u32_max_value, because (when we have correct range tracking) u32_max_=
value
> > > should always be smaller than u32_value. So the fix needed here is to=
 have
> > > correct range tracking.
> >
> > Hello,
> >
> > Sorry, I haven't noticed your reply when replying in a sibling thread.
>
> That's something I struggle with too :)
>
> > I agree with your analysis, I think the culprit here is inability of
> > __reg_combine_min_max() to deal with non-overlapping ranges.
> >
> > Consider example below:
> >
> > SEC("?tp")
> > __success __retval(0)
> > __naked void large_shifts(void)
> > {
> >         asm volatile ("                 \
> >         call %[bpf_get_prandom_u32];    \
> >         r8 =3D r0;                        \
> >         r6 =3D r0;                        \
> >         r6 &=3D 0x00f;                    \
> >         r8 &=3D 0xf00;                    \
> >         r8 |=3D 0x0ff;                    \
> >         if r8 !=3D r6 goto +1;            \
> >         w0 >>=3D w8;       /* shift-out-bounds here */    \
> >         exit;                           \
> > "       :
> >         : __imm(bpf_get_prandom_u32)
> >         : __clobber_all);
> > }
> >
> > Here the ranges before 'if' are {0,15} for R6 and {255,4095} for R8.
> >
> > And here is the code of __reg_combine_min_max():
> >
> >       ...
> >       src_reg->umin_value =3D dst_reg->umin_value =3D max(src_reg->umin=
_value,
> >                                                       dst_reg->umin_val=
ue);
> >       src_reg->umax_value =3D dst_reg->umax_value =3D min(src_reg->umax=
_value,
> >                                                       dst_reg->umax_val=
ue);
> >       ...
> >
> > This code would be executed when 'if' is processed from the following c=
all-chain:
> > - check_cond_jmp_op
> >   - reg_combine_min_max
> >     - __reg_combine_min_max
> >
> > The src_reg is R6 and dst_reg is R8, the min/max assignments above
> > would produce umin_value > umax_value for any ranges {a,b}, {c,d}
> > where a < b < c < d.
> >
> > Non-overlapping ranges can get to reg_combine_min_max() because
> > check_cond_jmp_op() does predictions only when one of the operands of
> > the comparison is constant.
> >
> > I think the way to fix this bug is to:
> > - teach check_cond_jmp_op() to do predictions when ranges of operands
> >   do not overlap;
> > - add assertion to __reg_combine_min_max() to make sure that only
> >   operands with overlapping ranges are passed as arguments.
> >
> > wdyt?
>
> Agree on both points above. For the assertion in __reg_combine_min_max() =
I
> think verbose("BUG...") plus __mark_reg_unknown() on both src_reg and
> dst_reg should be enough.

