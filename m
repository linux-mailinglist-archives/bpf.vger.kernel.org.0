Return-Path: <bpf+bounces-14380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6B7E3561
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 07:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DE2B20BE7
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 06:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F61EBE53;
	Tue,  7 Nov 2023 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arETF0AI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E117C3
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:52:55 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C711C
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:52:52 -0800 (PST)
Message-ID: <8a4d7471-76ac-448c-9496-12e028f7fe24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699339970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doeaJ3TCJRDoCUsKD6qI6DBlHF9Ho7sjk/KP9dPBko4=;
	b=arETF0AIU6QbazCH0FE0anWaoTLD4ci0DIkKCLjiSnicmlt69+X2FqGDShStWIUU5KQAYV
	ECX+jsZG8kORa8cwYusM/UIqgUUzsmgly4QU3h3mSZ5Mp3DJ6EK4ROR0seSdHlgAhOGcCf
	HWYHRf63aFd6JC+ueIKXaVs0JMNqAzA=
Date: Mon, 6 Nov 2023 22:52:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Let verifier consider {task,cgroup} is
 trusted in bpf_iter_reg
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, bpf@vger.kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-2-zhouchuyi@bytedance.com>
 <f807c58c-526c-0647-fc1c-9b488d351b1d@linux.dev>
 <9f55ef44-646d-4120-b437-defff91d1af5@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9f55ef44-646d-4120-b437-defff91d1af5@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/6/23 6:44 PM, Chuyi Zhou wrote:
> Hello,
>
> 在 2023/11/7 02:29, Martin KaFai Lau 写道:
>> On 11/5/23 5:34 AM, Chuyi Zhou wrote:
>>> BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
>>> teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
>>> doesn't work well.
>>>
>>> The reason is, bpf_iter__task -> task would go through btf_ctx_access()
>>> which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
>>> task_iter.c, we actually explicitly declare that the
>>> ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.
>>>
>>> This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
>>> PTR_TRUSTED in task_reg_info.
>>>
>>> Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since 
>>> we are
>>> under the protection of cgroup_mutex and we would check 
>>> cgroup_is_dead()
>>> in __cgroup_iter_seq_show().
>>>
>>
>> Make sense. I think the bpf_tcp_iter made similar change in 
>> tcp_seq_info also. What may be the Fixes tag? Is it fixing the recent 
>> kfunc of the css_task iter?
>>
>
> Thanks for the review.
>
> I think it's not a fix for recent kfunc of css_task iter. We are 
> working at SEC("iter/task") and SEC("iter/cgroup").
>
> I'm not sure whether it's a 'fix' for cgroup_iter/task_iter. If we 
> need fix tags, do we need to split this patch into two separate 
> patches? Or add two fix tags on commit log:

I think the patch itself is not a fix, rather an improvement. The bpf_iter predates kfunc/PTR_TRUSTED stuff. The argument 'task'
or 'cgroup' are already trusted so the bpf_iter program can print out useful data.
But recent kfunc things requires some parameters to be marked as PTR_TRUSTED so that they can be passed to kfunc,
so this patch enables this usage for kfunc in bpf_iter programs.


>
> Fixes: d4ccaf58a84721 ("bpf: Introduce cgroup iter")
> Fixes: 3c32cc1bceba8a17 ("bpf: Enable bpf_iter targets registering ctx 
> argument types")
>
> Thanks.
>
>
>

