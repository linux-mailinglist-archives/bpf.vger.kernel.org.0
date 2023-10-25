Return-Path: <bpf+bounces-13244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 561717D6CFD
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A141C20DD1
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679AF27ECB;
	Wed, 25 Oct 2023 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ+3z9/Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB71380
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 13:20:44 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE1111;
	Wed, 25 Oct 2023 06:20:42 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d84c24a810dso4894028276.2;
        Wed, 25 Oct 2023 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698240041; x=1698844841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPF+5Rsz+apiPCuGIdBu5hhoVuX8IXXK92UDgsE51EY=;
        b=lQ+3z9/Q2uCxd+cHRxB6CqFsfiidtLdbnZy/LXXV6WCOindSSmnv7YOPbgrL7hy02b
         lGYAOEr+gl/mhsV61L8Atqt0H1FuDIQg5EO9RCOnQPLr368tijIBG1+cNiqOWxiR2npA
         8DXqYsEGC0iaHlJGCPsJgBgW4cISVW/BMHNIouoswdsdJ8a2B9uwqRTd83xSrb7a2XBl
         6XizrbOo8Go4hJJg8X0Fb+umpOdhJi8Nr8LxXQ+XdYvRsHrNQXlIVyZ6A60tPZyIF3ET
         gGzft78Z55PDIKi95hzu8VdK8Vohxng93ZPZ9QSk2HxVmWLKH/5UfgXXFaLL43IIPrEq
         PdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240041; x=1698844841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPF+5Rsz+apiPCuGIdBu5hhoVuX8IXXK92UDgsE51EY=;
        b=TeVw5nrcnvFwRnkyh8PaA6IyyxdcOSqWO8bAmPr3pW9lw5LpDQHyIdnDRFQ296C0tl
         kwmEDnLixlSc+esnWkIdL8NCdY89h2PBIVj9naMco5bNBuqGAJZKIKUPL2u0rZ1u7Ujj
         f05svS0NnzRq4vu+efQytoiQR0OeTAQ26OpTp0wttCyEQnS/1hbFbR7VdtqiQlCyLD7j
         N2QjX51caMokYn3XqL9xff8f6mtoMIgXCQkrgRcKQf2yVu5sZD+8EoHt29tn5ZGou+E0
         mB0r3GYP5G9O939QMfCzP2hnMc8JDCqWvLWaMKC2FCkGpcuPverYghnImVqNY2UIhthI
         B00w==
X-Gm-Message-State: AOJu0Yx+5V0drmcpQiYatuviFaDc7SWB+3EVfV5/AA7VLtELEOKVks6n
	RyqPUocrgGFy4iPk1OznSKcbPbvw4HutZT+Irg==
X-Google-Smtp-Source: AGHT+IFLcsLSPKofOHu3dzTz4AZ1rnCSfsnB8IkZsu8AAEegFHBMsO/Qf1WLF1WQHbiJsXgzosCssWZXEzoyfbfzDeg=
X-Received: by 2002:a25:aca0:0:b0:d9a:4d90:feda with SMTP id
 x32-20020a25aca0000000b00d9a4d90fedamr261633ybi.62.1698240041458; Wed, 25 Oct
 2023 06:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
In-Reply-To: <CACkBjsbYMC7PgoGDK71fnqJ3QMywrwoA5Ctzh84Ldp6U_+_Ygg@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 25 Oct 2023 15:20:29 +0200
Message-ID: <CACkBjsYHN2VGjRUV_KA+EBPYeOjBbOgysj4JVBFqd6pPBN-_0w@mail.gmail.com>
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

On Wed, Oct 25, 2023 at 2:31=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> On Tue, Oct 24, 2023 at 2:40=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wro=
te:
> >
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
> >
>
> Here are the c macros for the above program in case anyone needs this:
>
>         // 0: (bc) w0 =3D w1
>         BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
>         // 1: (bf) r2 =3D r0
>         BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
>         // 2: (18) r3 =3D 0xd
>         BPF_LD_IMM64(BPF_REG_3, 0xd),
>         // 4: (bc) w4 =3D w0
>         BPF_MOV32_REG(BPF_REG_4, BPF_REG_0),
>         // 5: (bf) r5 =3D r0
>         BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
>         // 6: (bf) r7 =3D r3
>         BPF_MOV64_REG(BPF_REG_7, BPF_REG_3),
>         // 7: (bf) r8 =3D r4
>         BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
>         // 8: (2f) r8 *=3D r5
>         BPF_ALU64_REG(BPF_MUL, BPF_REG_8, BPF_REG_5),
>         // 9: (cf) r5 s>>=3D r5
>         BPF_ALU64_REG(BPF_ARSH, BPF_REG_5, BPF_REG_5),
>         // 10: (a6) if w8 < 0xfffffffb goto pc+10
>         BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0xfffffffb, 10),
>         // 11: (1f) r7 -=3D r5
>         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
>         // 12: (71) r6 =3D *(u8 *)(r1 +17)
>         BPF_LDX_MEM(BPF_B, BPF_REG_6, BPF_REG_1, 17),
>         // 13: (5f) r3 &=3D r8
>         BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_8),
>         // 14: (74) w2 >>=3D 30
>         BPF_ALU32_IMM(BPF_RSH, BPF_REG_2, 30),
>         // 15: (1f) r7 -=3D r5
>         BPF_ALU64_REG(BPF_SUB, BPF_REG_7, BPF_REG_5),
>         // 16: (5d) if r8 !=3D r6 goto pc+4
>         BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_6, 4),
>         // 17: (c7) r8 s>>=3D 5
>         BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 5),
>         // 18: (cf) r0 s>>=3D r0
>         BPF_ALU64_REG(BPF_ARSH, BPF_REG_0, BPF_REG_0),
>         // 19: (7f) r0 >>=3D r0
>         BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_0),
>         // 20: (7c) w5 >>=3D w8
>         BPF_ALU32_REG(BPF_RSH, BPF_REG_5, BPF_REG_8),
>         BPF_EXIT_INSN()
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

Here is another similar one, which can probably be fixed in the same
patch. Build the kernel with UBSAN and run the following repro can
easily reproduce this.

C reproducer: https://pastebin.com/raw/zNfHaBnj

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
UBSAN: shift-out-of-bounds in kernel/bpf/verifier.c:13049:63
shift exponent 55 is too large for 32-bit type 'int'
CPU: 3 PID: 8614 Comm: poc Not tainted 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty =
#22
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
 scalar32_min_max_arsh kernel/bpf/verifier.c:13049 [inline]
 adjust_scalar_min_max_vals kernel/bpf/verifier.c:13237 [inline]
 adjust_reg_min_max_vals.cold+0x116/0x353 kernel/bpf/verifier.c:13338
 do_check kernel/bpf/verifier.c:16890 [inline]
 do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
 do_check_main kernel/bpf/verifier.c:19626 [inline]
 bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
 bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
 __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
 __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x43b0a9
Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 48
RSP: 002b:00007fffec705b18 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fffec705ff8 RCX: 000000000043b0a9
RDX: 0000000000000080 RSI: 00007fffec705b30 RDI: 0000000000000005
RBP: 00007fffec705c00 R08: 0000000400000002 R09: 0000003e00000000
R10: 00000000000000fc R11: 0000000000000202 R12: 0000000000000001
R13: 00007fffec705fe8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

