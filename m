Return-Path: <bpf+bounces-37970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650B95D57D
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72D91C2248D
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA31191F62;
	Fri, 23 Aug 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2yFm2Qv"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295113634A
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438942; cv=none; b=oKb4kBTKC8cVNw1s+D74CI5u9DXwqbpSFsHlmq0AVbBpZu/A3ivXRmWJmJoUe+PGQJSnQ78VE2tlMph/TwSyEN8wOT7iw1RWG7Uv3ySO/qwUyVRaBKUE0HKqakKG6EoaqyD+2dCJGVTnU3hYq+7EFPLkYzve33sRgSaUjQHDdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438942; c=relaxed/simple;
	bh=TWL2MIVefQ12GZaOVVcxANHWJfwsKZKQd+xYbDghpiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtBgSOLxnhndHqbsNWUowWLE8wSvqZxVa4nyard63/7+6uNbms2EUUaJXqbAhgu6MUTmOvqxsWAppF7VMiUWFev5iYmYjZE1vpRedylHLsb5SojJmYdqv2AxBpddO9r4LPJ6XfEIr+BvrmQQFYq/uvRDVQvrX7qIlYKSo6u4byM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2yFm2Qv; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <173d3b06-57ed-4e2e-9034-91b99f41512b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724438937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kby6+9RbR1DnjNM7kKUPdGTyp1MYuWl6dZurQYumurk=;
	b=F2yFm2QvU5rc+5438dpysGUn5wuWo5E6kpKequitYiGHDDAdJf6n3IMxeof1Xb7/zufXQ9
	U4dvfko5NgzPYBaeVLGPJzjS0ZKaaEjOHRKWWyrHBGEKfxJujlUTxrbMy8JaFNzOAbLASG
	WaxOrtb0paeYf6nHQR60qaGU/1B/wEc=
Date: Fri, 23 Aug 2024 11:48:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not take
 effect when TCP over IPv4 via INET6 API
To: Eric Dumazet <edumazet@google.com>, Feng zhou <zhoufeng.zf@bytedance.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
 <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/23/24 6:35 AM, Eric Dumazet wrote:
> On Fri, Aug 23, 2024 at 10:53 AM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>>
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
>> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
>> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
>> use ip_queue_xmit, inet_sk(sk)->tos.
>>
>> So bpf_get/setsockopt needs add the judgment of this case. Just check
>> "inet_csk(sk)->icsk_af_ops == &ipv6_mapped".
>>
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp@intel.com/
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>> Changelog:
>> v1->v2: Addressed comments from kernel test robot
>> - Fix compilation error
>> Details in here:
>> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
>>
>>   include/net/tcp.h   | 2 ++
>>   net/core/filter.c   | 6 +++++-
>>   net/ipv6/tcp_ipv6.c | 6 ++++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 2aac11e7e1cc..ea673f88c900 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
>>                                              struct tcp_options_received *tcp_opt,
>>                                              int mss, u32 tsoff);
>>
>> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
>> +
>>   #if IS_ENABLED(CONFIG_BPF)
>>   struct bpf_tcp_req_attrs {
>>          u32 rcv_tsval;
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index ecf2ddf633bf..02a825e35c4d 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
>>                            char *optval, int *optlen,
>>                            bool getopt)
>>   {
>> -       if (sk->sk_family != AF_INET)
>> +       if (sk->sk_family != AF_INET
>> +#if IS_BUILTIN(CONFIG_IPV6)
>> +           && !is_tcp_sock_ipv6_mapped(sk)
>> +#endif
>> +           )
>>                  return -EINVAL;
> 
> This does not look right to me.
> 
> I would remove the test completely.
> 
> SOL_IP socket options are available on AF_INET6 sockets just fine.

Good point on the SOL_IP options.

The sk could be neither AF_INET nor AF_INET6. e.g. the bpf_get/setsockopt 
calling from the bpf_lsm's socket_post_create). so the AF_INET test is still needed.

Adding "&& sk->sk_family != AF_INET6" should do. From ipv6_setsockopt, I think 
it also needs to consider the "sk->sk_type != SOCK_RAW".

Please add a test in the next re-spin.

pw-bot: cr

