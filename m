Return-Path: <bpf+bounces-5922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A073B7631A4
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B541281D0A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F1BA31;
	Wed, 26 Jul 2023 09:20:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DBAD37
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:20:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829BB273B;
	Wed, 26 Jul 2023 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uXayj/Yf18aHDbjs538f8eIlrd2MMuKCabCQVkdwuVI=; b=Pf3slB1A2iw0llHI+l4WRhjcwj
	RjfQPHDhaoIW+a+rfgnJgProxKUju3/N/ektzOfCymWx/4zPuYoSSdbMFbN30C3EAnW6rxr2mifrY
	AwW60rIoCVrk/1wSdjm/pOFYYDqKlcW49SkTHrICI/dIPCGfwmwWg1JY0E5uGLXONcxsRl1T9aJhs
	0xyOYQ1RZtHdguaABpsNt2nIPFnizYOolsJAu2pu0hDWmODDiAEmRgfyMt2v/FaqYlEsJSbRohknB
	TRBTS3mqsUNvGRkL99aN1+ZGYndOfT4r2Lz2zitUqVC5JbEC30bjnfkBoFOjXG8HaIjb1/9nWkRca
	axlwhthQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qOaea-005mhb-2H;
	Wed, 26 Jul 2023 09:19:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6732430056F;
	Wed, 26 Jul 2023 11:17:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 196B12022E4DE; Wed, 26 Jul 2023 11:17:53 +0200 (CEST)
Date: Wed, 26 Jul 2023 11:17:52 +0200
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
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 08:37:41AM -1000, Tejun Heo wrote:

> We are comfortable with the current API. Everything we tried fit pretty
> well. It will continue to evolve but sched_ext now seems mature enough for
> initial inclusion. I suppose lack of response doesn't indicate tacit
> agreement from everyone, so what are you guys all thinking?

I'm still hating the whole thing with a passion.

As can be seen from the wide-spread SCHED_DEBUG abuse; people are, in
general, not interested in doing the right thing. They prod random
numbers (as in really, some are just completely insane) until their
workload improves and call it a day.

There is not a single doubt in my mind that if I were to merge this,
there will be Enterprise software out there that will mandate its own
BPF sched thing, or else it won't work.

They will not care, they will not contribute, they might even pull a
RedHat and only share the code to customers.

We all loose in that scenario. Not least me, because I get the
additional maintenance burden.

I also don't see upsides to merging this. You all can play with
schedulers out-of-tree just fine and then submit what actually works.

So, since you wanted it in writing, here goes:

NAK

