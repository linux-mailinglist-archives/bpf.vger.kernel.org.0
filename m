Return-Path: <bpf+bounces-5901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881FA762871
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 03:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708981C21071
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 01:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947F1360;
	Wed, 26 Jul 2023 01:59:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962367C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 01:59:31 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409DC1BFF;
	Tue, 25 Jul 2023 18:59:28 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VoElwYK_1690336763;
Received: from 30.240.115.26(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VoElwYK_1690336763)
          by smtp.aliyun-inc.com;
          Wed, 26 Jul 2023 09:59:25 +0800
Message-ID: <6a8feb5f-0e78-2dd2-db6a-2dc22c663a00@linux.alibaba.com>
Date: Wed, 26 Jul 2023 09:59:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] perf/core: Bail out early if the request AUX area is
 out of bound
Content-Language: en-US
To: James Clark <james.clark@arm.com>, alexander.shishkin@linux.intel.com,
 peterz@infradead.org, leo.yan@linaro.org
Cc: mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
 mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230711014120.53461-1-xueshuai@linux.alibaba.com>
 <75ddf1ce-64a2-f3a4-8a51-92e7bbb3899d@arm.com>
 <78dbe98e-8702-e332-59ff-3850cff2895b@linux.alibaba.com>
 <71064fb4-3745-c877-bf81-7542d815c289@arm.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <71064fb4-3745-c877-bf81-7542d815c289@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/25 17:56, James Clark wrote:
