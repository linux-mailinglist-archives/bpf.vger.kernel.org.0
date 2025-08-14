Return-Path: <bpf+bounces-65596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B204B25A56
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 06:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402BF7A6062
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 04:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FF1E7660;
	Thu, 14 Aug 2025 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+tTTCxr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97882FF645
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144851; cv=none; b=NT4GoLG2rBwdYnTHU8JEadM4pHDEC54vR+U+/yRUAAiKkl3Jx/4ITtHERACqcIkZNL6gXUn8VR7vg66jHAzm6Z8AUA8WQJxGZbTR8wP78Ng+9Bcq4rmvOPRHeB3vG6cqQF6HyyrRrO+dZJ/630lBgSlSTNiutFcDtB3yUGrJy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144851; c=relaxed/simple;
	bh=W3ZcEvVRhvVdNv42QcGvH2QC/tCWCrAF8Pc0nZtIKcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOVcs7ccbUH8MfEQtWWwJWG49Dng2Gn76vO+NfvOMnC5bMPK5r6vrwZd4l408Ettct/6dNbYgB/sGyI345JjNdy7I0mubrOORB4vhs6Qa5GkRkubNzZeUIhHtQfDigHfe372OUMNVq1Moa3xfd7VNssq3xb6fyX5BNTrOkaWysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+tTTCxr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109ad6411so6554391cf.1
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755144849; x=1755749649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7jvUnZnyLA02ycBORtHShnC38JrOReEmudPY5XXEdo=;
        b=I+tTTCxrDGlGlmdDFJyx6qSk2VypjEA0GmGtYkH4pk8CbEH9hKxXDNYCIJwTJJmGFg
         2CE/YUcpZastTUe4NH3ZQun8g0bg1XhWYAUnKltGVp93kFHAJ1KSJiBPgz6QlBBaeyyL
         rWPTzK7vM2e8LE4utC0N6zQtOsZaXycUhlw2ukwRmCDWZyCIE2aUCMNEb1AOQRuNHJhQ
         MqhdHVhXO/I5KUxrit4gi6geQaYmyHORiOq9Bid/+4d7RpbAOrnFJRrS3wKP6pJu6gYL
         Vqs294yS8RvwAUMD/Bf7MTL/bw/QRSa7U2ASEN+iYpU5eEpQxndpHY69Iu132bl61MaG
         bA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144849; x=1755749649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7jvUnZnyLA02ycBORtHShnC38JrOReEmudPY5XXEdo=;
        b=fVU955QDb5dvZm8rbTCoFtbOU+ch2mGaEBxkSU0SBKrVb/veXGfuzF2d6bhTAcUoqr
         cMILCXqBcJSv8FX1W1DlKAc//XxcA4qizKG7ZLaNJ+EvRbVRjQHfpYmtDaj5HjZ2wwV8
         l4B5ZrLs5L7jpeZe1DFzuDx0dAFFQrxxMZwg7AUHqyHq1L60d2hPg/nOMI+UcgdeWyMU
         6vBwEoP3m5o5qN4Fn1IK11yiMG5fh8DlnbK06qdJbVvB+ksb1Klca/a+UUU3Nfut18oq
         0faGBe5A5jYZTAbWp1aasXngq2Ty0DUUEeUZrvL/AYvtZORPPVvGFIfGkeIqp1kkK+gq
         MZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKRT5QnEOdXasQcGBL0EYDGqlkNofg9xas1SrCz1LFPvExAKTIRRwMfQhVtHyfiq+AGKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF25kaXP3YBUWV4/n8tW1cRFCHLrf+u3KCfaicJvhdQEJUhPwk
	2UqDdAymADt1HL9QKMcPKPhy0+frr0DdqXEHYsX/R2Ud8BLnmdaYWs/2ZXW47K4CYIdkF4LIl9+
	688qlM3ddPXIGpEghah8cZjt2xYi0DqI=
X-Gm-Gg: ASbGnctYpCdiDSl/L6a4TKEwEOZDjSE5huCwrcSZPcZIsFJS6q77MYiWmJDCjK9fXbh
	34hmUBEzGeEJTF/qTHX9rbCouX7J7WUFgEXgGkWDZLXvPWTnqOCnmhTzxJVdgPppepno/3bcrNW
	+dbY1pdc9jiPEcy8WOWlUTOPDFCtKvT99FBgUAbsx3U1doxVngiShAQXJCWQ/tQ8UjRvo+kkwpD
	PW0yxfsWsPdKICjRCw2tLShn8JqxT6wORtVOZs=
