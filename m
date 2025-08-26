Return-Path: <bpf+bounces-66592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8556B3739B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F11681F91
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A513635E;
	Tue, 26 Aug 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AstHThem"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407626B760
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238844; cv=none; b=H90ItBghPbefLngafJqNEQNRQyKHe3QOrFxNYjQFjbOYWduNamEQd6KywzMVFaQx4erU1F7reapAs+80KhRrAQsCW6aBE/7d1ObKbUfXpYuFh+P1Ep0/HuBcWc6kvefU9RfsTAE/XXHUNqoVS9UiNFhjGlq8oFVnr3PjfHpsa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238844; c=relaxed/simple;
	bh=dUOeQX3UH6Dnu9kzQfPGKmirvm0qPfIJbzYW1H/ZdVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ovb1xCEHF6BoscNK/0vZWrFCr7ssoorInbw4QhA0YgTSuhEhqzNeFo6Qnm2cV3BCP/29/1EQyKL6ejQGzeYnHbVeh4kPizhVLLVV7u/XdSsxAmmO2E+7jcKNeeLr+Oj+56weCetxU40DMYDgvd1/1z/sB1XdXN+TP0e9ZItI2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AstHThem; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2bac5d14-6927-4915-b1a8-e6301603e663@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756238828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGXPRwO1rOI8msO3ix26o5GQ8/9+pYzQdIxu50GTPWU=;
	b=AstHThem8edQWBRHUXeK+rTIFezkG7JWz5lqX4INtqKYOwPiCofiJv40HEs8sS2SuI5TS/
	ulfKU4LXDa8XO/kYDd9Wy/VF1UEAqv19jyQUT8/jmY3P3kBotpanxWz7Xwh1aXGu3uxBIC
	gSvRW1qTOoeih3jk62pRxRtZLVkyzvw=
Date: Tue, 26 Aug 2025 13:06:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in
 __inet_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: almasrymina@google.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, hannes@cmpxchg.org, john.fastabend@gmail.com,
 kuba@kernel.org, kuni1840@gmail.com, mhocko@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 roman.gushchin@linux.dev, sdf@fomichev.me, shakeel.butt@linux.dev,
 willemb@google.com
References: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
 <20250826002410.2608702-1-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250826002410.2608702-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/25/25 5:23 PM, Kuniyuki Iwashima wrote:
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Mon, 25 Aug 2025 16:14:35 -0700
>> On 8/25/25 11:14 AM, Kuniyuki Iwashima wrote:
>>> On Mon, Aug 25, 2025 at 10:57 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
>>>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>>>> index ae83ecda3983..ab613abdfaa4 100644
>>>>> --- a/net/ipv4/af_inet.c
>>>>> +++ b/net/ipv4/af_inet.c
>>>>> @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
>>>>>                 kmem_cache_charge(newsk, gfp);
>>>>>         }
>>>>>
>>>>> +     BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
>>>>> +
>>>>>         if (mem_cgroup_sk_enabled(newsk)) {
>>>>>                 int amt;
>>>>>
>>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>>>> index 233de8677382..80df246d4741 100644
>>>>> --- a/tools/include/uapi/linux/bpf.h
>>>>> +++ b/tools/include/uapi/linux/bpf.h
>>>>> @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
>>>>>         BPF_NETKIT_PEER,
>>>>>         BPF_TRACE_KPROBE_SESSION,
>>>>>         BPF_TRACE_UPROBE_SESSION,
>>>>> +     BPF_CGROUP_INET_SOCK_ACCEPT,
>>>>
>>>> Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED bit be
>>>> inherited from the listener?
>>>
>>> Since e876ecc67db80 and d752a4986532c , we defer memcg allocation to
>>> accept() because the child socket could be created during irq context with
>>> unrelated cgroup.  This had another reason; if the listener was created in the
>>> root cgroup and passed to a process under cgroup, child sockets would never
>>> have sk_memcg if sk_memcg was inherited.
>>>
>>> So, the child's memcg is not always the same one with the listener's, and
>>> we cannot rely on the listener's sk_memcg.
>>
>> I didn't mean to inherit the entire sk_memcg pointer. I meant to only inherit
>> the SK_BPF_MEMCG_SOCK_ISOLATED bit.
> 
> I didn't want to let the flag remain alone without accept() (error-prone
> but works because we always check mem_cgroup_from_sk() before the bit)
> and wanted to check mem_cgroup_sk_enabled() in setsockopt(), but if we
> don't care, it will be doable with other hooks, PASSIVE_ESTABLISHED_CB
> or bpf_iter etc.

I think this could be a surprise to the user. imo, this is the implementation 
details that a bit of a pointer is used for the setsockopt purpose and a right 
one for perf reason. It does not necessary need to affect what the user can 
expect from setsockopt in listener. From the user pov, what the user can usually 
expect from setsockopt in the listener and gets copied to child? Beside, the 
listener and the accept-or on different processes is one of the use case but not 
the only use case.

> 
> ---8<---
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a78356682442..9ef458fe706e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5269,7 +5269,7 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
>   
>   static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bool getopt)
>   {
> -	if (!mem_cgroup_sk_enabled(sk))
> +	if (!sk_has_account(sk))
>   		return -EOPNOTSUPP;
>   
>   	if (getopt) {
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index e92dfca0a0ff..efae15d04306 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -760,7 +760,10 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
>   	if (mem_cgroup_sockets_enabled &&
>   	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
>   	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
> +		unsigned short flags = mem_cgroup_sk_get_flags(newsk);
> +
>   		mem_cgroup_sk_alloc(newsk);
> +		mem_cgroup_sk_set_flags(newsk, flags);
>   		kmem_cache_charge(newsk, gfp);
>   	}
>   
> ---8<---
> 
> 
>>
>> If it can only be done at accept, there is already an existing
>> SEC("lsm_cgroup/socket_accept") hook. Take a look at
>> tools/testing/selftests/bpf/progs/lsm_cgroup.c. The lsm socket_accept doesn't
>> have access to the "newsock->sk" but it should have access to the "sock->sk", do
>> bpf_setsockopt and then inherit by the newsock->sk (?)
>>
>> There are already quite enough cgroup-sk style hooks. I would prefer not to add
>> another cgroup attach_type and instead see if some of the existing ones can be
>> reused. There is also SEC("lsm/sock_graft").
> 
> We need to do fixup below, so lsm_cgroup/socket_accept won't work
> if we keep the code in __inet_accept().  We can move this after
> lsm/sock_graft within __inet_accept().
> 
> if (mem_cgroup_sk_isolated(newsk))
> 	sk_memory_allocated_sub(newsk, amt);

If I read it correctly, lsm_cgroup/sock_graft should work but need to do the 
above sk_memory_allocated_sub() after the sock_graft and ...
  >
> But then, we cannot distinguish it with other hooks (lock_sock() &&
> sk->sk_socket != NULL), and finally the fixup must be done dynamically
> in setsockopt().

... need a way to disallow this SK_BPF_MEMCG_SOCK_ISOLATED bit being changed 
once the socket fd is visible to the user. The current approach is to use the 
observation in the owned_by_user and sk->sk_socket in the create and accept 
hook. [ unrelated, I am not sure about the owned_by_user check considering 
sol_socket_sockopt can be called from bh ].

If it is needed, there are other ways to stop the SK_BPF_MEMCG_SOCK_ISOLATED 
being changed again once the fd is visible to user. e.g. there are still bits 
left in the sk_memcg pointer to freeze it at runtime. If doing it statically 
(i.e. at prog load time), it can probably return a different setsockopt_proto 
that can understand the SK_BPF_MEMCG_FLAGS.