> 
> 
> On 25/07/2023 08:31, Shuai Xue wrote:
>>
>>
>> On 2023/7/24 23:21, James Clark wrote:
>>>
>>>
>>> On 11/07/2023 02:41, Shuai Xue wrote:
>>>> When perf-record with a large AUX area, e.g 4GB, it fails with:
>>>>
>>>>     #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
>>>>     failed to mmap with 12 (Cannot allocate memory)
>>>>
>>>> and it reveals a WARNING with __alloc_pages():
>>>>
>>>> [   66.595604] ------------[ cut here ]------------
>>>> [   66.600206] WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
>>>> [   66.608375] Modules linked in: ip6table_filter(E) ip6_tables(E) iptable_filter(E) ebtable_nat(E) ebtables(E) aes_ce_blk(E) vfat(E) fat(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sm4_ce_cipher(E) sm4(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) acpi_ipmi(E) sbsa_gwdt(E) sg(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ip_tables(E) sd_mod(E) ast(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme(E) sysimgblt(E) i2c_algo_bit(E) nvme_core(E) drm_shmem_helper(E) ahci(E) t10_pi(E) libahci(E) drm(E) crc64_rocksoft(E) i40e(E) crc64(E) libata(E) i2c_core(E)
>>>> [   66.657719] CPU: 44 PID: 17573 Comm: perf Kdump: loaded Tainted: G            E      6.3.0-rc4+ #58
>>>> [   66.666749] Hardware name: Default Default/Default, BIOS 1.2.M1.AL.P.139.00 03/22/2023
>>>> [   66.674650] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>>>> [   66.681597] pc : __alloc_pages+0x1ec/0x248
>>>> [   66.685680] lr : __kmalloc_large_node+0xc0/0x1f8
>>>> [   66.690285] sp : ffff800020523980
>>>> [   66.693585] pmr_save: 000000e0
>>>> [   66.696624] x29: ffff800020523980 x28: ffff000832975800 x27: 0000000000000000
>>>> [   66.703746] x26: 0000000000100000 x25: 0000000000100000 x24: ffff8000083615d0
>>>> [   66.710866] x23: 0000000000040dc0 x22: ffff000823d6d140 x21: 000000000000000b
>>>> [   66.717987] x20: 000000000000000b x19: 0000000000000000 x18: 0000000000000030
>>>> [   66.725108] x17: 0000000000000000 x16: ffff800008f05be8 x15: ffff000823d6d6d0
>>>> [   66.732229] x14: 0000000000000000 x13: 343373656761705f x12: 726e202c30206574
>>>> [   66.739350] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff8000083af570
>>>> [   66.746471] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
>>>> [   66.753592] x5 : 0000000000000000 x4 : ffff000823d6d8d8 x3 : 0000000000000000
>>>> [   66.760713] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
>>>> [   66.767834] Call trace:
>>>> [   66.770267]  __alloc_pages+0x1ec/0x248
>>>> [   66.774003]  __kmalloc_large_node+0xc0/0x1f8
>>>> [   66.778259]  __kmalloc_node+0x134/0x1e8
>>>> [   66.782081]  rb_alloc_aux+0xe0/0x298
>>>> [   66.785643]  perf_mmap+0x440/0x660
>>>> [   66.789031]  mmap_region+0x308/0x8a8
>>>> [   66.792593]  do_mmap+0x3c0/0x528
>>>> [   66.795807]  vm_mmap_pgoff+0xf4/0x1b8
>>>> [   66.799456]  ksys_mmap_pgoff+0x18c/0x218
>>>> [   66.803365]  __arm64_sys_mmap+0x38/0x58
>>>> [   66.807187]  invoke_syscall+0x50/0x128
>>>> [   66.810922]  el0_svc_common.constprop.0+0x58/0x188
>>>> [   66.815698]  do_el0_svc+0x34/0x50
>>>> [   66.818999]  el0_svc+0x34/0x108
>>>> [   66.822127]  el0t_64_sync_handler+0xb8/0xc0
>>>> [   66.826296]  el0t_64_sync+0x1a4/0x1a8
>>>> [   66.829946] ---[ end trace 0000000000000000 ]---
>>>>
>>>> 'rb->aux_pages' allocated by kcalloc() is a pointer array which is used to
>>>> maintain AUX trace pages. The allocated page for this array is physically
>>>> contiguous (and virtually contiguous) with an order of 0..MAX_ORDER. If the
>>>> size of pointer array crosses the limitation set by MAX_ORDER, it reveals a
>>>> WARNING.
>>>>
>>>> So bail out early with -EINVAL if the request AUX area is out of bound,
>>>> e.g.:
>>>>
>>>>     #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
>>>>     failed to mmap with 22 (Invalid argument)
>>>>
>>>
>>> Hi Shuai,
>>
>> Hi, James,
>>
>>>
>>> Now that I think about this, isn't the previous error "failed to mmap
>>> with 12 (Cannot allocate memory)" better than "failed to mmap with 22
>>> (Invalid argument)"?
>>
>> If I see a "invalid argument", I am expected to check my perf command
>> first. But for "Cannot allocate memory", I will doubt that the system
>> have problem but I dont have any idea about.
>>
>> IMO, I prefer "invalid argument". But I can change back to previous error
>> message if you insist.
>>
>>
> 
> Maybe, but if a tool is currently doing something like an increasing
> loop to check for the max possible aux buffer size and checking for "12
> (Cannot allocate memory)" then you could consider this change a
> userspace breaking one.
> 
> The script would probably just be checking for any error, but you never
> know.
> 
> I agree the error codes are quite non specific and don't really help
> with showing the cause of the problem. But I can't see how the memory
> one isn't more specific to the aux buffer size in this case.
> 
> I searched for other errors returned after checking get_order() and I
> found both -EINVAL and -ENOMEM, so if there is no consensus maybe it's
> best to stick to the existing return value.

Ok, I will change back to previous -ENOMEM :)

Thank you.

Best Regards,
Shuai


> 
> James
> 
>>> And you might want to split the doc change out if they are going to be
>>> merged through separate trees.
>>
>> Will do that.
>>
>>>
>>> And one comment below:
>>>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> ---
>>>> changes since v2:
>>>> - remove unnecessary overflow check (per Peter)
>>>>
>>>> changes since v1:
>>>> - drop out patch2 because it has been fixed on upstream (Thanks James for reminding)
>>>> - move sanity check into rb_alloc_aux (per Leo)
>>>> - add overflow check (per James)
>>>> ---
>>>>  kernel/events/ring_buffer.c              | 3 +++
>>>>  tools/perf/Documentation/perf-record.txt | 3 ++-
>>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>>>> index a0433f37b024..5933ce45c68a 100644
>>>> --- a/kernel/events/ring_buffer.c
>>>> +++ b/kernel/events/ring_buffer.c
>>>> @@ -699,6 +699,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>>>>  		watermark = 0;
>>>>  	}
>>>>  
>>>> +	/* Can't allocate more than MAX_ORDER */
>>>> +	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
>>>> +		return -EINVAL;
>>>>  	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
>>>>  				     node);
>>>>  	if (!rb->aux_pages)
>>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>>> index 680396c56bd1..5d8d3ad084ed 100644
>>>> --- a/tools/perf/Documentation/perf-record.txt
>>>> +++ b/tools/perf/Documentation/perf-record.txt
>>>> @@ -290,7 +290,8 @@ OPTIONS
>>>>  	specification with appended unit character - B/K/M/G. The
>>>>  	size is rounded up to have nearest pages power of two value.
>>>>  	Also, by adding a comma, the number of mmap pages for AUX
>>>> -	area tracing can be specified.
>>>> +	area tracing can be specified. With MAX_ORDER set as 10 on
>>>> +	arm64 platform , the maximum AUX area is limited to 2GiB.
>>>
>>> Minor nit: I wouldn't expect a Perf tool user to know what "MAX_ORDER"
>>> is, and I don't think the limitation is Arm specific? Maybe something in
>>> more relevant terms is more useful:
>>>
>>>   The maximum AUX area is limited by the page size of the system. For
>>>   example with 4K pages configured, the maximum is 2GiB.
>>
>> Agreed. Will change it.
>>
>>
>>>
>>> Thanks
>>> James
>>
>> Thank you for valuable comments.
>>
>> Best Regards,
>> Shuai
>>>
>>>>  
>>>>  -g::
>>>>  	Enables call-graph (stack chain/backtrace) recording for both

