Return-Path: <bpf+bounces-13241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F47D6B93
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B208A1C20E3D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C0262A7;
	Wed, 25 Oct 2023 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFjZK1ab"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374327EE5
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 12:31:16 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7C181;
	Wed, 25 Oct 2023 05:31:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da043b5b6c9so1400253276.2;
        Wed, 25 Oct 2023 05:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698237073; x=1698841873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l3I2cxFhwrz5S4I6HSq5hCGyEQj6NmZ7k4/ah/xFmA=;
        b=OFjZK1abP+NlFEc94VmLpr4Y52s9iSfkELfR9LUE1gwdJhhPVgRzqqG0kLa2KqiU3H
         LhYQbX7iLvyImSzKdkT5uqU0ge05Y1bFDeL65z8izRQ7gVMVlmrAcYjos7blQzHAO1OR
         AagOA7f4RgCZhCOA09lzTeC6a7/nNgn5dvVuVhmq96ltKoQAG3XF3/UgrgynbDGgbIMK
         Yd8gJiycC4Gm6xFbwp27FM+dC62TrpSZ0nh18lieJpbtOfoPdOMMMWOBlNlOquDDaWGR
         JOyv7BfybjVrpTJfvxV/CoHNv20dkFOZu9j6uMAaUG4i0REdjumsTU5FwYLd9jbsMe+9
         fcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237073; x=1698841873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l3I2cxFhwrz5S4I6HSq5hCGyEQj6NmZ7k4/ah/xFmA=;
        b=ECOkm81mEx67/aV+cIWniuurer3otrtv+8e2nWTFacQnOZxFrnkYwbjbw0M8ZRopT8
         hGx/jj7jrGqYy/wuzFPmqRs+6v+5ePLbUaPGGRaNvXNyhDD4c9VQdOqPIGhtasJFXO75
         buwOmzfdMtUuqmqmtf0C1p0jMRb6miRZJTDTNAbdj49wG4HcPK7j585UhLO/kvYVpnQv
         nFtVpIo4Zr+yR+VpBsxxsh3af9/1nAoDPt/n6KNmqfTN9o350e2VJ4CAOtYrgxanZCCw
         pAFplSC4RYYAVHzDK0x/RXLWaRM/Y/KO7GQzTEqyl1D6FZygM9I12kmTg9nsqR7898Hf
         J2DA==
X-Gm-Message-State: AOJu0YxNxK55E9/LWexJvR5SMQyfW4IeFE74osiO7OP9U/u5acgPK59I
	2vns7Jc632Q4wFwSivE77U98nioMutwPqMyaPA==
X-Google-Smtp-Source: AGHT+IHPmrUSM9sqyurrDYcn2Yhily2sy1cb/ruwZJEAfxFCXhuZfR1M2MqjGTq3Tjoc+dDsakGJ6MkbWz15OghpeGc=
X-Received: by 2002:a05:6902:18d2:b0:da0:76c4:fd1d with SMTP id
 ck18-20020a05690218d200b00da076c4fd1dmr2145177ybb.14.1698237073627; Wed, 25
 Oct 2023 05:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
In-Reply-To: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 25 Oct 2023 14:31:02 +0200
Message-ID: <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 2:40=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Hi,
>
> The following program can trigger a shift-out-of-bounds in
> tnum_rshift(), called by scalar32_min_max_rsh():
>
> 0: (bc) w0 =3D w1
> 1: (bf) r2 =3D r0
> 2: (18) r3 =3D 0xd
> 4: (bc) w4 =3D w0
> 5: (bf) r5 =3D r0
> 6: (bf) r7 =3D r3
> 7: (bf) r8 =3D r4
> 8: (2f) r8 *=3D r5
> 9: (cf) r5 s>>=3D r5
> 10: (a6) if w8 < 0xfffffffb goto pc+10
> 11: (1f) r7 -=3D r5
> 12: (71) r6 =3D *(u8 *)(r1 +17)
> 13: (5f) r3 &=3D r8
> 14: (74) w2 >>=3D 30
> 15: (1f) r7 -=3D r5
> 16: (5d) if r8 !=3D r6 goto pc+4
> 17: (c7) r8 s>>=3D 5
> 18: (cf) r0 s>>=3D r0
> 19: (7f) r0 >>=3D r0
> 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> 21: exit
>

