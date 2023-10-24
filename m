Return-Path: <bpf+bounces-13140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4108C7D56D8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2F72819D9
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6819381AC;
	Tue, 24 Oct 2023 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArKV8Nz3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B04374F1
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A87C433CA
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698162373;
	bh=NTGZLGGh8dbbKXLwOvkE1ecu6YAQQqIHk0ThiZGYjFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ArKV8Nz3qjYGdpXq3q6JbDPN+s11Bxh1PlkoCusYEj6Gu4kyCO1vhpk1tQG29rwuT
	 veGGbdOwEPNYRTcHrA9ovwY1OuHyNiOvgDXleC3yyKiqW868oGjpkF5Xx/vXBxrOon
	 Iu+9UTtqJcbLtBandg/MnylqvVTHqgmBBmkTS0gZ1CW/zkAwFpzLkWCbbkMdfyR56t
	 6jbSV5OfV7D0Ot19HZu6nb6dwrJIowQckPwdmAOQCoNTql+vsrfulJe+YMbY5xGQXt
	 20/R5lfrey/PG8Sje/ZklLMRXe5YcObz9NwA/uZWEECl8xLp6ien/wzaz8ecPgdVIc
	 eGA2oAnlQUr8g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so5301544e87.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 08:46:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJd319xwPvjr3qJ/JzqRmIauMaHo20dYLlyTPNKZLUh4FAEBMJ
	FZcSj9UI8oXaB+v3TGHCJYCXKXxRmJ/qXwlWpX4=
X-Google-Smtp-Source: AGHT+IHcYvjLDmX5gbPeW6HkkyybRmaTXJeVSHNlbhkdXb82j8/zS9pIVOEhvHSOGBfZv1mT9UwxmuT2I0Pq4GX7nQg=
X-Received: by 2002:a05:6512:3685:b0:505:728d:b48c with SMTP id
 d5-20020a056512368500b00505728db48cmr4328153lfs.19.1698162371796; Tue, 24 Oct
 2023 08:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018180336.1696131-1-song@kernel.org> <20231018180336.1696131-4-song@kernel.org>
 <c1e44b6f-f18d-8c30-3ff7-8af35a0706bf@iogearbox.net>
In-Reply-To: <c1e44b6f-f18d-8c30-3ff7-8af35a0706bf@iogearbox.net>
From: Song Liu <song@kernel.org>
Date: Tue, 24 Oct 2023 08:45:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4LEpELW7GT5Ephe4V8_djub=vaZWUHQhdaWU9ojs=8vg@mail.gmail.com>
Message-ID: <CAPhsuW4LEpELW7GT5Ephe4V8_djub=vaZWUHQhdaWU9ojs=8vg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: Add helpers for trampoline image management
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com, 
	Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 7:46=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/18/23 8:03 PM, Song Liu wrote:
> [...]
> > @@ -1040,6 +1038,38 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_ima=
ge *im, void *image, void *image
> >       return -ENOTSUPP;
> >   }
> >
> > +void * __weak arch_alloc_bpf_trampoline(int size)
> > +{
> > +     void *image;
> > +
> > +     WARN_ON_ONCE(size > PAGE_SIZE || size <=3D 0);
>
> non-blocking / can be follow-up, but why not:
>
> if (WARN_ON_ONCE(size > PAGE_SIZE || size <=3D 0))
>         return NULL
>
> size could also be u32, then you don't need size <=3D 0 check ?

Thanks for the suggestion! The code will indeed be cleaner with
these changes.

Song

