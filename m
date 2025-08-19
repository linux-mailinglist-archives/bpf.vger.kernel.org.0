Return-Path: <bpf+bounces-66007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744CBB2C415
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7232D3BB24B
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E267326D5E;
	Tue, 19 Aug 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mcU1ynxx"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBA20766E;
	Tue, 19 Aug 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607537; cv=none; b=CveydyDgjBs1SNQK0T3SzX6e/zoZ1/z9BWQFpMclH1U07V4nuebUra1WEX3+gSlAvaha3gMCfJHkHBxlWBc0XHztjj0AmDoXJKPFNUiDWY5iHe6ScVhyHj/qNAqeka0kyUeg17EUDIjp2FwrzyjWvZygPWC/qHxw8xz67Q9MJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607537; c=relaxed/simple;
	bh=vLJLqbjEqQ6qbXsGdGCcPyGE36xVsw0BYQAnFOrBOpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDqryF2CEjYlxpxnNVqZamG7LfEtIwuDfHbNysK8JeNlG1sfRUTO5eg8UebqcSo01RRNe782MNQ/665KhydptRmzbAHXDV1gXiMM66gvnPRLiLraY3jwKiFbSYBc9Tpk74bMsqeORInmV6exPZBgv0bx84uuMEjEcswTW8awRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mcU1ynxx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jOHKPONzxjGXxC6pd36/pjJbc0PguQWGK1ehAAFl1a0=; b=mcU1ynxxLRLE0e9ylb3bo26wzz
	UjyRyLTLHM07qdxghI1S8TgGUvrL5lJIjcazjB9KC4BxOa9WGQ7H5g08/E34UzH17uNytxAbvrcI4
	kv8VtZyA/fTrUWqMDGkxqSkR96i9vEThFGaj0x5f7/Bt/ZL7XZbbDWIkqRT/kYbxPzXj3fvX74w3h
	ge4TlXKjzUgA4PzJllAUFwHrPQ6lT+rSrY/gwmqTbKHFVleHE748SpGq1g5uS3jrb1xuZf776aI8P
	0ddfS73JmmugRqQbI7Vlz7TgAPbbuSSVDMrDILKUD3TSmMmD+XhUbTLGxoiJ24e8haadADEc4E5Ke
	WsiLJapw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoLiP-00000005Maj-2sZK;
	Tue, 19 Aug 2025 12:45:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AED3930036F; Tue, 19 Aug 2025 14:45:25 +0200 (CEST)
Date: Tue, 19 Aug 2025 14:45:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, simona.vetter@ffwll.ch,
	tzimmermann@suse.de, jani.nikula@intel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <20250819124525.GF4068168@noisy.programming.kicks-ass.net>
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn>
 <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123214.GH4067720@noisy.programming.kicks-ass.net>

On Tue, Aug 19, 2025 at 02:32:14PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 19, 2025 at 09:58:31AM +0800, Menglong Dong wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index be00629f0ba4..00383fed9f63 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +EXPORT_SYMBOL_GPL(runqueues);
> 
> Oh no, absolutely not.
> 
> You never, ever, export a variable, and certainly not this one.
> 
> How about something like so?
> 
> I tried 'clever' things with export inline, but the compiler hates me,
> so the below is the best I could make work.

extern inline, that is, obviously...

