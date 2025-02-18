Return-Path: <bpf+bounces-51875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04721A3AB8C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 23:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084D0188574A
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C21D9A49;
	Tue, 18 Feb 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+BhNuMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DF1D90A5
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917216; cv=none; b=fTJn5AaqyaUx1BHaTilOKMpMY3DKHgp2HkYXQjMboEUep1MKgOicbaQqf9bt6w3hEerbAIpO9lQxvSituePPwjIg42GzFvXXAuNyh2ii+d+okRr7MYu/v86atBzMaCzTgGytGofwm0nYueh6mLB4EQvaVsIzdwnGhbIjHdpf4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917216; c=relaxed/simple;
	bh=x/I53iBjkMGMsEzfKJLYpvy1ZZzmCAF1gK0vxBHH9wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly+lAmSKwB6TBlH3zIzH4/D0HdzvRh4D6D9eIXR3pEWO8SUDiwC3cWpxIBhda0qkVg9sxj8fnK/rowvKZwo1Je92qd3ShRMfNPOu0+bM3yMgxHGZViF/1HvMwNQkDsyKroI9KVrvumLHtTlXjrDfjrG/24cKEZvHalx5XV2sLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+BhNuMK; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f74b78df93so54294247b3.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 14:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739917214; x=1740522014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVdh2fVNAJsoK0HgecQ1cPfbbw9xm+lgrUuhajpUAh8=;
        b=B+BhNuMKzz2+USMJyLbRg1shZTjzQFARXuOABYzywbEBvmpHT+xVw43AxJBkQQikd+
         LU6Ww+iCICvNeAYRujrRNzYin09UYOusp4fNbtHajixPijyNYqRqxUyIpZd9uv/zZTka
         MMdoN5wNJceR9jkKteuofK7CqGQAZMYOtXY8N9Lr+xcpdrqVEXjoQslfxFCbEhSp2rnM
         FEXwR4p7ItBnMraKT3pky08APiCaVwqFLS4BMwKLIOkDidXaPZFoZAoDwApeCSCY7Xfs
         6tFUGOjpdmQSEEYQO5IWS2oOfSdha5YNFlZG/yoLs0RrsVDkcwhhjsK+bQ51MrW61L+7
         gfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917214; x=1740522014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVdh2fVNAJsoK0HgecQ1cPfbbw9xm+lgrUuhajpUAh8=;
        b=joUZbYr02RcGkZ8+oZWyxZyHB6q6FX5FR3EUTI16Gnv9ymyvuvhUX5G3jfXsJpwCdf
         FA+6WKkeo3jyhkNBE1XdAcH5MuK2iU/g/aCbZZj6bG3lhnRgsOY6wM+seBuKI59v0amk
         UfxYfLvmQAOdpZU9VJ/oflkM9pjNd2bSOJuqOwBY4BObvdHEp/SndUuKj1JX3C8n7QQC
         kyOEvmID8lVMfTRDQRlDW/CpA0l+YmXOL5BV2UzVn0k8VAQoAji/6qd7JtOZRI3ROOwo
         ZdzhD7ax74CsqQXMxs43FhEfTWMd8OSK5D3+OlXil/rNgbWqCC+GEojxZBV8knwo1pqM
         d57w==
X-Gm-Message-State: AOJu0YwtEc43xua2qNDspUjJScqyXB4YD75rpPQkCUpyrvUETHUoHUcN
	y0MAc7qdnrz84ymkHNxvhEYlKDtMd8KD7MNEvwclOdFJVh9qCXc02k9DUibvuswvlRsdcRo2boy
	BwdOfKmUH82v31gjeVv3Lyn7R/MY=
X-Gm-Gg: ASbGncv6NTIexmRb6I2m4EnU663sykNURcM8xMgryKZjNBwLo2yC3mnCYRZ6fzkkrqx
	DcGgphUFoCV+s7eMtguxJgExq9PHhhTZiShibUttGB6h76OO+NK6pCqVTkQDQ3vGBIeZQwqGx
X-Google-Smtp-Source: AGHT+IHfWqMWxhA4+1Z6WkOfOb6vRa2wPLm1ECtYc6yKdmcDJJP1x6XZDPAdE7ms4xsad8aZLwjxz1TFKBYb/P1Y/Kc=
X-Received: by 2002:a05:690c:6712:b0:6fb:a467:bff4 with SMTP id
 00721157ae682-6fba579deb4mr18031997b3.24.1739917213742; Tue, 18 Feb 2025
 14:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214164520.1001211-1-ameryhung@gmail.com> <45dd4b34-e8e0-47d0-a91a-9d2c6d3196a7@linux.dev>
In-Reply-To: <45dd4b34-e8e0-47d0-a91a-9d2c6d3196a7@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 18 Feb 2025 14:20:03 -0800
X-Gm-Features: AWEUYZlcXQQezZhlWlJZGMbCwXbJQDUcTGWCL25COr07qaD9ZalyRE9ok5czU70
Message-ID: <CAMB2axNY3gaYJQ7TRO01g4=AfnH7rjUknedRwgJ3kG_1EG+WgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/5] Extend struct_ops support for operators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:09=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/14/25 8:45 AM, Amery Hung wrote:
> > Hi,
> >
> > I am splitting the bpf qdisc patchset into smaller landable sets and
> > this is the first part.
> >
> > This patchset supports struct_ops operators that acquire kptrs through
> > arguments and operators that return a kptr. A coming new struct_ops use
> > case, bpf qdisc [0], has two operators that are not yet supported by
> > current struct_ops infrastructure. Qdisc_ops::enqueue requires getting
> > referenced skb kptr from the argument; Qdisc_ops::dequeue needs to retu=
rn
> > a referenced skb kptr. This patchset will allow bpf qdisc and other
> > potential struct_ops implementers to do so.
> >
> > For struct_ops implementers:
> >
> > - To get a kptr from an argument, a struct_ops implementer needs to
> >    annotate the argument name in the stub function with "__ref" suffix.
> >
> > - The kptr return will automatically work as we now allow operators tha=
t
> >    return a struct pointer.
> >
> > - The verifier allows returning a null pointer. More control can be
> >    added later if there is a future struct_ops implementer only expecti=
ng
> >    valid pointers.
> >
> > For struct_ops users:
> >
> > - The referenced kptr acquired through the argument needs to be release=
d
> >    or xchged into maps just like ones acquired via kfuncs.
> >
> > - To return a referenced kptr in struct_ops,
> >    1) The type of the pointer must matches the return type
> >    2) The pointer must comes from the kernel (not locally allocated), a=
nd
> >    3) The pointer must be in its unmodified form
>
> I only left some minor comments in the patches.
>
> A few other thoughts:
>
> I think https://lore.kernel.org/bpf/20250210174336.2024258-11-ameryhung@g=
mail.com/
> should be a good addition also. A new subtest in the prog_tests/pro_epilo=
gue.c
> should do for testing it.
>
> Another thing is disabling tail call in the bpf_qdisc_get_func_proto in
> https://lore.kernel.org/bpf/20250210174336.2024258-9-ameryhung@gmail.com/
> I am wondering if it can be done in a generic way for all struct_ops in
> check_struct_ops_btf_id(). At that point, we should know all the "has_tai=
l_call".
> I meant only for ops with __ref arg such that it won't break the existing
> struct_ops.
>
> I think both of them could be a followup.

Your suggestions make sense. I will follow-up on these two items with patch=
es.

Thanks,
Amery

