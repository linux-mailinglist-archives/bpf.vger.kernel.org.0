Return-Path: <bpf+bounces-54112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0FA6329E
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 22:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52E016D68E
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AAE1A0BE0;
	Sat, 15 Mar 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaD4e/5w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75261991C9
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742075370; cv=none; b=E7w3JqMIjLOjicTmaVQY2aO5wumR/+757GMVWvV+NuODICYNgO7FR0+qVnUBdAmFllHHjdNtFf9cHZ8TXufyM3eHmoMC1keV6OJq45+UBIm7R+DSIhtCsWMm1qvY8l9VjPvC66hmvNp+I28GqM2288ZUpGIS1kIpWAGUHDdiwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742075370; c=relaxed/simple;
	bh=utj7T2zjLM6qpykTGs4WjIvLnXZHO8IrJV3zbUY/Gyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAojccn3qVqs5hvpIug4KFt03VOa3EWNUdgrFCxQsL6ZyX1opjbGAKrKcVB07FEem67a1mns/c8vNnEPFj9I1DisDM6XdRR3b8hjt9vu+TNSus2X9Aoiex38hXuqMTYJdFLM3jbmfKP135CR0xuc3GfbUFmULzHgvdVf1StcRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaD4e/5w; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4767e969b94so53551981cf.2
        for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742075367; x=1742680167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htMXExvmZBQm7d6kU9o8ufhUChLLpNIQghzJTcbu4/A=;
        b=PaD4e/5wg2FD4Ifdq0tr/PLbyxcsXHfw6yrdCtQs5B2eU9FduR5Zm0WZsUq7CRIqBA
         RUy3+RYk3awtFpXWC7FPA9vWDKEgHtFJiXOKZAHkd9e+kJdeCLww3vXSfUOCRU6+9cFJ
         vzQX7Z4O8HhWtwCW8sCBeY6A8sKmO0Vw1uT0RseSZoJBjb/AlENu3cylnK3noBvDR64/
         /Dg0Xq0KeRH1RbaZLoLaiDl4RV3M+Z5W4Jv6TWiD8bvHgAt3K6SoiHrYbjrpZv6JrJ3O
         Xj1py4QUC+ojcB0lsURIbRKgmVL9ar7dqjj49iUtUEYoUfva0SidG38hlsc8SdRRpv4W
         /PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742075367; x=1742680167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htMXExvmZBQm7d6kU9o8ufhUChLLpNIQghzJTcbu4/A=;
        b=iOF9r8l2Pgg8LlnFtHGTnEUJ072soNQqLMUU+NtIMfGp2DRwR2UuEMhi18e9sAuM1D
         FviqUw9aMha7A3ObOr2FBuASqiQgk1ud6AILdzw72ti/sj4SpIV9Rb4mfimox3KZFfst
         7o/MPMvFe8SUW0WbqxuQWwu9pphhDgrPO4xCGEdQR4yVWaCt4muTAop6RsjbodW2FxN0
         8y0NrYV+mXfDN62THoEB6nBQ85v25pHiBhXR/puzgdFIIJTZze/OBNNykI1PGhjmqtjw
         QCHx841WEg3xsRfyfDyqoCACngx9EW5xDifFl562eJ8Yp5o7pAHIufFJNgR3unqnw1Hi
         c0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHLCSXJrhQ3C7I6FYWop5yJ/qdgcuiXVoPwmgtEJk7qVz4iD/RTmJKrSGIBN9luZS50oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYIBi7S3Kt60jnro+54kOtKlCBpXmDsxbt7QDg4XLt07yN7m2
	/CMMgK+wyJNEzePFoqjooHGTbMfH2zKhiXjIJ/6T3FZaywnNcLrNQCzXZY+CmfaC3T4OuFb0aUe
	IEd41qCDsdY6tJb+qPTmggxPcmhyEQYEc
X-Gm-Gg: ASbGncvQXJeNyViaCsYBLMqPR35hDLwGZyULr6XAsLV54Vliy9dteP3pjo6/tlop0jF
	xjDtbfDDbNsm9n/UtAPQsPwPa3QoyOJRO+b+u+xf2J3P6xyvGOBvUCEqD4ggP0MXM5SnNEbCnvT
	Tgd1id1+HdczdJJGtrasGYdrAaNNhZaTEc/cK5LI6NFLr7d9KMBJVZvIqbA/M=
