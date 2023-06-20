Return-Path: <bpf+bounces-2877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72873613A
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 03:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167FC280E74
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA41363;
	Tue, 20 Jun 2023 01:42:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888010E3
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 01:42:17 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5FFE59;
	Mon, 19 Jun 2023 18:42:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlTrx72Z7z4f422l;
	Tue, 20 Jun 2023 09:42:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBHJ9XvA5Fkyw8VMA--.19533S2;
	Tue, 20 Jun 2023 09:42:10 +0800 (CST)
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add benchmark for bpf
 memory allocator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 houtao1@huawei.com
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
 <20230613080921.1623219-6-houtao@huaweicloud.com>
 <20230619203543.sb3pqx62uxqnucuo@MacBook-Pro-8.local>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ead4cfa0-b446-e55d-fa22-588e0e2f31f6@huaweicloud.com>
Date: Tue, 20 Jun 2023 09:42:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230619203543.sb3pqx62uxqnucuo@MacBook-Pro-8.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBHJ9XvA5Fkyw8VMA--.19533S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryDur13ZFy5uFWUXry5Jwb_yoWrWw1DpF
	W0kay8GFn8tw1jvFyvqw4kJFW8Jrn8Jr12vry8K345Aryqk3WSgry3GFWrKF4rur95GF1j
	9a1jqFZxCwn5XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexei,

On 6/20/2023 4:35 AM, Alexei Starovoitov wrote:
> On Tue, Jun 13, 2023 at 04:09:21PM +0800, Hou Tao wrote:
>> +
>> +static void htab_mem_notify_wait_producer(pthread_barrier_t *notify)
> notify_wait and wait_notify names are confusing.
> The first one is doing map_update and 2nd is map_delete, right?
> Just call them such?
OK.
>
>> +{
>> +	while (true) {
>> +		(void)syscall(__NR_getpgid);
>> +		/* Notify for start */
> the comment is confusing too.
> Maybe /* Notify map_deleter that map_updates are done */ ?
Will update.
>
>> +		pthread_barrier_wait(notify);
>> +		/* Wait for completion */
> and /* Wait for deletions to complete */ ?
Yes. Will update.
>
>> +		pthread_barrier_wait(notify);
>> +	}
>> +}
>> +
>> +static void htab_mem_wait_notify_producer(pthread_barrier_t *notify)
>> +{
>> +	while (true) {
>> +		/* Wait for start */
>> +		pthread_barrier_wait(notify);
>> +		(void)syscall(__NR_getpgid);
>> +		/* Notify for completion */
> similar.
Will update.
>
>> +		pthread_barrier_wait(notify);
>> +	}
>> +}
>
>> +static int write_htab(unsigned int i, struct update_ctx *ctx, unsigned int flags)
>> +{
>> +	if (ctx->from >= MAX_ENTRIES)
>> +		return 1;
> It can never be hit, right?
> Remove it then?
MAX_ENTRIES / 64 = 128, so when then number of producers is greater than
128, it will be hit. But I think we can remove it and adjust max_entries
accordingly when the number of producers is greater than 128.
>
>> +
>> +	bpf_map_update_elem(&htab, &ctx->from, zeroed_value, flags);
> please add error check.
> I think update/delete notification is correct, but it could be silently broken.
> update(BPF_NOEXIST) could be returning error in one thread and
> map_delete_elem could be failing too...
If these threads update or delete the non-overlapped part of the hash
map, then there will be no fail. But when the number of producer is
greater than the number of online CPU, there will be failure, but this
use case is not expected benchmark use case.

>
>> +	ctx->from += ctx->step;
>> +
>> +	return 0;
>> +}
>> +
>> +static int overwrite_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	return write_htab(i, ctx, 0);
>> +}
>> +
>> +static int newwrite_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	return write_htab(i, ctx, BPF_NOEXIST);
>> +}
>> +
>> +static int del_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	if (ctx->from >= MAX_ENTRIES)
>> +		return 1;
> delete?
Will fix.
>
>> +
>> +	bpf_map_delete_elem(&htab, &ctx->from);
> and here.
>
>> +	ctx->from += ctx->step;
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int overwrite(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	update.step = nr_thread;
>> +	bpf_loop(64, overwrite_htab, &update, 0);
>> +	__sync_fetch_and_add(&op_cnt, 1);
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int batch_add_batch_del(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	update.step = nr_thread;
>> +	bpf_loop(64, overwrite_htab, &update, 0);
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	bpf_loop(64, del_htab, &update, 0);
>> +
>> +	__sync_fetch_and_add(&op_cnt, 2);
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int add_del_on_diff_cpu(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +	unsigned int from;
>> +
>> +	from = bpf_get_smp_processor_id();
>> +	update.from = from / 2;
> why extra 'from' variable? Just combine above two lines.
from is also used below to decide the bpf program should do update or
deletion.
>
>> +	update.step = nr_thread / 2;
>> +
>> +	if (from & 1)
>> +		bpf_loop(64, newwrite_htab, &update, 0);
>> +	else
>> +		bpf_loop(64, del_htab, &update, 0);
> I think it's cleaner to split this into two bpf programs.
> Do update(NOEXIST) in one triggered by sys_enter_getpgid
> and do delete_elem() in another triggered by a different syscall.
OK. Will do that in next version.
>
>> +
>> +	__sync_fetch_and_add(&op_cnt, 1);
>> +	return 0;
>> +}
>> -- 
>> 2.29.2
>>


