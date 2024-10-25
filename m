Return-Path: <bpf+bounces-43148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F19AFE38
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64F51F21F08
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC31D4159;
	Fri, 25 Oct 2024 09:32:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDD1C0DF0;
	Fri, 25 Oct 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848763; cv=none; b=DUlr77T00sKobLpSsqBsvjV7auaA18A1JBapw//p0vwu83t149v32RZ6XOOUjhvdGUD1FKWsum+hsg1JYis/8OWcejQ5txdUoZTgf4Pmdu+UWX1krBZ4hAICDtB7PFTjqG4eRFJybT0cwCepip7sYsRUglzwJTLBd7NNLk6sLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848763; c=relaxed/simple;
	bh=5yEZPxVzDT4JwSQbgOjUvY10CuQ/wntHADsWddzFNsA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RV1iznUsnoZrSvCbbCpZTWWQ8PGpbIekSwfOv4zeXfPxpIiNEKd+XYS9y373aZTMpGXTePihd/jgNc9mohLj0e61lv1oiYJa0Qe3IFWrLpmZoDyri5hkWIRy0RGjBXECvXOt8l06xEaHtCpPjdr/oNzm9jMftVh9lq71+YxKNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XZcVn0VNbz9v7NH;
	Fri, 25 Oct 2024 17:12:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CADF91404D9;
	Fri, 25 Oct 2024 17:32:32 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP2 (Coremail) with SMTP id GxC2BwAHcH+qZRtnP95nAA--.54446S2;
	Fri, 25 Oct 2024 10:32:32 +0100 (CET)
Message-ID: <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>
Date: Fri, 25 Oct 2024 11:32:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Subject: Re: Some observations (results) on BPF acquire and release
To: Andrea Parri <parri.andrea@gmail.com>, puranjay@kernel.org,
 paulmck@kernel.org
Cc: bpf@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Zxk2wNs4sxEIg-4d@andrea>
Content-Language: en-US
In-Reply-To: <Zxk2wNs4sxEIg-4d@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAHcH+qZRtnP95nAA--.54446S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZry8AF1UWFy3ArWxGFW7Arb_yoW5ZryDpF
	W8Ka98Kas7t3sxCwn7X3yUu3WkuF93Xr45Xr4kGr9xCrn8K3Wkta1xKF4YqrZrWrs2vr10
	q34UK3srX3Z8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	Ixkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x07brzVbUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 10/23/2024 7:47 PM, Andrea Parri wrote:
> Hi Puranjay and Paul,
> 
> I'm running some experiment on the (experimental) formalization of BPF
> acquire and release available from [1] and wanted to report about some
> (initial) observations for discussion and possibly future developments;
> apologies in advance for the relatively long email and any repetition.
> 
> 
> A first and probably most important observation is that the (current)
> formalization of acquire and release appears to be "too strong": IIUC,
> the simplest example/illustration for this is given by the following
> 
> BPF R+release+fence
> {
>   0:r2=x; 0:r4=y;
>   1:r2=y; 1:r4=x; 1:r6=l;
> }
>   P0                                 | P1                                         ;
>   r1 = 1                             | r1 = 2                                     ;
>   *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
>   r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
>   store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
> exists ([y]=2 /\ 1:r3=0)
> 
> This "exists" condition is not satisfiable according to the BPF model;
> however, if we adopt the "natural"/intended(?) PowerPC implementations
> of the synchronization primitives above (aka, with store_release() -->
> LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
> condition in question becomes (architecturally) satisfiable on PowerPC
> (although I'm not aware of actual observations on PowerPC hardware).

Are the resulting PPC tests available somewhere?

> 
> 
> At first, the previous observation (validated via simulations and later
> extended to similar but more complex scenarios ) made me believe that
> the BPF formalization of acquire and release could be strictly stronger
> than the corresponding LKMM formalization; but that is _not_ the case:
> 
> The following "exists" condition is satisfiable according to the BPF
> model (and it remains satisfiable even if the load_acquire() in P2 is
> paired with an additional store_release() in P1).  In contrast, the
> corresponding LKMM condition (e.g load_acquire() --> smp_load_acquire()
> and atomic_fetch_add() --> smp_mb()) is not satisfiable (in fact, the
> same conclusion holds even if the putative smp_load_acquire() in P2 is
> "replaced" with an smp_rmb() or with an address dependency).
> 
> BPF Z6.3+fence+fence+acquire
> {
>   0:r2=x; 0:r4=y; 0:r6=l;
>   1:r2=y; 1:r4=z; 1:r6=m;
>   2:r2=z; 2:r4=x;
> }
>   P0                                         | P1                                         | P2                                 ;
>   r1 = 1                                     | r1 = 2                                     | r1 = load_acquire((u32 *)(r2 + 0)) ;
>   *(u32 *)(r2 + 0) = r1                      | *(u32 *)(r2 + 0) = r1                      | r3 = *(u32 *)(r4 + 0)              ;
>   r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) |                                    ;
>   r3 = 1                                     | r3 = 1                                     |                                    ;
>   *(u32 *)(r4 + 0) = r3                      | *(u32 *)(r4 + 0) = r3                      |                                    ;
> exists ([y]=2 /\ 2:r1=1 /\ 2:r3=0)
> 
> 
> These remarks show that the proposed BPF formalization of acquire and
> release somehow, but substantially, diverged from the corresponding
> LKMM formalization.  My guess is that the divergences mentioned above
> were not (fully) intentional, or I'm wondering -- why not follow the
> latter (the LKMM's) more closely? -  This is probably the first question
> I would need to clarify before trying/suggesting modifications to the
> present formalizations.  ;-)  Thoughts?
> 
>    Andrea
> 
> 
> [1] https://github.com/puranjaymohan/herdtools7/commits/bpf_acquire_release/


