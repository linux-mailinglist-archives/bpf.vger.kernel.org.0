Return-Path: <bpf+bounces-4598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D24174D55A
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3A1C20A61
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D011C8F;
	Mon, 10 Jul 2023 12:26:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB111C87
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 12:26:25 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF8B1;
	Mon, 10 Jul 2023 05:26:22 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vn44hfE_1688991975;
Received: from 30.240.113.134(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vn44hfE_1688991975)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 20:26:17 +0800
Message-ID: <40c4b292-e396-3a1b-f26f-ebbea93c02a8@linux.alibaba.com>
Date: Mon, 10 Jul 2023 20:26:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [Patch v2] perf/core: Bail out early if the request AUX area is
 out of bound
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: alexander.shishkin@linux.intel.com, james.clark@arm.com,
 leo.yan@linaro.org, mingo@redhat.com, baolin.wang@linux.alibaba.com,
 acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230613123211.58393-1-xueshuai@linux.alibaba.com>
 <20230710120026.GA3034907@hirez.programming.kicks-ass.net>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230710120026.GA3034907@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/10 20:00, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 08:32:11PM +0800, Shuai Xue wrote:
> 
>>  kernel/events/ring_buffer.c              | 13 +++++++++++++
>>  tools/perf/Documentation/perf-record.txt |  3 ++-
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>> index a0433f37b024..e514aaba9d42 100644
>> --- a/kernel/events/ring_buffer.c
>> +++ b/kernel/events/ring_buffer.c
>> @@ -673,6 +673,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>>  	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
>>  	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
>>  	int ret = -ENOMEM, max_order;
>> +	size_t bytes;
>>  
>>  	if (!has_aux(event))
>>  		return -EOPNOTSUPP;
>> @@ -699,6 +700,18 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>>  		watermark = 0;
>>  	}
>>  
>> +	/*
>> +	 * 'rb->aux_pages' allocated by kcalloc() is a pointer array which is
>> +	 * used to maintains AUX trace pages. The allocated page for this array
>> +	 * is physically contiguous (and virtually contiguous) with an order of
>> +	 * 0..MAX_ORDER. If the size of pointer array crosses the limitation set
>> +	 * by MAX_ORDER, it reveals a WARNING.
>> +	 *
>> +	 * So bail out early if the request AUX area is out of bound.
>> +	 */
>> +	if (check_mul_overflow(nr_pages, sizeof(void *), &bytes) ||
>> +	    get_order(bytes) > MAX_ORDER)
>> +		return -EINVAL;
> 
> This is all quite horrific :/ What's wrong with something simple:
> 
> 	/* Can't allocate more than MAX_ORDER  */
> 	if (get_order((unsigned long)nr_pages * sizeof(void*)) > MAX_ORDER)
> 		return -EINVAL;
> 
> If you're on 32bit then nr_pages should never be big enough to overflow,
> fundamentally you'll only have 32-PAGE_SHIFT bits in nr_pages.

Well, you are right. Thank you for pointing it out.
I will send a new version with your simplified code :)

Best Regards,
Shuai

> 
> 
>>  	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
>>  				     node);
> 

