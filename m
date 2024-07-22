Return-Path: <bpf+bounces-35228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD5938FA7
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 15:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22C1B214D7
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5716D4EF;
	Mon, 22 Jul 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZZp/i1w3"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6652CA9;
	Mon, 22 Jul 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653679; cv=none; b=rrx7OgI1NQoAEMglKi0T4sTkEuEz/bIgx1DHD7hAwCFKek8X2NEADlob485KmphBCeJ0GihI82mwOS2XDNQgQBFkVZWrYOLrQ0um9pH6HhxOHCQ1a7TAJsPPAhgXla5MyLBRF7O1ov/w0JR+Hc/2+08JsQKAcpXOIguaRYwSM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653679; c=relaxed/simple;
	bh=Uw11ghWtGcb/6jiAOupVhzJiIFXMPpdpF9ha/ad7YSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTeOU2+igekr6NHuy74SAKMfqhxPzkkmP+kK7aTISmCYInVE/kjU60vTwtKroU+hqJxsAsg/FQSLXo1A2d/iNXAdUUkOFWAsqQEho9g/Pz/0ujNFXtRZuv5Y7bnTnPP3zwEZvdBEDIX9SARTJ2j7sdGUSLir4OBhD6QlQ02KuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZZp/i1w3; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sVslS-003B73-91; Mon, 22 Jul 2024 15:07:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=bri2wuhlUEm/441BOec90m5Wqnh2/H0HfDK6rXwOUyY=; b=ZZp/i1w3EoRVxSUx7JWLM3ffvD
	7kFjoSGQJZ1bOXzG94k1K78VYA5QwHedLb5Ca5J0GovDz93uwINwddTGGf7wzpU4ws/GyTdpKJJQn
	V16WLaSa5LsVATwWgcb09wW/jvRJN+zmIe1tLCi+Y5/Mv5bHuPAtjkroUHaGh/2GzJRZ1XuKtqFmF
	wwWN9JHnpDZCe1+ut+CNzDkGw9GzQJDAuUMFChRK7E0ekPI+HHhvGCB4s5NtK0WpL7ewAYefMrFeb
	FEQ587xBYFHN/qrsKDZqfWFg8+fMlCLH3y+DhFZr2PolTm+UZFRU2C2vvhO4pEozvIzoATpT3tAob
	bshGqhGw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sVslQ-0000he-P7; Mon, 22 Jul 2024 15:07:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sVslG-00A87R-60; Mon, 22 Jul 2024 15:07:30 +0200
Message-ID: <027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co>
Date: Mon, 22 Jul 2024 15:07:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
 <87ikx962wm.fsf@cloudflare.com>
 <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
 <87sew57i4v.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87sew57i4v.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/24 13:09, Jakub Sitnicki wrote:
> On Wed, Jul 17, 2024 at 10:15 PM +02, Michal Luczaj wrote:
>> On 7/13/24 11:45, Jakub Sitnicki wrote:
>>> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>>>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>>>> @type ignored, too.  Same treatment?
>>>
>>> That one will not be a trivial fix like this case. inet_socketpair()
>>> won't work for TCP as is. It will fail trying to connect() a listening
>>> socket (p0). I recall now that we are in this state due to some
>>> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
>>> inet in some function names").
>>> [...]
>>
>> Is this what you've meant? With this patch inet_socketpair() and
>> vsock_socketpair_connectible can be reduced to a single call to
>> create_pair(). And pairs creation in inet_unix_redir_to_connected()
>> and unix_inet_redir_to_connected() accepts both sotypes.
> 
> Yes, exactly. This looks great.

Happy to hear that. I'll prepare a series, include the little fixes and
send it out for a proper review.

One more thing: I've noticed changes in sockmap_helpers.h don't trigger
test_progs rebuild (seems to be the case for all .h in prog_tests/). No
idea if this is the right approach, but adding
"$(TRUNNER_TESTS_DIR)/sockmap_helpers.h" to TRUNNER_EXTRA_SOURCES in
selftests/bpf/Makefile does the trick.

> Classic cleanup with goto to close sockets is all right, but if you're
> feeling brave and aim for something less branchy, I've noticed we have
> finally started using __attribute__((cleanup)):
> 
> https://elixir.bootlin.com/linux/v6.10/source/tools/testing/selftests/bpf/progs/iters.c#L115

I've tried. Is such "ownership passing" (to inhibit the cleanup) via
construct like take_fd()[1] welcomed?

[1] https://lore.kernel.org/all/20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org/

static inline void close_fd(int *fd)
{
	if (*fd >= 0)
		xclose(*fd);
}

#define __closefd __attribute__((cleanup(close_fd)))

static inline int create_pair(int family, int sotype, int *c, int *p)
{
	struct sockaddr_storage addr;
	socklen_t len = sizeof(addr);
	int err;

	int s __closefd = socket_loopback(family, sotype);
	if (s < 0)
		return s;

	err = xgetsockname(s, sockaddr(&addr), &len);
	if (err)
		return err;

	int s0 __closefd = xsocket(family, sotype, 0);
	if (s0 < 0)
		return s0;

	err = connect(s0, sockaddr(&addr), len);
	if (err) {
		if (errno != EINPROGRESS) {
			FAIL_ERRNO("connect");
			return err;
		}

		err = poll_connect(s0, IO_TIMEOUT_SEC);
		if (err) {
			FAIL_ERRNO("poll_connect");
			return err;
		}
	}

	switch (sotype & SOCK_TYPE_MASK) {
	case SOCK_DGRAM:
		err = xgetsockname(s0, sockaddr(&addr), &len);
		if (err)
			return err;

		err = xconnect(s, sockaddr(&addr), len);
		if (err)
			return err;

		*p = take_fd(s);
		break;
	case SOCK_STREAM:
	case SOCK_SEQPACKET:
		*p = xaccept_nonblock(s, NULL, NULL);
		if (*p < 0)
			return *p;
		break;
	default:
		FAIL("Unsupported socket type %#x", sotype);
		return -EOPNOTSUPP;
	}

	*c = take_fd(s0);
	return err;
}


