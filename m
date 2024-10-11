Return-Path: <bpf+bounces-41677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8E9999C8
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDA285288
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83012E5B;
	Fri, 11 Oct 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mdkytAbu"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BA15E97;
	Fri, 11 Oct 2024 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611195; cv=none; b=KhlboRMNrfl75/kXbrt79rr7XFkW/y/xDWTyZnaSuI8g7ZkrouWcC+J+0XU8W9goOK8aFTNo2NfcMPgYU9bM5boPeS7evCI0D3RNYltM/Cs57/bvtI9q01l2LfWConYv9UNmz/uNX0Zn3rxWCczsWKOoyjC5Tv5j3WjULdtH/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611195; c=relaxed/simple;
	bh=V1ex6JnBkyArAbLsBg6zh29Yuy7ncQOxbLp2XoOjxBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwLJx0YohdTeCmm9hrm2/Cw1r9KIiFEm/vpKECM7IOg3HgtKgNtaYQhSyKW8oiCoKTGy6WLIy++t/lO18VmTkotC8YrPXZ6dA/gD3qI2qEtvKRr6R0YqnwHaoWxTP9cFn/lt+vsQK5c4bCiCNjoUvpmCl2HrHjqTr0cDWXBmgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mdkytAbu; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728611190; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Aq/pEFbbDoLqCT/1dwacA/sA0zk+kGqwRRgdCZkAyoE=;
	b=mdkytAbu6v/wvF9I+pbuiuFJMO6APMDlQ1Q1DOAAkJEzPHrtmarbB7Dk9JlT7WRo3S0dS6wrVqfncDBHQ0i5LO0ihO9vYXCKcYOXMdcSZsFy7S6tLuJ3LGPpX6IM99sf7C0VDc1ki0RHa7qBRdDhft/4mFJdcslDT7neSzn7lGg=
Received: from 30.221.128.133(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGo3O4w_1728611189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 09:46:29 +0800
Message-ID: <76395c99-a656-42c0-a004-b5e8db241ed0@linux.alibaba.com>
Date: Fri, 11 Oct 2024 09:46:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add rcu ptr in btf_id_sock_common_types
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008080916.44724-1-lulie@linux.alibaba.com>
 <80cb3d4b-cebb-4f08-865d-354110a54467@linux.dev>
 <2e3f676a-ef03-4618-852d-ceb3b620a640@linux.alibaba.com>
 <7b090ca5-7997-4371-8d79-7862a7e27052@linux.dev>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <7b090ca5-7997-4371-8d79-7862a7e27052@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/11 06:07, Martin KaFai Lau wrote:
> On 10/8/24 7:23 PM, Philo Lu wrote:
>>
>>
>> On 2024/10/9 03:05, Martin KaFai Lau wrote:
>>> On 10/8/24 1:09 AM, Philo Lu wrote:
>>>> Sometimes sk is dereferenced as an rcu ptr, such as skb->sk in tp_btf,
>>>> which is a valid type of sock common. Then helpers like bpf_skc_to_*()
>>>> can be used with skb->sk.
>>>>
>>>> For example, the following prog will be rejected without this patch:
>>>> ```
>>>> SEC("tp_btf/tcp_bad_csum")
>>>> int BPF_PROG(tcp_bad_csum, struct sk_buff* skb)
>>>> {
>>>>     struct sock *sk = skb->sk;
>>>>     struct tcp_sock *tp;
>>>>
>>>>     if (!sk)
>>>>         return 0;
>>>>     tp = bpf_skc_to_tcp_sock(sk);
>>>
>>> If the use case is for reading the fields in tp, please use the 
>>> bpf_core_cast from the libbpf's bpf_core_read.h. bpf_core_cast is 
>>> using the bpf_rdonly_cast kfunc underneath.
>>>
>>
>> Thank you! This works for me so this patch is unnecessary then.
>>
>> Just curious is there any technical issue to include rcu_ptr into 
>> btf_id_sock_common_types? AFAICT rcu_ptr should also be a valid ptr 
>> type, and then btf_id_sock_common_types will behave like 
>> (PTR_TO_BTF_ID + &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON]) in 
>> bpf_func_proto.
> 
> bpf_skc_to_*() returns a PTR_TO_BTF_ID which can be passed into other 
> helpers that takes ARG_PTR_TO_BTF_ID_SOCK_COMMON. There are helpers that 
> change the sk. e.g. bpf_setsockopt() changes the sk and needs sk to be 
> locked. Other non tracing hooks do have a hold on the skb also. I did 
> take a quick look at the bpf_setsockopt situation and looks ok. I am 
> positive there are other helpers that need to audit first.
> 
> Tracing use case should only read the sk. bpf_core_cast() is the correct 
> one to use. The bpf_sk_storage_{get,delete}() should be the only allowed 
> helper that can change the sk.

Thank you for explanation, Martin. This helps me a lot.
-- 
Philo


