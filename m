Return-Path: <bpf+bounces-36317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB09464E2
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1361F22C5A
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2673176;
	Fri,  2 Aug 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMyTba2Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F51ABEB9
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633141; cv=none; b=BOiJ3I+RUjdZgsIX7HIf5Cquz6Wv9Fonm0KeS0Fw4LmP6lmikXzQOFBkp1Zk0XSXmKFrJkgMUoAO+CXZz8StegxZDdB1nmK0SXmG7kejlepLhNMx8w72Q+njSpNC4P32wS4T0zJmN5IzvC934Z/Tnvcy1ScxZJyQr3pZjOdNfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633141; c=relaxed/simple;
	bh=I086UHAeGn0WZvYtG1opnnB77MXlM9x1O7sSa1lkIwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoOHgFv+i6iL79kvy7FpGx8zjjMwRDQ/mMU2h/dbo360H11KWcoN1+rX1yQhF9N6rPsjPIT0GQv86BI0J7EDv6B8bxhOVrXGwPCVeYvVCApYQblYcmfKiyBFSTQtvj6BXIpMKV3CK5UytpMA4yartuJ+LEXbyGJsFl91q4ClXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMyTba2Q; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfd374ec-0b7c-4238-8e2f-42a331635261@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722633132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8sW4J3FZ8zzoKGsxvYM5LU3ngzil5sjTKmQcGRxqf4=;
	b=gMyTba2Q3OQU8jkwQ0nkMzw+lhfMPMxt5iDKFXo7Df+nzrv8K9K6GW9wM/TfkeNxg09hR7
	S7AEs1PUwvNVVaPhRH3HGVjtIg/ooSRrDUY+bEyN8KV1zWImn/XFoyKuuPkU0k0ProiSHI
	6/CroFJWKKOw+Xr2UvPvs9DwuhKEOcg=
Date: Fri, 2 Aug 2024 14:12:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <157ef482-a018-46da-b049-10c47fd286c7@linux.dev>
 <8c20454b-9e45-4371-bc47-6dd079573130@gmail.com>
 <2be68df9-2b73-42c6-b5da-2fd622fcef69@linux.dev>
 <f183b180-3bb1-4650-89f9-704db529281b@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <f183b180-3bb1-4650-89f9-704db529281b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/2/24 1:37 PM, Kui-Feng Lee wrote:
>> One way could be putting them in a new traffic_monitor.c such that the non 
>> test_progs binaries won't link to it. and exports the test name and shmod_tmon 
>> in test_progs.h (e.g. through function).
>>
>> Another way (better and my preference if it works out) is to ask the 
>> traffic_monitor_start() to take the the pcap file name args and makeup a 
>> reasonable default if no filename is given.  Not that I am promoting non 
>> test_progs tests, traffic_monitor_start() can then be reused by others for 
>> legit reason. The test_progs's tests usually should not use 
>> traffic_monitor_start() directly and they should stay with the netns_{new, 
>> free}. I think only netns_new needs the env to figure out the should_tmon and 
>> the pcap filename. May be netns_new() can stay in test_progs.c, or rename it 
>> to test__netns_new().
>>
>> wdyt?
> 
> How about put two ideas together?
> Have traffic_monitor.c and macros in test_progs.h to collect
> data from env, and pass the data to netns_new() in traffic_monitor.c.
> 
> For example,
> 
> #define test__netns_new(ns) netns_new(ns, env.test->should_tmon || \
>              (env.subtest_state && env.subtest_state->should_tmon), \
>              env.test->test_name,                                   \
>              env.subtest_state ? env.subtest_state->name: NULL)
> 

The macro looks ok. I am not sure if it is easier as a macro in .h or just a 
func in test_progs.c. A quick look is the struct of env.test is not defined in 
.h. Just a thought.

If we have this macro/func, a quick thought is there is not much upside to 
create a new traffic_monitor.c instead of putting everything in 
network_helpers.c. I am fine either way. The other non test_progs binaries just 
need to link another traffic_monitor.o in the future if it wants to do 
traffic_monitor_start().

