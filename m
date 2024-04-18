Return-Path: <bpf+bounces-27142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F618A9DA5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2432E1F21730
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B2168B10;
	Thu, 18 Apr 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLnWKqsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7215F418
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451995; cv=none; b=YH28yBlEq1m+UNNzy4YRmlobMOO7qYJ1qE0xicH2UnjlpsmN8gxz4vQSAyZyHO5G+ffiR7/R4OTg5V/GGS/RJnoW5tnZs2Z6mN4Z29WLcX4EqaqnrenO1AfYVwep2BYbXm3LMcdQ2E//C3VXSvMZR7fGVyozTdXBf+VZvYiUZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451995; c=relaxed/simple;
	bh=E+QqoUyKTtb4RkYV4sJ5H2eYDaKo8WKO+W9VmawvQuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sae63F0E2o18KVQcP04mdoOkcmxGTrt3kbfy/paNTC4p3JLESEZzuWM8/Sy0JpN3gxyToVdigUwscaTsoUMm3RE+X8YpMp3fQpqU2CZJRxqbuDe91tLU31opiCjU6G7/3h9vIbCak1quAHWb4oJ8l42HjQrucLTWlY/5oKO9yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLnWKqsZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so840234f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713451992; x=1714056792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siBhCuojFZa3xiIL8O1lDPMwABLevgtmSDCVo4fQhck=;
        b=nLnWKqsZssa1d4+9AyWokoo/YZ34qPKSOf29y2/znNqfq5Gmtd5j7YOASaxM7Xcpbv
         GKEqCCPaDz+Fl4IER4NuXbD/eK1JBLfaYHF32X5D5COMdhxMncJ2peETXkJxHyYy4w8A
         pykOApegnET3Qoe9FexcSohcHULb8LpVUU69jFRpeXPYLa6gE/wYf2V7Z1znyzuXTUBV
         uGABzKsm6uuBaFj98zhz5T5T+BXP7eLZVTJkXCgPLZqxR3rG2A4wdFgq6iFoLrhXdzHs
         Jx845U8TamldrB4/N50cp8bCXxrdBst8X/TxnMH2tH5mitudKwGBgkEaa/lNomOIOhJU
         DLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451992; x=1714056792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siBhCuojFZa3xiIL8O1lDPMwABLevgtmSDCVo4fQhck=;
        b=FG9JB70hPJkUfaXF3e24j1fS6UE5Y7PFjPPj4OkrBTTAn/WdQ//7EmUdFhxH81wWcU
         Y9M4euTrbfKHA6509cuq9bjLooqjZEtoPZSY0CbXjcxn9N3LF/rvkfxN9ofjrQS+C1h6
         Rv9Iu0WfG6G9DySIaxKag9zOl/UKah79glIGasmNqzsUngoAdqX5bBXkrqr+qZ+yMwpU
         sXonAnPxDrFcPGwbg5+x0M+WC+agjDOFWDT8yugXN8Bw6qNWHJo8n6UxO9eWvU4UiBuF
         5snHj4R7MsUFOzDlQc0RZGaXHGjz0Lm0afYoOOOtFaK0ZtrzyNzMA1vPPR9Advr8uJU2
         kyyg==
X-Forwarded-Encrypted: i=1; AJvYcCXrzG17MYPm2FWGibMkyro3w+cIQWaqFznlxa8ahWmtvUB9miuaNWcSlQXLSWoJyhZsMWT/eARlyl0K+hwV6DQqsAkQ
X-Gm-Message-State: AOJu0Yy2p2BqWBADwd9AMCE6RheygFuoRIYGqjzDEC6GNQiD7Y07lRKe
	7DEb1BnOEsE/DGKHRD6jsXIL9UgMzoYJu9+mVuYdtpeHP03ywgbv87RCFKa2HIhON8MK/EvihPv
	tVU1B6v1melrpQ+sGESehSNDPcyE=
X-Google-Smtp-Source: AGHT+IGtrhBAizGk8RxrAgkcYdKW9EF/7tWUnMTgBQwuXQ9IHhCGMl5TCHmGEWwV9UPgeT6Woo8tFaPLZxpwFkXhLIY=
X-Received: by 2002:adf:f910:0:b0:346:b8cf:b620 with SMTP id
 b16-20020adff910000000b00346b8cfb620mr2373036wrr.53.1713451992316; Thu, 18
 Apr 2024 07:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210814.603377-1-thinker.li@gmail.com> <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com> <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
 <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com>
