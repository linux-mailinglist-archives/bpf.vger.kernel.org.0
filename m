Return-Path: <bpf+bounces-32535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D26B90F7E1
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4974C1F21C9A
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BB15A868;
	Wed, 19 Jun 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cuuTt6A7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="joC3bNAP"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107E1369AA;
	Wed, 19 Jun 2024 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830599; cv=none; b=C/KfVJQhEWmD+4WgH6Hs6e6HoMzaXJ7jfiRxhvrkkwXKza+4LuZoR0RfPLYm0Z/aFdgPZp1YEkscctso5lF8G8ygKsnM5iV+yeP9m271uvxVia7YpW2c9NBu/960K/KPjmFhthf54aX+zF7fmdX+GOPnCgm2zvn9Pi1ff8GaL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830599; c=relaxed/simple;
	bh=1eEzPNxd8KJw08g69nKprRZCVdo4n+CXffrWgelwV+Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=rSd8JIxegRI3AQz7/yjT7wm8m32B59XBidYyZx10AyzOP2JfjYfnYK/8OQCvQ8cuSOYnyedEPHZHJDook4bKV1V4PFxk6qGa58pYLhKIoYCGXBi3D2PpDifJsLCPgrRPEhUdWyo3q9cV8mzmNCiWwPnE9rXuZT7GA4F+dpY9RDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cuuTt6A7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=joC3bNAP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718830595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=soTsYXlNCZ8l4EmfZeiFwZfgRB0mVQk3PyWpiDnSLRI=;
	b=cuuTt6A71lUtqMb5duUm4Phh9fGokKLryZcZ7tiYJ7wcunmUQTRlcf0zhTS/xdfo2pOZL8
	PWBe6MtsPw/ufIooI/k9/QBfhpV/IrpE0B5zro4nCG8iVGiShzDDjc/p4YHjvO4YkYGMZW
	GvNNxkUnQhVkaTEM1pWA5+mCWVOQX9lOJHSLuxHHJs0NT44HCGZz5w4H9MVqO7KaqGMZuy
	X5ClpPf+0U6ThFRlCj1HdHrG1YCQ3Dn7yTztV9aB6uO+YCXatzHUL9B5e49ZjXV45oTP0S
	iw/sn+jsjMGZkGi58Muu9D8HDcpYJA3TNE26nwCHTsipQ5NBsYqwqrdA1/fKgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718830595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=soTsYXlNCZ8l4EmfZeiFwZfgRB0mVQk3PyWpiDnSLRI=;
	b=joC3bNAPc7atIannZzX/NJXthvUgifXisZHdeOdW7uDyIqBzgk+Wcj172yF+oeFNL73yXB
	YXo5NNXQQfv029BA==
To: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, joshdon@google.com,
 brho@google.com, pjt@google.com, derkling@google.com, haoluo@google.com,
 dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
 riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
 memxor@gmail.com, andrea.righi@canonical.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
In-Reply-To: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
Date: Wed, 19 Jun 2024 22:56:34 +0200
Message-ID: <87ed8sps71.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Tue, Jun 11 2024 at 14:34, Linus Torvalds wrote:
> On Wed, 1 May 2024 at 08:13, Tejun Heo <tj@kernel.org> wrote:
>>
>> This is v6 of sched_ext (SCX) patchset.
>>
>> During the past five months, both the development and adoption of sched_ext
>> have been progressing briskly. Here are some highlights around adoption:
> [...]
>
> I honestly see no reason to delay this any more. This whole patchset
> was the major (private) discussion at last year's kernel maintainer
> summit, and I don't find any value in having the same discussion
> (whether off-list or as an actual event) at the upcoming maintainer
> summit one year later, so to make any kind of sane progress, my
> current plan is to merge this for 6.11.

I was part of that discussion and sat down for quite some time with the
sched_ext people to find a constructive way out of this situation. My
memory might trick me, but I remember clearly that there was consensus
to resolve this in a constructive and collaborative way.

Unfortunately I ran out of cycles after Richmond to follow up and the
fact that Peter wrecked his shoulder and was AFK for months did not make
it any better.

However, the sched_ext people did not follow up either especially not
regarding a clean integration along the scheme I asked them for in
November. Contrary to that the series gained more ad hoc warts.

That's water under the bridge, but it clearly shows how non-constructive
this has become.

So instead of "solving" this brute force and thereby proliferating the
non-constructive situation, can you please hold off with that plan to
merge it as is and give us three month to get this onto a collaborative
and constructive track?

I can make cycles available to work with both sides to get this resolved
for the benefit of everyone.

A clean integration will help both ends and makes both the existing code
and the new code better and easier to maintain together. IIRC, that's
something you yourself asked people to do in the past.

Thanks,

	Thomas

