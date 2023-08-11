Return-Path: <bpf+bounces-7539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D3778BF2
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3310E281978
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDF7465;
	Fri, 11 Aug 2023 10:23:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37F6D22;
	Fri, 11 Aug 2023 10:23:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3630FC;
	Fri, 11 Aug 2023 03:23:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMfyN55bqz4f3tNt;
	Fri, 11 Aug 2023 18:23:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDnCsMaDNZkWJe1AQ--.16195S2;
	Fri, 11 Aug 2023 18:23:25 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 2/2] bpf, cpumap: Clean up bpf_cpu_map_entry
 directly in cpu_map_free
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
 <20230728023030.1906124-3-houtao@huaweicloud.com> <87fs4rfb8t.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3d4c4abf-0529-72a3-22e3-af87d8f008c4@huaweicloud.com>
Date: Fri, 11 Aug 2023 18:23:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87fs4rfb8t.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDnCsMaDNZkWJe1AQ--.16195S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1UuF13Gw4fWr1xWw1fCrg_yoW5JFy7pF
	W3Ga4UGw48XrsFk3y7Xw1UAry2vws2gw1UJ34Fka4rA3ZxJr97JFW8KFZ5GFy5urs2gr18
	uF1jgFyvkay7ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/10/2023 6:22 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> After synchronize_rcu(), both the dettached XDP program and
>> xdp_do_flush() are completed, and the only user of bpf_cpu_map_entry
>> will be cpu_map_kthread_run(), so instead of calling
>> __cpu_map_entry_replace() to empty queue and do cleanup after a RCU
>> grace period, do these things directly.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> With one nit below:
>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>

Thanks for the review.
>> ---
>>  kernel/bpf/cpumap.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 24f39c37526f..f8e2b24320c0 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -554,16 +554,15 @@ static void cpu_map_free(struct bpf_map *map)
>>  	/* At this point bpf_prog->aux->refcnt == 0 and this map->refcnt == 0,
>>  	 * so the bpf programs (can be more than one that used this map) were
>>  	 * disconnected from events. Wait for outstanding critical sections in
>> -	 * these programs to complete. The rcu critical section only guarantees
>> -	 * no further "XDP/bpf-side" reads against bpf_cpu_map->cpu_map.
>> -	 * It does __not__ ensure pending flush operations (if any) are
>> -	 * complete.
>> +	 * these programs to complete. synchronize_rcu() below not only
>> +	 * guarantees no further "XDP/bpf-side" reads against
>> +	 * bpf_cpu_map->cpu_map, but also ensure pending flush operations
>> +	 * (if any) are complete.
>>  	 */
>> -
>>  	synchronize_rcu();
>>  
>> -	/* For cpu_map the remote CPUs can still be using the entries
>> -	 * (struct bpf_cpu_map_entry).
>> +	/* The only possible user of bpf_cpu_map_entry is
>> +	 * cpu_map_kthread_run().
>>  	 */
>>  	for (i = 0; i < cmap->map.max_entries; i++) {
>>  		struct bpf_cpu_map_entry *rcpu;
>> @@ -572,8 +571,8 @@ static void cpu_map_free(struct bpf_map *map)
>>  		if (!rcpu)
>>  			continue;
>>  
>> -		/* bq flush and cleanup happens after RCU grace-period */
>> -		__cpu_map_entry_replace(cmap, i, NULL); /* call_rcu */
>> +		/* Empty queue and do cleanup directly */
> The "empty queue" here is a bit ambiguous, maybe "Stop kthread and
> cleanup entry"?

Sure. Will do in v1.
>
>> +		__cpu_map_entry_free(&rcpu->free_work.work);
>>  	}
>>  	bpf_map_area_free(cmap->cpu_map);
>>  	bpf_map_area_free(cmap);
>> -- 
>> 2.29.2