In-Reply-To: <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Apr 2024 07:53:00 -0700
Message-ID: <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:07=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 4/17/24 22:11, Alexei Starovoitov wrote:
> > On Wed, Apr 17, 2024 at 9:31=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 4/17/24 20:30, Alexei Starovoitov wrote:
> >>> On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM Kui-Feng Lee <thinker.li@gmai=
l.com> wrote:
> >>>>
> >>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
> >>>> global variables. This was due to these types being initialized and
> >>>> verified in a special manner in the kernel. This patchset allows BPF
> >>>> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head i=
n
> >>>> the global namespace.
> >>>>
> >>>> The main change is to add "nelems" to btf_fields. The value of
> >>>> "nelems" represents the number of elements in the array if a btf_fie=
ld
> >>>> represents an array. Otherwise, "nelem" will be 1. The verifier
> >>>> verifies these types based on the information provided by the
> >>>> btf_field.
> >>>>
> >>>> The value of "size" will be the size of the entire array if a
> >>>> btf_field represents an array. Dividing "size" by "nelems" gives the
> >>>> size of an element. The value of "offset" will be the offset of the
> >>>> beginning for an array. By putting this together, we can determine t=
he
> >>>> offset of each element in an array. For example,
> >>>>
> >>>>       struct bpf_cpumask __kptr * global_mask_array[2];
> >>>
> >>> Looks like this patch set enables arrays only.
> >>> Meaning the following is supported already:
> >>>
> >>> +private(C) struct bpf_spin_lock glock_c;
> >>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
> >>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
> >>>
> >>> while this support is added:
> >>>
> >>> +private(C) struct bpf_spin_lock glock_c;
> >>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node=
2);
> >>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node=
2);
> >>>
> >>> Am I right?
> >>>
> >>> What about the case when bpf_list_head is wrapped in a struct?
> >>> private(C) struct foo {
> >>>     struct bpf_list_head ghead;
> >>> } ghead;
> >>>
> >>> that's not enabled in this patch. I think.
> >>>
> >>> And the following:
> >>> private(C) struct foo {
> >>>     struct bpf_list_head ghead;
> >>> } ghead[2];
> >>>
> >>>
> >>> or
> >>>
> >>> private(C) struct foo {
> >>>     struct bpf_list_head ghead[2];
> >>> } ghead;
> >>>
> >>> Won't work either.
> >>
> >> No, they don't work.
> >> We had a discussion about this in the other day.
> >> I proposed to have another patch set to work on struct types.
> >> Do you prefer to handle it in this patch set?
> >>
> >>>
> >>> I think eventually we want to support all such combinations and
> >>> the approach proposed in this patch with 'nelems'
> >>> won't work for wrapper structs.
> >>>
> >>> I think it's better to unroll/flatten all structs and arrays
> >>> and represent them as individual elements in the flattened
> >>> structure. Then there will be no need to special case array with 'nel=
ems'.
> >>> All special BTF types will be individual elements with unique offset.
> >>>
> >>> Does this make sense?
> >>
> >> That means it will creates 10 btf_field(s) for an array having 10
> >> elements. The purpose of adding "nelems" is to avoid the repetition. D=
o
> >> you prefer to expand them?
> >
> > It's not just expansion, but a common way to handle nested structs too.
> >
> > I suspect by delaying nested into another patchset this approach
> > will become useless.
> >
> > So try adding nested structs in all combinations as a follow up and
> > I suspect you're realize that "nelems" approach doesn't really help.
> > You'd need to flatten them all.
> > And once you do there is no need for "nelems".
>
> For me, "nelems" is more like a choice of avoiding repetition of
> information, not a necessary. Before adding "nelems", I had considered
> to expand them as well. But, eventually, I chose to add "nelems".
>
> Since you think this repetition is not a problem, I will expand array as
> individual elements.

You don't sound convinced :)
Please add support for nested structs on top of your "nelems" approach
and prototype the same without "nelems" and let's compare the two.

