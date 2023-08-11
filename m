Return-Path: <bpf+bounces-7537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D815E778BE9
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C5B1C20B6D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922156FDB;
	Fri, 11 Aug 2023 10:22:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBA6FA1;
	Fri, 11 Aug 2023 10:22:28 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC691994;
	Fri, 11 Aug 2023 03:22:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMfxB4Jqrz4f3p0c;
	Fri, 11 Aug 2023 18:22:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAH46XbC9ZkYY7PAQ--.16370S2;
	Fri, 11 Aug 2023 18:22:23 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, cpumap: Use queue_rcu_work() to
 remove unnecessary rcu_barrier()
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 houtao1@huawei.com
References: <20230728023030.1906124-1-houtao@huaweicloud.com>
 <20230728023030.1906124-2-houtao@huaweicloud.com> <87il9nfbid.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ec87a815-36b1-0306-823f-d01a77092309@huaweicloud.com>
Date: Fri, 11 Aug 2023 18:22:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87il9nfbid.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAH46XbC9ZkYY7PAQ--.16370S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary5CF17Wr4kXw45CF17Jrb_yoW7uryxpF
	WfKF17Kr48Jw4v93yrXw18Jr12vrs7WF1UJ34rC34rAFn8JrZ7XrW0kF97CF98urWkuw17
	ur4jqFZ7GayqyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/10/2023 6:16 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> As for now __cpu_map_entry_replace() uses call_rcu() to wait for the
>> inflight xdp program and NAPI poll to exit the RCU read critical
>> section, and then launch kworker cpu_map_kthread_stop() to call
>> kthread_stop() to handle all pending xdp frames or skbs.
>>
>> But it is unnecessary to use rcu_barrier() in cpu_map_kthread_stop() to
>> wait for the completion of __cpu_map_entry_free(), because rcu_barrier()
>> will wait for all pending RCU callbacks and cpu_map_kthread_stop() only
>> needs to wait for the completion of a specific __cpu_map_entry_free().
>>
>> So use queue_rcu_work() to replace call_rcu(), schedule_work() and
>> rcu_barrier(). queue_rcu_work() will queue a __cpu_map_entry_free()
>> kworker after a RCU grace period. Because __cpu_map_entry_free() is
>> running in a kworker context, so it is OK to do all of these freeing
>> procedures include kthread_stop() in it.
>>
>> After the update, there is no need to do reference-counting for
>> bpf_cpu_map_entry, because bpf_cpu_map_entry is freed directly in
>> __cpu_map_entry_free(), so just remove it.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> I think your analysis is correct, and this is a nice cleanup of what is
> really a bit of an over-complicated cleanup flow - well done!
>
> I have a few nits below, but with those feel free to resend as non-RFC
> and add my:
>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>

Thanks for the review.
>
>> ---
>>  kernel/bpf/cpumap.c | 93 +++++++++++----------------------------------
>>  1 file changed, 23 insertions(+), 70 deletions(-)
>>
SNIP
>> -static void __cpu_map_entry_free(struct rcu_head *rcu)
>> +static void __cpu_map_entry_free(struct work_struct *work)
>>  {
>>  	struct bpf_cpu_map_entry *rcpu;
>>  
>> @@ -503,30 +454,33 @@ static void __cpu_map_entry_free(struct rcu_head *rcu)
>>  	 * new packets and cannot change/set flush_needed that can
>>  	 * find this entry.
>>  	 */
>> -	rcpu = container_of(rcu, struct bpf_cpu_map_entry, rcu);
>> +	rcpu = container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free_work);
>>  
>>  	free_percpu(rcpu->bulkq);
> Let's move this free down to the end along with the others.

Will do in v1.
>
>> -	/* Cannot kthread_stop() here, last put free rcpu resources */
>> -	put_cpu_map_entry(rcpu);
>> +
>> +	/* kthread_stop will wake_up_process and wait for it to complete */
> Suggest adding to this comment: "cpu_map_kthread_run() makes sure the
> pointer ring is empty before exiting."

Will do in v1.
>
>> +	kthread_stop(rcpu->kthread);
>> +
>> +	if (rcpu->prog)
>> +		bpf_prog_put(rcpu->prog);
>> +	/* The queue should be empty at this point */
>> +	__cpu_map_ring_cleanup(rcpu->queue);
>> +	ptr_ring_cleanup(rcpu->queue, NULL);
>> +	kfree(rcpu->queue);
>> +	kfree(rcpu);
>>  }
>>  
>>  /* After xchg pointer to bpf_cpu_map_entry, use the call_rcu() to
>> - * ensure any driver rcu critical sections have completed, but this
>> - * does not guarantee a flush has happened yet. Because driver side
>> - * rcu_read_lock/unlock only protects the running XDP program.  The
>> - * atomic xchg and NULL-ptr check in __cpu_map_flush() makes sure a
>> - * pending flush op doesn't fail.
>> + * ensure both any driver rcu critical sections and xdp_do_flush()
>> + * have completed.
>>   *
>>   * The bpf_cpu_map_entry is still used by the kthread, and there can
>> - * still be pending packets (in queue and percpu bulkq).  A refcnt
>> - * makes sure to last user (kthread_stop vs. call_rcu) free memory
>> - * resources.
>> + * still be pending packets (in queue and percpu bulkq).
>>   *
>> - * The rcu callback __cpu_map_entry_free flush remaining packets in
>> - * percpu bulkq to queue.  Due to caller map_delete_elem() disable
>> - * preemption, cannot call kthread_stop() to make sure queue is empty.
>> - * Instead a work_queue is started for stopping kthread,
>> - * cpu_map_kthread_stop, which waits for an RCU grace period before
>> + * Due to caller map_delete_elem() is in RCU read critical section,
>> + * cannot call kthread_stop() to make sure queue is empty. Instead
>> + * a work_struct is started for stopping kthread,
>> + * __cpu_map_entry_free, which waits for a RCU grace period before
>>   * stopping kthread, emptying the queue.
>>   */
> I think the above comment is a bit too convoluted, still. I'd suggest
> just replacing the whole thing with this:
>
> /* After the xchg of the bpf_cpu_map_entry pointer, we need to make sure the old
>  * entry is no longer in use before freeing. We use queue_rcu_work() to call
>  * __cpu_map_entry_free() in a separate workqueue after waiting for an RCU grace
>  * period. This means that (a) all pending enqueue and flush operations have
>  * completed (because or the RCU callback), and (b) we are in a workqueue
>  * context where we can stop the kthread and wait for it to exit before freeing
>  * everything.
>  */
Much better. Thanks for the rephrasing.  Will update it in v1.
>>  static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
>> @@ -536,9 +490,8 @@ static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
>>  
>>  	old_rcpu = unrcu_pointer(xchg(&cmap->cpu_map[key_cpu], RCU_INITIALIZER(rcpu)));
>>  	if (old_rcpu) {
>> -		call_rcu(&old_rcpu->rcu, __cpu_map_entry_free);
>> -		INIT_WORK(&old_rcpu->kthread_stop_wq, cpu_map_kthread_stop);
>> -		schedule_work(&old_rcpu->kthread_stop_wq);
>> +		INIT_RCU_WORK(&old_rcpu->free_work, __cpu_map_entry_free);
>> +		queue_rcu_work(system_wq, &old_rcpu->free_work);
>>  	}
>>  }
>>  
>> -- 
>> 2.29.2


