Return-Path: <bpf+bounces-66494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F4B3517B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 04:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CE11B60647
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292861D5141;
	Tue, 26 Aug 2025 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMdLSyj5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CF61FCE
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174735; cv=none; b=j6wU4bDbL/pPiXr3wCAQ/s3IQ3aLV3S5aW1kyDTK4iWAspxTZQ4YStlxggdVH2UPPDwpYsi3mpCaooF9YH+sD84TcYYOOpYHyJlWq7KYus1ms21QPdF80oiGFKgB4l+ciC2oR2hdObjjuBuu75gY4nHS1XQymRjzPlA22CcUNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174735; c=relaxed/simple;
	bh=ZHtjlYKKYAtoQG5Fzye4fMUyszWThwi2gRz/gmCNSjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHfHgLassZAD2fDmjYzQSxzPvHbmmSuJP9qfYghWyujI9Sm5K2qu1i8UWSn0klZINVb0zMvdUCIMt9wS+LTPGPwvycm70hM5VfN1hubl0Q5M55lz6aZgYnrUy2nCyiuZnmk7Ury+bW/EgDnAkWb81qAyyhRCQ61J0Ykfo9vskv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMdLSyj5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so30011045e9.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 19:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756174732; x=1756779532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKt9Q2+NtZfcgrGAop6jPMVgY/Pl7NUcgs853M9f8H4=;
        b=dMdLSyj5zGvWL1ss838OctztPTtMmHaB0N0I1at9FzXUaL065M/A5mlEAQ0dw3MN6t
         myoyE7eEpeRLczaeBw97wSi32ndiyHpYT+fTYpYXWbFjBBaUKOT1FQOVxcZbXGIRnxCk
         jShYHNHjK3cdTWYfotAmkZmft3YOlUiimE1gDxj41Uahv9cmNgcdxxVnknJNkXiO4/2k
         q7KjkbbLrQUpu3ptIw1fpKE4XlKv709noJ7OtX9ZU9rxVLjJNFY9pe2mvuGAS/tjacWN
         Wju3BHeWHHVsS1X0JhqyoYOzU+BZ9RtizbBZpN/T5gxjx234rrv1AZQ5OcJMhIMNsEZN
         tEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756174732; x=1756779532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKt9Q2+NtZfcgrGAop6jPMVgY/Pl7NUcgs853M9f8H4=;
        b=GyzHStrzo1lhNz4WPJNQVU0fgBmBAyMj+Eg5eaDtC3GKAzl7xebGNjbL2yar8zbP+m
         jOh8ynHr+ClCvoyWNieC79rvrMft/B6FL2uJQ6Rt7vmS7s87ayBkjaAYhNW776u81xjy
         S+TXB/z/GSnicbp8b83eAnk6Ho/pNwMVTEmt2EVXSnCpm1DzUxNfP11tc51co5k3BAdX
         CEcTNpLh9QBE7//hj4Ndn6AdYqfPEjzJO/3f584jChhX3KSTpP5JmovsuY78eqwHyLlv
         fXnUU1KCukBGVn+OPAFOLxahfxdE6Go1H/A2Vb/oZckwrmOz2qlVUnZNlgWPJHkRbomo
         Csiw==
X-Forwarded-Encrypted: i=1; AJvYcCVBzfo73M+X9TgTkeDuULwXiSmhuIl/zSMkQkC1d6tirDB7Hk7Q3ntfzPmfuP+ZiTTZOtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31WRbLi3NjJjOMZbjnD3t7IlvEXWatXUEieTZwNsen4cNV3VI
	zq3uRlYfYM/0i8cQc6RrlCTtWhcpE+460Qk9KMTua8K8RsuFGAL8XcalCtvSR8DvVAgfTEX3led
	00HiJVLG1RieVu9oZxN1rNvONPusfSbw=
X-Gm-Gg: ASbGnctMYrWyQ0HXtXI8meug1MYsx6yD4/oRN0g3FbFwHFwBI3wue50CNMdlIw0KCrE
	kn0jvqItNWUDTxtvsIIIz718jnfi+tN+px0j0GLPcyoSwqlkFDpKbZ9VkNwV/CHqdj8f8bznxKs
	CDM04p4YT4sdZynZHROWOyOn5h4pFFY9YnoPZjqUCVPfgbjmfuWPB/H+9hnc3MY0X+93TojLct3
	gjDeNJZjnT53EKJvQCFv94rp5NhWTkWZsqM
