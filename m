Return-Path: <bpf+bounces-68779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A06B84A3E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFCE2A3133
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E0303A3E;
	Thu, 18 Sep 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KPQxAtkX"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D90211C
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199547; cv=none; b=in2vhPGfMUWn3lhk+aM3t95bcgonsv6ROzXeeYsKdaBCCQ6gevo5VuWpRG19yMdktcUZURthyyL72xGJ0RcZASjQVVlvVL1zveheFw2osBhcf8BYnv/xmzax4dP7tT9Eyicfv9Vzm+KIFwDklm7RfLMkZXwZT4itT7/f0NcN88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199547; c=relaxed/simple;
	bh=mzKwFIqsGgXwEtbhpffy+ppn9zPepgeKleABiPhbzog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9Rjatop/DeGeGyTMuqBDw3/h5BFuj25/dVcwA4Bau4IO7vLMZBVFRbB0/s0mZ6FQ1OU72EsFcYZjdDwmnMjZqt17vggEo0+U1LzesAI8chvDuG1iBx8hpj7Li2IRgYfdwavu9jGNFA5dSHDFREFw/VD3qTwCNRIjmXIRBkJLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPQxAtkX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d9320eb-6be9-43e4-a63e-08e7ab1427e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758199532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGVg+fRknMB/K4YFDGb3eZrXnElVFr/VOGzCAPGLxQQ=;
	b=KPQxAtkXhPrj0tPDM2EfRpbVX1DCaMlCLevMwlE9WFx3vBJ82s8j9MRHr9g3k/OLZp2TIq
	K5hY9toagB78O4PAtjLuNYtKTE+cSF0490N0h/7U44AipAW0/nXFQdYXb60lFfp0AfORMj
	lqugtJvtAexNVqTYyaXDCqNvVGy68rQ=
Date: Thu, 18 Sep 2025 20:45:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for
 BPF_MAP_STACK_TRACE
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909163223.864120-1-chen.dylane@linux.dev>
 <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/18 06:16, Andrii Nakryiko 写道:
> On Tue, Sep 9, 2025 at 9:32 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The stacktrace map can be easily full, which will lead to failure in
>> obtaining the stack. In addition to increasing the size of the map,
>> another solution is to delete the stack_id after looking it up from
> 
> This is not a "solution", really. Just another partially broken
> workaround to an already broken STACKMAP map (and there is no fixing
> it, IMO).
>

Actually it is. But in our use case, we used continuous profiling with 
perf_event, the result looks better when we got the stack_id and deleted 
it to alleviate the data size pressure in the map. And there is no high 
requirement for the accuracy of stack information for us.

> When a user is doing lookup_and_delete for that element, another BPF
> program can reuse that slot, and user space will delete the stack that
> is, effectively, still in use.
> 
> <rant>
> 
> I also just looked at the bpf_stackmap_copy() implementation, and even
> lookup behavior appears broken. We temporarily remove the bucket while
> copying, just to put it back a bit later. Meanwhile another BPF
> program can put something into that bucket and we'll just silently
> discard that new value later. That was a new one for me, but whatever,

Yes, it is a problem.

> as I said STACKMAP cannot be used reliably anyways.
> 
> </rant>
> 
> But let's stay constructive here. Some vague proposals below.
> 
> Really, STACKMAP should have used some form of refcounting and let
> users put those refs, instead of just unconditionally removing the
> element. I wonder if we can retrofit this and treat lookup/delete as
> get/put instead? This would work well for a typical use pattern where
> we send stack_id through ringbuf of some sort and user space fetches
> stack trace by that ID. Each bpf_get_stackid() would be treated as
> refcount bump, and each lookup_and_delete or just delete would be
> treated as refcount put.
> 
> Also, it would be better for STACKMAP to be a proper hashmap and
> handle collisions properly.
> 
> The above two changes would probably make STACKMAP actually usable as
> "a stack trace bank" producing 4-byte IDs that are easily added to
> fixed-sized ringbuf samples as an extra field. This model sometimes is
> way more convenient than getting bpf_get_stack() and copying it into
> ringbuf (which is currently the only way to have reliable stack traces
> with BPF, IMO).
> 
> So, tl;dr. Maybe instead of pretending like we are fixing something
> about STACKMAP with slightly-more-atomic (but not really)
> lookup_and_delete support, maybe let's try to actually make STACKMAP
> usable?.. (it's way harder than this patch, but has more value, IMO)
> 

The idea looks great. I will try to make improvements in this direction, 
though there will be certain challenges for me right now.

> What does everyone think?
> 
> P.S. It seems like a good idea to switch STACKMAP to open addressing
> instead of the current kind-of-bucket-chain-but-not-really
> implementation. It's fixed size and pre-allocated already, so open
> addressing seems like a great approach here, IMO.
> 
>> the user, so extend the existing bpf_map_lookup_and_delete_elem()
>> functionality to stacktrace map types.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/bpf.h   |  2 +-
>>   kernel/bpf/stackmap.c | 16 ++++++++++++++--
>>   kernel/bpf/syscall.c  |  8 +++++---
>>   3 files changed, 20 insertions(+), 6 deletions(-)
>>
> 
> As for the patch in question, I think the logic is correct :) I find
> bpf_stackmap_copy_and_delete() name bad and misleading, though,
> because it's more of "maybe also delete". Maybe
> bpf_stackmap_extract()? Don't know, it's minor nit anyways.
> 
> [...]Will rename it in v2. The original idea in this patch was just to
make it convenient for users to delete the stackid when they obtain it.

-- 
Best Regards
Tao Chen

