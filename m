Return-Path: <bpf+bounces-45022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A119D0090
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 20:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973B6B23BAD
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0F191F9E;
	Sat, 16 Nov 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9R0azRv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851F944F
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731783636; cv=none; b=ReGOlVJvzTekzExMl8cUQrFXthaeh6RMh7VTtpS4O5jqk+MxKwS+VitT5ZWY9zIFsc0kpHPQqgVBvFFnj5VXbOQapPDc8VhaFly0BHNvNqRf5uJec4G/RWwIkG0O05DUGoI5V7wYd6mzImJSLK+xGLto5SwUfq/g7DRksZxBM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731783636; c=relaxed/simple;
	bh=zgeh8YPTktwYW/lg696Ue9n4XFY6TJ8hNrNildU+ztg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJnqcvkQx5xVRiN6kG2tSJSHXI7+4gh2+Bz8pS/0dfJRw3fWV2z3GH6G8J4abbDrGsSrsYokHEYoChaP4JNc1iAaiGCGIC58IF2bUUKA4iAal5B7gyGRE4LxZmriabIVSPXbR4+5bFpwgpZd/eR/tyMdpkCgl3zkznzktzxBft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9R0azRv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3822b77da55so815575f8f.1
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731783633; x=1732388433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3EkcDMqx/Sdcmes2bj4AmOwAvj+8QlfAtOWrmJ4ZQw=;
        b=P9R0azRvmkS19iDcc7qkVsp8QAqGJvLHqDUCT7KkJM/eAXC21CgAuuZC0POw6t0SYS
         lScui3zlk138gdq21NIjCwq0DgXRfAs9MwP31iyUD4xl+biFC9ei8IwSdcby11m5+zzN
         5VEY3CQgmaSzVIKUOrYQUx4YPH5b4et0Z1/cgpkru0Gry9R4T09ZCcbdcJ/g2U8SfssW
         oDc3X5l37avVFZHuSlYDS/Szafbp6QEpflDCzVowjVax+GT1K7jpiNnCIkAcCvQsXdiy
         wld/EOw1r/wmAEi79s8Oky+2ihDoVxkvlLvQaF2Du0savEt3yTceCgk9uO12bu1M8NZV
         UPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731783633; x=1732388433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3EkcDMqx/Sdcmes2bj4AmOwAvj+8QlfAtOWrmJ4ZQw=;
        b=l/PnzxxJV3TNK0IxAPuOR/ohO9hs8kn4gWHsDyD3rWo0ci/KupcVDrxtagujOJTSWR
         KAyUVPmzGUZMaLKwAlqS5yJ5EIQ+9T+G3Q25T3By+DwqwEFwrKbM4aD7JIuHT3AnM/EC
         JWlvy2zJkr0UvD7GJX9tpqz1f8Qev6BEAH+G3adTu21wtuIWPjPPb/CcqHZxwx97NQuN
         OE2bvbdjc4boYacs3TGKHeQMWrwgMv2sJmz3mIRtfmuubMa6NDt6JYZ6MkHcsSIi8nl4
         FXvi7hKx7cepSzbHrAxZ5d8IpGjm98DXKm8NyOcZymLzGVSC6tP3BMwwgAUWhN6pcMBQ
         F+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCULinCJWqE2j4Z88YUxFZGhpxDrIt9iwLSD+av/P1SNn2VdOa+88PAOG91DL8QbQxCQcUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsWxzatiR4U7JILx8Jqnm+1Bx11dDQziiQQdupTu8oWGXpfoY
	1uWksDnc4rIpqG7qRuPvPMK47wertQiy86VNfkz9ubBF/TRmt/e7h0n8PN4kOaOE/fyo/e+hK7M
	dWDp2HmKSnFNCglH/Xylu30D0FvQ=
X-Google-Smtp-Source: AGHT+IFxGHZo01o5zWQ5+EDz+VTAYzfEjbom1H1HRb8dtalKpUIbrWvCKHWhbbbmV2JfnzKDmMu5cUkLp11RQByT7aI=
X-Received: by 2002:a5d:5f4b:0:b0:381:ed32:d604 with SMTP id
 ffacd0b85a97d-38224e71c43mr7374379f8f.10.1731783632730; Sat, 16 Nov 2024
 11:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
 <20241108025616.17625-3-alexei.starovoitov@gmail.com> <Zzc8pVMtTAkqUdvA@krava>
 <3c98dc9c-0014-49a1-8d7a-910f0992cccc@linux.dev>
