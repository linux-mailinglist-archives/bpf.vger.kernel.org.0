Return-Path: <bpf+bounces-35804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9593DD42
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 06:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C5F1F234B0
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32C179A3;
	Sat, 27 Jul 2024 04:36:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295D2F2F;
	Sat, 27 Jul 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722054990; cv=none; b=q6kgJjkDuFFgdpzISKRp9BSnnE/CgLIlrqft/ALpGA5NrTE0u4bJvMef8icRTupXANR3qWru3+Fh2PVzrWI7JROUXxWAqJpvd3ow1nDmSh6twfzypVhK7IqTIXDbyN0mYFU+6Oc/3x599lyYUHstz+mOiMZivwtahJyW2TFw1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722054990; c=relaxed/simple;
	bh=+qxr+MmwJA4pD8/vtf0lGZ6jMOxTY7GW1bblbLD+OQ8=;
	h=From:Subject:To:References:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lkqFo1c/rmf7naQFB92n3u22+FJZO+qFscYNLCX2l4RuqjtCj17foHJNc5Aqizd2unbachkrtR8sTnB23td6foN6FKlrjOoDCxez2QETioAwUngFZuugEG61lxSwGvlRXN0+CGSyH63/L10mN3Hy2l+ymCx2TLMgvp36Y9svR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WWBdh3XHyz4f3jjy;
	Sat, 27 Jul 2024 12:36:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ED1211A0568;
	Sat, 27 Jul 2024 12:36:16 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBnBXc8eaRm+4r4BA--.1299S2;
	Sat, 27 Jul 2024 12:36:16 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH] bpf, cpumap: Fix use after free of bpf_cpu_map_entry in
 cpu_map_enqueue
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 Radoslaw Zielonek <radoslaw.zielonek@gmail.com>, yonghong.song@linux.dev
References: <20240726180157.1065502-2-radoslaw.zielonek@gmail.com>
 <87h6ccnft1.fsf@toke.dk>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <65fe18d2-bd9c-7d0e-0f15-c7dd855644d5@huaweicloud.com>
Date: Sat, 27 Jul 2024 12:36:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87h6ccnft1.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBnBXc8eaRm+4r4BA--.1299S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWrGw1DZryrGFW7WrWrAFb_yoWrJry8pF
	4DtFyxGr48JrWjka4rZw1UAF1Iyw1vqw4rG34rKa48J3ZxWr93GFykKFZrZFy5urs5uF43
	Xr4qqrW8uayqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU0s2-5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 7/27/2024 2:55 AM, Toke Høiland-Jørgensen wrote:
> Radoslaw Zielonek <radoslaw.zielonek@gmail.com> writes:
>
>> When cpu_map has been redirected, first the pointer to the
>> bpf_cpu_map_entry has been copied, then freed, and read from the copy.
>> To fix it, this commit introduced the refcount cpu_map_parent during
>> redirections to prevent use after free.
>>
>> syzbot reported:
>>
>> [   61.581464][T11670] ==================================================================
>> [   61.583323][T11670] BUG: KASAN: slab-use-after-free in cpu_map_enqueue+0xba/0x370
>> [   61.585419][T11670] Read of size 8 at addr ffff888122d75208 by task syzbot-repro/11670
>> [   61.587541][T11670]
>> [   61.588237][T11670] CPU: 1 PID: 11670 Comm: syzbot-repro Not tainted 6.9.0-rc6-00053-g0106679839f7 #27
>> [   61.590542][T11670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.1 11/11/2019

SNIP
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index a8e34416e960..0034a6d423b6 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -59,6 +59,9 @@ struct bpf_cpu_map_entry {
>>  	u32 cpu;    /* kthread CPU and map index */
>>  	int map_id; /* Back reference to map */
>>  
>> +	/* Used to end ownership transfer transaction */
>> +	struct bpf_map *parent_map;
>> +
>>  	/* XDP can run multiple RX-ring queues, need __percpu enqueue store */
>>  	struct xdp_bulk_queue __percpu *bulkq;
>>  
>> @@ -427,6 +430,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
>>  	rcpu->cpu    = cpu;
>>  	rcpu->map_id = map->id;
>>  	rcpu->value.qsize  = value->qsize;
>> +	rcpu->parent_map = map;
>>  
>>  	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
>>  		goto free_ptr_ring;
>> @@ -639,6 +643,14 @@ static int cpu_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>  
>>  static long cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
>>  {
>> +	/*
>> +	 * Redirection is a transfer of ownership of the bpf_cpu_map_entry
>> +	 * During the transfer the bpf_cpu_map_entry is still in the map,
>> +	 * so we need to prevent it from being freed.
>> +	 * The bpf_map_inc() increments the refcnt of the map, so the
>> +	 * bpf_cpu_map_entry will not be freed until the refcnt is decremented.
>> +	 */
>> +	bpf_map_inc(map);
> Adding refcnt increase/decrease in the fast path? Hard NAK.
>
> The map entry is protected by RCU, which should prevent this kind of UAF
> from happening. Looks like maybe there's a bug in the tun driver so this
> RCU protection is not working?

It will be possible if two different xdp programs set and use the value
of ri->tgt_vlaue separately as shown below:

(1) on CPU 0: xdp program A invokes bpf_redirect_map() (e.g., through
test_run) and sets ri->tgt_value as one entry in cpu map X
(2) release the xdp program A and the cpu map X is freed.
(3) on CPU 0: xdp program B doesn't invoke bpf_redirect_map(), but it
returns XDP_REDIRECT, so the old value of ri->tgt_value is used by
program B.

I think the problem is fixed after the merge of commit 401cb7dae813
("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT"). 
Before the commit, bpf_redirect_info is a per-cpu variable, and
ri->tgt_value is not cleared when the running of xdp program completes,
so it is possible that one xdp program could use a stale tgt_values set
by other xdp program. After changing bpf_redirect_info into a per-thread
variable and clearing it after each run of xdp program, such sharing
will be impossible.

Zielonek, could you please help to check whether or not the problem is
reproducible in latest bpf-next tree ?

>
> -Toke
>
>
> .


