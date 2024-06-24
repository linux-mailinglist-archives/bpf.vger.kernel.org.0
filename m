Return-Path: <bpf+bounces-32898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EC914AF1
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D4D1C21F6A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2C13CFB6;
	Mon, 24 Jun 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kh80y12s"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC91E4A9;
	Mon, 24 Jun 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233201; cv=none; b=sJRMSog1MUDM2m3v4SN+lv7JAu7XW9wb7LxyZtr0UkCB/o82fcJjWtbcNy//oyf3lR9cGAfkHp3VW3nTdDyKDlirID9Dg7ShxBHqvaYSe0g0TekpmTQIh8zTZUAR2tPgwbfBjFHjv+KvdRoMJ/qmUGZv+N/sw3qoL/8uZa5txXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233201; c=relaxed/simple;
	bh=x/Rav4kxZkNpPcd3LV8acvhtCDwrh/yQ32I/Xpo03Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwJSCi+OD6lf3zTE+q+3QpOae+QyVuYAypW9fwGQvmsxuk7TGC2zlN9yMFb/8SL0vPGl6T1L9C79hjkR/hnCxFfglEj06uaI3dDiUOZiKqIIU8XdPOobdd3cqwGcRmlvyIyWeatwxcA9MPbcS8xOjmD408j6Gz0BSNJ0nY+GUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kh80y12s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cpFzClzAeAIEsTBtfWnHdCWGnwNHhoHvJL1XHMt4TcA=; b=Kh80y12sVLQLfaXoq16dd9rEl1
	8isr7b3njLeC8CR3tp73fnZR38VoAtJpmCLCc1k4TbdMOWZB5lmecIXP0zg1eQfR2FQ0I5K2yputL
	xzGuSknGG126HCDy6Gdwfmt4vomYyyJzt3tHkdiVQbMUUddl0fdCVdA7dZ40MNvFOyKqoQfhUvK4R
	mo0WomAXB67Enh4YQjuaCwOlSxhbZZlaUq8om3pJEmsB8tNHxbpKsO8PmmG+90z9GTLXO9bUR7m9b
	WkA+HGg4QsFmn3ZmGgNIVCEAF9kQFj2e6VNj74WwCkeD/R4YgiVZfnSdLPZkTvI4uHsAewvr3M1FZ
	h5kbUWrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLj5P-00000008FCR-00Sb;
	Mon, 24 Jun 2024 12:46:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E29C300754; Mon, 24 Jun 2024 14:46:18 +0200 (CEST)
Date: Mon, 24 Jun 2024 14:46:18 +0200
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
	kernel-team@meta.com, David Vernet <void@manifault.com>
Subject: Re: [PATCH 19/39] sched_ext: Print sched_ext info when dumping stack
Message-ID: <20240624124618.GO31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-20-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-20-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:54AM -1000, Tejun Heo wrote:

> +static long jiffies_delta_msecs(unsigned long at, unsigned long now)
> +{
> +	if (time_after(at, now))
> +		return jiffies_to_msecs(at - now);
> +	else
> +		return -(long)jiffies_to_msecs(now - at);
> +}

You have this weird superfluous else:

	if ()
		return foo;
	else
		return bar;

pattern in multiple patches, please change that to:

	if ()
		return foo;
	return bar;

Throughout the series.

Also, if we consider 2s complement, does the above actually make sense?

