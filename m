Return-Path: <bpf+bounces-43162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364AF9B04D1
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005B52852D5
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302E2010FA;
	Fri, 25 Oct 2024 13:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33E1FB8B5;
	Fri, 25 Oct 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864680; cv=none; b=TCDvpoADqZYFJYrMyfYVyPtV/JjWr2nKlTOZiqDm+XIwYaMDDCedzVHA8H1pXjXmlEvzOm+4QNm7AZ/RqrSPb3qIZJ+5N+fGo71XuW7ylQUf77NyZeGifUbju/ccjh+/tegBojWxgKr/cmgLP68U+B4hDGtWroiQzIQCY3OMSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864680; c=relaxed/simple;
	bh=wjQPEd1fi5rVEdlc+56+MquhhXXQhQ4HeWzndbeDTnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwQbWG3Dq2HKAhEKbSq4dCCb2EF6abo7VCv42VHr7Cu4QrCGuBCmAGFQZIJ6wYNra7o+2QPyIDGEtFE3nnVDwhZ5GD98qytFVTWAz4oQKeSsFr1XcjOzeeoZRkDRqZpkoJ61EzX7nCSYEbhiGIUjpoka7LlaryPAwfrC1rMUyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZkNh3PZhz9v7Hp;
	Fri, 25 Oct 2024 21:37:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B7410140132;
	Fri, 25 Oct 2024 21:57:42 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwDHhzjLoxtn5LVpAA--.14069S2;
	Fri, 25 Oct 2024 14:57:41 +0100 (CET)
Message-ID: <8360f999-0d64-3b4f-e4b8-8c84f7311af2@huaweicloud.com>
Date: Fri, 25 Oct 2024 15:57:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Some observations (results) on BPF acquire and release
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>
Cc: puranjay@kernel.org, paulmck@kernel.org, bpf@vger.kernel.org,
 lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Zxk2wNs4sxEIg-4d@andrea>
 <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>
 <ZxuZ-wGccb3yhBAD@andrea>
 <d8aa61a8-e2fc-7668-9845-81664c9d181f@huaweicloud.com>
 <ZxugzP0yB3zeqKSn@andrea>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <ZxugzP0yB3zeqKSn@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDHhzjLoxtn5LVpAA--.14069S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15uF1rAr4UCr1fGFy7GFg_yoW5XF47pa
	yvka90krs2gay5Wr4Iqr4UuFs2vFZ3JF45XF18JwsrZ3Z0kFnxKF4xtF4YgFy3Grs2yw40
	vw1jkFZrWFyDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	Ixkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUyuHqUUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 10/25/2024 3:44 PM, Andrea Parri wrote:
> On Fri, Oct 25, 2024 at 03:28:17PM +0200, Hernan Ponce de Leon wrote:
>> On 10/25/2024 3:15 PM, Andrea Parri wrote:
>>>>> BPF R+release+fence
>>>>> {
>>>>>     0:r2=x; 0:r4=y;
>>>>>     1:r2=y; 1:r4=x; 1:r6=l;
>>>>> }
>>>>>     P0                                 | P1                                         ;
>>>>>     r1 = 1                             | r1 = 2                                     ;
>>>>>     *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
>>>>>     r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
>>>>>     store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
>>>>> exists ([y]=2 /\ 1:r3=0)
>>>>>
>>>>> This "exists" condition is not satisfiable according to the BPF model;
>>>>> however, if we adopt the "natural"/intended(?) PowerPC implementations
>>>>> of the synchronization primitives above (aka, with store_release() -->
>>>>> LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
>>>>> condition in question becomes (architecturally) satisfiable on PowerPC
>>>>> (although I'm not aware of actual observations on PowerPC hardware).
>>>>
>>>> Are the resulting PPC tests available somewhere?
>>>
>>> My data go back to the LKMM paper, cf. e.g. the R+pooncerelease+fencembonceonce
>>> entry at https://diy.inria.fr/linux/hard.html#unseen .
>>>
>>>     Andrea
>>
>> I guess I understood you wrong. I thought you had manually "compiled" those
>> to PPC litmus format (i.e., doing exactly what the JIT compiler would do). I
>> can obviously write them manually myself, but I find this painful and error
>> prone (I am particularly bad at this task), so I wanted to avoid this if
>> someone else had already done it.
> 
> FWIW, a comprehensive collection of PPC litmus tests could be found at
> 
>    https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/ppc002.html
> 
> (just follow the link on the test pattern/variants to see the sources);
> be aware the results of those tables date back to the PPC paper though.
> 
> Alternatively, remind that PPC is well supported by the herdtools7 diy7
> generator; I see no reason for having to (re)write such tests manually.
> 
>    Andrea

I am particularly interested in tests using lwarx and stwcx instructions 
(this is what I understood would be used if one follows [1] to compile 
the tests in this thread).

I have not yet check the cambridge website, but due to the timeline, I 
don't expect to find tests with those instructions. The same is true 
with [2].

I have limited experience with diy7, but I remember that it had some 
limitations to generate RMW instructions, at least for C [3].

Hernan

[1] 
https://github.com/torvalds/linux/blob/master/arch/powerpc/net/bpf_jit_comp32.c
[2] 
https://github.com/herd/herdtools7/tree/master/catalogue/herding-cats/ppc/tests/campaign
[3] https://github.com/herd/herdtools7/issues/905


