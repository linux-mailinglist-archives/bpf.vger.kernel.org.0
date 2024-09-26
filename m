Return-Path: <bpf+bounces-40337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D73986D62
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB22B2162A
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE0187851;
	Thu, 26 Sep 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2FhgltW"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D18224D6
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335001; cv=none; b=O0MDmddEjFx0L53R9SQoy3qGbZHD/u5mffMMjKy9wyfTVxn7br1QvIivfNWA5dpqmuyZ9X6Kjb7ONqmcUVzlSQcVgZtxTfgTh/uEVpchf5Agd7Pae26zd2poDtsHzQR4kWjbnvWEfOyK0HZ2G73Cg9F9IxW+lBAb++WjXBSoVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335001; c=relaxed/simple;
	bh=aLd1dBBjDCnXFKssmuiAHlADOGIEryKdovB/aPYcvec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOTMqPltHNOOqdggahYc6vQm0uPbfeXUflAnXnz5oSpHK84prRD+euoDmpj0DQTN+7YGqTwPPg5dmrESBKSCUq4CprM1zGOfRER80lRTwsZHePvUCTqcDPoxeA6ruX7ZSwblI1cz7iLxuk3SkmX4XmcJjOWDamEq4AkZetLTpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2FhgltW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aac4921a-3f09-4c62-af92-df9f8412dcf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727334997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0BA+wUoq8yius4lD6af4t7plXr6Mi/ong07HszRwwY=;
	b=q2FhgltWqAvv4JsVDy/+B4dAa3U0UkHHSSE+3/LiBnaMP7+v+QckzQV8QpYTVAX07lMY2g
	rSRhqpqtY20gtKmCyqDwgZ0p5Agksv0tNA1pRDpdKrDvegi1BgnPrcJeJHxeHleHJaGvHd
	xh6POdte2p3bWnUP22tsqMmBd9MLp3I=
Date: Thu, 26 Sep 2024 15:16:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Prevent updating extended prog to
 prog_array map
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240923134044.22388-1-leon.hwang@linux.dev>
 <20240923134044.22388-2-leon.hwang@linux.dev>
 <b879d9cf7eebd1e38492c76d7878a767b0245923.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <b879d9cf7eebd1e38492c76d7878a767b0245923.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Eduard,

Thank you for your review.

On 25/9/24 09:24, Eduard Zingerman wrote:
> On Mon, 2024-09-23 at 21:40 +0800, Leon Hwang wrote:
> 
> [...]
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 8a4117f6d7610..18b3f9216b050 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3292,8 +3292,11 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>>  	bpf_trampoline_put(tr_link->trampoline);
>>  
>>  	/* tgt_prog is NULL if target is a kernel function */
>> -	if (tr_link->tgt_prog)
>> +	if (tr_link->tgt_prog) {
>> +		if (link->prog->type == BPF_PROG_TYPE_EXT)
>> +			tr_link->tgt_prog->aux->is_extended = false;
>>  		bpf_prog_put(tr_link->tgt_prog);
>> +	}
>>  }
>>  
>>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
>> @@ -3523,6 +3526,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>  	if (prog->aux->dst_trampoline && tr != prog->aux->dst_trampoline)
>>  		/* we allocated a new trampoline, so free the old one */
>>  		bpf_trampoline_put(prog->aux->dst_trampoline);
>> +	if (prog->type == BPF_PROG_TYPE_EXT)
>> +		tgt_prog->aux->is_extended = true;
>>  
>>  	prog->aux->dst_prog = NULL;
>>  	prog->aux->dst_trampoline = NULL;
> 
> Sorry, this might be a silly question, I do not fully understand how
> programs and trampolines are protected against concurrent update.
> 

There's no protection against concurrent update.

> Sequence of actions in bpf_tracing_prog_attach():
> a. call bpf_trampoline_link_prog(&link->link, tr)
>    this returns success if `tr->extension_prog` is NULL,
>    meaning trampoline is "free";
> b. update tgt_prog->aux->is_extended = true.
> 
> Sequence of actions in bpf_tracing_link_release():
> c. call bpf_trampoline_unlink_prog(&tr_link->link, tr_link->trampoline)
>    this sets `tr->extension_prog` to NULL;
> d. update tr_link->tgt_prog->aux->is_extended = false.
> 
> In a concurrent environment, is it possible to have actions ordered as:
> - thread #1: does bpf_tracing_link_release(link pointing to tgt_prog)
> - thread #2: does bpf_tracing_prog_attach(some_prog, tgt_prog)
> - thread #1: (c) tr->extension_prog is set to NULL
> - thread #2: (a) tr->extension_prog is set to some_prog
> - thread #2: (b) tgt_prog->aux->is_extended = true
> - thread #1: (d) tgt_prog->aux->is_extended = false
> 
> Thus, loosing the is_extended mark?

Yes, you are correct.

> 
> (As far as I understand bpf_trampoline_compute_key() call in
>  bpf_tracing_prog_attach() it is possible for threads #1 and #2 to
>  operate on a same trampoline object).
> 

In order to avoid the above case:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6988e432fc3d..1f19b754623c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3281,6 +3281,9 @@ static void bpf_tracing_link_release(struct
bpf_link *link)
        struct bpf_tracing_link *tr_link =
                container_of(link, struct bpf_tracing_link, link.link);

+       if (link->prog->type == BPF_PROG_TYPE_EXT)
+               tr_link->tgt_prog->aux->is_extended = false;
+
        WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
                                                tr_link->trampoline));

@@ -3518,6 +3521,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog
*prog,
        if (prog->aux->dst_trampoline && tr != prog->aux->dst_trampoline)
                /* we allocated a new trampoline, so free the old one */
                bpf_trampoline_put(prog->aux->dst_trampoline);
+       if (prog->type == BPF_PROG_TYPE_EXT)
+               tgt_prog->aux->is_extended = true;

        prog->aux->dst_prog = NULL;
        prog->aux->dst_trampoline = NULL;

In bpf_tracing_link_release():
1. update tr_link->tgt_prog->aux->is_extended = false.
2. bpf_trampoline_unlink_prog().

In bpf_tracing_prog_attach():
1. bpf_trampoline_link_prog().
2. update tgt_prog->aux->is_extended = true.

Then, it is able to avoid losing the is_extended mark.

Thanks,
Leon


