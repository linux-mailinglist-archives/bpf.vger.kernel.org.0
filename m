Return-Path: <bpf+bounces-40053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDF97B896
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD36B1F22097
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD516A956;
	Wed, 18 Sep 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="g3CMuhbs"
X-Original-To: bpf@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA4273DC;
	Wed, 18 Sep 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644819; cv=none; b=AXW0fwwdBcD9kpV8GKFLA8t44ZGxfbOp+6WSwwAQao5HRul30KqPZZiIVVgtG66aDeUDIA2tjyf86/IjE41hEGQJSSy8TnOaBsZ6KDmLYuEZ3MLHBilLDPfJyO/30BYX7OTBmcMeAH8AxakoNcEBebOUGLPnX9mWke/smNyW928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644819; c=relaxed/simple;
	bh=KDWSO/DlRC22nIf1l+JdQKl0mmC4pDrhGOX9s3FmLtU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=juZ5o/3WGTX7C+JeWPpETWAJjnfMm0PClm6wftBntZMtG2Rucc+IuwINV0iqZp1rnscbiuADCBSyCslUmRtWvbf8A7T3A3QtRGycNCBkDvNGkl3TAzCAVootu3tN3O1hVSHuPYvrUawg1cJSWgRGXfRa1WtMdH+F6eZhnzgsEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=g3CMuhbs; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DBD020009;
	Wed, 18 Sep 2024 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1726644813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BGtCYOQcOECE4KEQhNC5Aph6S84pDq76u98tDqbbS0=;
	b=g3CMuhbsnZqxP5ZdE9M0GmBkodlm/f5cgZdPJbGcQbMI6zoGvjEzwCLC59BfFh8vVX5Ja3
	iqpVlJuYbsbrHoThh0P81XEn1dRrY3HbU4WlDcTWZ3rtLbPFUPwE3RqwI91mKZo8+Fjbcb
	oDvyLirXjsJilYWKSGvlQFhOOLHmaSozYmc6TTQpDp2PCiUmUkAbD9AcU+JqUvuS5Ck+YN
	FkRjgOT0H2HEensyYWVrKpkg/1qu6SgeSvx3pK3vcw3krRAJtMokZFREKv65m8xyc+VSRd
	oP2sMRZpMOdll0f/SoLBbYTJP9NpVu37XrHBeOTELLRSeuRaE7eBy0xOXtdg/A==
Message-ID: <da705c5d-9263-46dc-993e-dffee25969a3@gtucker.io>
Date: Wed, 18 Sep 2024 09:33:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Plumbers Testing MC potential topic: specialised toolchains
Content-Language: en-US
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
In-Reply-To: <e0b6e4b6-549a-43dc-bc76-3f8488cf5dd2@gtucker.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

Hello,

On 14/07/2024 1:03 am, Guillaume Tucker wrote:
>>> very interested to hear whether people feel it would be
>>> beneficial to work towards a more exhaustive solution supported
>>> upstream: kernel.org Docker images or something close such as
>>> Dockerfiles in Git or another type of images with all the
>>> dependencies included.  How does that sound?
>> A few thoughts around this:
>>
>> Having first party Dockerfiles could be useful but how would they be
>> used? Perhaps building a kernel in such a container could be plumbed
>> into Kbuild, such that the container manager could be invoked to build
>> the image if it does not exist then build the kernel in that image? This
>> might be a lofty idea but it would remove a lot of the friction of using
>> containers to build the kernel so that more people would adopt it?
> That's a great idea, and I think it's why having a live
> discussion at Plumbers would make sense as it's going to be
> harder to reach answers in a thread like this.

In fact I went ahead and made a small PoC for this as an experiment:

     https://gitlab.com/gtucker/linux/-/commits/linux-6.7-make-container

>> Another aspect of this is discoverability. I think a big problem with a
>> project like TuxMake is that while it is developed for the kernel
>> community, it is not a first party project, so without word of mouth,
>> there is not a great way for other people to hear about it.
>>
>> I think it would be a good idea to try and solicit feedback from the
>> greater kernel community at large to ensure that whatever solution is
>> decided on will work for both testing systems and
>> developers/maintainers. I think that a first party solution for having a
>> consistent and easy to set up/work with build environment has been
>> needed for some time but unfortunately, I am not sure how much
>> discussion around this problem has happened directly with those folks.
> Yes, that was my intention here with this thread to start
> widening the audience with the upstream community.  My
> understanding is that the issue hasn't been suitably framed to
> enable constructive discussion yet.  I'll consider submitting a
> proposal for the Toolchain track next.
> 
>>> [1]https://lpc.events/event/18/contributions/1665/
>>> [2]https://hub.docker.com/u/tuxmake
>>> [3]https://www.linaro.org/blog/tuxmake-building-linux-with-kernel-org-toolchains/
>> As an aside, consider using me as a point of contact for anything
>> ClangBuiltLinux related instead of Nick going forward, he has stepped
>> away to focus on LLVM libc for the immediate future.
> Noted, thank you.
> 
>> Thanks a lot for bring up this topic. I think it is important to work on
>> and I look forward to talking through this at Plumbers.
> That would be greatly appreciated.  Many thanks already for your
> insightful feedback.

The talk is happening today, slides are available:

     https://lpc.events/event/18/contributions/1928/

I'll reply later this week with a follow-up from the live
discussions at Plumbers and maybe this will lead to some RFCs or
a few patches.

Thanks,
Guillaume

