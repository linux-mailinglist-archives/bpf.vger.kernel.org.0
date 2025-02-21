Return-Path: <bpf+bounces-52205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93AA3FD34
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 18:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE281883102
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335B24E4CC;
	Fri, 21 Feb 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge1OCO9l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC20E1F3BB1
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158201; cv=none; b=pbUCl4fzTrKvjeej0rmLCpd2qG/8RNSSGgW+bvdhzHSfzn729b03VgdhUGWNtrnjj+UdR/9Y3QfDDyvpyWYoVrC383U0lsTlDzWU4ES2OyQEaGxqnC9JOL0DWZ6A2S+xgU1dNzZd7FuYepf3pHuE+LaDnuIpPWavIDJg4upUopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158201; c=relaxed/simple;
	bh=67LVgzVb1kz2JUULydJdeEejIvIVvYCsoBHINDMWzCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnpINThdvGkIDAURb0q2hHdKIfmB8tcA1x3Oww5FllIUJzuOvoCrBdTAxYCB3FeH6lXqGGm9zaX1/DE+jJaaxF+gS1d58qzxLlWQz1IRFuUD5c6qgKxdTIsNZe31tYUf5VdjU5vVQiZgbqGPP991NsNUXZQd7yIsqMouq8AMd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge1OCO9l; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso4636755a91.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 09:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740158199; x=1740762999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWc/9TQbT0U2iJfZzJcCrCwKyvk5vbS6RGavSH1vGcA=;
        b=Ge1OCO9l6n2aKfPXYF8gko9IwIsdGgdxVZwXyDq4ZFI78b/s/ppSwV9HCfWhCeWX6j
         GNufO6UqFVq0fco0/POx0ba3eANeJqMh/mL8ztq0cBoR4G/gwMD61rAD3CPg/x7DdHKM
         Djq0zeVlfrAmD3w1An1A1WkLjkAZMdejskJyEScc3kpkxZkmBkbi238c7Oj/IN1jhqJQ
         DGnO7XL0baOc5OJdlXlBYutM05bDguqgtuIIWHx6QKUXjcH0nNdTGlfBBC2whD7ZZBxw
         zShb3ybnxar7HJKwHS7e3Bvmp9NkJ5TVCYK9eKvIwiN41p5+ruebJ/RMyp1XMeRCg9uw
         AMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158199; x=1740762999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWc/9TQbT0U2iJfZzJcCrCwKyvk5vbS6RGavSH1vGcA=;
        b=bC5PnILukAu6pefGNqjX70/4tVP23cHNEaikGvpdJIaT6ON/qBIcBai/cISGh5nVuO
         bM7JnPj87uumH+mzypOBeLJE3sqV3Tbj7SF+ldpp38WDspdKkNhk2eccxx06kyVt1u6k
         dw/6jIJAlqBVe5Zu6IBEtROEl13f+L/VUFO/U9uz3WCF+b8BbN7pgvB2YNXwxQ5iLLjP
         CDARlfhZ5VJxIautKtXLju023w7mWTLxA3VUZvzHw8jDbhTp+tOqbLXR4MSdPzhNwpba
         59niCYTSFmTWjTQ2Zww0UVQVmzMqKeRHochSb3oD3SYk+n+T9NQ53SOhXh4YkCWRsMw8
         4DQA==
X-Forwarded-Encrypted: i=1; AJvYcCVr4fB3+Ltn18ZOq/mdymET6kXpGaKioyQ8FrXedTjKnrrCEXRqFFmNnen4N+lbk8CVrMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb961JdRuApYEiy5mLmDnpgDRZpI5hcJejazyC7jdqgdvx+8NI
	gGp3vKeY/wjcUJqsg1TNsdStGaFtgq7rQC4eu/T4guNbaHE6M6zeIWKOd9CC5h1+SHNgUH+ASIU
	eEkTaQkEFPOX0ULCQAJus7npwOUuFIw==
X-Gm-Gg: ASbGncuuVhpqH4a0bKpIRcf1Ng4YOcalxvTfZ+/rzW3Ges2jDEJp13DPdfdFN61bSF8
	IPD0VEvqqy+YSy+fi5Bj19TJx0oP30FOdTJZpcPqWWA3dFlrVjKNDKpmEoFQZxo8s5PS6b+h6cw
	kiwdZ1mw==
X-Google-Smtp-Source: AGHT+IEO5mKVC5eGBa2f0xf9DC+s6mvYZwcsp/x1sl+FAWLUwWiqYYPtqe0rIAm5nGkA3ckfGhTsw2XDU08hztRNsS4=
X-Received: by 2002:a17:90b:2792:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-2fce779bc14mr6057659a91.6.1740158198848; Fri, 21 Feb 2025
 09:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
 <20250218190027.135888-4-mykyta.yatsenko5@gmail.com> <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
 <9eaf9945-9a5c-4313-b449-cfa8144975e0@gmail.com>
In-Reply-To: <9eaf9945-9a5c-4313-b449-cfa8144975e0@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Feb 2025 09:16:26 -0800
X-Gm-Features: AWEUYZlH5FKQiUDkjZnvBj2WvIKRutYJJ_Wd5HVGBM4RF9dlCB5oaoNYr3BET_w
Message-ID: <CAEf4BzYDTKfa0MsOfQU-vk7tEMt3LNZYD=9+h4bxj1bEB6V=Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add tests for bpf_dynptr_copy
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:08=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 21/02/2025 00:52, Andrii Nakryiko wrote:
> > On Tue, Feb 18, 2025 at 11:01=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Add XDP setup type for dynptr tests, enabling testing for
> >> non-contiguous buffer.
> >> Add 2 tests:
> >>   - test_dynptr_copy - verify correctness for the fast (contiguous
> >>   buffer) code path.
> >>   - test_dynptr_copy_xdp - verifies code paths that handle
> >>   non-contiguous buffer.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
> >>   .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
> >>   .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++=
++
> >>   3 files changed, 110 insertions(+)
> >>

[...]

> >
> > BTW, more questions to networking folks (maybe Martin knows). Is there
> > a way to setup SKB or XDP packet with a non-linear region for testing?
> The setup I made in dynptr.c for XDP makes non-linear region.
> It looks like maximum linear mem size is 4k, so when going above that,
> it creates multiple frags in xdp_buff:
>
> ```
>
> char data[5000];
> ...
> .data_in =3D &data,
>
> ```
>
> I verified that in this test xdp_buff is non-linear, and all non-fast
> code paths of
> the bpf_dynptr_copy are tested.

Ah, awesome, great job!

>
> >
> >> +
> >> +       return XDP_DROP;
> >> +}
> >> --
> >> 2.48.1
> >>
> Thanks for findings, fixing them in v2.