X-Google-Smtp-Source: AGHT+IFMwa7QDGNX9RO7A6hcfLWK9lJOQ79D8v4yAh9k4h/Gpu/TWynAhn4DEMBHiNkl1mXky7zG38a9scrLcuvmDN8=
X-Received: by 2002:a05:622a:1496:b0:474:fee1:7915 with SMTP id
 d75a77b69052e-476c81682d5mr124403151cf.31.1742075367544; Sat, 15 Mar 2025
 14:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315080320.4193821-1-hengqi.chen@gmail.com>
In-Reply-To: <20250315080320.4193821-1-hengqi.chen@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sat, 15 Mar 2025 14:49:16 -0700
X-Gm-Features: AQ5f1JrCTgTsTFN_PWCWd0JGY8245UQ4qmXfu01j_vQCgwV5WvkunWqZ7rO12w0
Message-ID: <CAK3+h2xxwarw1uBo0R9r=4zVA6rEwDDz=de-cr4RqSBPSLvF=Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix off by one error in build_prologue()
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 1:03=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Vincent reported that running BPF progs with tailcalls on LoongArch
> causes kernel hard lockup. Debugging the issues shows that the JITed
> image missing a jirl instruction at the end of the epilogue.
>
> There are two passes in JIT compile, the first pass set the flags and
> the second pass generates JIT code based on those flags. With BPF progs
> mixing bpf2bpf and tailcalls, build_prologue() generates N insns in the
> first pass and then generates N+1 insns in the second pass. This makes
> epilogue_offset off by one and we will jump to some unexpected insn and
> cause lockup. Fix this by inserting a nop insn.
>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcall=
s")
> Reported-by: Vincent Li <vincent.mc.li@gmail.com>
> Closes: https://lore.kernel.org/loongarch/CAK3+h2w6WESdBN3UCr3WKHByD7D6Q_=
Ve1EDAjotVrnx6Or_c8g@mail.gmail.com/
> Closes: https://lore.kernel.org/bpf/CAK3+h2woEjG_N=3D-XzqEGaAeCmgu2eTCUc7=
p6bP4u8Q+DFHm-7g@mail.gmail.com/
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/include/asm/inst.h | 5 +++++
>  arch/loongarch/net/bpf_jit.c      | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 3089785ca97e..d61b356170fe 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -695,6 +695,11 @@ static inline void emit_jirl(union loongarch_instruc=
tion *insn,
>         insn->reg2i16_format.rj =3D rj;
>  }
>
> +static inline void emit_nop(union loongarch_instruction *insn)
> +{
> +       insn->word =3D INSN_NOP;
> +}
> +
>  #define DEF_EMIT_REG2BSTRD_FORMAT(NAME, OP)                            \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
>                                enum loongarch_gpr rd,                   \
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ea357a3edc09..2346c0b55043 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -142,6 +142,8 @@ static void build_prologue(struct jit_ctx *ctx)
>          */
>         if (seen_tail_call(ctx) && seen_call(ctx))
>                 move_reg(ctx, TCC_SAVED, REG_TCC);
> +       else
> +               emit_insn(ctx, nop);
>
>         ctx->stack_size =3D stack_adjust;
>  }
> --
> 2.43.5
>

Thanks Hengqi for the patch, I tested the patch on the LoongArch
platform with the loxilb tc BPF program, it does not lockup up the
kernel anymore.

attach loxilb tc BPF program to loongfire firewall green0 interface

[root@loongfire ~]# loxilb --whitelist=3D"green0"
loxilb start
...
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook1
prog tc_packet_func
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook2
prog tc_packet_func_slow
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook3
prog tc_packet_func_fw
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook4
prog tc_csum_func1
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook5
prog tc_csum_func2
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook6
prog tc_slow_unp_func
14:43:13 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook7
prog tc_packet_func_masq
libbpf: Error in bpf_create_map_xattr(nh_map):Invalid argument(-22).
Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(xctk):Operation not
supported(-95). Retrying without BTF.
2025-03-15 14:43:14 Get xsync()
14:43:15 INFO  common_libbpf.c:204: tc: bpf attach OK for green0
<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
14:43:15 DEBUG loxilb_libdp.c:3311: llb_link_prop_add: IF-green0 added
idx 1 type 2
2025-03-15 14:43:15 ebpf intfmap added - 5 vlan 0 -> 1
2025-03-15 14:43:15 ebpf txintfmap added - 1 -> 5

Above log shows the program loaded and attached to the green0
interface, no lockup.

One strange thing is that bpftool net does not show the tc BPF program
attached to green0 interface, attached to virtual interface llb0 ok, I
guess this should be irrelevant to kernel lockup issue.

[root@loongfire ~]# bpftool net
xdp:
llb0(7) generic id 55

tc:
llb0(7) clsact/ingress tc_packet_func_:[59] id 59

flow_dissector:

netfilter:

