Return-Path: <bpf+bounces-35751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B6093D85E
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 20:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FA11C233B5
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B6335A7;
	Fri, 26 Jul 2024 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fn1U9iHB"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C83D69
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018658; cv=none; b=e77Di2LB4ZkF5R6fLSgwVmKdRq1zxH62+UY25rdPZmVx1E1jXrwtRQHjvN0m5u64lx9MOQkJwBtk6QnfzMMDMs0r8E8Cia7e+CA3/rkSRoNXYKVQB7HzXMwTCXOuTGvo0YUEtm97UOkDpybCz0sY1WEgHswNFYIuKW+icgIO6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018658; c=relaxed/simple;
	bh=j/KomTOcMyM/V6bDJdPxKUsTG92xGsRpdRN9eZeVWnQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KPFrIGMpL/UZUaSnBLTzM9xtkBzF7L0qN645jMfEx9luUi1ZxjvqQGO5+L1scBEokY4zAjq5rtJQw8nUAGWUfw+v6uF80OCIoqxOkpaQHA1o8wvFsxw7cr/s+IMDZctPbv74LkPaviE1WnpMqUcw3BW1PIiV5LxcrY0Ru0JuytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fn1U9iHB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c97e9ab2-dd71-4ce2-8a64-501309b39122@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722018654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1O66myPDy+abPa0H7sgc/G3ypUdQwX+ppPK4jEw5fs=;
	b=Fn1U9iHB147SlOZZThiBnzEks/09LpnsF0lbV957yUHG26Fa6A8me+QPjaN/s5/h5/UqrP
	PkAxWANPsZsbOJBgWEHM+2HAOhBDY0O0cXmA0Yv26buDRrpOwZldLOENj5RgEgBwi3KlM3
	Z2HljCJFOGLkS7C1CHjZpz+g47XGnk8=
Date: Fri, 26 Jul 2024 11:30:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 07/11] bpf: net_sched: Allow more optional
 operators in Qdisc_ops
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-8-amery.hung@bytedance.com>
 <f3bfe9a5-40e8-4a1c-a5e5-0f7f24b9e395@linux.dev>
Content-Language: en-US
In-Reply-To: <f3bfe9a5-40e8-4a1c-a5e5-0f7f24b9e395@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/25/24 6:15 PM, Martin KaFai Lau wrote:
>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> index 5064b6d2d1ec..9fb9375e2793 100644
>> --- a/net/sched/sch_api.c
>> +++ b/net/sched/sch_api.c
>> @@ -1352,6 +1352,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>>           rcu_assign_pointer(sch->stab, stab);
>>       }
>> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
>> +    if (sch->flags & TCQ_F_BPF) {
> 
> I can see the reason why this patch is needed. It is a few line changes and they 
> are not in the fast path... still weakly not excited about them but I know it 
> could be a personal preference.
> 
> I think at the very least, instead of adding a new TCQ_F_BPF, let see if the 
> "owner == BPF_MODULE_OWNER" test can be reused like how it is done in the 
> bpf_try_module_get().
> 
> 
> A rough direction I am spinning...
> 
> The pre/post is mainly to initialize and cleanup the "struct bpf_sched_data" 
> before/after calling the bpf prog.
> 
> For the pre (init), there is a ".gen_prologue(...., const struct bpf_prog 
> *prog)" in the "bpf_verifier_ops". Take a look at the tc_cls_act_prologue().
> It calls a BPF_FUNC_skb_pull_data helper. It potentially can call a kfunc 
> bpf_qdisc_watchdog_cancel. However, the gen_prologue is invoked too late in the 

typo. The kfunc should be s/qdisc_watchdog_cancel/qdisc_watchdog_init/ for the pre.

> verifier for kfunc calling now. This will need some thoughts and works.
> 
> For the post (destroy,reset), there is no "gen_epilogue" now. If 
> bpf_qdisc_watchdog_schedule() is not allowed to be called in the ".reset" and 
> ".destroy" bpf prog. I think it can be changed to pre also? There is a ".filter" 
> function in the "struct btf_kfunc_id_set" during the kfunc register.
> 
>> +        err = bpf_qdisc_init_pre_op(sch, tca[TCA_OPTIONS], extack);
>> +        if (err != 0)
>> +            goto err_out4;
>> +    } 


