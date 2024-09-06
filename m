Return-Path: <bpf+bounces-39145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5FA96F6E4
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AED1F21C15
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F61D1F5B;
	Fri,  6 Sep 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="resg7dq+"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A550149DFA
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633170; cv=none; b=lfNW2nt/X2dlNOYvgwZXvZNYlhxZBjN6EbRya+YPIZlWm9eHMd6+X0gtWA5WXGwJYAuy/QhCaIRh/pBtFYDeY28Z4A9tdJzCG6sQSRBeFYKYhAC40Uy0BSKD6bZ7NwVYp2pSit2r4VGiW1jYyAcfhsZhGg/HgWnzstMB+4QNYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633170; c=relaxed/simple;
	bh=7wObuzUYKk/Jf1wORPiksdz0hGzhgpgHAQ2Oz03xoz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK5kUgykCA0VDHsfLbVwDhMREUHHyYwrdYIL5QHH9/1MqJcawVVenJDg+eTcrzgqaMKx5/n6hhtR1KggG83AQVKSECUAOrlq4SZdl9icXXjd7Og3r8XHZG+0l0wMMZ0+1TUjYv+8UX1c1F11R6Vxciym/bKsUQepelbMYBLugNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=resg7dq+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <007b71a8-ccaa-43f4-a24e-903d3ee9cbec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725633163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlArAyv14ve3ZSYb1vJjZdnGSXViXb6g9ji6N7vQOKQ=;
	b=resg7dq+n2tdJL/SSadx8hDImrWOemKuMOFn+GnnzU+JsaCrvJM5PH6xm5YqD93pivXdwa
	LjuK9Z+Rvhl+Kft/DnY9+MZLXaSYCoi5Rb2bUZs6/2WNC5sCFa3R5l5pQjvgVFUt1shwyi
	vfmAbe7oU2DqRhdcULpz0HCnqoUoJFM=
Date: Fri, 6 Sep 2024 22:32:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
To: Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, eddyz87@gmail.com,
 iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
 <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
 <mb61ped5ysbso.fsf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <mb61ped5ysbso.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/5 17:13, Puranjay Mohan wrote:
> Xu Kuohai <xukuohai@huaweicloud.com> writes:
> 
>> On 8/27/2024 10:23 AM, Leon Hwang wrote:
>>>
>>>
>>> On 26/8/24 22:32, Xu Kuohai wrote:
>>>> On 8/25/2024 9:09 PM, Leon Hwang wrote:
>>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
>>>>> issue happens on arm64, too.
>>>>>
>>>
>>> [...]
>>>
>>>>
>>>> This patch makes arm64 jited prologue even more complex. I've posted a
>>>> series [1]
>>>> to simplify the arm64 jited prologue/epilogue. I think we can fix this
>>>> issue based
>>>> on [1]. I'll give it a try.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/bpf/20240826071624.350108-1-xukuohai@huaweicloud.com/
>>>>
>>>
>>> Your patch series seems great. We can fix it based on it.
>>>
>>> Please notify me if you have a successful try.
>>>
>>
>> I think the complexity arises from having to decide whether
>> to initialize or keep the tail counter value in the prologue.
>>
>> To get rid of this complexity, a straightforward idea is to
>> move the tail call counter initialization to the entry of
>> bpf world, and in the bpf world, we only increase and check
>> the tail call counter, never save/restore or set it. The
>> "entry of the bpf world" here refers to mechanisms like
>> bpf_prog_run, bpf dispatcher, or bpf trampoline that
>> allows bpf prog to be invoked from C function.
>>
>> Below is a rough POC diff for arm64 that could pass all
>> of your tests. The tail call counter is held in callee-saved
>> register x26, and is set to 0 by arch_run_bpf.
> 
> I like this approach as it removes all the complexity of handling tcc in

I like this approach, too.

> different cases. Can we go ahead with this for arm64 and make
> arch_run_bpf a weak function and let other architectures override this
> if they want to use a similar approach to this and if other archs want to
> do something else they can skip implementing arch_run_bpf.
> 

Hi Alexei,

What do you think about this idea?

Thanks,
Leon

