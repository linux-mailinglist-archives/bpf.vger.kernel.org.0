Return-Path: <bpf+bounces-51633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BFA36B4B
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6003B1FB1
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D27F7FC;
	Sat, 15 Feb 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcJesFiB"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A69DDA8
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585359; cv=none; b=U2BErlhl+xMUaKja6KfXEViSn0KajOkdJSEgYIbr74Lzfji/pgcO6y9vUw6v3wJNJRjxh//OUapl9XNeHABSuGpDL6sZ3hhBp4pUotvKhUBgupCXFOe4aA43qZsThya3lmE+EF8+cMdV5QAcwvAQevGiH0FXV/2raayuE1adaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585359; c=relaxed/simple;
	bh=SfnftK2r6Tu9TN9G33HcsJhU60gn2dEGHYC6pODa974=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfSka8vWjagMFrhe9G7JPcqDH7iUT4/wUFrbuYtBL2sBzhSsVSILe1LhhbIH15OXquiKEUqOuMNsV4v2y3oZW9cvq/C2IZ2bZ2RQIYaqGzVWfiJIsMQqpp9jQ7qVj4MVTSdruPyFI2NPaEiM0PmP93Mxw0ZtVNvXAjwpXxbANwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcJesFiB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45dd4b34-e8e0-47d0-a91a-9d2c6d3196a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739585354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTvyFD3p/zZR9FjTDyvZK/P6e9kx0yA3T9E/AoBkP2k=;
	b=xcJesFiBi/gZdU1bHI6zU2UVq8vW1nqNf20a6ZiIcW7SEU4AQQbCMdQRx6ibZntyh7WzcM
	1x25hjU04MviV3YrmgsTDvaz4Dwx5kByJSyy4c74n9DJDoOlgM47Nq9eymtCYjjrSpfHO3
	cAVAmZA7DQMelRl7VHLefmkfIi//29g=
Date: Fri, 14 Feb 2025 18:09:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/5] Extend struct_ops support for operators
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com
References: <20250214164520.1001211-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250214164520.1001211-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 8:45 AM, Amery Hung wrote:
> Hi,
> 
> I am splitting the bpf qdisc patchset into smaller landable sets and
> this is the first part.
> 
> This patchset supports struct_ops operators that acquire kptrs through
> arguments and operators that return a kptr. A coming new struct_ops use
> case, bpf qdisc [0], has two operators that are not yet supported by
> current struct_ops infrastructure. Qdisc_ops::enqueue requires getting
> referenced skb kptr from the argument; Qdisc_ops::dequeue needs to return
> a referenced skb kptr. This patchset will allow bpf qdisc and other
> potential struct_ops implementers to do so.
> 
> For struct_ops implementers:
> 
> - To get a kptr from an argument, a struct_ops implementer needs to
>    annotate the argument name in the stub function with "__ref" suffix.
> 
> - The kptr return will automatically work as we now allow operators that
>    return a struct pointer.
> 
> - The verifier allows returning a null pointer. More control can be
>    added later if there is a future struct_ops implementer only expecting
>    valid pointers.
> 
> For struct_ops users:
> 
> - The referenced kptr acquired through the argument needs to be released
>    or xchged into maps just like ones acquired via kfuncs.
> 
> - To return a referenced kptr in struct_ops,
>    1) The type of the pointer must matches the return type
>    2) The pointer must comes from the kernel (not locally allocated), and
>    3) The pointer must be in its unmodified form

I only left some minor comments in the patches.

A few other thoughts:

I think https://lore.kernel.org/bpf/20250210174336.2024258-11-ameryhung@gmail.com/
should be a good addition also. A new subtest in the prog_tests/pro_epilogue.c
should do for testing it.

Another thing is disabling tail call in the bpf_qdisc_get_func_proto in
https://lore.kernel.org/bpf/20250210174336.2024258-9-ameryhung@gmail.com/
I am wondering if it can be done in a generic way for all struct_ops in
check_struct_ops_btf_id(). At that point, we should know all the "has_tail_call".
I meant only for ops with __ref arg such that it won't break the existing
struct_ops.

I think both of them could be a followup.

