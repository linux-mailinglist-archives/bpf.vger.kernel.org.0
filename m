Return-Path: <bpf+bounces-34197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2092B318
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B61A280E7A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFA154C02;
	Tue,  9 Jul 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iFPUshtp"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE641156661;
	Tue,  9 Jul 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515792; cv=none; b=Qj8J2d6VnRFM/1NVdUCsxqNB9cLnKl7AMGhXPFtUtLSt1y32uGQBSR2n0HC/YCVwV63IBY+YkqYIxawUq7fJJsSuhP96VAYiMOoXlCETpyWkZzF3p5lQzLcjk/JqxwpChfh0XwRe4WFZmg8zAYKdtz9boSnM8wgch0VOhKkMz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515792; c=relaxed/simple;
	bh=7FxawhzH0ATOU2njMMmD0ZbV6K7Wu4QG9eXgUH1Glis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPXYHdzmPFYPS536cIIQ4+J+VbaVyBOukljsQu1WNYx7yHhvH9DDRjqWUcmEYhYjPI0JuVcYIDSgbyqPKoE+M7fbZVX/elYOK2ZChRhgt2rUYsD6nlYmuzwrY3RiX0zj5e2x8ECAxxcFz5IBCb2KKs8gwC8uJ++siQu6JdStd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iFPUshtp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7FxawhzH0ATOU2njMMmD0ZbV6K7Wu4QG9eXgUH1Glis=; b=iFPUshtp8vJOZL+UeRIiVLCEsr
	8A6bS2uWbbynr/RJIkpVIi6MsilYWkajRxW9zLvopYHqBBdH9p8ZlDR2kAtUIpQIx1AET6rRpy3BD
	5PXdFLqGblNLAMUMin9pZJ05dlxtGw8+47U8D1PiXpDi1FMb6kZJSfKP4QL+bul/QFfcs5oL3bgRb
	esGsGr/hOiNkbvs5QUjgxZXy3wp8P5P3XnC5Y83PpQiZun8i0VkoK2a7P161Ah6jm8TbLnrOvr0km
	yr2a3z5EH1BrcAMhIPKqI/sPf9dRswUFCkGOfJFvhKDQW0VJaKmofYQCyNIbLMH/B6cmfE6IO5+Ss
	mTbPdtGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR6kb-00000000iLz-13Yv;
	Tue, 09 Jul 2024 09:03:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38D9D3006B7; Tue,  9 Jul 2024 11:03:04 +0200 (CEST)
Date: Tue, 9 Jul 2024 11:03:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240709090304.GG27299@noisy.programming.kicks-ass.net>
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

> Ramping this up to 16 threads shows that mmap_rwsem is getting more
> costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
> CPU. Is this expected? (I'm not familiar with the implementation
> details)

SRCU getting more expensive is a bit unexpected, it's just a per-cpu
inc/dec and a full barrier.

> P.S. Would you be able to rebase your patches on top of latest
> probes/for-next, which include Jiri's sys_uretprobe changes. Right now
> uretprobe benchmarks are quite unrepresentative because of that.

What branch is that? kernel/events/ stuff usually goes through tip, no?

