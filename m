Return-Path: <bpf+bounces-40389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5180987FF1
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605951F23C3C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6918951E;
	Fri, 27 Sep 2024 08:03:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA345189505;
	Fri, 27 Sep 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424227; cv=none; b=DrfpwAti9uufHLLzsvMtDxe/XoVkiLTIj1dNmd0/xiuSHx3AE2tU4fDMk42oxTr+rGp1EA+Y1iMXg7Mcl5EfMIb2CvRx0XEMolLBd8G5XAPtBCoO3mKcMtH3/2Xjjyk8ZHisYX59KWa1L3yiqV9Xkeu3zFyTO7n77je5bO8deEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424227; c=relaxed/simple;
	bh=uMpc1Nkk8d6B/SeF+pJYBARsZQUYbdOxtdXl4SFXqjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWBSbEszuC2bXhUtK6gHA4uBnS3Ixuq5DewST7HwrtenQ7r1qZdNnHS0u+ILQasyHXj4ui3Ym0DG1IPnjBs85guL5upiZCRyV0nbjI7ErW6wc4Vy19cRrjWFh77HGa6V/+lnO0DRUtwE0xQ8G4g6WJ0+vxQaKqE6dMtF4eFvQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFNJB5Pl5z4f3jR6;
	Fri, 27 Sep 2024 16:03:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 183C61A0C07;
	Fri, 27 Sep 2024 16:03:39 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgCHsy_YZvZmyOyeCQ--.53360S2;
	Fri, 27 Sep 2024 16:03:37 +0800 (CST)
Message-ID: <a27e36c6-bf71-40d8-85de-4797d764046c@huaweicloud.com>
Date: Fri, 27 Sep 2024 16:03:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Roman Gushchin <guro@fb.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240920103950.3931497-1-pulehui@huaweicloud.com>
 <2024092737-flick-commodity-20d5@gregkh>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <2024092737-flick-commodity-20d5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHsy_YZvZmyOyeCQ--.53360S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKrWrXF18Xry7Xw1rtrWfAFb_yoW8JF4rpF
	48Can8Kr45KrnxtrZY9F4vq3W8JwsYgFnIv34Y9ryUCayI9r1F93ySg3W5Ca43Ar9xCa12
	qFnrX34kC348CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/9/27 15:56, Greg Kroah-Hartman wrote:
> On Fri, Sep 20, 2024 at 10:39:50AM +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
>> devmap maps") relies on the v5.11+ basic mechanism of memcg-based memory
>> accounting [0]. The commit cannot be independently backported to the
>> 5.10 stable branch, otherwise the related memory when creating devmap
>> will be unrestricted and the associated bpf selftest map_ptr will fail.
>> Let's roll back to rlimit-based memory accounting mode for devmap and
>> re-adapt the commit 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check
>> on 32-bit arches") to the 5.10 stable branch.
>>
>> Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
>> Fixes: 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches")
>> Fixes: 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for devmap maps")
> 
> Should we just revert these changes instead?

Yes, Greg. My patch is to revert these two commits and re-adapt commit 
225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches").

Shall we need to split this patch into multiple patches?

> 
> thanks,
> 
> greg k-h


