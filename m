Return-Path: <bpf+bounces-2478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E482E72D792
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 05:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5FF1C20BF5
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7217FF;
	Tue, 13 Jun 2023 03:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7D7F
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 03:00:20 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F4EE;
	Mon, 12 Jun 2023 20:00:18 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vl0GR0C_1686625213;
Received: from 30.240.112.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vl0GR0C_1686625213)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 11:00:15 +0800
Message-ID: <0b3c6dfe-779e-2ee7-cfbc-aea6cfa3cf78@linux.alibaba.com>
Date: Tue, 13 Jun 2023 11:00:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 1/2] perf/core: Bail out early if the request AUX area is
 out of bound
Content-Language: en-US
To: Leo Yan <leo.yan@linaro.org>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-2-xueshuai@linux.alibaba.com>
 <20230612073821.GB217089@leoy-huanghe.lan>
 <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
 <20230612100502.GE217089@leoy-huanghe.lan>
 <20230612102537.GF217089@leoy-huanghe.lan>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230612102537.GF217089@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/12 18:25, Leo Yan wrote:
> On Mon, Jun 12, 2023 at 06:05:02PM +0800, Leo Yan wrote:
>> On Mon, Jun 12, 2023 at 04:35:07PM +0800, Shuai Xue wrote:
>>
>> [...]
>>
>>>> Furthermore, I believe the AUX trace pages are only mapped for VMA
>>>> (continuous virtual address), the kernel will defer to map to physical
>>>> pages (which means it's not necessarily continuous physical pages)
>>>> when handling data abort caused by accessing the pages.
>>>
>>> I don't know why the rb->aux_pages is limit to allocated with continuous physical pages.
>>> so I just add a check to avoid oops and report a proper error code -EINVAL to
>>> user.
>>>
>>> I would like to use vmalloc() family to replace kmalloc() so that we could support
>>> allocate a more large AUX area if it is not necessarily continuous physical pages.
>>> Should we remove the restriction?
>>
>> As you said, we are now able to support a maximum AUX trace buffer
>> size of up to 2GiB, and AUX trace buffer is per CPU wise.
> 
> Ouch, I reviewed my notes and correct myself:
> 
> For per thread mode, perf tool only allocates one generic ring buffer
> and one AUX ring buffer for the whole session; for the system wide mode,
> perf allocates the generic ring buffer and the AUX ring buffer per CPU
> wise.
> 
>> Seems to me, 2GiB AUX buffer per CPU is big enough for most tracing
>> scenarios, right?  Except you can provide profiling scenario which
>> must use bigger buffer size.
> 
> But I think this question is still valid.
> 
>> Another factor is the allocation of buffers from kmalloc() offers better
>> performance compared to allocation from vmalloc(), this is also
>> important for perf core layer.

I see, I don't have such profiling scenario, let's leave the restriction untouched
and I will move the sanity check into rb_alloc_aux().

>>
>> Thanks,
>> Leo

Thank you.

Best Regards,
Shuai

