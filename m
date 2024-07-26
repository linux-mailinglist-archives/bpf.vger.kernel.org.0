Return-Path: <bpf+bounces-35690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDD93CC0F
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 02:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C820DB2157A
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 00:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743C780B;
	Fri, 26 Jul 2024 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fxVVU+/b"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F863C
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953445; cv=none; b=seYNiqhZj/QXcM/VQPMMkTakMj53GAd0fbEQ6VUhzBtwCyebaxH8vLrJgs35fe4T8pzoMvZ8czfpo2wRTm5SBlJDpQKEs36Cd7NTvLMrFVYK/8RLz54VN6SwbTvhUc07+gphPC3Rxp3pTeFRQdZA/VNAwU6di3jv7PD+Ex8I0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953445; c=relaxed/simple;
	bh=GubneblwPNiJd8nXtOtnhyVYCi+1qP408i7wwzvPTN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MF6fsX+4PtyX4uUYSGQCHBApyyDt/iZblK2iM0N7uz1ydApn1DRVvK5sNstxWXtqoJkqB7jVG0XlyvTfP0Sts+GNq2Ud/nnPc7MUhjkrgoJq3iURdWqEzHjQI7yn7n5QZOttgcub6Rtb+xfFJwBAe9kSLKdbb6EpsiB42NfgHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fxVVU+/b; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7003dd9a-3458-46ea-b9b8-6025241b6833@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721953439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kTg6j9XYo0Iz3/XBkUNgSnF1+btaNJYx7uf7JdCJ30=;
	b=fxVVU+/bUmvG+Cs9gAmKgRvVpA/CREr9z/YoxsNzyECZMgg2n9RHLnE2Xh20DGj8wzZGiZ
	OshdzfC2bA2YTHXkmUDcKFJabYh16oMZMGA8apYqFmXFBCLuiAGCToGhr1MYhjlnq+l1ED
	TCNG/H0y/rZjWLzmtDi4yszKsYEnpI0=
Date: Thu, 25 Jul 2024 17:23:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me, kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-2-thinker.li@gmail.com>
 <51966001-297e-4dae-a7b8-41cdef0fd35c@linux.dev>
 <c80120a6-6991-4de9-a705-5533282e3e67@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c80120a6-6991-4de9-a705-5533282e3e67@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/25/24 3:47 PM, Kui-Feng Lee wrote:
>>> +/* Start to monitor the network traffic in the given network namespace.
>>> + *
>>> + * netns: the name of the network namespace to monitor. If NULL, the
>>> + * current network namespace is monitored.
>>> + *
>>> + * This function will start a thread to capture packets going through NICs
>>> + * in the give network namespace.
>>> + */
>>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns)
>>
>> There is opportunity to make the traffic monitoring easier for tests that 
>> create its own netns which I hope most of the networking tests fall into this 
>> bucket now. Especially for tests that create multiple netns such that the test 
>> does not have to start/stop for each individual netns.
>>
>> May be adding an API like "struct nstoken *netns_new(const char *netns_name)". 
>> The netns_new() will create the netns and (optionally) start the monitoring 
>> thread also. It will need another "void netns_free(struct nstoken *nstoken)" 
>> to stop the thread and remove the netns. The "struct tmonitor_ctx" probably 
>> makes sense to be embedded into "struct nstoken" if we go with this new API.
> 
> Agree! But, I think we need another type rather than to reuse "struct
> netns". People may accidentally call close_netns() on the nstoken
> returned by this function.

ah. Good point. close_netns() does free the nstoken also...
yep. probably make sense to have another type for netns create/destroy which 
start/stop the monitoring automatically based on the on/off in the libpcap.list.

> 
>>
>> This will need some changes to the tests creating netns but it probably should 
>> be obvious change considering most test do "ip netns add..." and then 
>> open_netns(). It can start with the flaky test at hand first like tc_redirect.
>>
>> May be a little more changes for the test using "unshare(CLONE_NEWNET)" but 
>> should not be too bad either. This can be done only when we need to turn on 
>> libpcap to debug that test.
>>
>> Also, when the test is flaky, make it easier for people not familiar with the 
>> codes of the networking test to turn on traffic monitoring without changing 
>> the test code. May be in a libpcap.list file (in parallel to the existing 
>> DENYLIST)?
>>
>> For the tests without having its own netns, they can either move to netns 
>> (which I think it is a good thing to do) or use the 
>> traffic_monitor_start/stop() manually by changing the testing code,
>> or a better way is to ask test_progs do it for the host netns (init_netns) 
>> automatically for all tests in the libpcap.list.
> 
> Agree! I will start move some tests to netns, and use libpcap.list to
> enable them.

The tc_redirect test should be in netns already. It seems the select_reuseport 
and the sockmap_listen test, that this patchset is touching, are not in netns. I 
hope the netns migration changes should be obvious for them. Other than those 
two flaky tests, I would separate other netns moving work to another effort.

