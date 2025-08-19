Return-Path: <bpf+bounces-66003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF2EB2C3DC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468CF72726A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C96305075;
	Tue, 19 Aug 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPN4g2jf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B93043BB
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606791; cv=none; b=dB2OL0OSRNDmkIvTtWZNoO4XY0EEL6oRNb8ifqbMcFMTacN5PSlIQc2wevTVkDMywRy4GR0vQr7Rsgz0lKlsi1mSu29dk7hCJfhl5iOZ/pCuPMLs6ayP1YWKUeVI9NsvyGbLKNFgiIjLu9+6udvJMrmr+VTC1mAFHuUeGANg2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606791; c=relaxed/simple;
	bh=oGIIhDvNcbEz2gNcueZOzpTWLK1v6vHPDTa7Zne8PoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZruTEYGjdGhA/smea99G07zw0HsoqcM1gU/OSSL8/X+CyaxXLWkEQXqzJ+JlCKgiw2rq7WcUyd0O4cgRstWY2Do7EkYbmmjV3zQazrzbioOe98Zx3uHbaw7oCJvGDXamgzyRPW1deO9/uuBdC5jBEE1xjd5c6M/9+Neqb67h0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPN4g2jf; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-435de5b2f29so1622508b6e.0
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606789; x=1756211589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euK/Sa43pRju1FeMVcXdjmsp+ESnMwlYC5m2uEfodPc=;
        b=QPN4g2jfoNfjA/6QkC2lUKqBSd+XQYzEZ1JoMEsbDOO5Q8sntgFOv/GaKg2yYBpIkX
         yW04Wv68xQJo4Hi6ATkjlsT9egBEk/Qo8cgI5nVAqmfC3JzoFGYIjXAxrVU8ppP7/nu9
         jECpwaWvHAHoS8gHQCVJNm4ybv8EpA+KL244jGVmemPHc4jhUPLGhQhm4jHXP9wwhsho
         UgGqFexzVifOLTUIpsPy0PTqF5oFKmEcXKMs+R0Coogbn75X+i+RnKu/vzSYsbvE/Wku
         YSZwFeAuzXMR2R9p4Tlxj40Xix0chgKJki+B2S161KYAq7lMCehdOSLsCxeRIp1efrlP
         Pz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606789; x=1756211589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euK/Sa43pRju1FeMVcXdjmsp+ESnMwlYC5m2uEfodPc=;
        b=KXpndojnJPBMq4h+N363ROG2twedQryg9cQDBlzO11qDMSJ8f7CAAZSnmVLOZiz5AI
         C1Re3CG4dywgxAd3KZFBlPjCALXsG2Nkxag8199aFk9Q4MXUUMLyV1SaFw05HfRuGAa3
         feCYn6GHk4aR/tvRLilZqXMccXhotV7l75RjFZ+7mtLVi4DCm4UJdGDtsrqpppM+7kMO
         M609dcYMOTAOAGAAKobk70+XkPxkb5AB2wzE3z1CxbLt/4oRnDEpY3aL5V5fE04KerQA
         KvBd7MpHWstNwg/1Ex2wZuE+qqhdiUddPpy9a6AoS+E+AJy6rrHa6F9y/OEAWzDbSRax
         19NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRRaCC2O/km77M4o7UVkSXGQOQVvql3Cfqdyc4ohkDvEhoOf+Aq75pqkBVEyy5Q2FHO9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGHHJPGQ9kCFT9DvE1GwUAsZQWsO43IAgblqJDK0M4TMbMw+8
	29waTf+0utHJ/dK1aFGs/bp4h4SbjMg0x8WanTOLIx1iWr3xB9UCOcFGiw/Uo281Qw+s02R1tA0
	W//AkSDTI0gNlU+/II4zkbzUQt04CdUw=
X-Gm-Gg: ASbGncvRW735DK3RfvqJj606Y/I29KNF8ON7jTTeCvQ4wEF2cRFWJp4sFVNMb3ITtfa
	uyM28Jj+OQsZ2/yweDWuP6DXJ8j66+gCGg2qX42x2/Q5BMtfXCCWqdzi81Vfv3UKjC2+6t2FG2K
	eRHJRT2HD7MXsU03a9qDFUt65RefIUZfKNt2IgNJL8wp3W48hASS81xqD88NLknKNCPDUW7oVBa
	Gxp1Yg=
X-Google-Smtp-Source: AGHT+IF3TnzwDKbWVmb0nbU19B6sCvfBoJv+fy7qHe2Grj5VTQW+DyaKaeKUpV05oMJRpppbHIo9Qf/7YXz89cmmuuk=
X-Received: by 2002:a05:6808:218f:b0:434:b6e:52a0 with SMTP id
 5614622812f47-436da1e7ea7mr1689680b6e.22.1755606788728; Tue, 19 Aug 2025
 05:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815082931.875216-1-jianghaoran@kylinos.cn>
