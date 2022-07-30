Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C95857E8
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 04:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiG3CPO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 22:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiG3CPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 22:15:13 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C553DAE;
        Fri, 29 Jul 2022 19:15:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Lvnxm3GzGzl12M;
        Sat, 30 Jul 2022 10:14:04 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
        by APP2 (Coremail) with SMTP id Syh0CgC3ui4qlORiRBZ9BQ--.53560S2;
        Sat, 30 Jul 2022 10:15:07 +0800 (CST)
Message-ID: <5b1e7489-df67-cbda-28f2-9d5442e48ce5@huaweicloud.com>
Date:   Sat, 30 Jul 2022 10:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: zhangwensheng@huaweicloud.com
Subject: Re: [PATCH -next] [RFC] block: fix null-deref in percpu_ref_put
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        yukuai3@huawei.com
References: <20220729105036.2202791-1-zhangwensheng@huaweicloud.com>
 <YuPnjI8oHx4dO3nr@T590>
From:   "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
In-Reply-To: <YuPnjI8oHx4dO3nr@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3ui4qlORiRBZ9BQ--.53560S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1UGw48KF4rXrW3uF43Awb_yoW8uFy7pF
        WUtF45KF48GFZrKas5Aw17Z348Xr4Yya4fGa4xGryayr13Wa4Fqw47Cr4YqFZ7Ars7Zw4Y
        qrWDWFsFvayq9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU84xRDUUUUU==
X-CM-SenderInfo: x2kd0wpzhq2xhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi， Ming

I don't think this is a generic issue in percpu_ref, I sort out some 
processes
using percpu_ref like "part->ref", "blkg->refcnt" and 
"ctx->reqs/ctx->users",
they all use percpu_ref_exit after "release" done which will not cause 
problem.
so I think it should not change it in api(percpu_ref_put_many), and user 
should
to guarantee it.

thanks！
Wensheng

在 2022/7/29 21:58, Ming Lei 写道:
> On Fri, Jul 29, 2022 at 06:50:36PM +0800, Zhang Wensheng wrote:
>> From: Zhang Wensheng <zhangwensheng5@huawei.com>
>>
>> A problem was find in stable 5.10 and the root cause of it like below.
>>
>> In the use of q_usage_counter of request_queue, blk_cleanup_queue using
>> "wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
>> to wait q_usage_counter becoming zero. however, if the q_usage_counter
>> becoming zero quickly, and percpu_ref_exit will execute and ref->data
>> will be freed, maybe another process will cause a null-defef problem
>> like below:
>>
>> 	CPU0                             CPU1
>> blk_cleanup_queue
>>   blk_freeze_queue
>>    blk_mq_freeze_queue_wait
>> 				scsi_end_request
>> 				 percpu_ref_get
>> 				 ...
>> 				 percpu_ref_put
>> 				  atomic_long_sub_and_test
>>    percpu_ref_exit
>>     ref->data -> NULL
>>     				   ref->data->release(ref) -> null-deref
>>
> Looks it is one generic issue in percpu_ref, I think the following patch
> should address it.
>
>
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index d73a1c08c3e3..07308bd36d83 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -331,8 +331,12 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
>   
>   	if (__ref_is_percpu(ref, &percpu_count))
>   		this_cpu_sub(*percpu_count, nr);
> -	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
> -		ref->data->release(ref);
> +	else {
> +		percpu_ref_func_t	*release = ref->data->release;
> +
> +		if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
> +			release(ref);
> +	}
>   
>   	rcu_read_unlock();
>   }
>
>
> Thanks,
> Ming

