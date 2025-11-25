Return-Path: <bpf+bounces-75487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF277C867FB
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA54B351D97
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4D32E123;
	Tue, 25 Nov 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="XWTIDnSr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA932D0FE
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094237; cv=none; b=XLw+yNUT0jkOv2xnIZgxshbYHUQbO4IfZB71z/ENsUAM3qNhjrsoZvQcpN61MeyucTQmUoxRgd8gkFh7KsAJX6KtA3X1/OnBhBjptseNMEnrtjKjGm9xgYEY73JjwTIrYFAx/AtKYa2BEfis2LhiMwdLAHJPT3q2BWmGGTUuR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094237; c=relaxed/simple;
	bh=ysTc2eDRKC1yaYlCntECXBP0Mr0bFCOoYm1AllRC9WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE7ugZf4ib6FxJHlIPq7Hd2MNNO3U9y4OZeX94jOm2C1xjhNObMOPjTP49+HOdvcIAdHuojLamernRPFMBzwPvLU0UALXX/NHt7RrQYzqAI/jZ6uygedMK+TrYyUQjxm4G3VWrP/Ifc/mDX2Pwl+Ckr/ULGSbbSTuFokADYLmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=XWTIDnSr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d6c0fe27so6157845ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1764094235; x=1764699035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Umec4MYCn7UWFTu95kobtomRxgANDBIZB5gZ37QVB98=;
        b=XWTIDnSrc9U5sBdvmmh6ehi8KkobtGGOTIds7XppVRtHqZQyd/NQ5rZh5S7TaXs/vG
         kQ4FELEbkHqzKSD2HU4a9K8C1Wk5WyP6yJZ13tWtSA9w6+A1vb2fA16oh2uCO5KLNCQg
         E/8Q/La6AOYPJ5t0rNY/p3ngGm1W0qZnzoEbSJf8WDuMi4HEW3NKxz8ZwHT7ykGR5Mfk
         42eJbpu0D1w7YeiBDimwp2f798gUlYqz/SE/hyhibdwRHPPg5GrMZlydteAFxgC2g3Qw
         d0gAKVKZ2ShZUSNJVtYpBWq9hRI19LTXqThxbtbHQ747PStxtLKgIAfdwSvYci4LP3g/
         ATyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094235; x=1764699035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umec4MYCn7UWFTu95kobtomRxgANDBIZB5gZ37QVB98=;
        b=jkOPwjAu9OpiZhL+yrcWwb4o3OGDIxug/MfVahm88ZstGrAjsHf1euwL0UroBApo/r
         N2W3bfx9TSiRz7ygrChbTOhZ+Ilv00Ax7aJQ3GDMeR/FcCqGQRhKmL53BlW8YdzSM0hg
         +AVFrymsDJXDoyXVUZuzzDIVOasLSMcwQsNm+RdvwPo6ZWBFZhU+MaZ3eZK8oTnK2iCe
         qbBg85MDM6I3sG2fzgdxyujwjp0JZvXWgSsQ9fFj8u/deBog9f9p4CFvUjrmuRNcnIdt
         69HGEuWutfjTPSn6TUK2YkohcG91KjEuhX9gEXqEpN+ERMV3j6P0teT94IVjJO/Go56P
         l8+g==
X-Gm-Message-State: AOJu0Ywzf0Ya0+qs3kqqaLYNbg1HqVUYC9hXaChwKI6I4JJSCa8vfEXJ
	xqvifXCff6WpaPFjcosTwbISYsyEw2HCu+hBbZU8tDE4eNjKqSaoqM4oRVZjPxyKu3o=
X-Gm-Gg: ASbGncvNxvIG9FkOqkZ3AGn9RR6Y0/O1f947sL2KlAqdUhk2wR8xjhfX5p6f6dJnIMk
	BrengrlTb+qXScfn2GC3F4X0tKrlgH9zSVkayJE4Cp73MBWwvkckM4BMoq93dfF2dMFz9jfARTq
	cyKAcxyuwM0vVnxwW6XFxEIosIwEtytL0jdpm/Tow/3WpLXRJ5HOWInC6OHMHzBbRMXkfE1mufI
	GRMTW9scCRAkXbH3F4xVgBsOFY9Z/bBURhfdo9lRYE1QQ5JwduepPARx900b4SpD/hQ67RuCvO8
	YPCES+HNaYs4ZZPQbkgbAQnF0IeZPNOH30D41SqNOT0gQQ7svmw+r2bJRMtKCjL80HJX+s+3GJ1
	xPxI/O2QIW2cQgfPQ3ngAzTYhk5+aM/Abf6NG7MH4y50sBkfphtFF2hom/A==
X-Google-Smtp-Source: AGHT+IGMaalvfN9l0DOr2S33Cgy8CQf0jRx582FHWei67nCNYyq/uZZfeYcD3+INNTene/3kJVhYsA==
X-Received: by 2002:a17:903:19f0:b0:297:f3a7:9305 with SMTP id d9443c01a7336-29b6bf6c143mr103444455ad.6.1764094235141;
        Tue, 25 Nov 2025 10:10:35 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:7dee:b1a1:fd3f:6b76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174ba7dsm18606671b3a.64.2025.11.25.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:10:34 -0800 (PST)
Date: Tue, 25 Nov 2025 10:10:32 -0800
From: Jordan Rife <jordan@jrife.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Implement BPF_LINK_UPDATE for
 tracing links
Message-ID: <gjfaxdq3qyz2q4ajgigwmqthhkoeffuym7sy4z764m4bvmfqdt@4eggpiyxff2i>
References: <20251118005305.27058-1-jordan@jrife.io>
 <CAADnVQJ-9JubH5r4oSwQneu3o6U6s8Fa0cjCsi=+6-R+9nkzHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ-9JubH5r4oSwQneu3o6U6s8Fa0cjCsi=+6-R+9nkzHw@mail.gmail.com>

On Fri, Nov 21, 2025 at 05:43:28PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 17, 2025 at 4:53 PM Jordan Rife <jordan@jrife.io> wrote:
> >
> > Implement update_prog for bpf_tracing_link_lops to enable
> > BPF_LINK_UPDATE for fentry, fexit, fmod_ret, freplace, etc. links.
> >
> > My initial motivation for this was to enable a use case where one
> > process creates and owns links pointing to "hooks" within a tc, xdp, ...
> > attachment and an external "plugin" loads freplace programs and updates
> > links to these hooks. Aside from that though, it seemed like it could
> > be useful to be able to atomically swap out the program associated with
> > an freplace/fentry/fexit/fmod_ret link more generally.
> 
> I don't think we should burden the kernel with link_update for fentry/fexit.
> bpf trampoline is already complex enough. I don't feel that
> additional complexity is justified.

OK. I could drop fentry/fexit from the series to avoid complexity with
the associated arch-specific stuff.

Jordan

