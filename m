Return-Path: <bpf+bounces-45026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961769D00CD
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ADE283DA2
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0157192590;
	Sat, 16 Nov 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9nPz7xr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553438385
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731789311; cv=none; b=ZjFtKg2hjt1+vYAzhXvJFwV9VgTswCc2ht8izIK7GnqVkQCbfl5LnQsI9Qya8NdvHGOB/ThM5VvDHBC94/90AASwEyVZIX6Ip4oH/PCWWI6/gcU7p3teLxf2/YPRAPzMVTDQ9R/zgpkb2vS9n0lTlJzYqAV9bqz/6HaGrK3bggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731789311; c=relaxed/simple;
	bh=QRPw7yo8ZIcfnUjhFXqGjlkmq/LvYwky7h9QvBmrkuU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkBPrAnweiHS9hNXvQvAWnhtsni3Q7FvXv2LBzjm8ArmX+XAv/VzIXT2a5+9XSnXNSWBgf0h6qzi+NpbX5LTIuw117AxHXlIvtLAT5Up8ZIH6LyEqpPyCX07qV3nvFYKb3G1vntdp5eD54QotdzG+0Oj5dC476VMyFTRZonfXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9nPz7xr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso2429709a12.3
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731789308; x=1732394108; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xq5QuV/OoA5yAHbNk0piaBbIqxFWsOztNsEZ1gG5Z2k=;
        b=O9nPz7xr4FhAgczvwWuXiDkQDwzYXx2Ta7jTG+K3mXWYM/OFXbbfkX08+xPAr9O28W
         GG6UVNysUxcJdXA1L5/UnX2RBE7VO8QcGv6HfWYZmhgW04Zx6S1JAqWykJ64eRox3L9h
         QvaGuEU5MVpdSuPwb0frOIGX4ARrOik1qGp0tQ6yGUgiM7/GNTggVQU8/ph3D1fW3dwA
         xq6r69OpGbPxYKbs0CHa0zUmxl8q2SvU86ghUOvGU5OvR8JN+jAoTCNiJdJMYA9LtgsN
         JQ1SPP3j3+AlR5jdUgvwm9XoHGaUHUUq8p6FyaT7GU2Q8aMn0rb6LZU5ydsN9hkJFbGA
         fj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731789308; x=1732394108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xq5QuV/OoA5yAHbNk0piaBbIqxFWsOztNsEZ1gG5Z2k=;
        b=QLMWHEyYXqBf3ZteEsPnM0/Wiakl2sELIi4f6cskuvg36tHMYlkaTcYSE2QGr37dyj
         u9bMStnDNsQ9AV3uNamhD8z2htoFaf8Grc/3TyDC1lHvCZGpBPSKIVmPuexRXqlOjLl4
         xkk24eReDenkEXPUDsnfghntqRIqS3ncSDuDa2updZo/OHG8/7Qh5dON5Aiwo9Ayhj3W
         g/8C5GQcLQ9tiMdAcTGuybqf5gXtbZNG5l97IwEobZtPR6VgwX+2Skw5oKP+q/+mU+uH
         4bPd7gb7Yao3XmMFuaqGh1MZ37Ch1RsGCLeygpRqffupwO0l6d8GgqD+wt/qGJnD7mDk
         uEBg==
X-Forwarded-Encrypted: i=1; AJvYcCXbtWptxZPMvmVlLr8FVVv4UYbq+zZWIomfE0KvtNvJ2S5xKzI453Yq5yiT2ZGSUfw60x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfdipwtSpX2AoGoiJ/dJzvqrmbY1BXAa2HNFtaGHv3tqeFvDd
	DpJ1FtiM/6unrsVjjPxmcZuGBdkI293VnpG15I/mR5lcIvg0U+70
X-Google-Smtp-Source: AGHT+IEzyNQHwFCg5WNLyoI+BI7ttuN8GaR5pwwkm5BWD5WJ00/2LscjspGhtFsfA3O3M7ezug+4CA==
X-Received: by 2002:a05:6402:210f:b0:5cf:a20:527c with SMTP id 4fb4d7f45d1cf-5cf8fceab92mr4502060a12.21.1731789307741;
        Sat, 16 Nov 2024 12:35:07 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfb07c1700sm593627a12.67.2024.11.16.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 12:35:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 21:35:03 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, djwong@kernel.org,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for arena range
 tree algorithm
