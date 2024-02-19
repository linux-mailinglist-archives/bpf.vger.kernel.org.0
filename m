Return-Path: <bpf+bounces-22265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3285AB9C
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F0B1F22A43
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33B45BFA;
	Mon, 19 Feb 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CczgDfjA"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3821CABC
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368990; cv=none; b=Mgd+GCTOkKT7CGftHc65kHHXmQs3704qa2H05iY8rZ3fVnxq1nBh8HtDtfY0l+OabiwBdUgzjlJYGuwQKr667olRR6FPF5+pKMlRYepIL8nnriX42fJYpjsV0C6RpgwDpPMETR6R+hgHBbdY5UScmhkvIB5Ittj6NQ10YAxBbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368990; c=relaxed/simple;
	bh=JoqP/GVsQXUXvqbaQ9qUcoHBmlT+3x+sQLHSLAF3rHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hl/Lf8L5JOGknTOM+NZLZIS/SJP8XWtPNJq8rDbd2GWx3o2enZnEhw18KxYrerxZn8YDlCb68XKFQ8R/76kHuWW4vbTWbhOSD9wHGOPvpQv8nFP/4g3PL42kIDqpIINf0le9FhwtqgE7IcY7ELZH6nxVEvpJ1AjLttN5yz1lNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CczgDfjA; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26a1cd82-8fa0-4e99-9e8b-a6e136ac7e0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708368985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRc+S6Awk8/9DraSVwshbqGBbSkcdWIaIofu3uzboeU=;
	b=CczgDfjAQIgSScj5VnuxPhM+gb/fRCZT1LAJS9bjHxzZC6jpZB8kwDepxF4DKqtmgD+Yvj
	VIANInUzZfaLfYWmy4fdL4/D6YQwR7A3L3RKpy5su08w8eSMqK4qIvuBr0QgChfH+2D5Uz
	EAlPoxEtcql9L6HdG4k+UFGj47mo1oE=
Date: Mon, 19 Feb 2024 10:56:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Segmented Stacks for BPF Programs
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, David Vernet <void@manifault.com>,
 lsf-pc@lists.linux-foundation.org
References: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>
 <g2eynf5qrku2y5g433syeftgp3l2yg2sqawmvcee37ygezkslx@tklh2vnevwhx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <g2eynf5qrku2y5g433syeftgp3l2yg2sqawmvcee37ygezkslx@tklh2vnevwhx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/15/24 9:03 PM, Daniel Xu wrote:
> Hi Yonghong,
>
> On Wed, Feb 14, 2024 at 11:53:13AM -0800, Yonghong Song wrote:
>> For each active kernel thread, the thread stack size is 2*PAGE_SIZE ([1]).
>> Each bpf program has a maximum stack size 512 bytes to avoid
>> overflowing the thread stack. But nested bpf programs may post
>> a challenge to avoid stack overflow.
>>
>> For example, currently we already allow nested bpf
>> programs esp in tracing, i.e.,
>>    Prog_A
>>      -> Call Helper_B
>>        -> Call Func_C
>>          -> fentry program is called due to Func_C.
>>            -> Call Helper_D and then Func_E
>>              -> fentry due to Func_E
>>                -> ...
>> If we have too many bpf programs in the chain and each bpf program
>> has close to 512 byte stack size, it could overflow the kernel thread
>> stack.
> Just curious - overflowing the thread stack would cause some kind of
> panic right? And also, segmented/split stacks for bpf just reduces

Yes. immediately after normal thread stack, there is a guard page.
If there is a load/store to that guard page, kernel will panic.

> likelihood of stack overflow due to BPF prog stack requirements. In

This is the intention as bpf prog will use a separate stack
for all its local variables.

> theory, a deep call stack due to fentry probes could still occur, right?

Yes, although currently I did not see a lot of use cases for this, but
still it is possible.

>
> [...]
>
> Thanks,
> Daniel

