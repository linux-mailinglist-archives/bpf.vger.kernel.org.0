Return-Path: <bpf+bounces-45311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57E9D451E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A844B21FA7
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400292F2E;
	Thu, 21 Nov 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjLcekoi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AB29A0
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150310; cv=none; b=tKSHtwtaLeRP5QtV1EP8gfalG/nK2HLYYIMWqZC5aLOIitgESDT9kx+oi4NfcVKHhssVwCZmZ8Zw+f+0IsoSAoDm67CXDGTM3Ma2YDFMwTtpr5PV9exiP41eOE+3aF2r464HrlfSwLI3fm4ju8Py3UJOUV5H7sJRBt+KgNNOsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150310; c=relaxed/simple;
	bh=VvXaxGul5eyjvbzM9SqgLN8iLVBsZ/CC8nmQYOWLsCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzorCUOyTgfenn3AX46GD2NNGnymFyh8aXeD6sL3OKo4KrcwMHQc5V5b/RpfuaGOUWRkIvRP55RT9/XW7+U1YbBJLBhu+Xt0glX48FCmOORtDrkYNEuuiFPHaqZ3kAzmvcNxPQUetHGgYZsNFwbo3a+nkwo8kyNNlhh5Q9OJL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjLcekoi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431688d5127so2452125e9.0
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150307; x=1732755107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvXaxGul5eyjvbzM9SqgLN8iLVBsZ/CC8nmQYOWLsCc=;
        b=JjLcekoiP9UHqUEkqAsETIckHXd1fNmUMz91kxK27f1hWSL3xd+kJvtwLqDzR7Cxfi
         bL7V1fTfLuU8g+0e8MksSasIi7rfLN0FkObDA6PM28PgjVcitxrjzgYK511KDf6EANPI
         n+LkuCPlUezipj76MxNlcJE4FORzLFpCnC/ISIix42Jn90Oij5QtovbsdQhwHbiaUG1A
         i7rQFd7xhX//7uqVHdq5FISt4oRsWBjxokGS3BeStT5ETVEZ0eEWO9USdiO1R0O5hIhY
         BbBjsdvTUyB2tOKxxT+kR7qOdpVPxQjEmkqJHuEYvYC1RFw9ScOeq+a6D/L9FlU24RvS
         Nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150307; x=1732755107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvXaxGul5eyjvbzM9SqgLN8iLVBsZ/CC8nmQYOWLsCc=;
        b=a5sRRKOhYLheexmU12NqU+Qi4lkFofUTt3pVFsllV9WDfI0nqLwJTWMkp88IhmiIBS
         OFNG9eK2WBWlEtyHTk+GKVBiM9RCUQ4O0sh57t0qri+ssv7peyUFuWgpbUeU0sICo9Mj
         bgBliF1BH2wWmDOpdP27kF9QEo9JNMsIV6KI4vK6v5/hzRyIN7UfocoPK4ByROO24WE7
         wZAykecgIFQWdLjNN34I4x1/HieDsTZEJcabvMqvWw6kzFPkZRB9POYNaxgoh150aQh/
         2u0uyS+5F5Dz0WHlAi+vT8PsZbkUoJ+0713y0UoYkXy04lK9Vhq0q/N+GtHCiizn3CMG
         52xw==
X-Gm-Message-State: AOJu0YyEs/u7Yt84Jqhpi89YCetwVB2SvMDmABip08vY3xjh7FCQBgBI
	p3104LzCS3aDpmUF3QZQMWRWO2SGR9/A3sqXO6hpmlsIdSzerPUapoUoIWNpd2kzXAnhQr6DTod
	mV8WgavPsyI270XYZr3hmJyLUF0+KvA==
X-Gm-Gg: ASbGncuoJjAkFCVvt6t02x3Dg1LkYQ/8Bg43/1QcTDCdU23rRykUwVwHC41ip8cqSLP
	qSswh6I7XQ/TaD+ieLOGt0oh90E6afg==
X-Google-Smtp-Source: AGHT+IHPKLbXoO0qWGt+uKPMDfUfA4tcefrBj5AnxD22BWtF91efgGQMhBybUUDt44LSQMOUZnnPMcJyUTSc8kSFZ/g=
X-Received: by 2002:a05:600c:1d95:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4334f01fb66mr38940725e9.25.1732150307207; Wed, 20 Nov 2024
 16:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzyDCKrmgAGa4NDD@google.com>
In-Reply-To: <ZzyDCKrmgAGa4NDD@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Nov 2024 16:51:36 -0800
Message-ID: <CAADnVQ+4qCnVBPbJdwYOakc+Sg-_55pekSsuavFxYS7eyMycOg@mail.gmail.com>
Subject: Re: bpf: adding BPF linked list iteration support
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:22=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Hi,
>
> Currently, we have BPF kfuncs which allow BPF programs to add and
> remove elements from a BPF linked list. However, we're currently
> missing other simple capabilities, like being able to iterate over the
> elements within the BPF linked lists. What is our current appetite
> with regards to adding new BPF kfuncs that support this kind of
> capability to BPF linked lists?

What kind of kfuncs do you have in mind for link lists ?

So far the only user of bpf_rbtree is sched-ext.
It was used in one scheduler and the experience was painful.
There is a chance that we will remove rbtree and link list
support from the verifier to reduce complexity.
So new link list kfuncs may be ok, but potentially not for too long.

> I know that we're now somewhat advocating for using BPF arenas
> whenever and wherever possible, especially when it comes to building
> out and supporting more complicated data structures in BPF. However,
> IMO BPF linked lists still have their place. Specifically, and as of
> now, I'd argue that the BPF linked list implementation could be
> considered more memory efficient when compared to a BPF arena backed
> linked list implementation. This is purely due to the fact that the
> BPF linked list implementation can perform more constrained memory
> allocations for elements via bpf_obj_new_impl() based on the demand,
> whereas for a BPF arena based implementation a BPF program needs to
> allocate memory upfront in terms of the number of pages (modulo the
> fact that not all pages for the BPF arena will necessarily be reserved
> upfront). The fact that allocations are performed in terms of
> multiples of PAGE_SIZE can lead to unnecessary memory wastage.

I don't follow this logic.
bpf_mem_alloc is relying on slab that relies on page alloc.
So either arena or bpf_ma allocates a page at a time.
So from that pov the cost is the same.
But in practice bpf_ma needs extra 8 bytes for every allocation
whereas arena allocs don't have this overhead.
Right now arena allocs need to be sleepable and that is
a severe limitation for tracing use cases.
We're working on lifting that. Once that happens
allocs in arena will be more usable than bpf_ma.
kptr-s in arena is another required feature.
There were few proposals. So it will be done as well. Eventually.

So new link list kfuncs are ok, but might get removed in the future.

