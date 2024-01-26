Return-Path: <bpf+bounces-20366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72183D283
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 03:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5AA1C24586
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74B8C02;
	Fri, 26 Jan 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwzYdiRU"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589EB66F
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235760; cv=none; b=u+OaxlzEwNsno3dm48/+B8fXrN1MmDSkfiqXFYSISGTCAxg9Bl+bh/tY9J5Woo/6fSYl6vZsYY4SpP5izNxZ7AvztXxSqTM//2rO+9uW+Jql1JCoxEL2Ru7Gxw6zoiNVtp98S8Wo/QtXneQM4BTO5kFBENZj7zivno0QYxyFLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235760; c=relaxed/simple;
	bh=OSYvZZpa+i3aP3yhhJ+vWAyL9KyBP8AFdARoqG6lphE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMomAYakeUXesgMMeKXz8PggzpEIxKsSVYNOWiksHNJAYvwVfslKSa/IQlGWWyfjmbICgzYncl64/O/D+Z0KGKkBgem5KoUwpdcAVBaGiNjRECUCVW/t00PlBV+i2KlTUCWHxEcbBLg9ZHO4VvnUgA4zrblL2ZUryAhE3yMvqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwzYdiRU; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706235756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5phVj9ffB9yqD140riS9TxGoMxQ06uZ9IH/spt6YXY=;
	b=FwzYdiRUvF9YtYtKY01Iuc+anl9MEJ0VpucsoC2yofBYE79RvgK088GyCa9lgvA2Ulv2If
	Fcep7tmyOY/s/VKNwtaBaUhA35M/iohQy7547eGxYyBcBWLOA/Y/Gy3PBekwOZHVnpAY9y
	ofbP2WeOt19dBxBLrmR7DseyaApSIqY=
Date: Thu, 25 Jan 2024 18:22:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Content-Language: en-US
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, netdev@vger.kernel.org
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
 <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/24 9:22 PM, Amery Hung wrote:
>> I looked at the high level of the patchset. The major ops that it wants to be
>> programmable in bpf is the ".enqueue" and ".dequeue" (+ ".init" and ".reset" in
>> patch 4 and patch 5).
>>
>> This patch adds a new prog type BPF_PROG_TYPE_QDISC, four attach types (each for
>> ".enqueue", ".dequeue", ".init", and ".reset"), and a new "bpf_qdisc_ctx" in the
>> uapi. It is no long an acceptable way to add new bpf extension.
>>
>> Can the ".enqueue", ".dequeue", ".init", and ".reset" be completely implemented
>> in bpf (with the help of new kfuncs if needed)? Then a struct_ops for Qdisc_ops
>> can be created. The bpf Qdisc_ops can be loaded through the existing struct_ops api.
>>
> Partially. If using struct_ops, I think we'll need another structure
> like the following in bpf qdisc to be implemented with struct_ops bpf:
> 
> struct bpf_qdisc_ops {
>      int (*enqueue) (struct sk_buff *skb)
>      void (*dequeue) (void)
>      void (*init) (void)
>      void (*reset) (void)
> };
> 
> Then, Qdisc_ops will wrap around them to handle things that cannot be
> implemented with bpf (e.g., sch_tree_lock, returning a skb ptr).

We can see how those limitations (calling sch_tree_lock() and returning a ptr) 
can be addressed in bpf. This will also help other similar use cases.

Other than sch_tree_lock and returning a ptr from a bpf prog. What else do you 
see that blocks directly implementing the enqueue/dequeue/init/reset in the 
struct Qdisc_ops?

Have you thought above ".priv_size"? It is now fixed to sizeof(struct 
bpf_sched_data). It should be useful to allow the bpf prog to store its own data 
there?

> 
>> If other ops (like ".dump", ".dump_stats"...) do not have good use case to be
>> programmable in bpf, it can stay with the kernel implementation for now and only
>> allows the userspace to load the a bpf Qdisc_ops with .equeue/dequeue/init/reset
>> implemented.
>>
>> You mentioned in the cover letter that:
>> "Current struct_ops attachment model does not seem to support replacing only
>> functions of a specific instance of a module, but I might be wrong."
>>
>> I assumed you meant allow bpf to replace only "some" ops of the Qdisc_ops? Yes,
>> it can be done through the struct_ops's ".init_member". Take a look at
>> bpf_tcp_ca_init_member. The kernel can assign the kernel implementation for
>> ".dump" (for example) when loading the bpf Qdisc_ops.
>>
> I have no problem with partially replacing a struct, which like you
> mentioned has been demonstrated by congestion control or sched_ext.
> What I am not sure about is the ability to create multiple bpf qdiscs,
> where each has different ".enqueue", ".dequeue", and so on. I like the
> struct_ops approach and would love to try it if struct_ops support
> this.

The need for allowing different ".enqueue/.dequeue/..." bpf 
(BPF_PROG_TYPE_QDISC) programs loaded into different qdisc instances is because 
there is only one ".id == bpf" Qdisc_ops native kernel implementation which is 
then because of the limitation you mentioned above?

Am I understanding your reason correctly on why it requires to load different 
bpf prog for different qdisc instances?

If the ".enqueue/.dequeue/..." in the "struct Qdisc_ops" can be directly 
implemented in bpf prog itself, it can just load another bpf struct_ops which 
has a different ".enqueue/.dequeue/..." implementation:

#> bpftool struct_ops register bpf_simple_fq_v1.bpf.o
#> bpftool struct_ops register bpf_simple_fq_v2.bpf.o
#> bpftool struct_ops register bpf_simple_fq_xyz.bpf.o

 From reading the test bpf prog, I think the set is on a good footing. Instead 
of working around the limitation by wrapping the bpf prog in a predefined 
"struct Qdisc_ops sch_bpf_qdisc_ops", lets first understand what is missing in 
bpf and see how we could address them.



