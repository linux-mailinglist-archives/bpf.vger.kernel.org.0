Return-Path: <bpf+bounces-77379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD3CDA60B
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7427301C439
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC857346FA4;
	Tue, 23 Dec 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRo5SSOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0B3043BE
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766518569; cv=none; b=msbDVjeynvVtV4EQcu8ZQoipPZ1exMw0ll6EsKf0aWMf0FNpyMR83SW7n/T9CMW7+R4DOM+GdQr/NWGlu0uTL4bYuwZ1Gnx8NSIXSY2eoDmXUulSfiDv90OMgDRpcMnhG+x9uEiADJNWdzd8g5t7Hn/KuF7DERO+NnGwmKQG+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766518569; c=relaxed/simple;
	bh=peN2WTMedxeLC2rmTLYlO9iplVfIegggV+F13cWlmYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdXclbS5YV0jplx/Wcs6nksPvAEaCoevHh2rYd+xFUirt858JKOfUqQ++2/jgNRJOVeBjLOLWwMTE4BakI/aqFRK6DwjIGBrqHdxXwn6ltnC4muqXSLRfEXCUzlNON1lhLQ6GWJp0X2MBBzWzoS6xsyJtT65vCbYrT8Aew2R56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRo5SSOJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so6491371a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 11:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766518564; x=1767123364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuyYgfLJ0fJTK7Cd3mWNz9l29EAgRZr/p9f+qs7JjJ8=;
        b=HRo5SSOJCK+rwigIg2YLeqR/32PS7ZUl+CvEv3klJAMCTml0GCbv5fU1kqkK4D/A5F
         Cfb8/eL5CLlCbUjFOBBESaLfnwNGMlN0m8bq3dmKi2G/usFAEVpFembm5fNfJFXskopE
         PwnSbIGDPxWhnrgxVDAmFrehjgGEe9evrpiUjWdqOubPzgnBApXL/mdyaKfJjbIyRz5Y
         65VOOYUB+smHlZ8d7H7/ZbbmGWQyppvxaOni3Kc0k8HbN4CXwCNZThAM5l46JZbThPwg
         eeAbyfgJlv0K3bIM8Ibq1Da+WzgteiOXWX65BIL/gtwiqC6rdic1vhc2vNMuuNZ87MNq
         bYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766518564; x=1767123364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NuyYgfLJ0fJTK7Cd3mWNz9l29EAgRZr/p9f+qs7JjJ8=;
        b=ph601DM3VNm0VZHlYnz+xU0lO/jUIL/p/yopxSOrxEFxY/RerAOO35o4LXSp0mRTh0
         60ycvHucnP+LoKSdZXQcVOMk80t3Y5Ic7xoFr69E7aKiQ2TkEzg+3LXTexUVuwrHiZHU
         Jqd+rMmD1d0PB6YF7OcEj/yej+MRqbw59KirnBzy6g4klODIeJmF6h6uZ0b/ToLjUouZ
         L7uzqSwqDfMDuWh8pmb6jJuHuBBqqybMgQV/vPlAUed/n+nHqqVn06G9eyfMjsb8Myd8
         pLK26nLqmST7ES3zytDiQuwPmr7z5xt+2XXd0bDd7EDTYpQED8dS+IEBcEYkHcnb7/Fx
         5LcA==
X-Gm-Message-State: AOJu0YzygOUUBtv2SwQIrU2LiyY9RyOWG12QoqGIWzEv/JKvjY9yVg5T
	DpQHJnI2q/oUlhi9+H5OwptwutsC+3QqnAXjsH1IUSTEagmtJbMDmS75UOtNPIpBwDTICbrxnVa
	OD6wfA4rKoruqk+8kX/amUptRdAz8EH0=
X-Gm-Gg: AY/fxX6odAxSSiYj46ZTj9xiOXcWZ6RCLx66Hbib/MbEU3j6x1zwseX1hDqeXQYdjJ9
	xExfsnjSsWROZDKXhfDe5TG36aaQTF0HPdAWqpxqxdfxxKPn5tNXZ6Ps/2XPSlXPYOxmmKstMDV
	PClrUHSGjy03VbGk54WK4bHikr0CDgVEKKb8Z/6bvtvPDEkF8uO/7b4cBPkwls6Ugm9bqdoK6Vx
	sptGgKsSGKz0hAqMK4+dKT5wSMCB/De+Xy/UbGeTrYusHDvO8lnyqLRN8LgBsnktkhgCPSJ
X-Google-Smtp-Source: AGHT+IESZXD0ycb3Qs5/xWn7QSoKnUgtnAXlXYQ+HSFH33brjkAoYnuO5jGs87kM37OwjCpBqC4ccGDcOLjpVczX1Zc=
X-Received: by 2002:a17:907:9811:b0:b79:f4e4:b55d with SMTP id
 a640c23a62f3a-b80371da8d4mr1683102666b.51.1766518563879; Tue, 23 Dec 2025
 11:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
 <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com> <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com>
In-Reply-To: <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Dec 2025 09:35:52 -1000
X-Gm-Features: AQt7F2ouI-Uzlk0kBDKNxtKpZT7qn8bQyEjyY_JmjafppdHKjDM_DouWMo7qRug
Message-ID: <CAADnVQLBFDU-E=_4DM1rp6dNgEaDKKfJaHehemDfJmVZm6OvOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:51=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> > >  int reserve_invalid_region(void *ctx)
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c=
 b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> > >                 return 9;
> > >         return 0;
> > >  }
> > > +
> > > +SEC("socket")
> > > +__success __retval(0)
> > > +int big_alloc3(void *ctx)
> > > +{
> > > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > > +       char __arena *pages;
> > > +       u64 i;
> > > +
> > > +       /*
> > > +        * Allocate 2051 pages in one go to check how kmalloc_nolock(=
) handles large requests.
> > > +        * Since kmalloc_nolock() can allocate up to 1024 struct page=
 * at a time, this call should
> > > +        * result in three batches: two batches of 1024 pages each, f=
ollowed by a final batch of 3
> > > +        * pages.
> > > +        */
> > > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_N=
ODE, 0);
> > > +       if (!pages)
> > > +               return -1;
> > > +
> > > +       bpf_for(i, 0, 2051)
> > > +                       pages[i * PAGE_SIZE] =3D 123;
> > > +       bpf_for(i, 0, 2051)
> > > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > > +                               return i;
> > > +
> > > +       bpf_arena_free_pages(&arena, pages, 2051);
> > > +#endif
> > > +       return 0;
> > > +}
> >
> > CI says that it's failing on arm64.
> > Error: #511/6 verifier_arena_large/big_alloc3
> > run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
> >
> > cannot quite tell whether it's sporadic or caused by this patch set.
>
> I tried reproducing it locally multiple times and it didn't fail. It
> also doesn't fail on manual CI run:
> https://github.com/kernel-patches/bpf/actions/runs/20442781110/job/587400=
00164?pr=3D10475
>
> I assume it is sporadic.

Ok. Applied. Let's watch for this. If it's actually flaky
we need to fix it.

