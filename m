Return-Path: <bpf+bounces-70490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE4BC0217
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 06:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D3F3A7286
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90A217723;
	Tue,  7 Oct 2025 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cmyho6/C"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8A20FAAB
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809935; cv=none; b=XyCJ/cq/tK1MOpTjHSPmJqkrtl3J5K57oGBQ2J14vvwcbV1mh9r6IumtmTe2kUJav6E6sIn70cy1ZpuLt1rBkuu8huwgoGeA+z0LZELfo1Qh+RAnSC1fBy5Mg6/6RfDLDVFFe8y/QxWQ40YQMP6IJ1eY+G/cP2/cw7MGvSIMsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809935; c=relaxed/simple;
	bh=o6K8MXxBxZXWW0NnX0lkhK7EDHOV3mtYRrDuLF0iKt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkSK3YhoahKcE6AHu53OnmV02kDlKKRj4++KFCElicjZb9j7ftHW1Hwa0bFP4XjlJFE0Ba9DvA3iPRVz1nbbQilcMQ6SVjG5fzzC8P6Dc4C8AJXmyn83FiEotQdUPKQKHFYjrf0lzSMYXrM1hOcwU+DF/VMXlDCkjoPxvslCCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cmyho6/C; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e24a7e9-fe8c-4af8-b775-ccc75e6af091@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759809930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNJCitJ4Tnp0EPXiVoeBb+P+yX7efY+z34gCVdRRGPw=;
	b=Cmyho6/ClxGN8TrhgGXngFbEr2PRb6hV/z+SW6bS77Yme4T33Z+d5OAz7GmIs4dgBCaJyn
	kLUowKujrHrGRwgQXfj/8mEl6f9WiZM2F+bSD7Oc087xc/3HQrrIdxwTCy4W4y+P9ePr5w
	gPHLtsV3Fkkls6DQFDLTR+a/YkOqn4A=
Date: Mon, 6 Oct 2025 21:05:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Avoid RCU context warning when unpinning
 htab with internal structs
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, toke@redhat.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Le Chen <tom2cat@sjtu.edu.cn>
References: <20251007012235.755853-1-kafai.wan@linux.dev>
 <20251007012235.755853-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251007012235.755853-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/6/25 6:22 PM, KaFai Wan wrote:
> When unpinning a BPF hash table (htab or htab_lru) that contains internal
> structures (timer, workqueue, or task_work) in its values, a BUG warning
> is triggered:
>   BUG: sleeping function called from invalid context at kernel/bpf/hashtab.c:244
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name: ksoftirqd/0
>   ...
>
> The issue arises from the interaction between BPF object unpinning and
> RCU callback mechanisms:
> 1. BPF object unpinning uses ->free_inode() which schedules cleanup via
>     call_rcu(), deferring the actual freeing to an RCU callback that
>     executes within the RCU_SOFTIRQ context.
> 2. During cleanup of hash tables containing internal structures,
>     htab_map_free_internal_structs() is invoked, which includes
>     cond_resched() or cond_resched_rcu() calls to yield the CPU during
>     potentially long operations.
>
> However, cond_resched() or cond_resched_rcu() cannot be safely called from
> atomic RCU softirq context, leading to the BUG warning when attempting
> to reschedule.
>
> Fix this by changing from ->free_inode() to ->destroy_inode() and rename
> bpf_free_inode() to bpf_destroy_inode() for BPF objects (prog, map, link).
> This allows direct inode freeing without RCU callback scheduling,
> avoiding the invalid context warning.
>
> Reported-by: Le Chen <tom2cat@sjtu.edu.cn>
> Closes: https://lore.kernel.org/all/1444123482.1827743.1750996347470.JavaMail.zimbra@sjtu.edu.cn/
> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


