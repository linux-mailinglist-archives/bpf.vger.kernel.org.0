Return-Path: <bpf+bounces-32708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE39120BE
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 11:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309E81F243E4
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2D16E894;
	Fri, 21 Jun 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H00XeCfO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jX03SBRQ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4916E87B;
	Fri, 21 Jun 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962553; cv=none; b=OKBbcY9/XA1aqlXhdL8GeiAgSwlOQ0B6Y6eoSRaXGkYmJs4VeOWjKHHQjW9me02lZG6QN19jo6tji88XcAaUL89fS5E1mtc6p+hywW/sLM9dD4lwPO4lfc6cq0ViP7tBIPJ72GT7UfFm+4UzX1kgZPCXGG5JssrscSPK4U033c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962553; c=relaxed/simple;
	bh=fueST5tq9tqjsbm1SF1O899MwneK4m+fej0WNIDv0rM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pX7wFaSpjbnJGJ+EVBcL1r/RsWzu3nzAQtTtj0NP/GuIRdUcqfcJJHzY2AhXULnmgtx43j1oSxld9F0IDi4R8Y39h6jyBJDQMj9RS2jiOz1LoimnOtS+2lAIlZFYObwHRN/QdoSi13E05V1mBJM9AXQV7J/UizROxqhzV0LLYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H00XeCfO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jX03SBRQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718962549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1wbUsrKrmv5V0PcF6YSir/wKQTjZgw80G37FSqXWD4=;
	b=H00XeCfO43+5VTc6fSQchdMPlGEsQEwrJBP1M0YDozxjHtGgUJS1ZmLFQURsgJJDkTYKXM
	BfraIDkl4XJ5X+T38CuHONluq9xJzq/MZNRD0K+HP2fABjQPerrMtQ80OcIX4kmsC0IK7R
	i6wRaMN/scWV3jx5MPlB+ICefVCE5JmZSiV9uwI4jU4MtsaZ4fHllJAbN2PITVTKeY+PAt
	WFbNkivgc65ACVjfXaZUTHcCtbGq6WuaVPwHxkLueYkniwt6nQn5m0mTntDt8IC+qzVzYD
	b/ob9lEG0Fo3NqZ1hsyGyEqcpycipH3t+5Lnw74kT9xhzfEg0FJlwfwW3M+fQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718962549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1wbUsrKrmv5V0PcF6YSir/wKQTjZgw80G37FSqXWD4=;
	b=jX03SBRQGQYBCVl1aL/D+1KTwMcAVrfxtIl7AjlA0YMo0P+t41nwz9C+n1IQ6cjD063Jve
	1S4n6w+ndMPddwBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com,
 himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
In-Reply-To: <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
Date: Fri, 21 Jun 2024 11:35:49 +0200
Message-ID: <87v822ocy2.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Thu, Jun 20 2024 at 12:20, Linus Torvalds wrote:
> On Thu, 20 Jun 2024 at 11:47, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > But I get the very strong feeling that people wanted to limit the
>> > amount of changes they made to the core scheduler code.
>>
>> Which is exactly the point.
>
> But Thomas - that's *MY* point.

You are seriously trying to lecture me of all people about out of tree
code and how it's supposed to be merged?

I really don't know whether I should laugh, cry or just walk away.

> If this code stays out of tree, the goal is always that "don't
> integrate, make the patch easy to apply".

That's absolutely not the goal. The goal is to do a proper and good
integration so that all involved parties can move on.

That's what I clearly said and nothing else.

> This whole "keep things out until they are perfect" is a DISEASE.

Nobody says that things need to be perfect. I'm very much a proponent of
"perfect is the enemy of good".

> It's a disease because it's counter-productive. First off, things will
> never be "perfect" because you have people with different goals in the
> first place.,
>
> But secondly, the "keep things out" is itself counter-productive.

Says the one who kept asking me repeatedly whether I can't keep the
remaining stuff of RT out of tree forever. The last time you asked that
was not that long ago.

Aside of that you are completely ignoring my point.

Collaborative integration is the right thing to do no matter what. I've
integrated and helped many others to integrate tons of controversial
features in the past 20 years so I definitely know what I'm talking
about. But I've also learned my lessons in the past 20 years.

The whole notion of "let's get this in and sort it out later" only works
when people collaborated to begin with and worked on making things more
palatable in the first place. At some point they just agreed to get over
it. That has nothing to do with perfect and keep stuff out of tree
forever.

In all other cases the stuff got merged and the "sort it out later" was
left to those who had the least interest in the so exiting new feature.
They had to mop up the mess to make progress with their own work. I
wasted a substantial portion of my life mopping up the mess which was
declared to be sorted out later and you know that.

If that is your vision of a working and healthy community, then we have
to agree that we disagree.

The issue at hand is clearly both a technical and a social problem.
Contrary to you I don't hate people and my goal is to bridge the rift
which clearly exists. That rift is definitely not helpful to get things
sorted out later in a constructive and collaborative way.

I've offered _my_ time to help and sort this out. That's all I can do.

If you don't care, so be it.

Thanks,

        tglx



