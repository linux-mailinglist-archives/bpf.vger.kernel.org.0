Return-Path: <bpf+bounces-48739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B5A100DA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 07:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA903A7CEA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB391235BE5;
	Tue, 14 Jan 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="foijGXzz"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D023099D
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736836535; cv=none; b=GBfzGxDNxM661aXuQy6hNdcNnVLCjc5W7uzjMpDZvOe8/rEk/JiG89m19KW71mf9sCEuj+XpbUuK1hDcN4dJQWHkXTpyG2/Sw5C3rezEmGRuAOg5FYhT+3V9VkxGVnagBLTYfrxE5gIh8YYudFp3Jl3no4GkTNmbMarLVRYqoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736836535; c=relaxed/simple;
	bh=5IlvV0cqNVHylw36J0/Hjiow/V1gwZFuw9Hz2Um8X9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZRppPEmSHmc6lsoaQxfXzJj+FthNkV8Q+h8Lt+Usas1digblR+140XZNOzVUiFRCdH605gx6rsKqRA8Pykb1y/s1wc3dJhqBO5JRMzsjFnVp/uM1lQmmOChDoxWvKnIkTTstLGuWFKJoKOo6Ffn/1QcxiEbmBqSk36CwjHgYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=foijGXzz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91d1adea-e8a0-48dd-b6dd-50402db7911d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736836530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+2hYN6PNxJY0hjQRtjYE+eFJCYrpPVro4wzadWtIws=;
	b=foijGXzzKHv9pwxLC+f1Ekjg/baWYHaoXwCRpzsAiIWTz6Xq0CwQquBeLYZKczgIQyps3m
	MZLf3sSCWfz1LnysHCx64gwy7O0gcHIDw49j1lJwTGjzDBmH6dpxQTtWUNpUGUCLmlVHz7
	e/Ijp0PmsHK0TKHdaevrtBfqEcxY5NY=
Date: Tue, 14 Jan 2025 14:35:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Introduce global percpu data
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20250113152437.67196-1-leon.hwang@linux.dev>
 <jfo4cgmk76zibxylkclgw4u7j47phg2ic4ogilhgz52ddilsui@gc3hiffnezkc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <jfo4cgmk76zibxylkclgw4u7j47phg2ic4ogilhgz52ddilsui@gc3hiffnezkc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Daniel Xu,

On 14/1/25 00:58, Daniel Xu wrote:
> Hi Leon,
> 
> On Mon, Jan 13, 2025 at 11:24:35PM +0800, Leon Hwang wrote:
>> This patch set introduces global per-CPU data, similar to commit
>> 6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictions
>> in C for BPF programs.
>>
>> With this enhancement, it becomes possible to define and use global per-CPU
>> variables, much like the DEFINE_PER_CPU() macro in the kernel[0].
>>
>> The idea stems from the bpflbr project[1], which itself was inspired by
>> retsnoop[2]. During testing of bpflbr on the v6.6 kernel, two LBR
>> (Last Branch Record) entries were observed related to the
>> bpf_get_smp_processor_id() helper.
>>
>> Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
>> the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
>> the overhead and consequently minimizing these two LBR records.
>>
>> However, the introduction of global per-CPU data offers a more robust
>> solution. By leveraging the percpu_array map and percpu instructions,
>> global per-CPU data can be implemented intrinsically.
>>
>> This feature also facilitates sharing per-CPU information between tail
>> callers and callees or between freplace callers and callees through a
>> shared global per-CPU variable. Previously, this was achieved using a
>> 1-entry percpu map, which this patch set aims to improve upon.
> 
> I think this would be great to have. bpftrace would've liked to use this
> for its recent big string support, but instead had to simulate a percpu
> global through regular globals.
> 

Thank you for the feedback! I'm glad to hear that this feature could
help simplify bpftrace, especially for use cases like the recent big
string support. It's great to know this feature has potential to address
more real-world challenges.

Thanks,
Leon



