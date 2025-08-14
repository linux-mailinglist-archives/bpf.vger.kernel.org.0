Return-Path: <bpf+bounces-65594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF5B259CB
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 05:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B537A709D
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 03:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7691EA7DF;
	Thu, 14 Aug 2025 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJnDIFaR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007652AE90
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141846; cv=none; b=IqRl8W8/qmCR5QUyNjJ6VdqemZxzeC2uxvY9UjspYzI1/H4ajhpe5SmIdZ1ck3jvbLsHtR69FlggG2nsFCsYopkO/H5RFJUrG9Cp18Yg3frH6YHbOUAuShOCv/f/vqvhwNS49eFH/pe1tc4rsYKnj4X9cFw9gysLw/tWK+xHceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141846; c=relaxed/simple;
	bh=y5ZvVMzRpasDaUW7mPHJTZe8nCpU5xTMkweHjnWLROw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiJ0ZlepAquLLxhQYmPaNRfoaDreKP4tdV2gQkfMnC1jhpJslJSZs04Kyf2bWdrXLk0/13rpL1prsUwQTOHzQsF5+hwllayttaHQ+8rmGZu5b2LHd0fZvqLpYO9+vNKwRz7r+KM7Bi//XBsjbonxjs9gLynNa9DBaP7wts9luFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJnDIFaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4BC4CEF5
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 03:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755141845;
	bh=y5ZvVMzRpasDaUW7mPHJTZe8nCpU5xTMkweHjnWLROw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oJnDIFaRhemZx4dTC6FXTx/C4He3ToyrFHz5W3Il2F3GWttNX/LS01kmAAHNKC2gD
	 tsX0Y370UTuCuFBFD+YYVtsJgbO4f6aohVKiRv5qRby2zdNZXQtF8CiMzgb0HT+WHU
	 tjco236RCGpNz+GGCvifcnQS9IUnICxG9ajtq8uB9XulCjuKyp8kCeUSEwBvWY2B10
	 eCBgatlItlQMrX7pI1JEZa4NNJC5k2XivnTESVZiiJ+wUCrE+UTzNoIgPHajU84E4n
	 IKVagQ1VxGWT/Vbld6J3fS47Iw56QpUlrSJjJ+Fm921a72a9cf3KCRbBi5DkKaqrSe
	 7uf1OVVer3PXA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b65a2f0so942286a12.1
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 20:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWewLfwSllI70tNKwfvpnZunAC0UIidM641viVrRoMMeGxzaMWlWVmOlotNIqZp/O+g6sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRnso1MXbbgcLSbpJl+iykK52oLWQTuj9yDqZ/c1yQC84cPnK
	pMSnF2j0LT30aumHh08nxK4GHzptCCh8f1MJDncRpwhKAtT6yIBhaSDywGliT4BQpxrOImGXHa7
	p/O57aSBXA0bKfSPnWhyP3hJsTRvD9fo=
X-Google-Smtp-Source: AGHT+IFWzXBB0SMMRRlE+hRu89CpzWjYI531lliy5GnGIsdMy99D9nkytOgGSFSFjQ6llVOpzR69KFGkY0XWBDP3EZE=
X-Received: by 2002:a05:6402:34cc:b0:615:5536:65f with SMTP id
 4fb4d7f45d1cf-618919d7313mr929238a12.32.1755141843917; Wed, 13 Aug 2025
 20:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814013412.108668-1-jianghaoran@kylinos.cn>
In-Reply-To: <20250814013412.108668-1-jianghaoran@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Aug 2025 11:23:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5RRRMsmdbcB-Jq=04C3r+7g_Sq-OB7pLEu8z3y_-==og@mail.gmail.com>
X-Gm-Features: Ac12FXzFd67te0XViLg52ChvtwstrGQbYF1sczjX4gYRJbt4owng6xhz7ab0UJM
Message-ID: <CAAhV-H5RRRMsmdbcB-Jq=04C3r+7g_Sq-OB7pLEu8z3y_-==og@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix incorrect return pointer value in the
 eBPF program
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	hengqi.chen@gmail.com, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Haoran,

On Thu, Aug 14, 2025 at 9:34=E2=80=AFAM Haoran Jiang <jianghaoran@kylinos.c=
n> wrote:
>
> In some eBPF programs, the return value is a pointer.
> When the kernel call an eBPF program (such as struct_ops),
> it expects a 64-bit address to be returned, but instead a 32-bit value.
>
> Before applying this patch:
> ./test_progs -a ns_bpf_qdisc
> CPU 7 Unable to handle kernel paging request at virtual
> address 0000000010440158.
>
> As shown in the following test case,
> bpf_fifo_dequeue return value is a pointer.
> progs/bpf_qdisc_fifo.c
>
> SEC("struct_ops/bpf_fifo_dequeue")
> struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
> {
>         struct sk_buff *skb =3D NULL;
>         ........
>         skb =3D bpf_kptr_xchg(&skbn->skb, skb);
>         ........
>         return skb;
> }
>
> kernel call bpf_fifo_dequeue=EF=BC=9A
> net/sched/sch_generic.c
>
> static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
>                                    int *packets)
> {
>         struct sk_buff *skb =3D NULL;
>         ........
>         skb =3D q->dequeue(q);
>         .........
> }
> When accessing the skb, an address exception error will occur.
> because the value returned by q->dequeue at this point is a 32-bit
> address rather than a 64-bit address.
>
> After applying the patch=EF=BC=9A
> ./test_progs -a ns_bpf_qdisc
> Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
> 213/1   ns_bpf_qdisc/fifo:OK
> 213/2   ns_bpf_qdisc/fq:OK
> 213/3   ns_bpf_qdisc/attach to mq:OK
> 213/4   ns_bpf_qdisc/attach to non root:OK
> 213/5   ns_bpf_qdisc/incompl_ops:OK
> 213     ns_bpf_qdisc:OK
> Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
>
> Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
Can this patch solve this bug?
https://lore.kernel.org/loongarch/CAK3+h2x1gjuqEsUSj+B-9sb73kRo3bStH6ROw=3D=
1LVSqQGMNcUw@mail.gmail.com/T/#t

Huacai

> ---
>  arch/loongarch/net/bpf_jit.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..7df067a42f36 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -229,8 +229,24 @@ static void __build_epilogue(struct jit_ctx *ctx, bo=
ol is_tail_call)
>         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_a=
djust);
>
>         if (!is_tail_call) {
> -               /* Set return value */
> +               /*
> +                *  Set return value
> +                *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If i=
t is,
> +                *  the value in regmap[BPF_REG_0] is a kernel-space addr=
ess.
> +                *
> +                *  t1 =3D regmap[BPF_REG_0] >> 63
> +                *  t2 =3D 1
> +                *  if(t2 =3D=3D t1)
> +                *      move a0 <- regmap[BPF_REG_0]
> +                *  else
> +                *      addiw a0 <- regmap[BPF_REG_0] + 0
> +                */
> +               emit_insn(ctx, srlid, LOONGARCH_GPR_T1, regmap[BPF_REG_0]=
, 63);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_T2, LOONGARCH_GPR_ZER=
O, 0x1);
> +               emit_cond_jmp(ctx, BPF_JEQ, LOONGARCH_GPR_T1, LOONGARCH_G=
PR_T2, 3);
>                 emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0]=
, 0);
> +               emit_uncond_jmp(ctx, 2);
> +               move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
>                 /* Return to the caller */
>                 emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA=
, 0);
>         } else {
> --
> 2.43.0
>
>

