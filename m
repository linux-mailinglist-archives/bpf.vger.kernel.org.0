Return-Path: <bpf+bounces-52910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABBAA4A460
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E003B5788
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CA146593;
	Fri, 28 Feb 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBb+8o1I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097F23CB
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775692; cv=none; b=CmMkrTmu0IznPgQLk386ihVQXwl+TEjsy8Qed3QMrW6/AyHytdY8Wmsq9H2z4WJg/Berk96aUrHfAG3RUMxPWxejhCr15iImpvQpBHDmjBV1/3C8w/GltTfiFr6BQ4BQXAyYhYQdH9l6pbQJP2Dwv6abKeAKUhWevViOKro8mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775692; c=relaxed/simple;
	bh=8lqgA1UDMEac0vJ39MticibOiAICALzBu8WKALXHp/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ9OTcQPfrL13IOgzzSGYl6+IQmv04PuKiZVGrV1P9DDDGL+mCXOd/15kMpCXKZrMCO6oYRJWj9kcmlY4Mf+Sx/VgoKMp+NgNIEqvOAAiYZtrGEfbF7ppcRkB9cEnVMZiK9Dhs0LXaJbAr4TtrCgt/ZxAUqJkzElucQP0YqaocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBb+8o1I; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so3772520a12.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740775689; x=1741380489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lqgA1UDMEac0vJ39MticibOiAICALzBu8WKALXHp/w=;
        b=XBb+8o1IVVWMn8Bybq8nDeDwL0KOaIN/dN3AjgYdox/bEYxQKy9jYRUjQkcQM8j8dy
         sJXTtQKx8iovq7AMRlXzVN6UCiniFWYQkv0FAUseYTLZMlu8goWz2gnxUI9yDBsDNBze
         rYJ4paZLCDj2nGETKCSxCM468wWgSLu5OLMXC/X7q7vxbWWv647sQBIN9NIdYZzshbcQ
         jRSQJy1U2Q46vN2eSsZnPBOniO+Lt1ntKqB0FjoBIiWfdKKCCHHxZwoJZGNXm4BaC/xy
         I/9KwFRiVfTLh3isBYuG0woODEtbrAEohtcSQraBbIkTsB3IxNzKo/T0b9vcnOYkbOpw
         D4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740775689; x=1741380489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lqgA1UDMEac0vJ39MticibOiAICALzBu8WKALXHp/w=;
        b=crgPAwv/2eT8RqjKewETVd1IpdLMYlKH5cB2RW7Q3O0FVDnS0Wfh7hKmlsr/8divII
         h2ZEd/fAaTIan+7AiD9HjY1xQXFh59rtK36birpErDtU+iBRiUAd4g3/juVI+LqX2NuI
         Pmxr8jOM5PGRAIics4pMVqf2uYRwO2sejJFzUVbtazqrbua88l/9FasbTU1jd/j+8zP5
         gpLlQdKc53q/sZ0BBxLca8pZf4+to+EK2xvjftHLepinwkVz8l34l2C6jMXCQkUyjZtL
         C4p2DEvTU0GC110Op8EgCK2KWZG+xRpr1kDxf+uSelfcca7lhT/1rMWbfvUvKH2fqCpY
         7e3Q==
X-Gm-Message-State: AOJu0YxewHIDOuEQ531yM80/C4ERRBDoR8ivLfga7H3AhMB33NmS5Cld
	SLpM6ZgPcIqA6Jx0U5/xb1y3+ENMR5Eqmvr+JaxS+ED6rCsAQGL3JuttlOjbnQnEe6oBz9jbSmO
	vH6CgvBR/sN/kb58sVV2a2xwsinI=
X-Gm-Gg: ASbGncvGqmCRmlPUCSPgPB1EUP6GmZo3wj5klFfCr2uir+E0Xln6PRexUr1h4tVLKwa
	rGSADtGQX8jhfSjPYsKwTbJaB9LymVuRxrRHF0CZzpxnZ4B4hhy68xsjerFC1hfHV/etnvXs60H
	U5X8FStWI/Ia5bvUqPzm7u62jtTDg=
X-Google-Smtp-Source: AGHT+IGpIZ+rJjXadc0/iZrhgVBzFODSXpr4/k9gA3gPWiDiFth9kO4G1qiqBJ51qbCKD1dBDn77s+jc0W/HaVGCOcc=
X-Received: by 2002:a05:6402:239a:b0:5e5:552:32b7 with SMTP id
 4fb4d7f45d1cf-5e505523a61mr2290591a12.16.1740775688427; Fri, 28 Feb 2025
 12:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228162858.1073529-1-memxor@gmail.com> <20250228162858.1073529-2-memxor@gmail.com>
 <be5c35ce48592380e4edfabac2866bfc4f822cac.camel@gmail.com>
In-Reply-To: <be5c35ce48592380e4edfabac2866bfc4f822cac.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 28 Feb 2025 21:47:31 +0100
X-Gm-Features: AQ5f1Jq9UN83IuoJXlW73dT7cI0ZO6_6K_mRsI7WlDG-kkEKSkzbkzkegZ3rYJM
Message-ID: <CAP01T75M-mA6w5rPr_gJ425ZRt0LTzFRvpsq5iAdV16O6hTOsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 21:42, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-02-28 at 08:28 -0800, Kumar Kartikeya Dwivedi wrote:
> > The verifier currently does not permit global subprog calls when a lock
> > is held, preemption is disabled, or when IRQs are disabled. This is
> > because we don't know whether the global subprog calls sleepable
> > functions or not.
> >
> > In case of locks, there's an additional reason: functions called by the
> > global subprog may hold additional locks etc. The verifier won't know
> > while verifying the global subprog whether it was called in context
> > where a spin lock is already held by the program.
> >
> > Perform summarization of the sleepable nature of a global subprog just
> > like changes_pkt_data and then allow calls to global subprogs for
> > non-sleepable ones from atomic context.
> >
> > While making this change, I noticed that RCU read sections had no
> > protection against sleepable global subprog calls, include it in the
> > checks and fix this while we're at it.
> >
> > Care needs to be taken to not allow global subprog calls when regular
> > bpf_spin_lock is held. When resilient spin locks is held, we want to
> > potentially have this check relaxed, but not for now.
> >
> > Tests are included in the next patch to handle all special conditions.
> >
> > Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> I think this change also has to deal with freplace for sleepable
> sub-programs, e.g. see verifier.c:bpf_check_attach_target(),
> part dealing with `tgt_changes_pkt_data`.
>
> Other than that the logic seems ok.

Ah, good catch. Let me fix that and add a test to check it.

>
> [...]
>

