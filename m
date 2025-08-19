Return-Path: <bpf+bounces-66029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C113B2CCD9
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D70580D2B
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095F30F544;
	Tue, 19 Aug 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dqS8uZ80"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DF28C01E;
	Tue, 19 Aug 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631079; cv=none; b=lVLvjCb+ovj7dfOr878+F/Z5uohDBFwBBtY/sk2pHsxHErWkaeMFvDoaXpObzB8DLGXNw9QKTLxuHEtaeNM+9l/yCtPioYVTCpVRW9s2bEiXAo3VonPMqUPATecFPlFu5PWBEzvKCLZewtfTajuwqoQWWhviqV9aH4jf721WONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631079; c=relaxed/simple;
	bh=8VUS3MNjijYEEqUa9MHAfh0tD+Axljmg+OjHaNQW6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTPJohUoLlQAcqQ7JguHH1ZN0irCskrhjypJ88+6Guy56otyZDPA1kVpMleL23ywZJhqF5XOrQ5+IE0fRFb+uBDWEFOHC66QWcVmRbN4guiCmY30DrVbWKzlO1oIluKAhgZSdJvpsttqXqI0m+Kg1nNCuHkPB8LV8LG5eCBUSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dqS8uZ80; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8VUS3MNjijYEEqUa9MHAfh0tD+Axljmg+OjHaNQW6g8=; b=dqS8uZ80Rk5tXFFCRB5CZq50gx
	lv7ZulxCqtHX0Ya6L+PdbUsphJ+np2C37VfzeRXt0AZ41r0c/x+UcWCE7ZTFP/f1g9rPg4fuZTmA0
	SFLS/yaav4eEd3FhEqsqCiejUQSsLSgR0U5aDcW4nKQh5/zBf4NWW3Fxj3K8LmstHqzYDcB/x/5wz
	o8BmyHwAPiyEICvV1jvXExtVLevQm96UhMxtIyIb01sXmSzNGw9Cpo3nA7cE7CpbYCC1ykhP+ptPP
	wjnFVmKLOm9VkvN9mqnygfxT+Jukw0L56xuDEaEYPagGRJosc3IcTf0PcLzU3SeNk9E6zANh/SaiB
	FqZC5Pww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoRq5-000000005WP-0Ziq;
	Tue, 19 Aug 2025 19:17:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1577F30036F; Tue, 19 Aug 2025 21:17:44 +0200 (CEST)
Date: Tue, 19 Aug 2025 21:17:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250819191744.GN3289052@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250725191318.554f2f3afe27584e03a0eaa2@kernel.org>
 <aIftAJg1hZGYp4NF@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIftAJg1hZGYp4NF@krava>

On Mon, Jul 28, 2025 at 11:34:56PM +0200, Jiri Olsa wrote:

> Peter, do you have more comments?

I'm not really a fan of this syscall is faster than exception stuff. Yes
it is for current hardware, but I suspect much of this will be a
maintenance burden 'soon'.

Anyway, I'll queue the patches tomorrow. I think the shadow stack thing
wants fixing though. The rest we can prod at whenever.

