Return-Path: <bpf+bounces-40691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE298C201
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815C6283603
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579A1C9EDC;
	Tue,  1 Oct 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F7fZNdVb"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF651C6F6E
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797696; cv=none; b=ZDJ30VMpUDpWXope6847rymgK0NzKsSlsy14X++jHZD+eJVtaO2V4/B6PHpNdrP5rEuTzFFrIorRK5An1KKoBQSn84KhDdAt1lgO7J/p/iEo9Agh8VPXwSq20AKhOgzgiRNWK+vvLWi8RvD05xGSmVBWAoN9YMIH7HgSy/YbneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797696; c=relaxed/simple;
	bh=FfULulB0EVznGzrb6EIU+D7zwd93uvLHHcnYsVzJ9Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqeCOsSek2R6B+/VHnZFqqOQPQ4KmIKv5I3pGBvhewNHKpBwaWEVlOlEV2CyYuM1IHS/5an3SCoZJoWrdpH2qXnzrGMD9q4/8DnfeBOA3KqD313fAINQAl9+suLWIIxX4S3BSIK/BNyVZ6bKfDx8LJHwotkjc4q1ylPBuWUFJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F7fZNdVb; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727797691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzMDWHT2EciKHOB8kY0N9p/k+iIyyTKdvdi811bFij8=;
	b=F7fZNdVbfIOhXyVILQwNoy8SmbuF6o9Zy4aD2ZHcptj9VJ6l9+ba9TVTobN0L6lXkk2NJM
	4NKfoB2hmjhSNuBGs5MCUhxwB6f6yKNsK+FAyMwD8zFIQvZ6S811a4C35EKlMoeOuBLl17
	vXpzc79/EEVR1uyvi+GDQe42w7d8LKE=
Date: Tue, 1 Oct 2024 08:48:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod
 operations
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/30/24 6:50 PM, Alexei Starovoitov wrote:
> On Thu, Sep 26, 2024 at 8:39 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Patch [1] fixed possible kernel crash due to specific sdiv/smod operations
>> in bpf program. The following are related operations and the expected results
>> of those operations:
>>    - LLONG_MIN/-1 = LLONG_MIN
>>    - INT_MIN/-1 = INT_MIN
>>    - LLONG_MIN%-1 = 0
>>    - INT_MIN%-1 = 0
>>
>> Those operations are replaced with codes which won't cause
>> kernel crash. This patch documents what operations may cause exception and
>> what replacement operations are.
>>
>>    [1] https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@linux.dev/
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../bpf/standardization/instruction-set.rst   | 25 +++++++++++++++----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
>> index ab820d565052..d150c1d7ad3b 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -347,11 +347,26 @@ register.
>>     =====  =====  =======  ==========================================================
>>
>>   Underflow and overflow are allowed during arithmetic operations, meaning
>> -the 64-bit or 32-bit value will wrap. If BPF program execution would
>> -result in division by zero, the destination register is instead set to zero.
>> -If execution would result in modulo by zero, for ``ALU64`` the value of
>> -the destination register is unchanged whereas for ``ALU`` the upper
>> -32 bits of the destination register are zeroed.
>> +the 64-bit or 32-bit value will wrap. There are also a few arithmetic operations
>> +which may cause exception for certain architectures. Since crashing the kernel
>> +is not an option, those operations are replaced with alternative operations.
>> +
>> +.. table:: Arithmetic operations with possible exceptions
>> +
>> +  =====  ==========  =============================  ==========================
>> +  name   class       original                       replacement
>> +  =====  ==========  =============================  ==========================
>> +  DIV    ALU64/ALU   dst /= 0                       dst = 0
>> +  SDIV   ALU64/ALU   dst s/= 0                      dst = 0
>> +  MOD    ALU64       dst %= 0                       dst = dst (no replacement)
>> +  MOD    ALU         dst %= 0                       dst = (u32)dst
>> +  SMOD   ALU64       dst s%= 0                      dst = dst (no replacement)
>> +  SMOD   ALU         dst s%= 0                      dst = (u32)dst
>> +  SDIV   ALU64       dst s/= -1 (dst = LLONG_MIN)   dst = LLONG_MIN
>> +  SDIV   ALU         dst s/= -1 (dst = INT_MIN)     dst = (u32)INT_MIN
>> +  SMOD   ALU64       dst s%= -1 (dst = LLONG_MIN)   dst = 0
>> +  SMOD   ALU         dst s%= -1 (dst = INT_MIN)     dst = 0
> This is a great addition to the doc, but this file is currently
> being used as a base for IETF standard which is in its final "edit" stage
> which may require few patches,
> so we cannot land any changes to instruction-set.rst
> not related to standardization until RFC number is issued and
> it becomes immutable. After that the same instruction-set.rst
> file can be reused for future revisions on the standard.
> Hopefully the draft will clear the final hurdle in a couple weeks.
> Until then:
> pw-bot: cr

Sure. No problem. Will resubmit once the RFC number is issued.


