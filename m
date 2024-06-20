Return-Path: <bpf+bounces-32576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C89100CF
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3971F26733
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FBE1A4F37;
	Thu, 20 Jun 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Icekwg7Q"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0C2594;
	Thu, 20 Jun 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877158; cv=none; b=j/dA9j7iLMaQI9INTWk8dB9NY55rxl48KZpcnMW26WNcaAcXIT+woM3EhFWw2LNJ6LWbr1tQdGoOIM0hVJ3BnDbaCULocgjLXSF2rD+to1usfatotMXxQfMh7JMhLgtVqgdWUVUTROa3M9RdXvCguOtu+lNKb7HiGqvhqDiRGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877158; c=relaxed/simple;
	bh=O5gMPGPkxSae++PznbV3SBuEKQM+ZxUENKrJ/Rj5XRc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R7qSiANTpFnYJ/dez9HRLw5GlXNIkgi4UgUO54yIHFU6BWne8iraak4jPbyp6f+GAe870KBajcsR8sO2nWtjefZ+0MM5OcX41025c+cPx8N+rJthCULR3Rin+eSqj9wLUbkd8Nq7ynW73wIJeszPQGQ8UJjTxk0hECHtddNCFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Icekwg7Q; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kDuOXpS1n4BVbEWa1fJAOI7m+pURA+so01GB3GqC8ds=; b=Icekwg7Qh53xQWg219hStV3Fqv
	kUhwzxLTVlNc9d4wMZA9hLGgBntdrCrpbEUn6/4RyZw7l11ugzSr/DUT+h5VFnYAk9KWsMZI/zUdk
	n6foR2/xTisrJn219W9So9HbFw9CC9nLliyAnMK6WUjYHxlymHpT9LbLghRA1nXh17/fvFv+PJ33z
	FmOeSJZIAu0zUmkBK0eczPSEV3dtpPWzLoLnyLx9OC+5OhE6upLlwmkVBJU4cb+YTz+wxou16oDvq
	63JVEL0/RMDptKV0neL8ntzY/jjQmdFJ0zNP9u8lZt+TI64qi6dBl+/yJwO3jzLxH4MKtdliuC5yd
	WUt2wzxQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKESu-0001Sn-IP; Thu, 20 Jun 2024 11:52:24 +0200
Received: from [178.197.248.18] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKESt-0001zP-29;
	Thu, 20 Jun 2024 11:52:23 +0200
Subject: Re: XDP Performance Regression in recent kernel versions
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Samuel Dobron <sdobron@redhat.com>,
 netdev@vger.kernel.org
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
Date: Thu, 20 Jun 2024 11:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmmkn3mq.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27312/Thu Jun 20 10:34:55 2024)

On 6/19/24 9:17 PM, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>> On 18/06/2024 17.28, Sebastiano Miano wrote:
>>> I have been conducting some basic experiments with XDP and have
>>> observed a significant performance regression in recent kernel
>>> versions compared to v5.15.
>>>
>>> My setup is the following:
>>> - Hardware: Two machines connected back-to-back with 100G Mellanox
>>> ConnectX-6 Dx.
>>> - DUT: 2x16 core Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz.
>>> - Software: xdp-bench program from [1] running on the DUT in both DROP
>>> and TX modes.
>>> - Traffic generator: Pktgen-DPDK sending traffic with a single 64B UDP
>>> flow at ~130Mpps.
>>> - Tests: Single core, HT disabled
>>>
>>> Results:
>>>
>>> Kernel version |-------| XDP_DROP |--------|   XDP_TX  |
>>> 5.15                      30Mpps               16.1Mpps
>>> 6.2                       21.3Mpps             14.1Mpps
>>> 6.5                       19.9Mpps              8.6Mpps
>>> bpf-next (6.10-rc2)       22.1Mpps              9.2Mpps
>>>
>>
>> Around when I left Red Hat there were a project with [LNST] that used
>> xdp-bench for tracking and finding regressions like this.
>>
>> Perhaps Toke can enlighten us, if that project have caught similar
>> regressions?
>>
>> [LNST] https://github.com/LNST-project/lnst
> 
> Yes, actually, we have! Here's the bugzilla for it:
> https://bugzilla.redhat.com/show_bug.cgi?id=2270408

 > We compared performance of ELN and RHEL9 candidate kernels and noticed significant
 > drop in XDP drop [1] on mlx5 (25G).
 >
 > On any rhel9 candidate kernel we are able to drop 19-20M pkts/sec but on an ELN
 > kernels, we are reaching just 15M pkts/sec (CPU utillization remains the same -
 > around 100%).
 >
 > We don't see such regression on ixgbe or i40e.

It looks like this is known since March, was this ever reported to Nvidia back
then? :/

Given XDP is in the critical path for many in production, we should think about
regular performance reporting for the different vendors for each released kernel,
similar to here [0].

Out of curiosity, @Saeed: Is Nvidia internally regularly assessing XDP perf for mlx5
as part of QA? (Probably not, but I thought I'd ask.)

Thanks,
Daniel

   [0] http://core.dpdk.org/perf-reports/