Here are the c macros for the above program in case anyone needs this:

        // 0: (bc) w0 =3D w1
        BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
        // 1: (bf) r2 =3D r0
        BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
        // 2: (18) r3 =3D 0xd
        BPF_LD_IMM64(BPF_REG_3, 0xd),
        // 4: (bc) w4 =3D w0
        BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
        // 5: (bf) r5 =3D r0
        BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
        // 6: (bf) r7 =3D r3
        BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
        // 7: (bf) r8 =3D r4
        BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
        // 8: (2f) r8 *=3D r5
        BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
        // 9: (cf) r5 s>>=3D r5
        BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
        // 10: (a6) if w8 < 0xfffffffb goto pc+10
        BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
        // 11: (1f) r7 -=3D r5
        BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
        // 12: (71) r6 =3D *(u8 *)(r1 +17)
        BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
        // 13: (5f) r3 &=3D r8
        BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
        // 14: (74) w2 >>=3D 30
        BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
        // 15: (1f) r7 -=3D r5
        BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
        // 16: (5d) if r8 !=3D r6 goto pc+4
        BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
        // 17: (c7) r8 s>>=3D 5
        BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
        // 18: (cf) r0 s>>=3D r0
        BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
        // 19: (7f) r0 >>=3D r0
        BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
        // 20: (7c) w5 >>=3D w8
        BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
        BPF_EXIT_INSN()

> After load:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> shift exponent 255 is too large for 64-bit type 'long long unsigned int'
> CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
>  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
>  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
>  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
>  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
>  do_check kernel/bpf/verifier.c:16890 [inline]
>  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
>  do_check_main kernel/bpf/verifier.c:19626 [inline]
>  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
>  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
>  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
>  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
>  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x5610511e23cd
> Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
>  </TASK>
>
> If remove insn #20, the verifier gives:
>  -------- Verifier Log --------
>  func#0 @0
>  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>  0: (bc) w0 =3D w1                       ;
> R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xfffffff=
f))
> R1=3Dctx(off=3D0,
>  imm=3D0)
>  1: (bf) r2 =3D r0                       ;
> R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R2_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  2: (18) r3 =3D 0xd                      ; R3_w=3D13
>  4: (bc) w4 =3D w0                       ;
> R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  5: (bf) r5 =3D r0                       ;
> R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  6: (bf) r7 =3D r3                       ; R3_w=3D13 R7_w=3D13
>  7: (bf) r8 =3D r4                       ;
> R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R8_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  8: (2f) r8 *=3D r5                      ;
> R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R8_w=3Dscalar()
>  9: (cf) r5 s>>=3D r5                    ; R5_w=3Dscalar()
>  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=3D-5,s=
max32=3D-1,
>  umin32=3D4294967291,var_off=3D(0xfffffff8; 0xffffffff00000007))
>  11: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dscalar(=
)
>  12: (71) r6 =3D *(u8 *)(r1 +17)         ; R1=3Dctx(off=3D0,imm=3D0)
> R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,
>  var_off=3D(0x0; 0xff))
>  13: (5f) r3 &=3D r8                     ;
> R3_w=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D8,smax=3Dumax=3Dsmax32=3Dum=
ax32=3D13,var_off=3D(0x8;
>  0x5)) R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=
=3D-5,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
>  14: (74) w2 >>=3D 30                    ;
> R2_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D3,var_off=
=3D(0x0;
> 0x3))
>  15: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dscalar(=
)
>  16: (5d) if r8 !=3D r6 goto pc+3        ;
> R6_w=3Dscalar(smin=3Dumin=3Dumin32=3D4294967288,smax=3Dumax=3Dumax32=3D25=
5,smin32=3D-8,smax32=3D-1,
>  var_off=3D(0xfffffff8; 0x7))
> R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=3D-5,smax=
32=3D-1,umin32=3D4294967291)
>  17: (c7) r8 s>>=3D 5                    ; R8_w=3D134217727
>  18: (cf) r0 s>>=3D r0                   ; R0_w=3Dscalar()
>  19: (7f) r0 >>=3D r0                    ; R0=3Dscalar()
>  20: (95) exit
>
>  from 16 to 20: safe
>
>  from 10 to 20: safe
>  processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
> -------- End of Verifier Log --------
>
> In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> the check here:
>          if (umax_val >=3D insn_bitness) {
>              /* Shifts greater than 31 or 63 are undefined.
>               * This includes shifts by a negative number.
>               */
>              mark_reg_unknown(env, regs, insn->dst_reg);
>              break;
>          }
>
> However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
>
> Should we check if(src_reg->u32_max_value < insn_bitness) before calling
> scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> because issues somewhere else, incorrectly setting u32_min_value to
> 34217727
>
> Best
> Hao Sun

