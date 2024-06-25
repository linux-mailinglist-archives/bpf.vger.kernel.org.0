Return-Path: <bpf+bounces-33026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297B916007
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8D5B22224
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B70146A7D;
	Tue, 25 Jun 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BXgsGVKv"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD061FD5;
	Tue, 25 Jun 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300623; cv=none; b=C98uLVx5q2M7L9WCceqvDruim+lbjMftUkBBUtkTqM2yIMtzSsHnAPWuPA0k9zTyl2WTBEOws5rJIGv2f8G0aUs0R2e6DzZmJZqrOtmvue168uuflG/z5durcwJdy4iRM/YF/15kmc3xa6x81s/j9twV0cD5vkuls6XujWa9Rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300623; c=relaxed/simple;
	bh=yB5Svsp9mNzKIuZnzXqjiK08dhoftGN+4t+vx+2N1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7zrue2G6fNW5fnMOoc42wQe1owAOIqlAEssqLHtJ8NThMAUt3tVBP2MFYiKVuKQVgUycuQ9bA7KcSUPDq0q+XI0QuN/5MXwn5Rdv34SH7HrihMQc1jtMcSkV7PxUK9tcuNhuj9wuj/5zhToJoy/lkEF6UyaGS1InnmsKK6i71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BXgsGVKv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yB5Svsp9mNzKIuZnzXqjiK08dhoftGN+4t+vx+2N1vU=; b=BXgsGVKv1z6yJk6YgNCi2gSK8k
	RHBxRV1FJbPzL3TgsWI85R2+Cwh5zy+tZWXlstECVPG6+aBkqTsIzZv1ixJ3DUKtoElLKDODDe/Ag
	rs4JL43j78IG9vxVDMMJEdzuISeBfIJCuAwHzFqhgG5DiVGTF9RLo2i4j9HpAgJFwl66os2sGt3vf
	0h4iqYU6IgAnqvQM6XEwkgLXpvM7CqrJZiK843AkkaO5UzSrlh+fAh6I8SAsAkjEaHkDTU33mpk+m
	+S8etuRncziA6iEzbprfr5zn3KD1KWPSd2owROhf3QUJGn2ZIeRU3busQcqaWlPs/PnAspAOLLDsC
	7YKnYROg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM0cl-00000008Mlp-1BYZ;
	Tue, 25 Jun 2024 07:29:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65D53300754; Tue, 25 Jun 2024 09:29:54 +0200 (CEST)
Date: Tue, 25 Jun 2024 09:29:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 04/39] sched: Add sched_class->reweight_task()
Message-ID: <20240625072954.GQ31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
 <20240624102331.GI31592@noisy.programming.kicks-ass.net>
 <ZnoIRnCZaN_oHQ6N@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnoIRnCZaN_oHQ6N@slm.duckdns.org>

On Mon, Jun 24, 2024 at 01:59:02PM -1000, Tejun Heo wrote:

> Were you trying to say that if the idle policy were to implement
> ->reweight_task(), it wouldn't be called?

This. IDLE really is FAIR but with a really small weight.

