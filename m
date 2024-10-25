Return-Path: <bpf+bounces-43165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA8D9B06DA
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5191B22743
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6146420F3E5;
	Fri, 25 Oct 2024 15:00:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764C1E501B;
	Fri, 25 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868455; cv=none; b=P+bhPBf92PfTm4vh4UZUasQe1nchlHetICcjqxlF3TVCbT27H5DzSs2spQtU0zYbufHtEI+9dGROrxtrBx4mit4h5dmKh3EAKavgh56IaJKQwp6fM2DuhLnU91mxZvosxUSN5+CcduLaxNN1KdG+kkYcVbh2K9i7603y1t8QtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868455; c=relaxed/simple;
	bh=2f+OeXc7L8hDW3RrfmTk1SvY5JPPYd2ylwQYzahkVKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSS3ZWh2fEHmvRPc4t7mK5Gzzm/yiUfxQiAsy3QMdgd+/A3NvIkFpKYdke5DgDoXHOOgsxYpbKt97Pief2WRJVvZIB5MKE6sGnzcdZAGzA2/EvmN0srKdZjxH6dOkdSo3q+1PPmRN8DCKv7p4k4pY0yTe9cAHGKc6synwfj14ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZln96dkmz9v7Ht;
	Fri, 25 Oct 2024 22:40:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 42240140CF7;
	Fri, 25 Oct 2024 23:00:29 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwA3qTmGshtnY2NqAA--.55073S2;
	Fri, 25 Oct 2024 16:00:28 +0100 (CET)
Message-ID: <727cbf48-0135-de6b-6d05-a6f8f7b4b853@huaweicloud.com>
Date: Fri, 25 Oct 2024 17:00:20 +0200
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
 <8360f999-0d64-3b4f-e4b8-8c84f7311af2@huaweicloud.com>
 <Zxuq2Zvpn7ap4ZR5@andrea>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <Zxuq2Zvpn7ap4ZR5@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwA3qTmGshtnY2NqAA--.55073S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UZFW5Xr4ktFWDXw4fZrb_yoW8AF43pF
	48try3Kr40gr48Z3yxKF48ZF4xKFyfCFW5JFWrJrZrZF90qFn0qFyjvr43GFyag392vwsr
	ZF10ga4xZF98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbcT
	QUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 10/25/2024 4:27 PM, Andrea Parri wrote:
>> I am particularly interested in tests using lwarx and stwcx instructions
>> (this is what I understood would be used if one follows [1] to compile the
>> tests in this thread).
>>
>> I have not yet check the cambridge website, but due to the timeline, I don't
>> expect to find tests with those instructions. The same is true with [2].
>>
>> I have limited experience with diy7, but I remember that it had some
>> limitations to generate RMW instructions, at least for C [3].
> 
> Oh, I'm sure there are, though I'd also not consider myself the 'expert'
> when it comes to diy7 internals.  ;-)  Here's an example use of diy7 /
> diyone7 generating lwarx and stwcx and reflecting the previous pattern:
> 
> $ diyone7 -arch PPC LwSyncdWW Coe SyncdWRPA SyncdRRAP Fre
> PPC A
> "LwSyncdWW Coe SyncdWRNaA SyncdRRANa Fre"
> Generator=diyone7 (version 7.57+1)
> Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
> Com=Co Fr
> Orig=LwSyncdWW Coe SyncdWRNaA SyncdRRANa Fre
> {
> 0:r2=x; 0:r4=y;
> 1:r2=y; 1:r3=z; 1:r6=x;
> }
>   P0           | P1              ;
>   li r1,1      | li r1,2         ;
>   stw r1,0(r2) | stw r1,0(r2)    ;
>   lwsync       | sync            ;
>   li r3,1      | Loop00:         ;
>   stw r3,0(r4) | lwarx r4,r0,r3  ;
>                | stwcx. r4,r0,r3 ;
>                | bne  Loop00     ;
>                | sync            ;
>                | lwz r5,0(r6)    ;
> exists ([y]=2 /\ 1:r5=0)

That is exactly what I was looking for. Thanks Andrea!

Hernan

> 
> But again, I'd probably have to defer to proper herdtools7 developers
> and maintainers for any diy7 bug or misbehavior you'd have to discover.
> 
>    Andrea
> 
> 
>>
>> Hernan
>>
>> [1] https://github.com/torvalds/linux/blob/master/arch/powerpc/net/bpf_jit_comp32.c
>> [2] https://github.com/herd/herdtools7/tree/master/catalogue/herding-cats/ppc/tests/campaign
>> [3] https://github.com/herd/herdtools7/issues/905
>>


