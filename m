Return-Path: <bpf+bounces-34496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F354692DE3D
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 04:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825D22829CD
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FBDDDF;
	Thu, 11 Jul 2024 02:05:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D5383;
	Thu, 11 Jul 2024 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663557; cv=none; b=ldGcEpcqdcPiZ8MzU0af9BxfuEU6qc+/6EDN2yYBFH/F01vxF+pmmlJs1/YTyOwvi4joqb23mMmR9tuy4r8rFKDB/c0+I7inwfVR1ePuhdnI7ERjoDXRZiT9OasNgT/eRIuN8wPwgUepC0Y/Kq9/n3mKNoPI8AD1I06bgpmPcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663557; c=relaxed/simple;
	bh=8xQZflV4+sVWWI8BAh5XMpMjW5885RiRrVGlv0CSCVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pTn4sJP9GPrHnLPG/Oa4lfTrT4B7m6iogkyWAP3kglf3P8RyKE9upbxsXyXTF1QbMb1gOnuRFr9mlqq8rS28wQ6wiOEFkwyftsqg6GoEPSphQwAQ6wbtoJ9fyQBjqToKiEP4rbTvYStbHq4nSFyKtWdPjWg7shV1Bt7aKVh7VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WKHyY1QZsz1yvHt;
	Thu, 11 Jul 2024 10:01:25 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4478F1A0188;
	Thu, 11 Jul 2024 10:05:21 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 11 Jul 2024 10:05:20 +0800
Message-ID: <993a2fa6-b40e-b85c-ea87-e7940db11d3d@huawei.com>
Date: Thu, 11 Jul 2024 10:05:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] uprobes: Optimize the return_instance related
 routines
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <mykolal@fb.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20240709005142.4044530-1-liaochang1@huawei.com>
 <20240709005142.4044530-2-liaochang1@huawei.com>
 <CAEf4BzYDrVJXnAruko-h5-oXCGuZ92x4KnY-2cD=XXBp1U_kBg@mail.gmail.com>
 <2336576e-1ed4-cd5e-5535-2d9b88218dae@huawei.com>
 <CAEf4BzYDvh2Ynrttk4NLyCGB8AVM2d-2tKSzRZF_cXVA80qucw@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYDvh2Ynrttk4NLyCGB8AVM2d-2tKSzRZF_cXVA80qucw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/7/11 5:21, Andrii Nakryiko 写道:
> On Wed, Jul 10, 2024 at 1:19 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/7/10 7:55, Andrii Nakryiko 写道:
>>> On Mon, Jul 8, 2024 at 6:00 PM Liao Chang <liaochang1@huawei.com> wrote:
>>>>
>>>> Reduce the runtime overhead for struct return_instance data managed by
>>>> uretprobe. This patch replaces the dynamic allocation with statically
>>>> allocated array, leverage two facts that are limited nesting depth of
>>>> uretprobe (max 64) and the function call style of return_instance usage
>>>> (create at entry, free at exit).
>>>>
>>>> This patch has been tested on Kunpeng916 (Hi1616), 4 NUMA nodes, 64
>>>> cores @ 2.4GHz. Redis benchmarks show a throughput gain by 2% for Redis
>>>> GET and SET commands:
>>>>
>>>> ------------------------------------------------------------------
>>>> Test case       | No uretprobes | uretprobes     | uretprobes
>>>>                 |               | (current)      | (optimized)
>>>> ==================================================================
>>>> Redis SET (RPS) | 47025         | 40619 (-13.6%) | 41529 (-11.6%)
>>>> ------------------------------------------------------------------
>>>> Redis GET (RPS) | 46715         | 41426 (-11.3%) | 42306 (-9.4%)
>>>> ------------------------------------------------------------------
>>>>
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>> ---
>>>>  include/linux/uprobes.h |  10 ++-
>>>>  kernel/events/uprobes.c | 162 ++++++++++++++++++++++++----------------
>>>>  2 files changed, 105 insertions(+), 67 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> +static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
>>>> +                                    struct pt_regs *regs)
>>>> +{
>>>> +       struct return_frame *frame = &utask->frame;
>>>> +       struct return_instance *ri = frame->return_instance;
>>>> +       enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
>>>> +
>>>> +       while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
>>>> +               ri = next_ret_instance(frame, ri);
>>>> +               utask->depth--;
>>>> +       }
>>>> +       frame->return_instance = ri;
>>>> +}
>>>> +
>>>> +static struct return_instance *alloc_return_instance(struct uprobe_task *task)
>>>> +{
>>>> +       struct return_frame *frame = &task->frame;
>>>> +
>>>> +       if (!frame->vaddr) {
>>>> +               frame->vaddr = kcalloc(MAX_URETPROBE_DEPTH,
>>>> +                               sizeof(struct return_instance), GFP_KERNEL);
>>>
>>> Are you just pre-allocating MAX_URETPROBE_DEPTH instances always?
>>> I.e., even if we need just one (because there is no recursion), you'd
>>> still waste memory for all 64 ones?
>>
>> This is the truth. On my testing machines, each struct return_instance data
>> is 28 bytes, resulting in a total pre-allocated 1792 bytes when the first
>> instrumented function is hit.
>>
>>>
>>> That seems rather wasteful.
>>>
>>> Have you considered using objpool for fast reuse across multiple CPUs?
>>> Check lib/objpool.c.
>>
>> After studying how kretprobe uses objpool, I'm convinced it is a right solution for
>> managing return_instance in uretporbe. While I need some time to fully understand
>> the objpool code itself and run some benchmark to verify its performance.
>>
>> Thanks for the suggestion.
> 
> Keep in mind that there are two patch sets under development/review,
> both of which touch this code. [0] will make return_instance
> variable-sized, so think how to accommodate that. And [1] in general
> touches a bunch of this code. So I'd let those two settle and land
> before optimizing return_instance allocations further.
> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20240701164115.723677-1-jolsa@kernel.org/
>   [1] https://lore.kernel.org/linux-kernel/20240708091241.544262971@infradead.org/

Thanks for letting me know. I've made a note to track the progress of these patch sets.

> 
>>
>>>
>>>> +               if (!frame->vaddr)
>>>> +                       return NULL;
>>>> +       }
>>>> +
>>>> +       if (!frame->return_instance) {
>>>> +               frame->return_instance = frame->vaddr;
>>>> +               return frame->return_instance;
>>>> +       }
>>>> +
>>>> +       return ++frame->return_instance;
>>>> +}
>>>> +
>>>> +static inline bool return_frame_empty(struct uprobe_task *task)
>>>> +{
>>>> +       return !task->frame.return_instance;
>>>>  }
>>>>
>>>>  /*
>>>
>>> [...]
>>
>> --
>> BR
>> Liao, Chang

-- 
BR
Liao, Chang

