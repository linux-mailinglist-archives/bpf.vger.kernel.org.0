Return-Path: <bpf+bounces-65844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D50B29730
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A666D189969E
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A825A347;
	Mon, 18 Aug 2025 03:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EB25A2CD;
	Mon, 18 Aug 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486005; cv=none; b=NZBty2sEjTzr6h1DiuMy6no5y83wkX85jjT2AhxeBp77mx2UohTGqnOt1fMxGHdUx8xPoahh63GKgCyUtsbYHZjZAG6Y7vw4AC4YmRbK7QcRU5aPAqSfuMxu6eZb6TSEwDnIWCZGgE9FiYxj7obnv9GeKYEqz1ipDGN6yuL9u3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486005; c=relaxed/simple;
	bh=bQlXvockhKFH3O7EY/UuSs9p6fvQc7UsNhVlF3281uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9TqFKNYwnhEGNR+4F1q4Jw48MX25hZmeNBwSrc/ontwQIP5QyTvWCXRhWw6IJLGJzGiRfDn98IwE8L2dk04UqoQPYcSSzfYfS2HK+W7bhKKpMffY4vKxpQh5MhUVHpXo8ZFCXiuN/yBu741Oeyrc/lLsqK/jvw7AxV+q49UZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <daniel@iogearbox.net>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<eddyz87@gmail.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<martin.lau@linux.dev>, <sdf@fomichev.me>, <song@kernel.org>,
	<wangfushuai@baidu.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf] bpf: Use cpumask_next_wrap() in get_next_cpu()
Date: Mon, 18 Aug 2025 10:58:51 +0800
Message-ID: <20250818025851.21413-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <75cd7b00-53b6-496f-a934-339eed8f9a72@iogearbox.net>
References: <75cd7b00-53b6-496f-a934-339eed8f9a72@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

>> Replace the manual sequence of cpumask_next() and cpumask_first()
>> with a single call to cpumask_next_wrap() in get_next_cpu().
>> 
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>> ---
>>   kernel/bpf/bpf_lru_list.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index 2d6e1c98d8ad..34881f4da8ae 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
>> @@ -21,10 +21,7 @@
>>   
>>   static int get_next_cpu(int cpu)
>>   {
>> -	cpu = cpumask_next(cpu, cpu_possible_mask);
>> -	if (cpu >= nr_cpu_ids)
>> -		cpu = cpumask_first(cpu_possible_mask);
>> -	return cpu;
>> +	return cpumask_next_wrap(cpu, cpu_possible_mask);
>>   }
> 
> Lets then get rid of the get_next_cpu() function since its only used
> once, and just use the cpumask_next_wrap() at call site ?
> 
> [...]
>                  raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> 
>                  steal = cpumask_next_wrap(steal, cpu_possible_mask);
>          } while (!node && steal != first_steal);
> [...]
>
 
Thank you for your suggestion.

> Btw, in $subj please target [PATCH bpf-next] given its a cleanup,
> not a fix.

I will send a v2 shortly.

Regards,
Wang.

