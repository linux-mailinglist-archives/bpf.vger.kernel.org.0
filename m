Return-Path: <bpf+bounces-57061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E2AA5128
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088A03A89DF
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADB2609EC;
	Wed, 30 Apr 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8SE2eHm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADD25D534
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029154; cv=none; b=HNevA5wrzUVRS/mA88/fiqUW4tJvCgWzRH3aBUzAXJNanz8TtMvHnoVipnem4N5LKZqeO2zxhVbA8FCGUPUgco/3Z2pu/7Z1LhojlWH26yHb6+7GP0NKecmr9CQ1F3Vt530lPJRIM+RfBsDKi/YFZ1Dill3PcuMLF5ZWJStMfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029154; c=relaxed/simple;
	bh=MROiByPDyEz2DGLOzQYjP8EFlQ9oLDCUqpyLSI6Y0Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYgX7SfAxRoHDqxeEROnUz65/YXrVSQN2aVoyknhX4maaQ69kGKKFMiEpkJbginhiqa4mZNb+6oJ7bpn2JWkuA3tquu6eZ/cArf6O/nATx1wvbNHKu8x98b8LvMWsxWXQDSDZf9KPm++3JCZorpPSISaEAzv9lvXvG0kLcJ9AwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8SE2eHm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c1138ae5so72214b3a.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029152; x=1746633952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE7Da28zkRosKkvPfcU+TBlv2d44cgX1Ozn99gPET0Y=;
        b=k8SE2eHmrSc/yv7/EZePiztE6tJ0aIwoq5Vk32is07qOcvTMa1aNOE6jrb3ndm7tXZ
         lCBieQjMts1qzJNXKWp2MzrhrRcEqvVPaFn32n1XI1lqTrNlL+ledLvN2OkO3l/1eEVn
         0bNUjVGZCAD/SNhwL7lTh4cgwD0q17URDBV19RsMS97wK3BXxHLsAmDLjfCbfuEOeOln
         GPBiZ214HleS3g55Fd9seRsgYjtZ4eIpuUKhbKqwFB2yEBapuFbekhUo0ZXwxPnJdnjR
         u3WLAgsIEhaEb6MnvV6EdCZUxBdxyfI51sj4p9BoVJjE/uCA82yVSkHrS3MZnPtXk7UK
         jpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029152; x=1746633952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hE7Da28zkRosKkvPfcU+TBlv2d44cgX1Ozn99gPET0Y=;
        b=a9PdPKD035fkLWjH0ygGMhphJ7qe/WtNGN3+rjdZ17eAP6wlq+goRw5RUQr7E2/0up
         UFdpmsMFBvr1AjBUhtpc58sctxGFQcoSi3N2Yvn7+GNvB9ygWobvQOlQ/0uBXXUIUbEC
         eJq7IZWWek6GxEYypxFa9TwAR+j0au+nNjnwMoDErXIbbVy1Bt5GMfPi5MFGHd+8OkBG
         NaZDAiEvVXiNggXTxoLBON6tiB9wfVDd3oZHoUp0P+L3oYKzm1QKAdrDYFljrv7emHVY
         weSM5mRUnQGElFwlk1RlpnFkMKCAHT24HDNWF/i9KexYzFlpowtZLAj12J4CCzPIjzS0
         5Xrw==
X-Gm-Message-State: AOJu0YyKfPY0F9Drm43pS8EwKNwJdqoKHTr1ixoJHGanjl5DgejBAYbA
	X4CiTKUrkpxDNVvmGksb8erTFIEmsZlUAa0L5URqIXtWP+onJqMSKCdCz66IpVcvFBnRkLZjstd
	HOq+PKsrQFuEA94NRkN+eIKYcOJE=
X-Gm-Gg: ASbGnctzCeABohyVhvIzVglE3MeqkGE4U/k9XZpnt48HSfSI9zTzVhgEaXgCjEhWxYR
	DJ3wb8GGf5X8vqQovSA3U4iGqFOOCsF0mCidikrB60HdUSM8DXlJL2gTY++mMRNTYMINX4olMRI
	MHrT+p63p166TfrHpfex1rkrAnMWg8f1o8lCVW4Q==
X-Google-Smtp-Source: AGHT+IF1xS//OtwzMUgY5wUHCG/zRuoJXe3wyJ8yGPmcFUkvq4rWS1LJ6HnayRr9z6Hhp769YRFPKryM5ns4WqLcYIs=
X-Received: by 2002:aa7:8895:0:b0:735:d89c:4b8e with SMTP id
 d2e1a72fcca58-7403a75b24bmr4302600b3a.5.1746029152374; Wed, 30 Apr 2025
 09:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430120820.2262053-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250430120820.2262053-1-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Apr 2025 09:05:40 -0700
X-Gm-Features: ATxdqUF2qWOu_sZePi_c6p5-3e2sRd2-LIBn0Zn-GEWnRdouFQ43khbOn88ks3k
Message-ID: <CAEf4BzYmNyBS-xofAagQ6diVkSEn3iT46kcRrBSM-_14fAmgzg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] libbpf: use proper errno value in linker
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 5:03=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Return values of the linker_append_sec_data() and the
> linker_append_elf_relos() functions are propagated all the
> way up to users of libbpf API. In some error cases these
> functions return -1 which will be seen as -EPERM from user's
> point of view. Instead, return a more reasonable -EINVAL.
>
> Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 56f5068e2eba..a469e5d4fee7 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1376,7 +1376,7 @@ static int linker_append_sec_data(struct bpf_linker=
 *linker, struct src_obj *obj
>                 } else {
>                         if (!secs_match(dst_sec, src_sec)) {
>                                 pr_warn("ELF sections %s are incompatible=
\n", src_sec->sec_name);
> -                               return -1;
> +                               return -EINVAL;
>                         }
>
>                         /* "license" and "version" sections are deduped *=
/
> @@ -2223,7 +2223,7 @@ static int linker_append_elf_relos(struct bpf_linke=
r *linker, struct src_obj *ob
>                         }
>                 } else if (!secs_match(dst_sec, src_sec)) {
>                         pr_warn("sections %s are not compatible\n", src_s=
ec->sec_name);
> -                       return -1;
> +                       return -EINVAL;

doh, not sure how that slipped through, thanks for the fix! I applied
it to bpf-next.

BTW, if you would be so kind, I think we have a similar issue with
validate_nla() in nlattr.c, where -1 can be eventually returned as
user-visible error code, it would be nice to fix this up like you did
with linker APIs, thanks!

>                 }
>
>                 /* shdr->sh_link points to SYMTAB */
> --
> 2.34.1
>

