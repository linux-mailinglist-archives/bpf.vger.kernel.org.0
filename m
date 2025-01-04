Return-Path: <bpf+bounces-47863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F49A01186
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 02:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F7164B72
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705DD54728;
	Sat,  4 Jan 2025 01:30:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43635280
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735954213; cv=none; b=nZpW2VGuCmuX7vPR7jQPdV2Na3XzJC+Ntjky0+0iJihBMlNCZogulloVD4PmNRQpA0h3O7woYKY71XlvcnCUCYjzM3BHLmt7UeCwpSqUOnjgEwOZy4EWZImPU3oL2DEaNfbaIa4U1Hwxe1buUZTwUSQ/ugki+njpk0ZlsfpDbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735954213; c=relaxed/simple;
	bh=3jpKNd1eOMPHbFypCrNrNadVJ9sT+e0TSmxcQzBwMKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/oG5PQ9rkZvIbgCjE0ktHYT/6ylGzB0dYP363r+zLokC+Vz5CH42sSzh+Y0pdE6hOUDUg4VEtLGg9MPErGPl9g1OfbFWwT9V9GcGLT2tvtAf2P0OhXYAMh1gQjMvlAVdAXjTPKpRqnlf/gis7OIDCiDSS5EEE+97liXFdoGWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YQ2tJ55y9z4f3lW6
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 09:29:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E2D561A0FC0
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 09:30:05 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgAnz7Acj3hnea1RGQ--.30931S2;
	Sat, 04 Jan 2025 09:30:05 +0800 (CST)
Message-ID: <4c501274-69fc-43d8-a9e7-fe6209d5c869@huaweicloud.com>
Date: Sat, 4 Jan 2025 09:30:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Move out synchronize_rcu_tasks_trace from
 mutex CS
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jann Horn <jannh@google.com>, Pu Lehui <pulehui@huawei.com>
References: <20241231033509.349277-1-pulehui@huaweicloud.com>
 <Z3gAxZTJTYngLnYi@krava>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <Z3gAxZTJTYngLnYi@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnz7Acj3hnea1RGQ--.30931S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5JF4rWr4xXFWxZr4fXwb_yoW5Kw4DpF
	WDGFZ0kr4UXr4jqws5Zr13u345C3yvqrZ8Wan8Ja4F9ryjgrZYgF1DGF4Ygr1F9rWUGFyI
	qw1jqrnrGFWjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/1/3 23:22, Jiri Olsa wrote:
> On Tue, Dec 31, 2024 at 03:35:09AM +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
>> RCU flavors") resolved a possible UAF issue in uprobes that attach
>> non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
>> period. But, in the current implementation, synchronize_rcu_tasks_trace
>> is included within the mutex critical section, which increases the
>> length of the critical section and may affect performance. So let's move
>> out synchronize_rcu_tasks_trace from mutex CS.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   kernel/trace/bpf_trace.c | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 48db147c6c7d..30ef8a6f5ca2 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2245,12 +2245,15 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>>   {
>>   	struct bpf_prog_array *old_array;
>>   	struct bpf_prog_array *new_array;
>> +	struct bpf_prog *prog;
>>   	int ret;
>>   
>>   	mutex_lock(&bpf_event_mutex);
>>   
>> -	if (!event->prog)
>> -		goto unlock;
>> +	if (!event->prog) {
>> +		mutex_unlock(&bpf_event_mutex);
>> +		return;
>> +	}
>>   
>>   	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
>>   	if (!old_array)
>> @@ -2265,6 +2268,11 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>>   	}
>>   
>>   put:
>> +	prog = event->prog;
>> +	event->prog = NULL;
>> +
>> +	mutex_unlock(&bpf_event_mutex);
>> +
>>   	/*
>>   	 * It could be that the bpf_prog is not sleepable (and will be freed
>>   	 * via normal RCU), but is called from a point that supports sleepable
>> @@ -2272,11 +2280,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>>   	 */
>>   	synchronize_rcu_tasks_trace();
>>   
>> -	bpf_prog_put(event->prog);
>> -	event->prog = NULL;
>> -
>> -unlock:
>> -	mutex_unlock(&bpf_event_mutex);
>> +	bpf_prog_put(prog);
>>   }
>>   
>>   int perf_event_query_prog_array(struct perf_event *event, void __user *info)
>> -- 
>> 2.34.1
>>
> 
> would something like below be simpler? (not tested)
> 
> jirka
> 
> 
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 973104f861e9..a4c0efa3a26e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2246,6 +2246,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>   {
>   	struct bpf_prog_array *old_array;
>   	struct bpf_prog_array *new_array;
> +	struct bpf_prog *prog = NULL;
>   	int ret;
>   
>   	mutex_lock(&bpf_event_mutex);
> @@ -2266,18 +2267,22 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>   	}
>   
>   put:
> -	/*
> -	 * It could be that the bpf_prog is not sleepable (and will be freed
> -	 * via normal RCU), but is called from a point that supports sleepable
> -	 * programs and uses tasks-trace-RCU.
> -	 */
> -	synchronize_rcu_tasks_trace();
> -
> -	bpf_prog_put(event->prog);
> +	prog = event->prog;
>   	event->prog = NULL;
>   
>   unlock:
>   	mutex_unlock(&bpf_event_mutex);
> +
> +	if (prog) {
> +		/*
> +		 * It could be that the bpf_prog is not sleepable (and will be freed
> +		 * via normal RCU), but is called from a point that supports sleepable
> +		 * programs and uses tasks-trace-RCU.
> +		 */
> +		synchronize_rcu_tasks_trace();
> +
> +		bpf_prog_put(prog);
> +	}
>   }
>   
>   int perf_event_query_prog_array(struct perf_event *event, void __user *info)

Thanks for review. It looks better, will send it soon.


