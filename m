Return-Path: <bpf+bounces-21517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D877C84E759
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E3728461F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5E129A89;
	Thu,  8 Feb 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CEZ0d4kJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DC1292F5
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415485; cv=none; b=VsPK5okPQt0+mmjarfbgtdPu1OWH5kCMnlAgGWbFpPDi7K6RYNls+9OMU2kJvWVT/EvWsBLZJcMdQV22o1jefk2OjSJt5bfiZ6BVEziK+c/1H216UW8HOB7vAhjDiAXL9cqIrG1lXKoB2DoKehOdK+RaxusBXOmhkOaUGFLOdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415485; c=relaxed/simple;
	bh=/WC86u1+nwFQxe2fVvzFL7zqfPO5riYV2XwI/GTRoME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZDUH9upoD5ZMTeckLGtiS974oJaeOlHwu6zGhiQnavDMY2OF7E8nx4PyMFztNV31S/RO/z/XxC1sS7gUghCI+7I5n2NG2/R3FHiF6on/mBihcIPeWD2Rd1SScrje1nQZtVnVxOy3JCnfL5gshI9TieeTTWHI/A5J/iQPMN7CSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CEZ0d4kJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8297be08-cd05-4f08-8bb2-5956f13bbd25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707415481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz80R0EwPdjtSFpe8L6i1OWXEBf64IJUPFUd+DrKUNs=;
	b=CEZ0d4kJrlAF76cEIoazdQ4+DTn5Lk3u6g3oua+NW1IOIgVTJ81H0V4K0Nv3OvnN1dZr6d
	3WTDirVDgOlZojZotcI64erUGawmc3hDBobSjshi8o8LCr6RwuFODh0jiX1uBdYXdEIkjV
	39zvtv7dkGCJnWekW3cX+AIQ9mL70K0=
Date: Thu, 8 Feb 2024 10:04:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, david.faust@oracle.com,
 cupertino.miranda@oracle.com
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
 <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev> <87h6ijfayj.fsf@oracle.com>
 <87wmrfdsk7.fsf@oracle.com>
 <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
 <87o7crdmjn.fsf@oracle.com>
 <eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
 <87il2zdl43.fsf@oracle.com>
 <7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
 <871q9mew62.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <871q9mew62.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 8:51 AM, Jose E. Marchesi wrote:
>> On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
>> [...]
>>
>>> If the compiler generates assembly code the same code for profile2.c for
>>> before and after, that means that the loop does _not_ get unrolled when
>>> profiler.inc.h is built with -O2 but without #pragma unroll.
>>>
>>> But what if #pragma unroll is used?  If it unrolls then, that would mean
>>> that the pragma does something more than -funroll-loops/-O2.
>>>
>>> Sorry if I am not making sense.  Stuff like this confuses me to no end
>>> ;)
>> Sorry, I messed up while switching branches :(
>> Here are the correct stats:
>>
>> | File            | insn # | insn # |
>> |                 | before |  after |
>> |-----------------+--------+--------|
>> | profiler1.bpf.o |  16716 |   4813 |
> This means:
>
> - With both `#pragma unroll' and -O2 we get 16716 instructions.
> - Without `#pragma unroll' and with -O2 we get 4813 instructions.
>
> Weird.

Thanks for the analysis. I can reproduce with vs. without '#pragma unroll' at -O2
level, the number of generated insns is indeed different, quite dramatically
as the above numbers. I will do some checking in compiler.

>
>> | profiler2.bpf.o |   2088 |   2050 |
> - Without `#pragma unroll' and with -O2 we get 2088 instructions.
> - With `#pragma loop unroll(disable)' and with -O2 we get 2050
>    instructions.
>
> Also surprising.
>
>> | profiler3.bpf.o |   4465 |   1690 |

