Return-Path: <bpf+bounces-29655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953518C46C5
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F6D1C20DEC
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E733CF1;
	Mon, 13 May 2024 18:26:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C62C1A9;
	Mon, 13 May 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715624811; cv=none; b=tDA9OV/SsZ9oZ2L9//JxzWGdFqPpm2p/WcNam3zFHC2EMD6yJUa20UW1cRMfUESUWR8n/e2pRG8eeiBCETiLseUVmeBff3CVXemFgTVo5/qjxfc2R7nWK11Bx2TblGbeUw7tfga55OljQOS2ypv5eWvKpnX/O2+23iCuz0sFDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715624811; c=relaxed/simple;
	bh=KMlCK65C87EvBcjZbxwN/eiP899E0BT6IdkmKFZJmSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpKdfvYRflt/VuLtfM05u5PyyLjiphHwLaLOTo7PCnpwVrn8tNtkXpRt4dVeOY9s1nyU6ZOehBZFnUacciD8frGQEaT2tdXSMoetBDfODvWwJeaWJhsxr0JdTrE43eOm4UVROVTtJk+AZzaah9QaDRRdU62V3i/OxFTOr6tvm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8819C113CC;
	Mon, 13 May 2024 18:26:48 +0000 (UTC)
Date: Mon, 13 May 2024 14:26:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com,
 himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240513142646.4dc5484d@rorschach.local.home>
In-Reply-To: <20240513080359.GI30852@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
	<20240502084800.GY30852@noisy.programming.kicks-ass.net>
	<ZjPnb1vdt80FrksA@slm.duckdns.org>
	<20240503085232.GC30852@noisy.programming.kicks-ass.net>
	<ZjgWzhruwo8euPC0@slm.duckdns.org>
	<20240513080359.GI30852@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 10:03:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > I believe we agree that we want more people contributing to the schedul=
ing
> > area.  =20
>=20
> I think therein lies the rub -- contribution. If we were to do this
> thing, random loadable BPF schedulers, then how do we ensure people will
> contribute back?

Hi Peter,

I'm somewhat agnostic to sched_ext itself, but I have been an advocate
for a plugable scheduler infrastructure. And we are seriously looking
at adding it to ChromeOS.

>=20
> That is, from where I am sitting I see $vendor mandate their $enterprise
> product needs their $BPF scheduler. At which point $vendor will have no
> incentive to ever contribute back.

Believe me they already have their own scheduler, and because its so
different, it's very hard to contribute back.

>=20
> And customers of $vendor that want to run additional workloads on
> their machine are then stuck with that scheduler, irrespective of it
> being suitable for them or not. This is not a good experience.

And $vendor usually has a unique workload that their changes will
likely cause regressions in other workloads, making it even harder to
contribute back.

>=20
> So I don't at all mind people playing around with schedulers -- they can
> do so today, there are a ton of out of tree patches to start or learn
> from, or like I said, it really isn't all that hard to just rip out fair
> and write something new.

For cloud servers, I bet a lot of schedulers are not public. Although,
my company tries to publish the schedulers they use.

>=20
> Open source, you get to do your own thing. Have at.
>=20
> But part of what made Linux work so well, is in my opinion the GPL. GPL
> forces people to contribute back -- to work on the shared project. And I
> see the whole BPF thing as a run-around on that.
>=20
> Even the large cloud vendors and service providers (Amazon, Google,
> Facebook etc.) contribute back because of rebase pain -- as you well
> know. The rebase pain offsets the 'TIVO hole'.

=46rom what I understand (I don't work on production, but Chromebooks), a
lot of changes cannot be contributed back because their updates are far
from what is upstream. Having a plugable scheduler would actually allow
them to contribute *more*.

>=20
> But with the BPF muck; where is the motivation to help improve things?

For the same reasons you mention about GPL and why it works.
Collaboration. Sharing ideas helps everyone. If there's some secret
sauce scheduler then they would likely just replace the scheduler, as
its more performant. I don't believe it would be worth while to use BPF
for that purpose.

>=20
> Keeping a rando github repo with BPF schedulers is not contributing.

Agreed, and I would guess having them in the Linux kernel tree would be
more beneficial.

> That's just a repo with multiple out of tree schedulers to be ignored.
> Who will put in the effort of upsteaming things if they can hack up a
> BPF and throw it over the wall?

If there's a place in the Linux kernel tree, I'm sure there would be
motivation to place it there. Having it in the kernel proper does give
more visibility of code, and therefore enhancements to that code. This
was the same rationale for putting perf into the kernel proper.

>=20
> So yeah, I'm very much NOT supportive of this effort. From where I'm
> sitting there is simply not a single benefit. You're not making my life
> better, so why would I care?
>=20
> How does this BPF muck translate into better quality patches for me?

Here's how we will be using it (we will likely be porting sched_ext to
ChromeOS regardless of its acceptance).

Doing testing of scheduler changes in the field is extremely time
consuming and complex. We tested EEVDF vs CFS by backporting EEVDF to
5.15 (as that is the kernel version we are using on the chromebooks we
were testing on), and then we need to add a user space "switch" to
change the scheduler. Note, this also risks causing a bug in adding
these changes. Then we push the kernel out, and then start our
experiment that enables our feature to a small percentage, and slowly
increases the number of users until we have a enough for a statistical
result.

What sched_ext would give us is a easy way to try different scheduling
algorithms and get feedback much quicker. Once we determine a solution
that improves things, we would then spend the time to implement it in
the scheduler, and yes, send it upstream.

To me, sched_ext should never be the final solution, but it can be
extremely useful in testing various changes quickly in the field. Which
to me would encourage more contributions.

-- Steve

