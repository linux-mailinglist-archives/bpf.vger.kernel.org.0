Return-Path: <bpf+bounces-28949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6B8BECC3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DDE1C20F86
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD416D32A;
	Tue,  7 May 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vO5ZCSMQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27321373
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111195; cv=none; b=tFZC4uUumLrFRRBhLF/x5fSFZ/QDicTPDoaIVfta+KLc+AMZogmregMTjgit9rx7NvhwLwcrNJXV5Vj/2u8PtmILZCQPNiswQwtl0N5UEkKEb7MchQDWpu71lYxWD8jCI3APsc5GUMWp8CnCgUeyesJCMVhtrE08LKcKbDKrgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111195; c=relaxed/simple;
	bh=fCBVj4ZE6KbLq9xirowc0BDlDqzSWufmZ8Xov2sNrvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0M/MmJ3B7tQeZSHTjbekWekjj5IZzdrP+MPpvmEs+j6QUtGG3nFvzvkF2MQP7e9i+ytlFmwDJuzIWQA/JZSpv5aNIn03QykYMA6JzShHYBRwjqPj+hk1JC1rPBrck+2NzXlGpdwadJ0k2bhA5d7vY+FQdAdknbUICJm6OmtdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vO5ZCSMQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19f42b7f-0d9d-40ac-bfae-ea6c9bc6f9f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715111189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzttPlKlTNEdCDeeOHJkFBmlbO2zftSnPoH1s9Z+Vas=;
	b=vO5ZCSMQE8nHWCCgOmKoi0jVCz5sFWZ/r/Yja2OmF8p/hsY7NF3zqbR+kOPmjJ5xMHu+SD
	/oM6ni6p2kAa9IwLV1QvrY2efO7Q+4u51B7HNbe5mIGfhqBwQ/5QbevDbJahOUhqMgzRJg
	Mh4VAZJtQc8hs3PNulABuFH8fRC4n3I=
Date: Tue, 7 May 2024 12:46:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: avoid uninitialized warnings in
 verifier_global_subprogs.c
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com,
 cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
References: <20240507140540.3972-1-jose.marchesi@oracle.com>
 <223e5ab8-83da-40b7-b10b-0f6341aacb27@linux.dev> <87edadcwm8.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87edadcwm8.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/7/24 11:20 AM, Jose E. Marchesi wrote:
>> On 5/7/24 7:05 AM, Jose E. Marchesi wrote:
>>> The BPF selftest verifier_global_subprogs.c contains code that
>>> purposedly performs out of bounds access to memory, to check whether
>>> the kernel verifier is able to catch them.  For example:
>>>
>>>     __noinline int global_unsupp(const int *mem)
>>>     {
>>> 	if (!mem)
>>> 		return 0;
>>> 	return mem[100]; /* BOOM */
>>>     }
>>>
>>> With -O1 and higher and no inlining, GCC notices this fact and emits a
>>> "maybe uninitialized" warning.  This is by design.  Note that the
>>> emission of these warnings is highly dependent on the precise
>>> optimizations that are performed.
>> Interesting. The error message is 'maybe uninitialized' but not
>> an error to complain out-of-bound access. But anyway, since gcc
>> produces a warning, your patch silences it and LGTM.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Please hold on.  The right warning to inhibit is -Wmaybe-uninitialized,
> which is GCC specific.
>
> So it must be:
>
>    #if !defined(__clang__)
>    #pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
>    #endif
>
> Unless you disagree I am testing this and will send a V2 with your
> Acked-by.

I thought -Wmaybe-unitialized also available to clang but just checked
that clang does not have this. So your above change looks good to me.

>
> Sorry about this.  I hate to be erratic, but so many small patches
> today.
>
>>> This patch adds a compiler pragma to verifier_global_subprogs.c to
>>> ignore these warnings.
>>>
>>> Tested in bpf-next master.
>>> No regressions.
>>>
>>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>>> Cc: david.faust@oracle.com
>>> Cc: cupertino.miranda@oracle.com
>>> Cc: Yonghong Song <yonghong.song@linux.dev>
>>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>>> ---
>>>    tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git
>>> a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>> b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>> index baff5ffe9405..d05dc218b7e9 100644
>>> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>> @@ -8,6 +8,11 @@
>>>    #include "xdp_metadata.h"
>>>    #include "bpf_kfuncs.h"
>>>    +/* The compiler may be able to detect the access to uninitialized
>>> +   memory in the routines performing out of bound memory accesses and
>>> +   emit warnings about it.  This is the case of GCC. */
>>> +#pragma GCC diagnostic ignored "-Wuninitialized"
>>> +
>>>    int arr[1];
>>>    int unkn_idx;
>>>    const volatile bool call_dead_subprog = false;

