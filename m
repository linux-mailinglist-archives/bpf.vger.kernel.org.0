Return-Path: <bpf+bounces-66475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8396DB34FA0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F853A66E8
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4C2C0F6F;
	Mon, 25 Aug 2025 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cpf/btbt"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D71E32DB
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163699; cv=none; b=BuGtWQVA/6PhSiRnGTja5emwmgWApqcAOUaPV1TBtpkbjdhO5eQ/5m+pyRVyxhuKe2v1ji7s2nRP5lk1X+PlnKdC4PhLU3e7NaqY6Kmjy5rv5itq5bCwVi5VKLaOZAfIgtJLtB8OrBkTert+DDD+iS+3t2DvKL2lX11PXLwKSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163699; c=relaxed/simple;
	bh=LmSiDwcMgQKxO34arUC6nj7eXbX5FH5joo+FB1ueHu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W88y57+eCzj4XbUBhofYN5079d739mCtVNeEoVd9CNpBdAhC8LoVFBQh4CDSQ4AsF0vr/3A5stA8B5RQo4uPTXSn5TsZ+xYMsLJUyAE4lcwqxiZ69Yyaj/qzC0pJxSzPYv/X+QrGVSFjTD5tgF5kWTxbvXrSA9Te7W73oDdNpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cpf/btbt; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756163684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldnAJsm7Vh9h0iyz9zBqvXyPfBR7apAayjwl7UWt4UI=;
	b=Cpf/btbt8uMGuiMspAtfSFgMpqPGrMg2jYgRj8l2CB3xPx172KkLPA+GYlpdWal6HqStRX
	TGlIylV2i+Um94TLdt8Zzg9asS4vlp+zVWfaKTQMpSyWERB8rafqu9MV4B7DM9I2onrHe+
	Zg2XPOclYNuxOMuCeLjY+Oi6VAc3ZSE=
Date: Mon, 25 Aug 2025 16:14:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in
 __inet_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250822221846.744252-1-kuniyu@google.com>
 <20250822221846.744252-3-kuniyu@google.com>
 <daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev>
 <CAAVpQUDUULCrcTP4AQ31B5bfo-+dtw3H8CQGq9_SQ7d28xXSvA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUDUULCrcTP4AQ31B5bfo-+dtw3H8CQGq9_SQ7d28xXSvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/25/25 11:14 AM, Kuniyuki Iwashima wrote:
> On Mon, Aug 25, 2025 at 10:57 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>> index ae83ecda3983..ab613abdfaa4 100644
>>> --- a/net/ipv4/af_inet.c
>>> +++ b/net/ipv4/af_inet.c
>>> @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
>>>                kmem_cache_charge(newsk, gfp);
>>>        }
>>>
>>> +     BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
>>> +
>>>        if (mem_cgroup_sk_enabled(newsk)) {
>>>                int amt;
>>>
>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>> index 233de8677382..80df246d4741 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
>>>        BPF_NETKIT_PEER,
>>>        BPF_TRACE_KPROBE_SESSION,
>>>        BPF_TRACE_UPROBE_SESSION,
>>> +     BPF_CGROUP_INET_SOCK_ACCEPT,
>>
>> Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED bit be
>> inherited from the listener?
> 
> Since e876ecc67db80 and d752a4986532c , we defer memcg allocation to
> accept() because the child socket could be created during irq context with
> unrelated cgroup.  This had another reason; if the listener was created in the
> root cgroup and passed to a process under cgroup, child sockets would never
> have sk_memcg if sk_memcg was inherited.
> 
> So, the child's memcg is not always the same one with the listener's, and
> we cannot rely on the listener's sk_memcg.

I didn't mean to inherit the entire sk_memcg pointer. I meant to only inherit 
the SK_BPF_MEMCG_SOCK_ISOLATED bit.

If it can only be done at accept, there is already an existing 
SEC("lsm_cgroup/socket_accept") hook. Take a look at 
tools/testing/selftests/bpf/progs/lsm_cgroup.c. The lsm socket_accept doesn't 
have access to the "newsock->sk" but it should have access to the "sock->sk", do 
bpf_setsockopt and then inherit by the newsock->sk (?)

There are already quite enough cgroup-sk style hooks. I would prefer not to add 
another cgroup attach_type and instead see if some of the existing ones can be 
reused. There is also SEC("lsm/sock_graft").

