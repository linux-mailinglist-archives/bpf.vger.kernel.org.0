Return-Path: <bpf+bounces-40606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4898ADD1
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129151F2302B
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A771A0BED;
	Mon, 30 Sep 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="e231wNzI"
X-Original-To: bpf@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09B1A0BDA;
	Mon, 30 Sep 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727199; cv=none; b=LGBbxocPkEWUq5DUy4ZBlM9rB6O++sPJAYyfixwv5gnWokEUWGKRuCn95X7w91C3UoYAnzonUHRMt46M1iA+DjExQdAVmqhH66dmcRBN5Lit/wruFVUJqWyzVRXc08V4SxsbQTAiFxxBdjEHPvovfagCsY362jVHrTBpGn+gThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727199; c=relaxed/simple;
	bh=jpHFbPS4b46l4Uy5ur3XAr82nRkU4uFcljnesW3CQjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V+51BNg9eZN30RnB+opj/PMX9sjNI3BSgTtaVTRf8INgzBo4D+WMA4avKL0xPwAzxbr0rZ40exsRXupgCdqKl+FQRZIi7ObihmkNOquTptwjXIZExFfs4sg4QVDGgn0KuC69grFGpTl4YlzOOcoH2Rq9z8kAwgCPiDSlu9KNFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=e231wNzI; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 17D9FC2119;
	Mon, 30 Sep 2024 20:07:46 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7686B60005;
	Mon, 30 Sep 2024 20:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1727726858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPjZZqN7jnSiL2NmefSUuNypX5UxgdYOfraEUVr0Otg=;
	b=e231wNzIz4oR70aovEHisrl21oyE2m0L3T4+Z8hXGO7hhzHaByLdi/1MobIS+zPxM9O23o
	CIKANaTkENTMIiqYTB2bwAtRFFx9K32FJ++KtEXXPp7q0cn2ru0ka999sZ/i0MiAxq6gGg
	Js/7MdmM6enEH874PpBnaIYtYPFXjce2HHd4o7Fqy39g398TtkkTrTUN9bqnUOV2TuwmQS
	GteyLvj78INFCPBj8k6pBCH8usXi8BI7r+bNW2QtiGs4i4aph8jjtOsFvnkOXnUL5e37mo
	8AObZa8eHe9imlZ9BiIEYB13Prf1/EKWBTI1/MxRfJnQZUfRtj5gCGOwCwkKyw==
Message-ID: <affb7aff-dc9b-4263-bbd4-a7965c19ac4e@gtucker.io>
Date: Mon, 30 Sep 2024 22:07:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Automated-testing] Plumbers Testing MC potential topic:
 specialised toolchains
From: Guillaume Tucker <gtucker@gtucker.io>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
 rust-for-linux@vger.kernel.org, yurinnick@meta.com, bpf@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 automated-testing@lists.yoctoproject.org
References: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
 <20240709053031.GB2120498@thelio-3990X>
 <e0b6e4b6-549a-43dc-bc76-3f8488cf5dd2@gtucker.io>
 <17F6464FBF21FF99.27464@lists.yoctoproject.org>
Content-Language: en-GB
Organization: gtucker.io
In-Reply-To: <17F6464FBF21FF99.27464@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gtucker@gtucker.io

On 18/09/2024 09:33, Guillaume Tucker wrote:
> Hello,
> 
> On 14/07/2024 1:03 am, Guillaume Tucker wrote:
>>>> very interested to hear whether people feel it would be
>>>> beneficial to work towards a more exhaustive solution supported
>>>> upstream: kernel.org Docker images or something close such as
>>>> Dockerfiles in Git or another type of images with all the
>>>> dependencies included.  How does that sound?
>>> A few thoughts around this:
>>>
>>> Having first party Dockerfiles could be useful but how would they be
>>> used? Perhaps building a kernel in such a container could be plumbed
>>> into Kbuild, such that the container manager could be invoked to build
>>> the image if it does not exist then build the kernel in that image? This
>>> might be a lofty idea but it would remove a lot of the friction of using
>>> containers to build the kernel so that more people would adopt it?
>> That's a great idea, and I think it's why having a live
>> discussion at Plumbers would make sense as it's going to be
>> harder to reach answers in a thread like this.
> 
> In fact I went ahead and made a small PoC for this as an experiment:
> 
>     https://gitlab.com/gtucker/linux/-/commits/linux-6.7-make-container
> 
>>> Another aspect of this is discoverability. I think a big problem with a
>>> project like TuxMake is that while it is developed for the kernel
>>> community, it is not a first party project, so without word of mouth,
>>> there is not a great way for other people to hear about it.
>>>
>>> I think it would be a good idea to try and solicit feedback from the
>>> greater kernel community at large to ensure that whatever solution is
>>> decided on will work for both testing systems and
>>> developers/maintainers. I think that a first party solution for having a
>>> consistent and easy to set up/work with build environment has been
>>> needed for some time but unfortunately, I am not sure how much
>>> discussion around this problem has happened directly with those folks.
>> Yes, that was my intention here with this thread to start
>> widening the audience with the upstream community.  My
>> understanding is that the issue hasn't been suitably framed to
>> enable constructive discussion yet.  I'll consider submitting a
>> proposal for the Toolchain track next.
>>
>>>> [1]https://lpc.events/event/18/contributions/1665/
>>>> [2]https://hub.docker.com/u/tuxmake
>>>> [3]https://www.linaro.org/blog/tuxmake-building-linux-with-kernel-org-toolchains/
>>> As an aside, consider using me as a point of contact for anything
>>> ClangBuiltLinux related instead of Nick going forward, he has stepped
>>> away to focus on LLVM libc for the immediate future.
>> Noted, thank you.
>>
>>> Thanks a lot for bring up this topic. I think it is important to work on
>>> and I look forward to talking through this at Plumbers.
>> That would be greatly appreciated.  Many thanks already for your
>> insightful feedback.
> 
> The talk is happening today, slides are available:
> 
>     https://lpc.events/event/18/contributions/1928/
> 
> I'll reply later this week with a follow-up from the live
> discussions at Plumbers and maybe this will lead to some RFCs or
> a few patches.

Well, we're now more than a week after but I got some extras with
actual container images and a blog post with all the details:

    https://gtucker.io/posts/2024-09-30-korg-containers/

In a nutshell, this went down rather well at Plumbers.  I think
there are still a few critical points to address before bringing
this up as actual RFC kernel patches but let's see how this goes.

Many thanks once again to the Toolchain Track organizers and
Nathan for the feedback.

Best wishes,
Guillaume


