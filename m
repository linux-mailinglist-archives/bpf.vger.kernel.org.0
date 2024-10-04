Return-Path: <bpf+bounces-40913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E429198FCC5
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 06:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0651C222BD
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7A73466;
	Fri,  4 Oct 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cif02BMw"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EC43ADE
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017111; cv=none; b=N4RidX0O3+l7gFUf66GPdj7xgIDrZa14bpY2uLPndy7IKmrvcsKA6AWk2x6XjeBcE8ama3Giqa0ImqIjbvivGtf+u9E+fLz1Fiwahm47U5QpipksEZbpUwXwA1VHWgXMKTUd63XTcnFuhldHiqSTfK++ZFzGORcpQWfuGisqvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017111; c=relaxed/simple;
	bh=VmwvU0W4CbtoHjdtRtYbUa1zfcrUwdOCsDV5l+mX1gQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MqvurnnD2XGkMk8kVu1LFt1ZDjgvjLqYHxMdg3zOwgWW4tFtJJ5Jwq8aoZ83e5yOv19ryz9rb99l5+ZpOnk7xmJ/SaVHdgxkwRvyRzEv9j91rrsqS/3nWbXMiUUQifEYlQAlS4GKrCawlhFTI1NVk/JR67VYyunt6e+gBPsf9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cif02BMw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d23b607-b6d6-4074-8778-c50bf3bd0b91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728017103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytssWJLKmXIWXSrDg9ABlNpbkQhbsJOWwycT6PoQRhQ=;
	b=cif02BMw0GzdjzhEZDwFVDFEIppcN7DFA9RB7RJTWvYL/k1JyQxwrtdZ3o/ht160Nnev2+
	MjCoa0xOwItozXfUK1vw63f/lurOBt0ZK2wv8UaJ7r97F1YtJeztgwwIFJKN+I4FgTXwUS
	D5qe/rCsFpIY8ITEVkZkD1Gqg0UU6Go=
Date: Thu, 3 Oct 2024 21:44:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev> <ZuVWmxoqXFI3qvVI@lore-desk>
 <20240914063828.7bd73c5e@kernel.org>
 <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
 <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
Content-Language: en-US
In-Reply-To: <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/24/24 6:37 PM, Martin KaFai Lau wrote:
> There are other .sh tests that could better use the test_progs migration. In 
> particular the ones without existing test coverage. For non XDP related, 
> test_tcp_check_syncookie.sh, test_flow_dissector.sh, and test_tc_edt.sh should 
> be the good ones.

I just took a closer look at the test_tc_edt.* for another reason. It seems 
doing some bandwidth test which may not be a good fit (e.g. too flaky) for 
test_progs. I would leave it to the bottom of the todo list for now.

> 
> For XDP, test_xdp_meta.sh should be useful also. You may also want to check the 
> test_xdp_redirect_*.sh.
> 
>> processes and tcp/udp channels involved), but if keeping the standalone version
>> is really needed, I can give a try. Does it sound reasonable ?
>> - one part of my overall goal is to clean up the tools/testing/selftests/bpf
>> directory from anything that is not tested automatically. What should we do with
>> the wrapping shell script (test_xdp_features.sh) ? Since test_progs will
>> automate the test with veths, I guess it is still ok to just remove it ?
>>
>>> No preference but just to raise awareness - drivers/net's NetDrvEpEnv
>>> class provides the setup for running tests with an endpoint.
>>> XDP tests intended for HW would fit there pretty well.
>>
>> Thanks for the hint. If we want to keep some tooling for real hw xdp features
>> testing, maybe we could add a small part in tools/testing/selftests/drivers/net
>> and make it use this NetDrvEpEnv ? Or it is a bigger hint that the whole test
>> about xdp features could be moved there (and then tested by net kselftests
>> rather than by ebpf ci specifically) ? @Lorenzo and eBPF tests maintainers, any
>> opinion ?
>>
>> Thanks,
>>
>> Alexis
>>
> 
> 


