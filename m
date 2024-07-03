Return-Path: <bpf+bounces-33836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF9926BAD
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742CFB212F6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12D193097;
	Wed,  3 Jul 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwmglolh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B651747F;
	Wed,  3 Jul 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046464; cv=none; b=anQjKRQ06VG8+XqyacAoqz/vm1uoEAo9NNRpHbGQ7WI3luwOQBzA4RCuBxLgG5H7zKS4aOADy5HefBqhv7t+CqLuV55gt9M+HzTJ9VBogaAdpd8kKzhyKsODZWg8rfMOJBydDSTUmkdLrboK9RiJPjkVXGc88h0uLLGVWzu0QYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046464; c=relaxed/simple;
	bh=c4HcoAL5OGlqvu44M2cW9EqVDsE9T7akesnEeOLwWmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJUTi9Csw0HnNe0yBM/CSB944TwmJId/oJUCN5tA0yLy+euTjJCMgQQLxA7loJOkUMOsdlbQmP2QNFpmfj6d2/ypbp+LQR8hLBryjVHNJqA2C6/9vUJqMquDMZ6EZJ6x3pnVDfx4CtDzYlXBJdwew7b8HNTvWYf6oyORHC6dBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwmglolh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84136C2BD10;
	Wed,  3 Jul 2024 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720046464;
	bh=c4HcoAL5OGlqvu44M2cW9EqVDsE9T7akesnEeOLwWmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwmglolhVpLNfs0ZBftSKiiOYy+9lkPvyaGMwiLqTLTXfHyXWdU0MJWDS4L4Pr4mE
	 jua7AgBjYqSnPW1hKfrqRXyQF7gp44u6zWZ/sTV13ECTJiqbe5aBJpuUtuLe43t+tI
	 j0ZKy4bCpocob3tFDKlA9mN0fevvSNjSuX+hkBfwqG2Q+Xud1D6qQvTTbi1/CafxiD
	 Ubb0C6PpOBucKKMIQ+bjrmKZuLeyHgxu5j4C+tluDyH7AIue5mxQrtU4z/NCBdnq8j
	 +4W1KZd7IMfGSawxT1LiA7S9+ZEdNdwfTL0tU/P2qsdT11q6f9ltyW1lrheeFVsKQo
	 VBbqssdmOlqEQ==
Date: Wed, 3 Jul 2024 15:41:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240703224101.36r32g7j2atskidg@treble>
References: <20240702171858.187562-1-andrii@kernel.org>
 <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble>
 <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
 <20240703011153.jfg6jakxaiedyrom@treble>
 <CAEf4BzbzsKLtzPUOhby0ZOM3FskE0q4bYx-o5bB4P=dVBVPSNw@mail.gmail.com>
 <20240703061119.iamshulwf3qzsdu3@treble>
 <CAEf4Bza6YdQ5HCcuPozOwVx75UrcyZL_1DGnYrJ=2pz=DxJpPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bza6YdQ5HCcuPozOwVx75UrcyZL_1DGnYrJ=2pz=DxJpPQ@mail.gmail.com>

On Wed, Jul 03, 2024 at 01:23:39PM -0700, Andrii Nakryiko wrote:
> > >  [0] https://docs.google.com/presentation/d/1k10-HtK7pP5CMMa86dDCdLW55fHOut4co3Zs5akk0t4
> >
> > I don't seem to have permission to open it.
> >
> 
> Argh, sorry, it's under my corporate account which doesn't allow
> others to view it. Try this, I "published" it, let me know if that
> still doesn't work:
> 
>   [0] https://docs.google.com/presentation/d/e/2PACX-1vRgL3UPbkrznwtNPKn-sSjvan7tFeMqOrIyZAFSSEPYiWG20JGSP80jBmZqGwqMuBGVmv9vyLU4KRTx/pub

The new link doesn't work either :-)

> > > Few questions, while we are at it. Does it mean that
> > > perf_callchain_user() will support working from sleepable context and
> > > will wait for data to be paged in? Is anyone already working on this?
> > > Any pointers?
> >
> > I had a prototype here:
> >
> >   https://lkml.kernel.org/lkml/cover.1699487758.git.jpoimboe@kernel.org
> >
> > Hopefully I can get started on v2 soon.
> 
> Ok, so you are going to work on this. Please cc me on future revisions
> then. Thanks!

Will do!

-- 
Josh