Message-ID: <ZzkB9xr90ovtnhhK@krava>
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
 <20241108025616.17625-3-alexei.starovoitov@gmail.com>
 <Zzc8pVMtTAkqUdvA@krava>
 <3c98dc9c-0014-49a1-8d7a-910f0992cccc@linux.dev>
 <CAADnVQ+Md9HYD=0UGRy0FCDjD7MYbEexy8y0y7X+nUqWfus9hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+Md9HYD=0UGRy0FCDjD7MYbEexy8y0y7X+nUqWfus9hQ@mail.gmail.com>

On Sat, Nov 16, 2024 at 11:00:21AM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 15, 2024 at 8:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> >
> >
> > On 11/15/24 4:20 AM, Jiri Olsa wrote:
> > > On Thu, Nov 07, 2024 at 06:56:16PM -0800, Alexei Starovoitov wrote:
> > >> From: Alexei Starovoitov <ast@kernel.org>
> > >>
> > >> Add a test that verifies specific behavior of arena range tree
> > >> algorithm and just existing bif_alloc1 test due to use
> > >> of global data in arena.
> > >>
> > >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > >> ---
> > >>   .../bpf/progs/verifier_arena_large.c          | 110 +++++++++++++++++-
> > >>   1 file changed, 108 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > >> index 6065f862d964..8a9af79db884 100644
> > >> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > >> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > >> @@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
> > >>      if (!page1)
> > >>              return 1;
> > >>      *page1 = 1;
> > >> -    page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
> > >> +    page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
> > >>                                    1, NUMA_NO_NODE, 0);
> > >>      if (!page2)
> > >>              return 2;
> > >>      *page2 = 2;
> > >> -    no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
> > >> +    no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
> > >>                                      1, NUMA_NO_NODE, 0);
> > >>      if (no_page)
> > >>              return 3;
> > >> @@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
> > >>   #endif
> > >>      return 0;
> > >>   }
> > >> +
> > >> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > >> +#define PAGE_CNT 100
> > >> +__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
> > >> +__u8 __arena *base;
> > >> +
> > >> +/*
> > >> + * Check that arena's range_tree algorithm allocates pages sequentially
> > >> + * on the first pass and then fills in all gaps on the second pass.
> > >> + */
> > >> +__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
> > >> +            int max_idx, int step)
> > >> +{
> > >> +    __u8 __arena *pg;
> > >> +    int i, pg_idx;
> > >> +
> > >> +    for (i = 0; i < page_cnt; i++) {
> > >> +            pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
> > >> +                                       NUMA_NO_NODE, 0);
> > >> +            if (!pg)
> > >> +                    return step;
> > >> +            pg_idx = (pg - base) / PAGE_SIZE;
> > > hi,
> > > I'm getting compile error below with clang 20.0.0:
> > >
> > >        CLNG-BPF [test_progs] verifier_arena_large.bpf.o
> > >      progs/verifier_arena_large.c:90:24: error: unsupported signed division, please convert to unsigned div/mod.
> > >         90 |                 pg_idx = (pg - base) / PAGE_SIZE;
> > >
> > > should we just convert it to unsigned div like below?
> > >
> > > also I saw recent llvm change [1] that might help, I'll give it a try
> >
> > I am using latest clang 20 and compilation is successful due to the llvm change [1].
> >
> > >
> > > jirka
> > >
> > >
> > > [1] 38a8000f30aa [BPF] Use mul for certain div/mod operations (#110712)
> > > ---
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > index 8a9af79db884..e743d008697e 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > @@ -87,7 +87,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
> > >                                          NUMA_NO_NODE, 0);
> > >               if (!pg)
> > >                       return step;
> > > -             pg_idx = (pg - base) / PAGE_SIZE;
> > > +             pg_idx = (unsigned int) (pg - base) / PAGE_SIZE;
> > >               if (first_pass) {
> > >                       /* Pages must be allocated sequentially */
> > >                       if (pg_idx != i)
> >
> > I think this patch is still good.
> > Compiling the current verifier_arena_large.c will be okay for llvm <= 18 and >= 20.
> > But llvm19 will have compilation failure as you mentioned in the above.
> >
> > So once bpf ci upgrades compiler to llvm19 we will see the above compilation failure.
> >
> > Please verifify it as well. If this is the case in your side, please submit a patch.
> 
> The merge window is about to open, so I pushed the fix myself.

thanks, also the [1] llvm change fixes the build for me

jirka

