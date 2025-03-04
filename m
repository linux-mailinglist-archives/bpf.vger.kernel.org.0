Return-Path: <bpf+bounces-53159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232CA4D1FE
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 04:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE66A7A300D
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B2189BB1;
	Tue,  4 Mar 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ARceBhAq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B1B640
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741058324; cv=none; b=TuDf+5F3ST/OnawkVyyrkSb/bBXztvu/0ehAso2OFC3QRZ6O2NpW8tL1NiXZPFZd1QXeD2awge9SWdI/U8LzlpOXTqBA0M+25qHq9Mr/hLRYmJFmDEFDIqBDVGheZl1G4Q52s9USt6s2dKSusbhatf84+tS8tZoUjIEUreaLNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741058324; c=relaxed/simple;
	bh=iILAiWbEj6twID+5lSsQlisVXDGxmJFY1G5iVrg8jWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bctLiqTFKOt0D6nyCGR+wVJnnW1+eQE6yURKPWQE6jBudT+Qg/ZG1Og9Nwh2FpY3sBT06z0D3kHi14/uNNGD40K6659DehuNZhBDsD6y0tzb5b3S5Z8mGRZc3a5vZGhyUcfT9a1stTS3D4M0MzRpdLmPQ7sx7SW7ckRgtSUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ARceBhAq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f6c90b51c3so47641897b3.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 19:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741058319; x=1741663119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBbSOOyBsN4vl+LoGn6VijeMJR9mva3Pr0jebWnY27E=;
        b=ARceBhAq+/yw1uE8HJuGBth7+kLb4YNcSBW0PRiAMLqlYKCUwQp2wyRz7VE1kJSHJ3
         TF+CxxfSdOd+XOdsW6llD/rfJ5tU1WGG/2QDHCoSUY5y1ccdKhuefU92isUBI6NcVB2e
         pMg9Tv+qtSXqkoYZaN3NeQKjD8IxYOTaJq7J+jVrKVxw4DwJyuV4s6zI9qgZVmMEF5xa
         L+a3ymRL/7+TLxRfW2U1JyV7sAU2I2cCWVaOvNfXuTMzHWWjmMkdwPgbA/65XmLAW+RE
         nplWzOIxGgsVWbMM8bSU3CwuMIJkF7pSxOCtuj2wyB/dHBktL2149kVx+UlL7uMD0E4g
         3rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741058319; x=1741663119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBbSOOyBsN4vl+LoGn6VijeMJR9mva3Pr0jebWnY27E=;
        b=G7lwtcYxpGc5KaQspRM5/2GEio3nstQvs8cqWejwGfozOUfSwlzQvZWLP9U02QZ+3W
         OiKxHeDcJPUAJvl5xwiQutduqIAyEJQ+sq2YZK1w7Z1nhu51Sa7vCP/bbejfnEM38T5k
         /gFwNDB+eG/p7ha9NXDSgMqLN8ZdJ1MfVf8roEcTpAY9JXFzyQg7J4jMj+XW/3jZL9gX
         ss9RDfBiD7Ch77DQuUlL46qSWlReW75TEyr7TkFud9VYHf5zqwYBC89U12xABaL+YeGo
         x2aYGuJST9x9JSzX/kiFXF8+MUDOps1pl3F6EemFja0RxW9bQKu3mO8X8tNhEAdJJ8xQ
         nFAw==
X-Gm-Message-State: AOJu0YwdY4nKH7vcFWNA/k3TndJ5MnTYEuGZnBpENxyvnZ3m2DELbaoS
	XkTCxsoGD85DrRj3tKtdqGIddZgF/5uRyF887gNyLDuQsI6J5yiGC9cHxCTx2o3RP2eSRZUDtFg
	thSJnnP1NkAmqfyajnHQyb1pv9x4RV/eS40tTwCpW5PFJ/fw6rb0=
X-Gm-Gg: ASbGnctJ91nCpEmAV9q0IpuOrbL7WHav9pJyT9Rip12ahQG1qIMCKK/7y3PMI1SZuTn
	IcdV1xKVHSQJbfec9tmrAye/Rm/w4gtxqu/XcbrHy/0afCwi+h6geki5Yj9pXR2decmZVyCfC0f
	b2BWuD3OACkO0Img8jEvkkyFat8IE=
X-Google-Smtp-Source: AGHT+IF5GlhwBW+JU6cwdrJEtLs/Wm3eAvnwJWuADl6d66GShSULTDvRZWkHCs+rt78UPfK2/yLDjivz2RmD0FGMe1Y=
X-Received: by 2002:a05:690c:7086:b0:6f2:9704:405c with SMTP id
 00721157ae682-6fd4a0865afmr214886427b3.15.1741058318869; Mon, 03 Mar 2025
 19:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228003321.1409285-1-emil@etsalapatis.com>
 <20250228003321.1409285-2-emil@etsalapatis.com> <9c51ec81-d7e3-679e-055d-8f82a73766ef@huaweicloud.com>
In-Reply-To: <9c51ec81-d7e3-679e-055d-8f82a73766ef@huaweicloud.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 3 Mar 2025 22:18:28 -0500
X-Gm-Features: AQ5f1JqtHycDKIYOYO0ytC5Hqp-CpOddvFnr1b9Sq5v-yvBqhkZqTDcuhgJDR9E
Message-ID: <CABFh=a7U8ut-YE1kc=P60sqrG4ySXMcXKewpoKzAvpQoQz8pgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: add kfunc for populating cpumask bits
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.de, eddyz87@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 28, 2025 at 7:56=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/28/2025 8:33 AM, Emil Tsalapatis wrote:
> > Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF
> > memory.
> >
> > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > ---
> >  kernel/bpf/cpumask.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index cfa1c18e3a48..a13839b3595f 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -420,6 +420,26 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cp=
umask *cpumask)
> >       return cpumask_weight(cpumask);
> >  }
> >
> > +/**
> > + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
> > + * a BPF memory region.
> > + *
> > + * @cpumask: The cpumask being populated.
> > + * @src: The BPF memory holding the bit pattern.
> > + * @src__sz: Length of the BPF memory region in bytes.
> > + *
> > + */
> > +__bpf_kfunc int bpf_cpumask_fill(struct cpumask *cpumask, void *src, s=
ize_t src__sz)
> > +{
> > +     /* The memory region must be large enough to populate the entire =
CPU mask. */
> > +     if (src__sz < BITS_TO_BYTES(nr_cpu_ids))
> > +             return -EACCES;
> > +
> > +     bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
>
> Should we use src__sz < bitmap_size(nr_cpu_ids) instead ? Because in
> bitmap_copy(), it assumes the size of src should be bitmap_size(nr_cpu_id=
s).

This is a great catch, thank you. Comparing with
BITS_TO_BYTES(nr_cpu_ids) allows byte-aligned
masks through, even though bitmap_copy assumes all masks are long-aligned.

> > +
> > +     return 0;
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
> > @@ -448,6 +468,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
> >  BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
> >
> >  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
>

