Return-Path: <bpf+bounces-43158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D419B0404
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62A01C226E7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C184670814;
	Fri, 25 Oct 2024 13:28:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11621216E;
	Fri, 25 Oct 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862923; cv=none; b=mCEfgLaZNDluz0B2PufH2yXRi3kMI7otEniTK8L24bjO4H0UdRqGN8JDD/Ah1/Vzz79cZAFTbnWn/uldjZIb0W9EtfzmiBrhUOsZ7GjOOFVbzvf/HvkkeYdbBA/e36PeKOaw4Q9ckO2VLrKHnKobtyeuhYfUEgffrFxmO9R1MCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862923; c=relaxed/simple;
	bh=rqD8O7ASW2YD34InFNtypxnf2obGHXh6ceZe7cQlsGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHjdQeYjlUykJOXzT63z0jesllqlthtfNdfROfpM6o1AKklR2i/emilIV+7hJz7LXCY0jQ1XfQOviskgX+FuwOqJXGHTyxhv3iHNEsxg7iTbs6CwkKQuvPAuzzhujC1sv1f0B19/HQ7UFBU21DBgGXP/m2CZ9Vq/j4MpM87aXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XZjkw1gpdz9v7NL;
	Fri, 25 Oct 2024 21:08:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 366D21402DE;
	Fri, 25 Oct 2024 21:28:29 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwD3aDnznBtnO2VpAA--.54724S2;
	Fri, 25 Oct 2024 14:28:28 +0100 (CET)
Message-ID: <d8aa61a8-e2fc-7668-9845-81664c9d181f@huaweicloud.com>
Date: Fri, 25 Oct 2024 15:28:17 +0200
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
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <ZxuZ-wGccb3yhBAD@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwD3aDnznBtnO2VpAA--.54724S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fWw1ktw17Kw4rtFyrZwb_yoW8GryDpF
	Wvkan8KFn7t3yakrZ2qr13WFs5uF4fAr45XF18Jw47Cwn0kr1ftF4xKF40gFZrJwn2ka10
	qr1jkFZ3W3WIvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 10/25/2024 3:15 PM, Andrea Parri wrote:
>>> BPF R+release+fence
>>> {
>>>    0:r2=x; 0:r4=y;
>>>    1:r2=y; 1:r4=x; 1:r6=l;
>>> }
>>>    P0                                 | P1                                         ;
>>>    r1 = 1                             | r1 = 2                                     ;
>>>    *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
>>>    r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
>>>    store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
>>> exists ([y]=2 /\ 1:r3=0)
>>>
>>> This "exists" condition is not satisfiable according to the BPF model;
>>> however, if we adopt the "natural"/intended(?) PowerPC implementations
>>> of the synchronization primitives above (aka, with store_release() -->
>>> LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
>>> condition in question becomes (architecturally) satisfiable on PowerPC
>>> (although I'm not aware of actual observations on PowerPC hardware).
>>
>> Are the resulting PPC tests available somewhere?
> 
> My data go back to the LKMM paper, cf. e.g. the R+pooncerelease+fencembonceonce
> entry at https://diy.inria.fr/linux/hard.html#unseen .
> 
>    Andrea

I guess I understood you wrong. I thought you had manually "compiled" 
those to PPC litmus format (i.e., doing exactly what the JIT compiler 
would do). I can obviously write them manually myself, but I find this 
painful and error prone (I am particularly bad at this task), so I 
wanted to avoid this if someone else had already done it.

Hernan