X-Google-Smtp-Source: AGHT+IGKB49enSIdAv/2p/N2lvoO7p4V5yeMUM/I4tpxRCOh2id90+SSg37sGtBsKsFxZK2ItIWD3lkeqVRY1yUDRks=
X-Received: by 2002:a05:600c:4695:b0:456:26a1:a0c1 with SMTP id
 5b1f17b1804b1-45b517cb8e5mr150392425e9.17.1756174731897; Mon, 25 Aug 2025
 19:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
 <CAADnVQK4nhBTCOjP2dw85v9WSUW5rs_oThk9ME-TWBTjLwnspg@mail.gmail.com> <787555a1-1b18-4a76-8741-0fab4282f6f2@nandakumar.co.in>
In-Reply-To: <787555a1-1b18-4a76-8741-0fab4282f6f2@nandakumar.co.in>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Aug 2025 19:18:40 -0700
X-Gm-Features: Ac12FXx-umA_phZedZ_jZ-LNPSay_e79xgTQd7W7ak_uj-Fa6Q0Lrcy_kHmEXRw
Message-ID: <CAADnVQLKbefDGFHSD2MpK5+cKB__f-bqahu9zO5iY2sMJfeTuQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/2] bpf: improve the general precision of tnum_mul
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:05=E2=80=AFPM Nandakumar Edamana
<nandakumar@nandakumar.co.in> wrote:
>
> On 26/08/25 06:19, Alexei Starovoitov wrote:
> > On Mon, Aug 25, 2025 at 10:30=E2=80=AFAM Nandakumar Edamana
> > <nandakumar@nandakumar.co.in> wrote:
> >> This commit addresses a challenge explained in an open question ("How
> >> can we incorporate correlation in unknown bits across partial
> >> products?") left by Harishankar et al. in their paper:
> >> https://arxiv.org/abs/2105.05398
> > Either drop this paragraph or add the details inline.
>
> Okay, I'll drop it from the commit message and add it to the code like
> this, since it's useful information:
>
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index c98aa148e666..4c82f3ede74e 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -116,7 +116,7 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
>          return TNUM(v & ~mu, mu);
>   }
>
> -/* Perform long multiplication, iterating through the trits in a:
> +/* Perform long multiplication, iterating through the bits in a using
> rshift:
>    * - if LSB(a) is a known 0, keep current accumulator
>    * - if LSB(a) is a known 1, add b to current accumulator
>    * - if LSB(a) is unknown, take a union of the above cases.
> @@ -132,6 +132,11 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
>    *    xx            00            11
>    * ------        ------        ------
>    *   ????          0011          1001
> + *
> + * Considering cases LSB(a) =3D known 0 and LSB(a) =3D known 1 separatel=
y and
> + * taking a union addresses a challenge explained in an open question ("=
How
> + * can we incorporate correlation in unknown bits across partial
> products?")
> + * left by Harishankar et al. in their paper:

No. This indirection is not helpful.
People should not be forced to click on some link and read the paper.
Just drop it.

> https://arxiv.org/abs/2105.05398
>    */
>   struct tnum tnum_mul(struct tnum a, struct tnum b)
>   {
>
> >> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> >> from which we could find two possible partial products and take a
> >> union. Experiment shows that applying this technique in long
> >> multiplication improves the precision in a significant number of cases
> >> (at the cost of losing precision in a relatively lower number of
> >> cases).
> >>
> >> This commit also removes the value-mask decomposition technique
> >> employed by Harishankar et al., as its direct incorporation did not
> >> result in any improvements for the new algorithm.
> > Please rewrite commit using imperative language.
>
> This will be my new message:
>
>    bpf: Improve the general precision of tnum_mul
>
>    Drop the value-mask decomposition technique and adopt straightforward
>    long-multiplication with a twist: when LSB(a) is uncertain, find the
>    two partial products (for LSB(a) =3D known 0 and LSB(a) =3D known 1) a=
nd
>    take a union.
>
>    Experiment shows that applying this technique in long multiplication
>    improves the precision in a significant number of cases (at the cost
>    of losing precision in a relatively lower number of cases).

+1

> Using uppercase for the character after "bpf: " this time, just to be
> consistent with other commits.

+1

> Similar changes for PATCH 2/2.
>
> > "trit" is not used anywhere in the code.
> > Use "ternary digit" instead.
>
> Changing it to "bits" since other comments in the file already use it to
> mean trit (also, "digit" could be confused for a decimal thing). With
> another clarification, "iterating through the trits in a" now becomes
> "iterating through the bits in a using rshift". Hope it's okay.

Sounds good.

> I'll send v6 after waiting for a while for further feedback, if any.

Just respin it. The code itself looks good.

> > Keep acks when respining.
> Sorry, I didn't get this. Is this something I need to do?

When you respin apply the acks/review-by tags you received already.

