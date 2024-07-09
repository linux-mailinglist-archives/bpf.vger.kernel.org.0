Return-Path: <bpf+bounces-34196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0392B2E9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39B51F21DB3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680F14534C;
	Tue,  9 Jul 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DsT8yjlc"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F742058;
	Tue,  9 Jul 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515723; cv=none; b=rLCz653/c1T6ohaI57VmjwqxFvNbMQi/I+YFVe8GDYoFSxx9kiTMcHukMOEzT80UOOzznGYJpFyrhNN3fOMnb4S3A7+T6G/MV5cjcyVW3EI0iA9HK9Xerewmmib3j40TwCtvYMjURGWGDrZZx80e/kJ4RQCMiSTb+TTV3radiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515723; c=relaxed/simple;
	bh=YUVkkZqGlK+Y5PDWQFqdu2ClmQbzaAOFnNpXa+BOT7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDF97mSqc9vFEkadwV7l+xtfzGkFplp3As1IYY5OTRb9IxcoWPNW98ox3TMsTIe2RPlyXLT9iTm77nqcdHcIVuZxAMxa0CvhbgTFv3OfmluA6gEmZO/OKwjuJ+7uhK4Itgcs+0tCmUfG0UTEu5MN6bvFM8RupmWCuFnR6Hpx9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DsT8yjlc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EDag5mC9T7H5KTDdf5Q/nQS2lcMfcQcQX7+NBW3rwMo=; b=DsT8yjlcoerxMGrDEgfYBlMwo5
	sWYpzDWxuGK5PzjedsfEYwUtRsBg7U4loZOhuJmG82R3ltT4AS8ddVX5V5c9L/a5asxMPvILt/EHG
	1Y2XLW9ARROTfifgYt6cxbmjOF+ovDC9EOz1moBdhOR8IaNrNfduB5o6QaJMKJPwWZUKUu5vXy+40
	weQRZXgrE1YWQKModngMSxBYIqZvy+Q927Sz1gK4Sxmr11njOaVHA3so9WslTXCjg+QNUECf6aIGZ
	TphiOv4x2fwV/Rr3pJJm3oqOZGbAeO0sssfa/+jfYCkyzHKxVODA0ZuMfr6SOEwXF2JqWSK4ejUmD
	tPcLtD6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR6jS-00000007hS4-3rJL;
	Tue, 09 Jul 2024 09:01:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BAD7E3006B7; Tue,  9 Jul 2024 11:01:53 +0200 (CEST)
Date: Tue, 9 Jul 2024 11:01:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>,
	willy@infradead.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240709090153.GF27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>

On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:

> Quick profiling for the 8-threaded benchmark shows that we spend >20%
> in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
> that's what would prevent uprobes from scaling linearly. If you have
> some good ideas on how to get rid of that, I think it would be
> extremely beneficial. 

That's find_vma() and friends. I started RCU-ifying that a *long* time
ago when I started the speculative page fault patches. I sorta lost
track of that effort, Willy where are we with that?

Specifically, how feasible would it be to get a simple RCU based
find_vma() version sorted these days?

