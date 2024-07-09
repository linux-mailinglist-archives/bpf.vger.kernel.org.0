Return-Path: <bpf+bounces-34224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D0692B4F9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CCD1C229E2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A1155CB3;
	Tue,  9 Jul 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hqoIfGI4"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D913D89D;
	Tue,  9 Jul 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520206; cv=none; b=bKJkUWC7yeq6O68PlISDwmIT1uwgwlNaXQaOfRJN/r2fSJZvPlGNQC4OGqIcwnuN3Fvkfqu9CKoDK4zvCPpQmRX0ucPVMindPvaSLPPIY6tw13Mq0e28vsKLKZot6LRjxK+DEyB25tahKEzv9ghFueEFV5D7roiZbQNMG8jWd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520206; c=relaxed/simple;
	bh=Dtpi1yrKRTtPk6r5zt7CiBiVsXJzpMWBZmyOj05XhgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc4yLDkvNB7x+nVLcwx6BLMD/5Q9nMzPaU+DGNHrCFS/d9qGtRf4SXH5GIJx0faQ/QIsQZ2lZM2VrcHbCHHEdYdsauPvZ8sDpiuWCmctLnxrLbQv0oYKnsvoMgKbAYCYWLd6v3MkBL5i8+C1BPqx5o/qXmY8MY86A0h/DezvVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hqoIfGI4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mh5ahTlQQ1u1cc+uN8Y4hernut2vJWnu3t21K5h/yFo=; b=hqoIfGI4pB2BPewTPk/Y83AHAy
	7nIAaAD/yld+8Afy4coT5a/rVwTEFYrsbHZr5TMMG8Bnshlp0kZgGYG2Q+HILcn2q6IOhdHdbWGV1
	eyHR3/lRksZ4vHirOLLQQuxkrAGmWZRNUprcckTjKdgC7ZASCYe2dXUe79c6SIDbe6N51PUzjhktp
	JPOn3PHkLIfUUfAlIdfZ/UXiNIzGq0ezQORAc55VCGrGFBwS0TqQB38MALIq69sEKbIJ3A9/2YmWW
	4jAnnAsW2gyuxqXRZuliLOGHQZB9WGHTnMrWcpbS0SlP6V1wVcKN8BP6YjqaScY/uLGRAkwKP3iAd
	YxvMr+9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR7tj-00000007mEl-0Rtr;
	Tue, 09 Jul 2024 10:16:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A87833006B7; Tue,  9 Jul 2024 12:16:34 +0200 (CEST)
Date: Tue, 9 Jul 2024 12:16:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, clm@meta.com,
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240709101634.GJ27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090304.GG27299@noisy.programming.kicks-ass.net>
 <Zo0KX1P8L3Yt4Z8j@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0KX1P8L3Yt4Z8j@krava>

On Tue, Jul 09, 2024 at 12:01:03PM +0200, Jiri Olsa wrote:
> On Tue, Jul 09, 2024 at 11:03:04AM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> > 
> > > Ramping this up to 16 threads shows that mmap_rwsem is getting more
> > > costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
> > > CPU. Is this expected? (I'm not familiar with the implementation
> > > details)
> > 
> > SRCU getting more expensive is a bit unexpected, it's just a per-cpu
> > inc/dec and a full barrier.
> > 
> > > P.S. Would you be able to rebase your patches on top of latest
> > > probes/for-next, which include Jiri's sys_uretprobe changes. Right now
> > > uretprobe benchmarks are quite unrepresentative because of that.
> > 
> > What branch is that? kernel/events/ stuff usually goes through tip, no?
> 
> it went through the trace tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes/for-next
> 
> and it's in linux-next/master already

FFS :-/ That touches all sorts and doesn't have any perf ack on. Masami
what gives?


