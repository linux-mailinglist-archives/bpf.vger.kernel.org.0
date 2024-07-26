Return-Path: <bpf+bounces-35756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D39993D8FD
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 21:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B35284462
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD3433B9;
	Fri, 26 Jul 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GWRiH78+"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF18210EC
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022453; cv=none; b=Ac7wHmzhK2PdQtu3P0gS65/KZDmrbQCK9jGRgwhyNDfOqwi3x73wiYn1kOo/iAJDJLxJzhOMW6OMOofdeW4flKjz/fQORMqHhZ8vM5KvIYN1YiSrIHxnQyqDEzOEE4ZgqhiZEqqqNB+oFT8TH7L0iYRYdpvgN500w19hqoaO4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022453; c=relaxed/simple;
	bh=pCodZNenu66lWzVH0AtMl7LkCqMPPT5+VDpuwd9yFo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXVCZA0ShyS3hf84B86rd4AU3D+zMlaSAnVvJJEi9VSABMpIzKOa8vTHk/PJiN0Ym4vaZXzL5y9IRGPZ7lr/84fpaucOtCXD/YhByYv0ATTt4n2YU9u5WpNbsqgd6ohqvmBG+fkHDMcAdHdb3F7hePDs53zf0cV/kWKwopxn6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GWRiH78+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b3dbe1c-3771-4bb9-b01a-647943fb7ec8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722022449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHwIykuHQavL3Wd86VItWDgV9PfhdAoSBxGuqsImz+I=;
	b=GWRiH78+Oe6lM/f6zYMKvX5gv9pDLTtrQSf/NnHH1SM/Hc+UgnVmwfdoHG54cCo4aIhPZK
	jxEqXLIfUK/mbFUlVJWjHe0onNFBQqYMkmVtf2H6+LKaeI0uiZubYcgsjcxmRB5qzfTIOk
	5HnlPsGZxbyXHG8/LFDyF0prIdo9N5I=
Date: Fri, 26 Jul 2024 12:34:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix updating attached freplace prog
 to prog_array map
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240726153952.76914-1-leon.hwang@linux.dev>
 <20240726153952.76914-2-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240726153952.76914-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 8:39 AM, Leon Hwang wrote:
> The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
> resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed a NULL pointer
> dereference panic, but didn't fix the issue that fails to update attached
> freplace prog to prog_array map.
>
> Since commit 1c123c567fb138eb ("bpf: Resolve fext program type when
> checking map compatibility"), freplace prog and its target prog are able
> to tail call each other.
>
> And the commit 3aac1ead5eb6b76f ("bpf: Move prog->aux->linked_prog and
> trampoline into bpf_link on attach") sets prog->aux->dst_prog as NULL
> after attaching freplace prog to its target prog.

Similar to my previous comment in the cover letter, please use 12 alphanum
for the commit and the commit subject should be in the same line.

>
> Then, as for following example:
>
> tailcall_freplace.c:
>
> // SPDX-License-Identifier: GPL-2.0
>
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
>
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> int count = 0;
>
> SEC("freplace")
> int entry_freplace(struct __sk_buff *skb)
> {
> 	count++;

Empty line is not necessary.

> 	bpf_tail_call_static(skb, &jmp_table, 0);

Empty line is not necessary.

> 	return count;
> }
>
> char __license[] SEC("license") = "GPL";
>
> tc_bpf2bpf.c:
>
> // SPDX-License-Identifier: GPL-2.0
>
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
>
> __noinline
> int subprog(struct __sk_buff *skb)
> {
> 	volatile int ret = 1;
>
> 	asm volatile (""::"r+"(ret));

Let us replace the above asm volatile to __sink(ret). Also, I think 'volatile' is not needed.

Also remove the empty line.

> 	return ret;
> }
>
> SEC("tc")
> int entry_tc(struct __sk_buff *skb)
> {
> 	return subprog(skb);
> }
>
> char __license[] SEC("license") = "GPL";
>
> And entry_freplace's target is the entry_tc's subprog.
>
> After loading entry_freplace, the jmp_table's owner type is
> BPF_PROG_TYPE_SCHED_CLS.
>
> Next, after attaching entry_freplace to entry_tc's subprog, its prog->aux->
> dst_prog is NULL.
>
> Next, while updating entry_freplace to jmp_table, bpf_prog_map_compatible()
> returns false because resolve_prog_type() returns BPF_PROG_TYPE_EXT instead
> of BPF_PROG_TYPE_SCHED_CLS.
>
> With this patch, resolve_prog_type() returns BPF_PROG_TYPE_SCHED_CLS to
> support updating the attached entry_freplace to jmp_table.
>
> Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Other than the above, LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


