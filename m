Return-Path: <bpf+bounces-22273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E485B004
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 01:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39721B21E67
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 00:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FA17F6;
	Tue, 20 Feb 2024 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M5hg8pAy"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1C15BB
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708388741; cv=none; b=n7n3kk0GOe0qZxgYjzCB5BGmvv7s+xC8nxuxeS3N8HDv617R5gflBrz38h5CALxubWuUhqk4JVIUrcyHCer1Jelek/ETTNu2yU2JujYjL5A+yShAXEIFjPe/u53CibQW5WMq0X1gqBFHqzdGkaFso3EQMN6jHRLceppBrPtTm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708388741; c=relaxed/simple;
	bh=WkcAqIaEmKG2lz+mWq4qRiQnuAmmN619esXlTolgQnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onRK6/Nc29miU2MNqShdLPHeWcnt94pSgoZ4lBsqqOz1u/lHV37AUhts6Wus7Ap/oNuxZLI+LlpxL8LfH7q69brm3IxdJxo//X4eKi7uBM/KMdAe7HqkCaIJdxlp8IwOE2zIYbySvk+pr3sR8gHV4er6l7qOXjtmHqtn09FWiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M5hg8pAy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f21c1a87-a657-407b-a074-496503edd20e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708388737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tp+xcGFSxyPlC/H+ak3Mkq2Y+jZatU49IreSsReZE4E=;
	b=M5hg8pAyIdCzVSpK6WP/nzmhsG6exIWQINAGsOTtfypGVX2peUGDZKUXghX9bzjXeAmuCd
	g9/PLhPAzi5pPhf5j/SHJoydDw5FosLHhNBhBRJ1Ns1UJxiDlERNUy4+R79/1hAcd763cD
	GLVd9a+gYPIzrZTgNnAQf+8BTKg2XC0=
Date: Mon, 19 Feb 2024 16:25:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, kuniyu@amazon.com
References: <20240212143832.28838-1-eddyz87@gmail.com>
 <20240212143832.28838-3-eddyz87@gmail.com>
 <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
 <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
 <0e5b990eeaa63590e067c8ac10642b6bc6d0e9a8.camel@gmail.com>
 <1fbcd9f1-6c83-4430-b797-a92285d1d151@linux.dev>
 <9e19786565a3fbfea58dcd25bba644fe8e0ed6b0.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9e19786565a3fbfea58dcd25bba644fe8e0ed6b0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/16/24 6:27 AM, Eduard Zingerman wrote:
> On Wed, 2024-02-14 at 09:42 -0800, Yonghong Song wrote:
>
>>>    .------------------------------------- Checkpoint / State name
>>>    |    .-------------------------------- Code point number
>>>    |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
>>>    |    |   |        .------------------- Callback depth in frame #0
>>>    v    v   v        v
>>> 1  - (0) {7P,7P,7},depth=0
>>> 2    - (3) {7P,7P,7},depth=1
>>> 3      - (0) {7P,7P,42},depth=1
>>> (a)      - (3) {7P,7,42},depth=2
>>> 4          - (0) {7P,7,42},depth=2      loop terminates because of depth limit
>>> 5            - (4) {7P,7,42},depth=0    predicted false, ctx.a marked precise
>>> 6            - (6) exit
>>> 7        - (2) {7P,7,42},depth=2
>>> 8          - (0) {7P,42,42},depth=2     loop terminates because of depth limit
>>> 9            - (4) {7P,42,42},depth=0   predicted false, ctx.a marked precise
>>> 10           - (6) exit
>>> (b)      - (1) {7P,7P,42},depth=2
>>> 11         - (0) {42P,7P,42},depth=2    loop terminates because of depth limit
>>> 12           - (4) {42P,7P,42},depth=0  predicted false, ctx.{a,b} marked precise
>>> 13           - (6) exit
>>> 14   - (2) {7P,7,7},depth=1
>>> 15     - (0) {7P,42,7},depth=1          considered safe, pruned using checkpoint (a)
>>> (c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)
>> For the above line
>>      (c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)
>> I would change to
>>      (c)  - (1) {7P,7P,7},depth=1
>>             - (0) {42P, 7P, 7},depth = 1     considered safe, pruned using checkpoint (11)
> At that point:
> - there is a checkpoint at (1) with state {7P,7P,42}
> - verifier is at (1) in state {7,7,7}
> Thus, verifier won't proceed to (0) because {7,7,7} is states_equal to {7P,7P,42}.

Okay, I think the above example has BPF_F_TEST_STATE_FREQ set as in Patch 3. It will
be great if you can explicitly mention this (BPF_F_TEST_STATE_FREQ) in the commit message.
With this flag,
   (c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)
is correct.

But then for
   14   - (2) {7P,7,7},depth=1
   15     - (0) {7P,42,7},depth=1          considered safe, pruned using checkpoint (a)
The state
   14   - (2) {7P,7,7},depth=1
will have state equal to
    7        - (2) {7P,7,42},depth=2
right?
   

>
>> For
>> 14   - (2) {7P,7,7},depth=1
>> 15     - (0) {7P,42,7},depth=1          considered safe, pruned using checkpoint (a)
>> I suspect for line 15, the pruning uses checking point at line (8).
> Right, because checkpoints for a particular insn form a stack. My bad.
>
>> Other than the above, the diagram LGTM.
> Thank you for the feedback, I'll post v2 shortly.

