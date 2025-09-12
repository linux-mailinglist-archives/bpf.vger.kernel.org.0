Return-Path: <bpf+bounces-68247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C229B55583
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD45A68EA
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CE1F8BD6;
	Fri, 12 Sep 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNqRxzX8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894CBA45
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698470; cv=none; b=Ex3u3PsOZdwZfw1EX3cSQ09wYNicUaAzB2CWX/sq06UDZjQkwvmMJLJRwYg5Ay9tl+T2kBCI1HuF6lFeWGOGSqEYlS42FvjsbvVPFRAvBGDbhzrDE2hW6MI0pDJO0onZxsKP+bFNEGF7eJjUyjm8P5q9bse4ppYWP2xVaoJCIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698470; c=relaxed/simple;
	bh=oIHIrss8Cf/fKev3+2zhYWHUF2w908OBQ0WxAP2UMu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/uS3CJsP7VZf+OZ0CBBQMZv0hKTeZwDfaoS6eO9L+M9T4k4c3gxCH1YH3WGMhbjfBKc8lRaRgA4KolBOGANob6AHXtrynmZz8B3DXNOyCKFMZQI+ACOcRTYf8YSgePLIVLR3I3jQ2v8QU0FNt8JAr1+wABPS0IjYS/y+ctPBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNqRxzX8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e07ffffb87so1235170f8f.2
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757698467; x=1758303267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5LHAOD3RsM7IX6ZQaWQlGO8B8wFFk4TliEC/qZmawU=;
        b=jNqRxzX8B5ozVtDhrOVgEMngGtsw11GMgFGgRKMzHWdqiUekrnmB+JNKhv5Ve1C1zG
         pOoyyFvocQyPqGCHLM0VIUxGjQRC2leVKDXWg8Ddso5vw0IMRksUdIbfBtRw+BEVXK0s
         psQ4LlROycqABQdMWrkQH7luYYIUKdwzXp/fbKOnSbH2cJMksPOVsgWSgLrpYr0v5X03
         FxeBTk+0Ks1S1Y6jJISozFc3yJHoHB/3lxg6kGnIqE7P50nvXF6B1c8GD2dBMEgbTf97
         oRuddtAAZKPoNtp+1WgiegjCXO7RDqvYnzwJ7DPssIMHXwujBT6ANkRrIkS4RojNCXp0
         j7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757698467; x=1758303267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5LHAOD3RsM7IX6ZQaWQlGO8B8wFFk4TliEC/qZmawU=;
        b=Cj718wdwi3wCOsVzzeyForpr/fGwa5NMKncOsPzUmGMXnYAtluh0DKWJywKT5ZUhJC
         nNf/pXjTbCTROYc4T9tmohB+8pmRMehApzGtlDXIX3asIbN3qP+Esz9QH6EDaKWuivkM
         rafSTfY+mJH7qhw8Azmi+RcG1fQ7G73o4O8Dw3fwa5C7rI/WRPfpAcYp/DReSbGQLYKJ
         Yj/ffhTkg7x0vsmBGHdt8fakbIrVLv0WMF+gbDlbrJoD3fQnQuWc5aHs5t/bbxZc8PVX
         ETxHKaW5zs6gXAbIhXJs+pOvePv9D50M5NrbLpUiuovvh7AgC+WdI9WKsezeolYw7uo2
         iclg==
X-Forwarded-Encrypted: i=1; AJvYcCW2UOLfrkOP7tSNNlBVfmO86XQQenG5kvTH/95qbxT50o+h1RSgMDmjtJA23HX/SXwGutI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KHXczO4atxVXY6rI8B59CE5N2qkn7qSVacg5UvxqVWH+M3L3
	xnGzYCVFfYscCee2bP+B3MJDZlqzpXB/FcShBoN0UhXZAqS4MmDCX3qVzPNKtzDAXhF7mfjNpb1
	OUlZCQ6SPxGpRcSDpvmF1twUP6qcnHko=
X-Gm-Gg: ASbGncvGZlHRQl9CnzL8g69VSyKhAxOjiBbY9CXuoa/RlBIs3bFscTulZs0FP3M9CeC
	52REGMcqxO6vGpTvJir1jXVTJ0/XMBiELZldFRyRoulPd02dcFa36yn/0ApfPvdTxtJ5j4K97hh
	ho6TGhE8AB9k6E3y9ZGoGcX4keaQ1TVHWVXDGFzjJvMxHpTBrSc8ciTSu0G+Ch3ctoX670gC8uz
	aUQgDK4+yoPLMyOW1dTPmC6HujoqOXpZmlAUEi2OJ/wokY=
X-Google-Smtp-Source: AGHT+IF84u9tsLSiw4lDvT5XmwWtoH0L/3zRkVWz/Q7BbdJ5SQIMqXyHfKSwJKnSQJcmnQtbE+lOWa60Ml7eykZbfmc=
X-Received: by 2002:a05:6000:2510:b0:3e7:4277:ddc2 with SMTP id
 ffacd0b85a97d-3e76579abb9mr3853126f8f.10.1757698466762; Fri, 12 Sep 2025
 10:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-3-alexei.starovoitov@gmail.com> <2kaahuvnmke2bj27cu4tu3sr5ezeohra56btxj2iu4ijof5dim@thdwhzjjqzgd>
 <aMRVNqH47mdkl5Ke@casper.infradead.org>
In-Reply-To: <aMRVNqH47mdkl5Ke@casper.infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 10:34:15 -0700
X-Gm-Features: AS18NWDOSsJ18D-9VlumoGDeKjZauJ0F3-n9lYvWRCc26bWu4h9-Bjo2I0KS2Vg
Message-ID: <CAADnVQJbx0Wf4xrAEfQyZhhpC13zJH6NqdFjYQ+StQzzi+Y=Nw@mail.gmail.com>
Subject: Re: [PATCH slab v5 2/6] mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
To: Matthew Wilcox <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:15=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Sep 12, 2025 at 10:11:26AM -0700, Shakeel Butt wrote:
> > On Mon, Sep 08, 2025 at 06:00:03PM -0700, Alexei Starovoitov wrote:
> > [...]
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index d1d037f97c5f..30ccff0283fd 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -7480,6 +7480,7 @@ static bool __free_unaccepted(struct page *page=
)
> > >
> > >  /**
> > >   * alloc_pages_nolock - opportunistic reentrant allocation from any =
context
> > > + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
> >
> > If only __GFP_ACCOUNT is allowed then why not use a 'bool account' in t=
he
> > parameter and add __GFP_ACCOUNT if account is true?
>
> It's clearer in the callers to call alloc_pages_nolock(__GFP_ACCOUNT)
> than it is to call alloc_pages_nolock(true).
>
> I can immediately tell what the first one does.  I have no idea what
> the polarity of 'true' might be (does it mean accounted or unaccounted?)
> Is it rlated to accounting, GFP_COMP, highmem, whether it's OK to access
> atomic reserves ... or literally anything else that you might want to
> select when allocating memory.
>
> This use of unadorned booleans is an antipattern.  Nobody should be
> advocating for such things.

+1.
We strongly discourage bool in arguments in any function.
It makes callsites unreadable.

We learned it the hard way though :(
Some of the verifier code became a mess like:
        err =3D check_load_mem(env, insn, true, false, false, "atomic_load"=
);

it's on our todo to clean this up.

