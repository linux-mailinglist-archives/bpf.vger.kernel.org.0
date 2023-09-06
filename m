Return-Path: <bpf+bounces-9317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8747935EB
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 09:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A001C208ED
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE80A59;
	Wed,  6 Sep 2023 07:07:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC0362
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 07:07:50 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8107FE50;
	Wed,  6 Sep 2023 00:07:47 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrSmrBZ_1693984063;
Received: from 30.240.113.202(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrSmrBZ_1693984063)
          by smtp.aliyun-inc.com;
          Wed, 06 Sep 2023 15:07:44 +0800
Message-ID: <62cf5489-802a-ce37-16ea-bb9d8c92399d@linux.alibaba.com>
Date: Wed, 6 Sep 2023 15:07:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/2] perf/core: Bail out early if the request AUX area
 is out of bound
Content-Language: en-US
To: Leo Yan <leo.yan@linaro.org>
Cc: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 alexander.shishkin@linux.intel.com, mingo@redhat.com,
 baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com,
 jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, nathan@kernel.org, bpf@vger.kernel.org
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-2-xueshuai@linux.alibaba.com>
 <20230804085947.GB589820@leoy-yangtze.lan>
 <534c5e53-07bb-07bd-0435-76a10b55228d@linux.alibaba.com>
 <bad0d23d-a66e-0558-469b-a2dd1d5eb497@linux.alibaba.com>
 <20230906070238.GC388456@leoy-huanghe.lan>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230906070238.GC388456@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/6 15:02, Leo Yan wrote:
> Hi Shuai,
> 
> On Wed, Sep 06, 2023 at 11:27:38AM +0800, Shuai Xue wrote:
> 
> [...]
> 
>>>>> +	/* Can't allocate more than MAX_ORDER */
>>>>
>>>> The comment is confused.  I'd like to refine it as:
>>>>
>>>>   /*
>>>>    * kcalloc_node() is unable to allocate buffer if the size is larger
>>>>    * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
>>>>    */
>>>
>>> Hi, Leo,
>>>
>>> Thank you for your quick feedback. The comment is simplified from Peter's reply in v2
>>> version. Your refined comment is more detailed and it makes sense to me, I would like
>>> to adopt it if @Peter has no other opinions.
>>>
>>>> To be honest, I am not sure if perf core maintainers like this kind
>>>> thing or not.  Please seek their opinion before you move forward.
>>>>
>>>
>>> and hi, all perf core maintainers,
>>>
>>> I have not received explicit objection from perf core maintainers @Peter or @James so
>>> I moved forward to address their comments. It's fine to me to wait for more opinions from
>>> perf core maintainers.
>>>
>>> Best Regards,
>>> Shuai
>>>
>>
>> Hi, Leo, and all folks,
>>
>> Any more comments? Should I move forward to send a new patch?
> 
> I am afraid I cannot give a reliable suggestion.
> 
> Anyway, I personally think the returned error value in this patch is
> better than the kernel oops since the kernel oops is a bit scary for
> tool's users ;)   Another reason is the perf core layer should report
> error earlier rather than relying on the page buddy allocation layer
> to detect the memory allocation failure, which is easier for both
> developers and users to understand the failure.
> 
> IMHO, a good practice is to respin a new patch set and send out for
> review.  Good luck!
> 

Hi, Leo,

Thanks for valuable comments.

I will send a new patch set.

Thank you.

Best Regards,
Shuai

