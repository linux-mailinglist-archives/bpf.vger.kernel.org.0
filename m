Return-Path: <bpf+bounces-33730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960E925381
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 08:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A00B1C2185C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 06:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88D7CF1F;
	Wed,  3 Jul 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4htRq5Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D891C1C69A;
	Wed,  3 Jul 2024 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987082; cv=none; b=SCx/wGa512CgEmZZaqyU+ZPrkmaDwiikllyiFiAyH2YGsMhibwlrmZ6wkbl76Ei5t+QN4WIeNlyHayAXQ9pVKFSa/GO05xBJ6VJc9Zvl2xfm3Q87jTnltnfXXQDYbGSOMaoLR4pr0BYzjyVOAjy8GQ/QzGo8QyhnIO+f8jbJaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987082; c=relaxed/simple;
	bh=dkrl4qdg1v7Cw1wOdAvDDj6CD1YkoPIloW0UtKmbjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZqGqPdYN1knf5gQZgZfBb/yvgk8Ftv50jhwhtrAXUu+Z0k0rD1meRRMI+UmEAKXKXJBY6dWDfiPFw6hcPgNAVtCaQqTb4aeNhj24a6tGuc1KVKuPKgD6y4x0faeYZBs47cCMnasXa2XuXGRymyzebUZeMqV799Gfh75FXASK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4htRq5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B42C32781;
	Wed,  3 Jul 2024 06:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719987081;
	bh=dkrl4qdg1v7Cw1wOdAvDDj6CD1YkoPIloW0UtKmbjX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4htRq5YxeO43gwT/hyUFvB/tlmMH1ZoTto/N3dKJfBB61txf6cRt5GjbsZTVLWjs
	 iMd0b9JLHM8/DGliEUPKVBVGps3qQJ4tjlTod8ZW/iWfG5riX3qvZy+437BLovvF30
	 DGq11iy5J+1d/Q3LMds2EFb7crocRxclaWF5xQspNi7RH6ecGU22SZBN5mXb/z40tc
	 4JQLWjzoOA6RsPjnjd4qGY9/pEtMJYeb4aJ5U6D3bT4duDhaGweaxpozgzK8STH0a5
	 URbfNUWzAy5Usr+um9s5/HH/Zu5zt0oz88rkjMq7XYR4D8HUvKw1HCriimNoQOTRgo
	 CNLy5pjNIKrYg==
Date: Tue, 2 Jul 2024 23:11:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240703061119.iamshulwf3qzsdu3@treble>
References: <20240702171858.187562-1-andrii@kernel.org>
 <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble>
 <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
 <20240703011153.jfg6jakxaiedyrom@treble>
 <CAEf4BzbzsKLtzPUOhby0ZOM3FskE0q4bYx-o5bB4P=dVBVPSNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbzsKLtzPUOhby0ZOM3FskE0q4bYx-o5bB4P=dVBVPSNw@mail.gmail.com>

On Tue, Jul 02, 2024 at 08:35:08PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 2, 2024 at 6:11 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > On Tue, Jul 02, 2024 at 05:06:14PM -0700, Andrii Nakryiko wrote:
> > > In general, even with false positives, I think it's overwhelmingly
> > > better to get correct entry stack trace 99.9% of the time, and in the
> > > rest 0.01% cases it's fine having one extra bogus entry (but the rest
> > > should still be correct), which should be easy for humans to recognize
> > > and filter out, if necessary.
> >
> > Agreed, this is a definite improvement overall.
> 
> Cool, I'll incorporate that into v3 and send it soon.
> 
> >
> > BTW, soon there will be support for sframes instead of frame pointers,
> > at which point these checks should only be done for the frame pointer
> > case.
> 
> Nice, this is one of the reasons I've been thinking about asynchronous
> stack trace capture in BPF (see [0] from recent LSF/MM).
>  [0] https://docs.google.com/presentation/d/1k10-HtK7pP5CMMa86dDCdLW55fHOut4co3Zs5akk0t4

I don't seem to have permission to open it.

> Few questions, while we are at it. Does it mean that
> perf_callchain_user() will support working from sleepable context and
> will wait for data to be paged in? Is anyone already working on this?
> Any pointers?

I had a prototype here:

  https://lkml.kernel.org/lkml/cover.1699487758.git.jpoimboe@kernel.org

Hopefully I can get started on v2 soon.

-- 
Josh

