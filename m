Return-Path: <bpf+bounces-27110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0AB8A9246
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 07:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E8D1F21982
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 05:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763B54BCC;
	Thu, 18 Apr 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH3bP/yI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69187282F4
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417095; cv=none; b=d0r9RcG7JjmG32Ov03LQZgq9nXOtVu/c0YQW7gVgkqsOQtno9c9k2i+Yz2HXBVu95MzgCwZ8qAWa5X8kmAk5IUqyFiYtj5HWNK/VAkX4W6Wej1hpvlJKOwA6Jbnu1yXmbDr2LqzsZ2SX3R+iclCHgN0PaTKTolVXySAwoSm4cxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417095; c=relaxed/simple;
	bh=Z/atiaVkm0tszWpdXwjnAeZ8ftfdk4W6M4IMZ2FWOw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIASUcv8jHUWBctRJ/FLdE3Z6dKlvuC2eUzHoMflqhlvYzUEQPPdHggJ7CgVeJfX2jjwwn4os56GNh0dR53M2OlLMBAictcvD7QWGD24hzjFbubi6rKyvokvn/oAV6SLLsYSnEd+LR/nCs1FfKJi6XdIXJ8m0tcO68q8vUcgWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH3bP/yI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418dcaa77d5so3613275e9.2
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 22:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713417092; x=1714021892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLyb23bKXUIQYYGxaz26KUBaTj3GST7zpsLNHdi9yXw=;
        b=cH3bP/yINfz6pF/6Y0VKeDftosgywzlwVxKLiTEorkmapBghgCy1Ejh0Z1H2j+D9Qs
         ebxUmo/S+OTroc7azeRc8Qg2u7yueYFmkiHAOnXkZSgfwYIOpdES6VWvjOoAgreI54c0
         ogUHnxY3QGx9MG05IaLGqyWsm/uJVhyi4UnNEV4Xbo4Fx2zh2ZquV3KDfyHD6h214ovl
         W/CvDT6+RVA7F/a9J+UVNUtTu4WGcUzwu49FsCYN+kCMYFdClIrFQp+xxozhQNQKkNmy
         kCneTygHrwod2EQxlfvso7RMBrC/oNiHgRmbxJdjyxeWSkU9yQKjZ9goN40ssHwyfI/1
         Ampw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713417092; x=1714021892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLyb23bKXUIQYYGxaz26KUBaTj3GST7zpsLNHdi9yXw=;
        b=vknwEE9MSIAlcttBLCs1s5qbbn4iIZRAf6hFLaaJkFn7/NCCcJwCs+X6fJbVtANW08
         RmMz/2cwjWWRpQSvIWXcDcIsZXh8eSnnQMJ2vcRusojqnVQh+Z38bZVODCLmV4iu1gEX
         FsWRX4Yjp/H8zvTlgZU8Ci3Ynhjfg+FOEm+Xr80WK6ltx7CRRbk9Mspxx9lnXNDrTMbK
         J+6GVcAXkeA6Ji+Y21yPU7Hpzd1/CUyVtKwQn9UzT4NQkf8TnDQEo5AcitKx3xw0LylG
         SH6tNRChQlG1P8TRQ+6eXRnkn6y6bankA4vndM9naATUQgmn2IShgbDbaPH820QHfBJe
         uteg==
X-Forwarded-Encrypted: i=1; AJvYcCXMT6FPORfUW7gVEMswARnorpL8ThJcbgl8z86KnvJcp6ycYv8CsoAE4SlNBp3owDqHpj9WrtMP1GPZSqsEKbRJfVnh
X-Gm-Message-State: AOJu0YzOG9g/KS3TU7MQ20Bmvv4J/2WlftDtasPbWbDc/KNlb9Q+I6xL
	JE2MQ1oRTFwvz9YBx7ifrzprs8wSkRbL4wfPSMzT5yIXffy4xzX/R+LbTRVUxWHKjCHy2NXSVK0
	D2lEq32HQTmyCFDGplthJSzg/VSc=
X-Google-Smtp-Source: AGHT+IFs7KdwYUccfNSF2jHp5iXcIM8enlRKu6Th+Yz0SGsxGXBE4nswrCSv2PrxuzH80WDiI4PYaTHMcl9OqZYCkyI=
X-Received: by 2002:a05:600c:c08:b0:417:e316:be80 with SMTP id
 fm8-20020a05600c0c0800b00417e316be80mr1065345wmb.3.1713417091504; Wed, 17 Apr
 2024 22:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210814.603377-1-thinker.li@gmail.com> <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com>
In-Reply-To: <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Apr 2024 22:11:20 -0700
Message-ID: <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:31=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 4/17/24 20:30, Alexei Starovoitov wrote:
> > On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.=
com> wrote:
> >>
> >> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
> >> global variables. This was due to these types being initialized and
> >> verified in a special manner in the kernel. This patchset allows BPF
> >> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
> >> the global namespace.
> >>
> >> The main change is to add "nelems" to btf_fields. The value of
> >> "nelems" represents the number of elements in the array if a btf_field
> >> represents an array. Otherwise, "nelem" will be 1. The verifier
> >> verifies these types based on the information provided by the
> >> btf_field.
> >>
> >> The value of "size" will be the size of the entire array if a
> >> btf_field represents an array. Dividing "size" by "nelems" gives the
> >> size of an element. The value of "offset" will be the offset of the
> >> beginning for an array. By putting this together, we can determine the
> >> offset of each element in an array. For example,
> >>
> >>      struct bpf_cpumask __kptr * global_mask_array[2];
> >
> > Looks like this patch set enables arrays only.
> > Meaning the following is supported already:
> >
> > +private(C) struct bpf_spin_lock glock_c;
> > +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
> > +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
> >
> > while this support is added:
> >
> > +private(C) struct bpf_spin_lock glock_c;
> > +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node2)=
;
> > +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node2)=
;
> >
> > Am I right?
> >
> > What about the case when bpf_list_head is wrapped in a struct?
> > private(C) struct foo {
> >    struct bpf_list_head ghead;
> > } ghead;
> >
> > that's not enabled in this patch. I think.
> >
> > And the following:
> > private(C) struct foo {
> >    struct bpf_list_head ghead;
> > } ghead[2];
> >
> >
> > or
> >
> > private(C) struct foo {
> >    struct bpf_list_head ghead[2];
> > } ghead;
> >
> > Won't work either.
>
> No, they don't work.
> We had a discussion about this in the other day.
> I proposed to have another patch set to work on struct types.
> Do you prefer to handle it in this patch set?
>
> >
> > I think eventually we want to support all such combinations and
> > the approach proposed in this patch with 'nelems'
> > won't work for wrapper structs.
> >
> > I think it's better to unroll/flatten all structs and arrays
> > and represent them as individual elements in the flattened
> > structure. Then there will be no need to special case array with 'nelem=
s'.
> > All special BTF types will be individual elements with unique offset.
> >
> > Does this make sense?
>
> That means it will creates 10 btf_field(s) for an array having 10
> elements. The purpose of adding "nelems" is to avoid the repetition. Do
> you prefer to expand them?

It's not just expansion, but a common way to handle nested structs too.

I suspect by delaying nested into another patchset this approach
will become useless.

So try adding nested structs in all combinations as a follow up and
I suspect you're realize that "nelems" approach doesn't really help.
You'd need to flatten them all.
And once you do there is no need for "nelems".

