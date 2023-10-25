Return-Path: <bpf+bounces-13221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E697D66A5
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54EA281B34
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E1210EB;
	Wed, 25 Oct 2023 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez17VxEt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F220B20
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 09:22:38 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712BDC;
	Wed, 25 Oct 2023 02:22:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2ea7cca04so3689445b6e.2;
        Wed, 25 Oct 2023 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698225756; x=1698830556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuMllKrf0e5wx/nBZwfJJ89yqGV6ewvo0Qm5IgKd8uU=;
        b=Ez17VxEtOyOlSOmxH6w+CFnc7vuX85YMx6WGHMDBZHTQ/TeQFvL0gSKjH/b41ALcR3
         9N+rseWgGZXgmXXfonO4+M7BDwOkXC3WZdS34gsvESvBl9IA4UDUQJHa9RG9E8m3ZeDT
         3ZHGvzSNoORk+4Uc/3OYLwAuSJxu7WrYAPBHiRNgjGx3PVy+naaU1OpoDibuJMYQ2NqY
         TYCGtCTdknruEHa71sMinPNzyv4W0CrSai7u/jmFFc+Gab74uoquZgFcZo0MLLuBvMHR
         xs3CO+7QfdpSApnmHrnmgIRmEzcMU98Vrgc0jqIr85Lw5myrho8qazDASHh+Nj5NsiiW
         C15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225756; x=1698830556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuMllKrf0e5wx/nBZwfJJ89yqGV6ewvo0Qm5IgKd8uU=;
        b=QkZXga8OUKqjRLXOUQF5mZS0xJkLjrj/5AoXI8mGbjYKZKvKwYg4o+1wJhDJoNr9vo
         JIq7QuIq9jTgKhW+NR6/ANUiyEfoOzhk8LkxH8xGQAQV/YY3jLxOMs6VqQXHo25rzsib
         O9iFctclpNZLKYKTFp2hj6HzjBbcPtGM+j8zTSGeFIwwY5bOnvyjf5jCh31xLTrSoCD3
         XSrMWyYZQFyiRETYA+eGgkxht1e2Xflj2XUrQJm+WEfLtHET9qztxobYKteaD6Rf/qfG
         W1EufxYqeMjarxtZwekPf/LXxm7ERXMe7D4YEoym7YKefENXjDubkVI7O9qhnFPjMw/j
         mGpw==
X-Gm-Message-State: AOJu0YyUyxFSHC5hhKBciNIDu3cBtQxwd4tFjAk6XitPfOWryRs91yHP
	KSLXs5g0R7fUHGKQn+3//YOL/h2FOvS0bbrcXRbXUvY1sQ==
X-Google-Smtp-Source: AGHT+IFyBzbjASwn7Zb7q3PunlrMtH+XwSxMfBQwcK6i9IjwykzIhV1/Of9wlHhowV4yivp/LsriHx3T225L/Ccl/K8=
X-Received: by 2002:a05:6808:1818:b0:3b2:e60d:27f6 with SMTP id
 bh24-20020a056808181800b003b2e60d27f6mr18041506oib.29.1698225756189; Wed, 25
 Oct 2023 02:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
In-Reply-To: <CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 25 Oct 2023 11:22:25 +0200
Message-ID: <CACkBjsa=Wwxvb21m5b+F0jtnJTc6M=7w7uKUFMMA2078cEWXSw@mail.gmail.com>
Subject: Re: bpf: incorrect value spill in check_stack_write_fixed_off()
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:16=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrot=
e:
>
> Hi,
>
> In check_stack_write_fixed_off(), the verifier creates a fake reg to stor=
e the
> imm in a BPF_ST_MEM:
> ...
> else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> insn->imm !=3D 0 && env->bpf_capable) {
>         struct bpf_reg_state fake_reg =3D {};
>
>         __mark_reg_known(&fake_reg, (u32)insn->imm);
>         fake_reg.type =3D SCALAR_VALUE;
>         save_register_state(state, spi, &fake_reg, size);
>
> Here, insn->imm is cast to u32, and used to mark fake_reg, which is incor=
rect
> and may lose sign information. Consider the following program:
>
> r2 =3D r10
> *(u64*)(r2 -40) =3D -44
> r0 =3D *(u64*)(r2 - 40)
> if r0 s<=3D 0xa goto +2
> r0 =3D 0
> exit
> r0  =3D 1
> exit
>

Sorry, the program should be:

 r2 =3D r10
 *(u64*)(r2 -40) =3D -44
 r0 =3D *(u64*)(r2 - 40)
 if r0 s<=3D 0xa goto +2
 r0 =3D 1
 exit
 r0  =3D 0
 exit

Here is the C macros for the following verifier's log:

BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
BPF_ST_MEM(BPF_DW, BPF_REG_2, -40, -44),
BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -40),
BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0xa, 2),
BPF_MOV64_IMM(BPF_REG_0, 1),
BPF_EXIT_INSN(),
BPF_MOV64_IMM(BPF_REG_0, 0),
BPF_EXIT_INSN()

> The verifier gives the following log:
>
> -------- Verifier Log --------
> func#0 @0
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 0: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> 1: (7a) *(u64 *)(r2 -40) =3D -44        ; R2_w=3Dfp0 fp-40_w=3D4294967252
> 2: (79) r0 =3D *(u64 *)(r2 -40)         ; R0_w=3D4294967252 R2_w=3Dfp0
> fp-40_w=3D4294967252
> 3: (c5) if r0 s< 0xa goto pc+2
> mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=3Dr0 stack=3D before 2: (79) r0 =3D *(u64 *)(r=
2 -40)
> 3: R0_w=3D4294967252
> 4: (b7) r0 =3D 1                        ; R0_w=3D1
> 5: (95) exit
> verification time 7971 usec
> stack depth 40
> processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>
> Here, the verifier incorrectly thinks R0 is 0xffffffd4, which should
> be 0xffffffffffffffd4,
> due to the u32 cast in check_stack_write_fixed_off(). This makes the veri=
fier
> collect incorrect reg scalar range.
>
> Since insn->imm is i32, we should cast it to the signed integer with
> correct size
> according to BPF_MEM, then promoting the imm to u64 to mark fake reg as
> known, right?
>
> Best
> Hao

