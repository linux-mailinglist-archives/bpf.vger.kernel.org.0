Return-Path: <bpf+bounces-10861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F77AE8CD
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0EF05281894
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD8612B83;
	Tue, 26 Sep 2023 09:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2263AF
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 09:20:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6ABE;
	Tue, 26 Sep 2023 02:20:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 423AD215E6;
	Tue, 26 Sep 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1695720027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ubSji0XDPEOBVnTbBKRyr/HLsbPg3Su+gignwc5fUs=;
	b=BbaR/gVVPxxyYnB52OZ4s1av2WTX2jiGwKOnEojCmPgU/OXetpZ+5NT6gDAUqkIimBneTo
	8Cg05UaX1YDiFYAWe3x28j5iEeYzTAvUptDq2pkMPNTAwFNJOF57HU1pakSdn56jGbBrla
	8yrVrG22Zf/QwglPPcH88r6Cns1dPm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695720027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ubSji0XDPEOBVnTbBKRyr/HLsbPg3Su+gignwc5fUs=;
	b=16Eucii0LhbAGVV/yMBofHtzU1AJNU3AesM8Fa5T6kGqyXZnAMl5yt8ckJFVjOHC0l0PIU
	gBxXMKXOdFyqFYDA==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id C2EFE2C142;
	Tue, 26 Sep 2023 09:20:22 +0000 (UTC)
Date: Tue, 26 Sep 2023 10:20:20 +0100
From: Mel Gorman <mgorman@suse.de>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <20230926092020.3alsvg6vwnc4g3td@suse.de>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
 <20230817124457.b5dca734zcixqctu@suse.de>
 <ZOfMNEoqt45Qmo00@slm.duckdns.org>
 <ZQngsfCdj0TJbEUL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZQngsfCdj0TJbEUL@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 07:56:01AM -1000, Tejun Heo wrote:
> Hello, Mel.
> 
> I don't think the discussion has reached a point where the points of
> disagreements are sufficiently laid out from both sides. Do you have any
> further thoughts?
> 

Plenty, but I'm not sure how to reconcile this. I view pluggable scheduler
as something that would be a future maintenance nightmare and our "lived
experience" or "exposure bias" with respect to the expertise of users differs
drastically. Some developers will be mostly dealing with users that have
extensive relevant expertise, a strong incentive to maximise performance
and full control of their stack, others do not and the time cost of
supporting such users is high. While I can see advantages to having specific
schedulers targeting either a specific workload or hardware configuration,
the proliferation of such schedulers and the inevitable need to avoid
introducing any new regressions in deployed schedulers will be cumbersome.

I generally worry that certain things may not have existed in the shipped
scheduler if plugging was an option including EAS, throttling control,
schedutil integration, big.Little, adapting to chiplets and picking preferred
SMT siblings for turbo boost. In each case, integrating support was time
consuming painful and a pluggable scheduler would have been a relatively
easy out that would ultimately cost us if it was never properly integrated.
While no one wants the pain, a few of us also want to avoid the problem
of vendors publishing a hacky scheduler for their specific hardware and
discontinuing the work at that point.

I see that some friction with the current state is due to tuning knobs
moving to debugfs. FWIW, I didn't 100% agree with that move either and
carried an out-of-tree revert that displayed warnings for a time but I
understood the logic behind it. However, if the tuning parameters are
insufficient, and there is good reason to change them then the answer
is to add tuning knobs with defined semantics and document them -- not
pluggable schedulers. We've seen something along those lines recently
with nice_latency even if it turned into EEVDF instead of a new interface,
so I guess we'll see how that pans out.

I get most of your points. Maybe most users will not care about a pluggable
scheduler but *some will* and they will the maintenance burden. I get your
point as well that if there is a bug and the pluggable scheduler then the
first step would be "reproduce without the pluggable scheduler" and again,
you'd be right, that is a great first step *except* sometimes they can't or
sometimes they simply won't without significant proof and that's incurs a
maintenance burden. Even if the pluggable schedulers are GPL, there still
is a burden to understood any scheduler that is loaded to see if it's the
source of a problem which means. Instead of understanding a defined number
of schedulers that are developed over time with the history in changelogs,
we may have to understand N schedulers that may be popular and that also
is painful. That's leaving aside the difficulty of what happens when
more than 1 can be loaded and interacting once containers are involved
assuming that such support would exist in the future. It's already known
that interacting IO schedulers are a nightmare so presumably interacting
CPU schedulers within the same host would also be zero fun.

Pluggable schedulers are effectively a change that we cannot walk back
from if it turns out to be a bad idea because it potentially comes under
the "you cannot break userspace" rule if a particular pluggable scheduler
becomes popular. As I strongly believe it will be a nightmare to support
within distributions where there is almost no control over the software
stack of managing user expectations, I'm opposed to crossing that line with
pluggable schedulers. While my nightmare scenarios may never be realised
and could be overblown, it'll be hard to convince me it'll not kick me in
the face eventually.

-- 
Mel Gorman
SUSE Labs

