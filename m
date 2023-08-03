Return-Path: <bpf+bounces-6874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27D76EDFA
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AAB1C215E1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102523BE7;
	Thu,  3 Aug 2023 15:22:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A818B0D
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 15:22:32 +0000 (UTC)
Received: from out-97.mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACBE77
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 08:22:23 -0700 (PDT)
Message-ID: <cddeb658-563e-9ff9-0ece-4509eabab663@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691076141; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adyOJcRRSqgTRkQM1xmjt/umYksn60AIoqQGEOzFf8I=;
	b=t8y0VAlIQITqjw1Ppi/Ei96I8a5zC4DPPZk8kJ/BEIDbaM4BzwawQ5eOnzjCwxa85/DQOX
	oFkmoZ59XJAydi7v91BjYO+c3woNwwIO4q1VFuJgy8qRC1Cb7G77aSwZ6IyTE0cwDybXmf
	0j6hG/AkFdwCmqsVgoIunhf89DPPEMo=
Date: Thu, 3 Aug 2023 08:22:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 David Vernet <void@manifault.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 Stephen Brennan <stephen.s.brennan@oracle.com>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
 <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge>
 <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
 <998f8e89-fb00-820f-15d9-1d227cc09e54@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <998f8e89-fb00-820f-15d9-1d227cc09e54@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 1:21 AM, Alan Maguire wrote:
> On 02/08/2023 17:33, Alexei Starovoitov wrote:
>> On Tue, Aug 1, 2023 at 8:30 PM David Vernet <void@manifault.com> wrote:
>>> I agree that this is the correct way to generalize this. The only thing
>>> that we'll have to figure out is how to generalize treating const struct
>>> cpumask * objects as kptrs. In sched_ext [0] we export
>>> scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
>>> return trusted global cpumask kptrs that can then be "released" in
>>> scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
>>> exists only to appease the verifier that the trusted cpumask kptrs
>>> aren't being leaked and are having their references "dropped".
>>
>> why is it KF_ACQUIRE ?
>> I think it can just return a trusted pointer without acquire.
>>
>>> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>
>>> I'd imagine that we have 2 ways forward if we want to enable progs to
>>> fetch other global cpumasks with static lifetimes (e.g.
>>> __cpu_possible_mask or nohz.idle_cpus_mask):
>>>
>>> 1. The most straightforward thing to do would be to add a new kfunc in
>>>     kernel/bpf/cpumask.c that's a drop-in replacment for
>>>     scx_bpf_put_idle_cpumask():
>>>
>>> void bpf_global_cpumask_drop(const struct cpumask *cpumask)
>>> {}
>>>
>>> 2. Another would be to implement something resembling what Yonghong
>>>     suggested in [1], where progs can link against global allocated kptrs
>>>     like:
>>>
>>> const struct cpumask *__cpu_possible_mask __ksym;
>>>
>>> [1]: https://lore.kernel.org/all/3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev/#t
>>>
>>> In my opinion (1) is more straightforward, (2) is a better UX.
>>
>> 1 = adding few kfuncs.
>> 2 = teaching pahole to emit certain global vars.
>>
>> nm vmlinux|g -w D|g -v __SCK_|g -v __tracepoint_|wc -l
>> 1998
>>
>> imo BTF increase trade off is acceptable.
> 
> Agreed, Stephen's numbers on BTF size increase were pretty modest [1].
> 
> What was gating that work in my mind was previous discussion around
> splitting aspects of BTF into a "vmlinux-extra". Experiments with this
> seemed to show it's hard to support, and worse, tooling would have to
> learn about its existence. We have to come up with a CONFIG convention
> about specifying what ends up in -extra versus core vmlinux BTF, what do
> we do about modules, etc. All feels like over-complication.
> 
> I think a better path would be to support BTF in a vmlinux BTF module
> (controlled by making CONFIG_DEBUG_INFO_BTF tristate). The module is
> separately loadable, but puts vmlinux in the same place for tools -
> /sys/kernel/btf/vmlinux. That solves already-existing issues of BTF size
> for embedded use cases that have come up a few times, and lessens
> concerns about BTF size for other users, while it all works with
> existing tooling. I have a basic proof-of-concept but it will take time
> to hammer into shape.
> 
> Because variable-related size increases are pretty modest, so should we
> proceed with the BTF variable support anyway? We can modularize BTF
> separately later on for those concerned about BTF size.

Alan, it seems a consensus has reached that we should include
global variables (excluding special kernel made ones like
__SCK_ and __tracepoint_) in vmlinux BTF.
please go ahead and propose a patch. Thanks!

> 
> [1]
> https://lore.kernel.org/bpf/20221104231103.752040-1-stephen.s.brennan@oracle.com/