X-Google-Smtp-Source: AGHT+IGPWDVTY+2ZDHAoY+X+qy7ipoL6Aq4SfnyJQpQ56tGuFzNm3BMMNLPegktQdLQzCbdHM58gKHH+i85KbF3W0Qk=
X-Received: by 2002:a05:622a:1f13:b0:4b0:7e8c:64cd with SMTP id
 d75a77b69052e-4b10a9583f1mr25908261cf.4.1755144848685; Wed, 13 Aug 2025
 21:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814013412.108668-1-jianghaoran@kylinos.cn> <CAAhV-H5RRRMsmdbcB-Jq=04C3r+7g_Sq-OB7pLEu8z3y_-==og@mail.gmail.com>
In-Reply-To: <CAAhV-H5RRRMsmdbcB-Jq=04C3r+7g_Sq-OB7pLEu8z3y_-==og@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 13 Aug 2025 21:13:57 -0700
X-Gm-Features: Ac12FXyUFeOusnmGuC44W9r6qWNAGwU0MXrXyMSLjUA_-FeQvbSpdIfSnRHqFQ4
Message-ID: <CAK3+h2yxz4ChozY=2p-M5dwq8+ehqzZU=xHNX=GR7zwY5XavsA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix incorrect return pointer value in the
 eBPF program
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	kernel@xen0n.name, hengqi.chen@gmail.com, yangtiezhu@loongson.cn, 
	jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:24=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Haoran,
>
> On Thu, Aug 14, 2025 at 9:34=E2=80=AFAM Haoran Jiang <jianghaoran@kylinos=
.cn> wrote:
> >
> > In some eBPF programs, the return value is a pointer.
> > When the kernel call an eBPF program (such as struct_ops),
> > it expects a 64-bit address to be returned, but instead a 32-bit value.
> >
> > Before applying this patch:
> > ./test_progs -a ns_bpf_qdisc
> > CPU 7 Unable to handle kernel paging request at virtual
> > address 0000000010440158.
> >
> > As shown in the following test case,
> > bpf_fifo_dequeue return value is a pointer.
> > progs/bpf_qdisc_fifo.c
> >
> > SEC("struct_ops/bpf_fifo_dequeue")
> > struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
> > {
> >         struct sk_buff *skb =3D NULL;
> >         ........
> >         skb =3D bpf_kptr_xchg(&skbn->skb, skb);
> >         ........
> >         return skb;
> > }
> >
> > kernel call bpf_fifo_dequeue=EF=BC=9A
> > net/sched/sch_generic.c
> >
> > static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
> >                                    int *packets)
> > {
> >         struct sk_buff *skb =3D NULL;
> >         ........
> >         skb =3D q->dequeue(q);
> >         .........
> > }
> > When accessing the skb, an address exception error will occur.
> > because the value returned by q->dequeue at this point is a 32-bit
> > address rather than a 64-bit address.
> >
> > After applying the patch=EF=BC=9A
> > ./test_progs -a ns_bpf_qdisc
> > Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
> > 213/1   ns_bpf_qdisc/fifo:OK
> > 213/2   ns_bpf_qdisc/fq:OK
> > 213/3   ns_bpf_qdisc/attach to mq:OK
> > 213/4   ns_bpf_qdisc/attach to non root:OK
> > 213/5   ns_bpf_qdisc/incompl_ops:OK
> > 213     ns_bpf_qdisc:OK
> > Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> > Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> Can this patch solve this bug?
> https://lore.kernel.org/loongarch/CAK3+h2x1gjuqEsUSj+B-9sb73kRo3bStH6ROw=
=3D1LVSqQGMNcUw@mail.gmail.com/T/#t
>

I tested this patch, it does not solve bpf selftests module_attach lockup i=
ssue.

> Huacai
>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index abfdb6bb5c38..7df067a42f36 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -229,8 +229,24 @@ static void __build_epilogue(struct jit_ctx *ctx, =
bool is_tail_call)
> >         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack=
_adjust);
> >
> >         if (!is_tail_call) {
> > -               /* Set return value */
> > +               /*
> > +                *  Set return value
> > +                *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If=
 it is,
> > +                *  the value in regmap[BPF_REG_0] is a kernel-space ad=
dress.
> > +                *
> > +                *  t1 =3D regmap[BPF_REG_0] >> 63
> > +                *  t2 =3D 1
> > +                *  if(t2 =3D=3D t1)
> > +                *      move a0 <- regmap[BPF_REG_0]
> > +                *  else
> > +                *      addiw a0 <- regmap[BPF_REG_0] + 0
> > +                */
> > +               emit_insn(ctx, srlid, LOONGARCH_GPR_T1, regmap[BPF_REG_=
0], 63);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_T2, LOONGARCH_GPR_Z=
ERO, 0x1);
> > +               emit_cond_jmp(ctx, BPF_JEQ, LOONGARCH_GPR_T1, LOONGARCH=
_GPR_T2, 3);
> >                 emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_=
0], 0);
> > +               emit_uncond_jmp(ctx, 2);
> > +               move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> >                 /* Return to the caller */
> >                 emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_=
RA, 0);
> >         } else {
> > --
> > 2.43.0
> >
> >
>

