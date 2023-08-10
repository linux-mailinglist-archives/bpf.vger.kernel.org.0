Return-Path: <bpf+bounces-7492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1707781B7
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3011C20AB6
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C922F1D;
	Thu, 10 Aug 2023 19:41:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5420CA8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:41:12 +0000 (UTC)
Received: from out-108.mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC22683
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 12:41:10 -0700 (PDT)
Message-ID: <c390dc64-280e-6d9f-661a-9a5d77f16cf8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691696468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuDx6q87jGoCwsecy09MqUn126nk87pBh26c1SpaUZI=;
	b=EyIqYMe+6RnnpEVKI1DDmD/DL9g9mqschLBHCfLPeH6sJI8V8oI6p18NmddlVUh3zGrgdw
	poEHB80/OafLc+5Z6Lp9U0lr8Q2o7wCEKcA1LyrzheoJx3KQJ3/Sg87iEIFDJiR0dvde6F
	Iq5XbQuMFFQkt0xZcte/W+q0kmgGJSs=
Date: Thu, 10 Aug 2023 12:41:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
 robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz> <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz> <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>>> First, I'm a bit concerned about implicit restrictions we apply to bpf programs
>>>> which will be executed potentially thousands times under a very heavy memory
>>>> pressure. We will need to make sure that they don't allocate (much) memory, don't
>>>> take any locks which might deadlock with other memory allocations etc.
>>>> It will potentially require hard restrictions on what these programs can and can't
>>>> do and this is something that the bpf community will have to maintain long-term.
>>>
>>> Right, BPF callbacks operating under OOM situations will be really
>>> constrained but this is more or less by definition. Isn't it?
>>
>> What do you mean?
> 
> Callbacks cannot depend on any direct or indirect memory allocations.
> Dependencies on any sleeping locks (again directly or indirectly) is not
> allowed just to name the most important ones.
> 
>> In general, the bpf community is trying to make it as generic as possible and
>> adding new and new features. Bpf programs are not as constrained as they were
>> when it's all started.

bpf supports different running context. For example, only non-sleepable bpf prog 
is allowed to run at the NIC driver. A sleepable bpf prog is only allowed to run 
at some bpf_lsm hooks that is known to be safe to call blocking 
bpf-helper/kfunc. From the bpf side, it ensures a non-sleepable bpf prog cannot 
do things that may block.

fwiw, Dave has recently proposed something for iterating the task vma 
(https://lore.kernel.org/bpf/20230810183513.684836-4-davemarchevsky@fb.com/). 
Potentially, a similar iterator can be created for a bpf program to iterate 
cgroups and tasks.



