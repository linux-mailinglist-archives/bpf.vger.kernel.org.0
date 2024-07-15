Return-Path: <bpf+bounces-34867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45BD931DE3
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2174A1C21D23
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4714431C;
	Mon, 15 Jul 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gfa9t3jd"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F42145B02
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087789; cv=none; b=gfxJAlRRBk/IHH6C1YFVcHEI3z2p9xQUUcDC7mZ+Zj9B8csjwu5tf7sfYwoSi9mcJ2YKf2Yyvou6FhspXGAdwsQFGXU1Go+FeQtR1qIGa6EP7B/eQmhnjN1P9PiuBN2oJjEYtOo1ZzlfposA/dsyEzFdpBSMhwrfqdMIVMtOSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087789; c=relaxed/simple;
	bh=l8UfKSLEadKaU0rdgtalSfXxO3GOy0o8Sm8fqFrEy3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDekc5aUkr4/XsbruD0BlvyC46itr7RZgYrAOhC2UrucyOQH+vr3EiquUw3iJI2EewN6ACR8ESn46FXaHgX0rxQvYwGExMoM5TOYCr2uX4QLgFmUdIE11cQZxJZ7ZtJtZShuRAH/ZQypIJn+wmXoq7cAIbR5ewyUsy897z+Ft2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gfa9t3jd; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721087785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BCPF3CqBj6opeHIFR+Mc806VJa0ZmxysSlp2KedOBc=;
	b=Gfa9t3jdzgvykKd1nQVa6ft9Nb6sokZ7sJRu8dyODM3J5GPaMZpen/aPCKhONY+O5IyeYH
	oU0n2s06I+4/wx0lJL042KeGnPjok82Kr6qwqQlmB5cdLQbHLj5gkGHbKLS80qStOkDTzG
	H9gRvbnxlU3DKKa5CT60rCCWBsebeKk=
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: kuifeng@meta.com
Message-ID: <940fff33-ed2b-41e0-bac6-d388deda9446@linux.dev>
Date: Mon, 15 Jul 2024 16:56:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
To: Kui-Feng Lee <sinquersw@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240713055552.2482367-1-thinker.li@gmail.com>
 <ZpWVvo5ypevlt9AB@mini-arch> <4c658385-dc3c-46ff-a868-0159edf84dc1@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <4c658385-dc3c-46ff-a868-0159edf84dc1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/24 3:07 PM, Kui-Feng Lee wrote:
> 
> 
> On 7/15/24 14:33, Stanislav Fomichev wrote:
>> On 07/12, Kui-Feng Lee wrote:
>>> Run tcpdump in the background for flaky test cases related to network
>>> features.
>>
>> Have you considered linking against libpcap instead of shelling out
>> to tcpdump? As long as we have this lib installed on the runners
>> (likely?) that should be a bit cleaner than doing tcpdump.. WDYT?
> 
> I just checked the script building the root image for vmtest. [1]
> It doesn't install libpcap.
> 
> If our approach is to capture the packets in a file, and let developers
> download the file, it would be a simple and straight forward solution.
> If we want a log in text, it would be more complicated to parse
> packets.
> 
> Martin & Stanislay,
> 
> WDYT about capture packets in a file and using libpcap directly?
> Developers can download the file and parse it with tcpdump locally.

thinking out loud...

Re: libpcap (instead of tcpdump) part. I am not very experienced in libpcap. I 
don't have a strong preference. I do hope patch 1 could be more straight forward 
that no need to use loops and artificial udp packets to ensure the tcpdump is 
fully ready to capture. I assume using libpcap can make this sync part 
easier/cleaner (pthread_cond?) and not too much code is needed to use libpcap?

Re: dump to file and download by developer. If I read patch 1 correctly, it only 
dumps everything at the end of the test (by calling traffic_monitor_report). 
imo, it lost the chronological ordering with other ASSERT_* logs and does not 
make a big difference (vs downloading as a file).

The developer needs to go through another exercise to figure out (e.g.) a 
captured packet may be related to a ASSERT_* failure by connecting the timestamp 
between the ASSERT_* log and the captured packet (afaik, there is a timestamp in 
the CI raw log). Ideally, the packet can be logged to stderr/out as soon as it 
is captured such that the developer can still sort of relate the packet with the 
other ASSERT_*() log around it.


