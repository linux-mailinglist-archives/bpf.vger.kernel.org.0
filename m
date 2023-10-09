Return-Path: <bpf+bounces-11701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851C7BD94D
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAE62817E8
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3444171BE;
	Mon,  9 Oct 2023 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FF1171E;
	Mon,  9 Oct 2023 11:11:19 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B1ED;
	Mon,  9 Oct 2023 04:11:17 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vtn6Z4K_1696849872;
Received: from 30.240.114.194(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vtn6Z4K_1696849872)
          by smtp.aliyun-inc.com;
          Mon, 09 Oct 2023 19:11:14 +0800
Message-ID: <54601861-bd02-d4c9-6d78-34901807a001@linux.alibaba.com>
Date: Mon, 9 Oct 2023 19:11:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/2] perf record: Update docs regarding the maximum
 limitation of AUX area
Content-Language: en-US
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
 mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 nathan@kernel.org, bpf@vger.kernel.org, alexander.shishkin@linux.intel.com,
 peterz@infradead.org, james.clark@arm.com, leo.yan@linaro.org
References: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
 <20230907004308.25874-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20230907004308.25874-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/7 08:43, Shuai Xue wrote:
> The maximum AUX area is limited by the page size of the system. Update
> the documentation to reflect this.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 680396c56bd1..dfc322d6f1f1 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -292,6 +292,17 @@ OPTIONS
>  	Also, by adding a comma, the number of mmap pages for AUX
>  	area tracing can be specified.
>  
> +	The maximum AUX area is limited by the maximum physically contiguous
> +	memory allocated from slab/slub. It can be calculated with following
> +	formula:
> +
> +	  PAGE_SIZE << MAX_ORDER
> +	( ---------------------- ) * PAGE_SIZE
> +	   sizeof(page_pointer)
> +
> +	For example with 4K pages and MAX_ORDER=10 configured, the maximum AUX
> +	area is 2GiB.
> +
>  -g::
>  	Enables call-graph (stack chain/backtrace) recording for both
>  	kernel space and user space.


Hi, Namhyung,

Since PATCH [1/2] of this series has been merge into perf/core[1], are you happy to
pick this part [2/2] into perf-tools-next?

Thank you.

Best Regards,
Shuai

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/core&id=54aee5f15b83437f23b2b2469bcf21bdd9823916

