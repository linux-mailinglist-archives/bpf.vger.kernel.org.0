Return-Path: <bpf+bounces-32718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30669122C4
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA82289E28
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F40171E6A;
	Fri, 21 Jun 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zeriEZJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ar1Xz6jS"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1E7FBBD;
	Fri, 21 Jun 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966768; cv=none; b=o9DjXWUsIJCpErXdhhwCQRv5i8uPIUMk6opjyuwDqVko3vN3JACLkySWwAzDUg3phyI3sv9VIkW2Jl22V/LiuVoqivyc8NAjtJSOmRsPuXkiAWbOdbMKUXcD+hsbaQSTnLji1C/xMbozLvw4T4Kyxfj4r2h3qZL2J1FaiFXalfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966768; c=relaxed/simple;
	bh=VrIIoHGeotm8tbt7s5A8/A4khw9feLi4pSGfWNF6d7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYgdEqY9/L0SppK1Rrt4TwMbkHmaD9/UVXY1jZHQ9JAy36AgZhaxr3P+5Euhz35J3MCYXwnPfJkLzBO4DBCSDkOJNxVM6xbshOCOayMjWh2lBNAc6wpjIiKXmqLLOCO4vVvi5XtNPI8q1/LpmEmf6CbqEeweZ9Yx1a9E2bkNjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zeriEZJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ar1Xz6jS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718966763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6uzgA3OuvNjAKIJ1N0WUV8pAvtRghi5pTO6jCkNH5U=;
	b=zeriEZJ7L1UK/GlEtsiC3fs7tuAVTkfjEc6VkvBHIxusX4kyGOAtDMsIhU89oj4CZ+6pg8
	in9aBAFxv8A969MdpenBZfobQkXfJBbar982zcqWIGVBCbUZSz6uZwWrz0xlwTjVUdUVpJ
	2mAvJnNrHWE3Yq2+fqh/eBUnp2mx7CdHnRiPwkEKqTrA1XIGloB6YryVwnN9ihaIen4EHT
	v9sKOpPIXVhwDJiJZP5rlUlv6J1BzsDiwLDFt/53yDpvsKKhsplplIq+Z+q91xu5hOOknm
	GQG6skoGjy+LicxDznXuMCnIIXyW6XWLhl2D78ma8MlFi+Zok6vHJt9XM+3bFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718966763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6uzgA3OuvNjAKIJ1N0WUV8pAvtRghi5pTO6jCkNH5U=;
	b=Ar1Xz6jSrHUvkUGhcAZDKDWtOxkObXL0L6pA6oHpfZZ9K2PImIerWkaERoGYgRPBozDvHS
	XTN1rOjLplwR1YBg==
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
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
In-Reply-To: <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
Date: Fri, 21 Jun 2024 12:46:03 +0200
Message-ID: <87r0cqo9p0.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tejun!

On Thu, Jun 20 2024 at 09:35, Tejun Heo wrote:
> On Thu, Jun 20, 2024 at 04:35:08AM +0200, Thomas Gleixner wrote:
>> When I sat there in Richmond with the sched_ext people I gave them very
>> deep technical feedback especially on the way how they integrate it:
>> 
>>   Sprinkle hooks and callbacks all over the place until it works by some
>>   definition of works.
>
> I would characterize that part of the discussion more nebulous than deep.
> You cited a really high number for where SCX is hooking into the scheduler
> core and then made wide-ranging suggestions including refactoring all the
> schedulers, which seemed vague and out of scope. I tried to probe and we
> didn't get anywhere concrete, which is fine. It's difficult to hash out
> details in such settings.

It's not that nebulous. And fine if you tried and got nowhere, but did
you give feedback to those failed attempts or started a discussion with
anyone on the scheduler side? No.

>> That's perfectly fine for a PoC, but not for something which gets merged
>> into the core of an OS. I clearly asked them to refactor the existing
>> code so that these warts go away and everything is contained into the
>> scheduler classes and at the very end sched_ext falls into place. That's
>> a basic engineering principle as far as I know.
>> 
>> They nodded, ignored my feedback and just continued to pursue their way.
>
> However, this is not true. During the discussion, I asked you multiple times
> to review the patches and point out the parts that are problematic so that
> they can be addressed and the discussion can become more concrete. You
> promised you would but didn't.

Yes, I said I will do two things:

     - Talk to Peter
     - Review the stuff again

I talked to Peter to come up with a proper plan in order to give
feedback. It was unfortunate that Peter vanished from the planet at that
time due to his shoulder incident.

As I said to Linus, I'm sorry that I afterwards dropped the ball
because I got dragged into other things and ran out of cycles.

I also asked you to reach out to the scheduler folks and work with them
to get things moving again. Are you really claiming that you couldn't do
that without me holding your hands?

> When we attempted to follow up with you afterwards, we got no responses.

I just checked and found three private mails from you which ended up in
the wrong filter dated Feb 1, Feb 9, Feb 16. My bad that I dropped
them, but definitely not because of desinterest or malice.

You can of course say you tried and I ignored you, but seriously?

If you really wanted to get my attention then you exactly know how to
get it like everyone else who is working with me for decades.

Thanks,

        tglx





