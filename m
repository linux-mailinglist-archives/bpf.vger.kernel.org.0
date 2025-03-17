Return-Path: <bpf+bounces-54174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6EA64826
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1E73B3D32
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F2722ACDA;
	Mon, 17 Mar 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LhbTY4eW"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E982D98;
	Mon, 17 Mar 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205126; cv=none; b=Y5W8KH644LIeMKRHMvoAECNtCT7nG6/6bN4Ze8ZlRITRJg9hKcPSK9XqToSrLPTVvv4vRwwS0cN4u+jXWI1JnpJRc+xWihJWE0yzMHsKVHTuy6tjziPwTsS8SK3DiXc1s7Sv5RJxI1hPp5fZIaMcvKt4KgxEu+QkSFKrRieVO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205126; c=relaxed/simple;
	bh=RQlN4PHT9t/BaZ1ZSO4BH6eUUyXAz56KtVwjMkjqBWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYfybW3SIg+95JyBfOp3nA2iFYaN7uhdiYYWqpEfU+5BZ337KdHCMTld8b7LijI5o+vKHNzj0/mklzqkMPR4UwYJTIpYM9JI527SM6+IrrBheTtSPmqPKjNLYBBxM/ljxn5legeCcJoy7rBW1tHkt6DyoMicLTJPHBdECDbE/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LhbTY4eW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tu78P-00Dms8-A3; Mon, 17 Mar 2025 10:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=fVP4auPXeZ1wxgMxif41gK7AYDaPeOrAkaHk042YAE4=; b=LhbTY4eWbI+zGFZbmiLECfoOwY
	vDpT1/PVIxRBFRTzkeix8eRzEWgT1kzSQfIQrdcEKpRH5Mqo22BL5oIDR8jqog5eJX9nJougQORCv
	Xn7YlK2iEz8jldpNM9uywGbIkcKoT1eBEcQNIPIVzwxtZyfXB9QIETfvM02VKSX2Hi6njygAcr5y7
	HLGyM8SRnAEptvT+4ureNLQvwCdWM6xs1ZRTi8h+EeWJ8PRMBKkxQ0Mf9u1HyiC5Dg29NReZgdk2X
	D2HmZU25L5FK7fN2iXwlWy7u/v0DkKlEIHtv+zg3s2J6rgASlL37ap6FDhB+eoyArbkiEx8tZt2ae
	MkFQejcg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tu78N-0006il-JQ; Mon, 17 Mar 2025 10:51:47 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tu78F-00DHyx-Ed; Mon, 17 Mar 2025 10:51:39 +0100
Message-ID: <67a1ae27-84c1-4a5c-9178-a29276d6ab52@rbox.co>
Date: Mon, 17 Mar 2025 10:51:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
To: Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
 <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
 <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 09:23, Paolo Abeni wrote:
> On 3/16/25 11:45 PM, Michal Luczaj wrote:
>> Racing signal-interrupted connect() and sockmap update may result in an
>> unconnected (and missing vsock transport) socket in a sockmap.
>>
>> Test spends 2 seconds attempting to reach WARN_ON_ONCE().
>>
>> connect
>>   / state = SS_CONNECTED /
>>                                 sock_map_update_elem
>>   if signal_pending
>>     state = SS_UNCONNECTED
>>
>> connect
>>   transport = NULL
>>                                 vsock_bpf_recvmsg
>>                                   WARN_ON_ONCE(!vsk->transport)
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> This is apparently causing some bpf self-test failure. (Timeout? the
> self-test failure output is not clear to me.)
> 
> Could you please have a look?

Sending signal to the whole process group probably isn't the best idea. Not
sure how the previous version passed though.
Sorry, v4 incoming.

Michal


