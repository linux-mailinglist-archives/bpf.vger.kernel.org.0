Return-Path: <bpf+bounces-73743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA11C38461
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F6B18C1532
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847E2F360B;
	Wed,  5 Nov 2025 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2yCQMVu"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2132E8DF5
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383559; cv=none; b=YCqbW0moYcOZIWyJ+GPjt8Cog28ZXcecjQiCxqNKUrM/1Du6r1Hs9jIl+Q8pYCP1ZasJjJqhqqZKtMiwD81VQKwsfEfrhLKoAGwlT3Kx9ZyuuH9MDCxCYW1u2cfoHQdj/vKomrR18QYmHawQyHufbWVJktYjo63/byTDfTSlN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383559; c=relaxed/simple;
	bh=CPuuHp7pZQpd6tLnAgipCfEtZDhJg4P3Ocuzr1bEB+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7NyGskmmyAGfJs3V5ObDf9NZxrvZ+Xrk7sPKt6tdbBgiPbUzpWysbAnsIGyK/uvn71l1YQz32GsM5llnqQilOypJVZCiBdvZ2o1CIjDGWJJSUbq4ZwJOlzjVUbC0mrLoYHdHehOv9WFgkt5rsNCwyWaC2uGODdsD1O1Xhtt2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2yCQMVu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfed97fb-4e0c-416e-b5d8-8de7b3edce69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762383544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcKXpeoIv1/TaQKBGE1ZFK7wbf9vgDzD2Za3TAGvfaM=;
	b=Y2yCQMVuM7M3fRc4/lPNcRrfzkGEF/duGONkbpEWwV1iIhPa/iBDnGssq3oIyH4LKxh7BO
	hp1b5OC38lLTfKRKnEzNcH9BMuxib+hMHUy1t0RBy4292BO6rwo4lxfwQ+fOTNwCRy/WEx
	K/PzfB19hcbeTw6TI/pkB50wxsI2NjU=
Date: Wed, 5 Nov 2025 14:58:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-3-alibuda@linux.alibaba.com>
 <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
 <20251105070140.GA31761@j66a10360.sqa.eu95>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251105070140.GA31761@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/4/25 11:01 PM, D. Wythe wrote:
> On Tue, Nov 04, 2025 at 04:03:46PM -0800, Martin KaFai Lau wrote:
>>
>>
>> On 11/2/25 11:31 PM, D. Wythe wrote:
>>> +#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>>> +#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
>>> +	typeof(init_val) __ret = (init_val);			\
>>> +	struct smc_hs_ctrl *ctrl;				\
>>> +	rcu_read_lock();					\
>>> +	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
>>
>> The smc_hs_ctrl (and its ops) is called from the netns, so the
>> bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a
>> netns has not been done before. More on this later.
>>
>>> +	if (ctrl && ctrl->func)					\
>>> +		__ret = ctrl->func(__VA_ARGS__);		\
>>> +
>>> +	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
>>> +		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
>>
>> ... so just pass tp instead of passing both sk and tp?
>>
>> [ ... ]
>>
> 
> You're right, it is a bit redundant. However, if we merge the parameters,
> every user of this macro will be forced to pass tp. In fact, we’re
> already considering adding some callback functions that don’t take tp as
> a parameter.

If the struct_ops callback does not take tp, then don't pass it to the
callback. I have a hard time to imagine why the bpf prog will not be
interested in the tp/sk pointer though.

or you meant the caller does not have tp? and where is the future caller?
> 
> I’ve been considering this: since smc_hs_ctrl is called from the netns,
> maybe we should replace the sk parameter with netns directly. After all,
> the only reason we pass sk here is to extract sock_net(sk). Doing so
> would remove the redundancy and also keep the interface more flexible
> for future extensions. What do you think?

The net can be obtained from the tp also.

Like in this patch, all the caller needs to type
"const struct sock *sk = &tp->inet_conn.icsk_inet.sk;". I can imagine all
the callers will have to type "sock_net((struct sock *)tp)" if passing net.
Why not just do that in the smc_hs_ctrl instead of asking all the callers
to type that?

I meant something like this (untested):

-#define smc_call_hsbpf(init_val, sk, func, ...) ({             \
+#define smc_call_hsbpf(init_val, func, tp, ...) ({             \
	typeof(init_val) __ret = (init_val);                    \
	struct smc_hs_ctrl *ctrl;                               \
	rcu_read_lock();                                        \
-	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);      \
+	ctrl = rcu_dereference(sock_net((struct sock *)(tp))->smc.hs_ctrl);     \
	if (ctrl && ctrl->func)                                 \
-		__ret = ctrl->func(__VA_ARGS__);                \
+		__ret = ctrl->func(tp, ##__VA_ARGS__);          \
	rcu_read_unlock();                                      \
	__ret;                                                  \
  })