In-Reply-To: <20250815082931.875216-1-jianghaoran@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 19 Aug 2025 20:32:57 +0800
X-Gm-Features: Ac12FXws3USO7bmtx8j4CoQoQxI-9k1R3TMQL0Aj_uHfyKHkQOQjd7LKqRtoh4w
Message-ID: <CAEyhmHTv+3FxN5mGvtrNpW5Y=r5gD9wfS3iFUO4UCAzO9cBcPg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: BPF: Fix incorrect return pointer value in
 the eBPF program
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:30=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.c=
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
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
>
> ----------
> v2:
> 1,add emit_slt* helpers
> 2,Use slt/slld/srad instructions to avoid branch
> ---
>  arch/loongarch/include/asm/inst.h |  8 ++++++++
>  arch/loongarch/net/bpf_jit.c      | 17 +++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 277d2140676b..20f4fc745bea 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -92,6 +92,8 @@ enum reg2i6_op {
>  };
>
>  enum reg2i12_op {
> +       slti_op         =3D 0x08,
> +       sltui_op        =3D 0x09,
>         addiw_op        =3D 0x0a,
>         addid_op        =3D 0x0b,
>         lu52id_op       =3D 0x0c,
> @@ -148,6 +150,8 @@ enum reg3_op {
>         addd_op         =3D 0x21,
>         subw_op         =3D 0x22,
>         subd_op         =3D 0x23,
> +       slt_op          =3D 0x24,
> +       sltu_op         =3D 0x25,
>         nor_op          =3D 0x28,
>         and_op          =3D 0x29,
>         or_op           =3D 0x2a,
> @@ -629,6 +633,8 @@ static inline void emit_##NAME(union loongarch_instru=
ction *insn,   \
>         insn->reg2i12_format.rj =3D rj;                                  =
 \
>  }
>
> +DEF_EMIT_REG2I12_FORMAT(slti, slti_op)
> +DEF_EMIT_REG2I12_FORMAT(sltui, sltui_op)
>  DEF_EMIT_REG2I12_FORMAT(addiw, addiw_op)
>  DEF_EMIT_REG2I12_FORMAT(addid, addid_op)
>  DEF_EMIT_REG2I12_FORMAT(lu52id, lu52id_op)
> @@ -729,6 +735,8 @@ static inline void emit_##NAME(union loongarch_instru=
ction *insn,   \
>  DEF_EMIT_REG3_FORMAT(addw, addw_op)
>  DEF_EMIT_REG3_FORMAT(addd, addd_op)
>  DEF_EMIT_REG3_FORMAT(subd, subd_op)
> +DEF_EMIT_REG3_FORMAT(slt, slt_op)
> +DEF_EMIT_REG3_FORMAT(sltu, sltu_op)
>  DEF_EMIT_REG3_FORMAT(muld, muld_op)
>  DEF_EMIT_REG3_FORMAT(divd, divd_op)
>  DEF_EMIT_REG3_FORMAT(modd, modd_op)
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..50067be79c4f 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -229,8 +229,21 @@ static void __build_epilogue(struct jit_ctx *ctx, bo=
ol is_tail_call)
>         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_a=
djust);
>
>         if (!is_tail_call) {
> -               /* Set return value */
> -               emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0]=
, 0);
> +               /*
> +                *  Set return value
> +                *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If i=
t is,
> +                *  the value in regmap[BPF_REG_0] is a kernel-space addr=
ess.
> +
> +                *  long long val =3D regmap[BPF_REG_0];
> +                *  int shift =3D 0 < val ? 32 : 0;
> +                *  return (val << shift) >> shift;
> +                */
> +               move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> +               emit_insn(ctx, slt, LOONGARCH_GPR_T0, LOONGARCH_GPR_ZERO,=
 LOONGARCH_GPR_A0);
> +               emit_insn(ctx, sllid, LOONGARCH_GPR_T0, LOONGARCH_GPR_T0,=
 5);
> +               emit_insn(ctx, slld, LOONGARCH_GPR_A0, LOONGARCH_GPR_A0, =
LOONGARCH_GPR_T0);
> +               emit_insn(ctx, srad, LOONGARCH_GPR_A0, LOONGARCH_GPR_A0, =
LOONGARCH_GPR_T0);
> +

This change seems wrong to me. Need further investigation.

>                 /* Return to the caller */
>                 emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA=
, 0);
>         } else {
> --
> 2.43.0
>