In-Reply-To: <3c98dc9c-0014-49a1-8d7a-910f0992cccc@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 11:00:21 -0800
Message-ID: <CAADnVQ+Md9HYD=0UGRy0FCDjD7MYbEexy8y0y7X+nUqWfus9hQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for arena range
 tree algorithm
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	djwong@kernel.org, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:30=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
>
> On 11/15/24 4:20 AM, Jiri Olsa wrote:
> > On Thu, Nov 07, 2024 at 06:56:16PM -0800, Alexei Starovoitov wrote:
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Add a test that verifies specific behavior of arena range tree
> >> algorithm and just existing bif_alloc1 test due to use
> >> of global data in arena.
> >>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> ---
> >>   .../bpf/progs/verifier_arena_large.c          | 110 ++++++++++++++++=
+-
> >>   1 file changed, 108 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c =
b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> >> index 6065f862d964..8a9af79db884 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> >> @@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
> >>      if (!page1)
> >>              return 1;
> >>      *page1 =3D 1;
> >> -    page2 =3D bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_=
SIZE,
> >> +    page2 =3D bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_=
SIZE * 2,
> >>                                    1, NUMA_NO_NODE, 0);
> >>      if (!page2)
> >>              return 2;
> >>      *page2 =3D 2;
> >> -    no_page =3D bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
> >> +    no_page =3D bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAG=
E_SIZE,
> >>                                      1, NUMA_NO_NODE, 0);
> >>      if (no_page)
> >>              return 3;
> >> @@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
> >>   #endif
> >>      return 0;
> >>   }
> >> +
> >> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> >> +#define PAGE_CNT 100
> >> +__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
> >> +__u8 __arena *base;
> >> +
> >> +/*
> >> + * Check that arena's range_tree algorithm allocates pages sequential=
ly
> >> + * on the first pass and then fills in all gaps on the second pass.
> >> + */
> >> +__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first=
_pass,
> >> +            int max_idx, int step)
> >> +{
> >> +    __u8 __arena *pg;
> >> +    int i, pg_idx;
> >> +
> >> +    for (i =3D 0; i < page_cnt; i++) {
> >> +            pg =3D bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
> >> +                                       NUMA_NO_NODE, 0);
> >> +            if (!pg)
> >> +                    return step;
> >> +            pg_idx =3D (pg - base) / PAGE_SIZE;
> > hi,
> > I'm getting compile error below with clang 20.0.0:
> >
> >        CLNG-BPF [test_progs] verifier_arena_large.bpf.o
> >      progs/verifier_arena_large.c:90:24: error: unsupported signed divi=
sion, please convert to unsigned div/mod.
> >         90 |                 pg_idx =3D (pg - base) / PAGE_SIZE;
> >
> > should we just convert it to unsigned div like below?
> >
> > also I saw recent llvm change [1] that might help, I'll give it a try
>
> I am using latest clang 20 and compilation is successful due to the llvm =
change [1].
>
> >
> > jirka
> >
> >
> > [1] 38a8000f30aa [BPF] Use mul for certain div/mod operations (#110712)
> > ---
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b=
/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > index 8a9af79db884..e743d008697e 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > @@ -87,7 +87,7 @@ __noinline int alloc_pages(int page_cnt, int pages_at=
once, bool first_pass,
> >                                          NUMA_NO_NODE, 0);
> >               if (!pg)
> >                       return step;
> > -             pg_idx =3D (pg - base) / PAGE_SIZE;
> > +             pg_idx =3D (unsigned int) (pg - base) / PAGE_SIZE;
> >               if (first_pass) {
> >                       /* Pages must be allocated sequentially */
> >                       if (pg_idx !=3D i)
>
> I think this patch is still good.
> Compiling the current verifier_arena_large.c will be okay for llvm <=3D 1=
8 and >=3D 20.
> But llvm19 will have compilation failure as you mentioned in the above.
>
> So once bpf ci upgrades compiler to llvm19 we will see the above compilat=
ion failure.
>
> Please verifify it as well. If this is the case in your side, please subm=
it a patch.

The merge window is about to open, so I pushed the fix myself.

