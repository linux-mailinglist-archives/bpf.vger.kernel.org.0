Return-Path: <bpf+bounces-29894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319BF8C7F75
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6371F1C21986
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EEE818;
	Fri, 17 May 2024 01:17:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EE622;
	Fri, 17 May 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908633; cv=none; b=kkNT83zKDnhbcotwgfLY5AER4FppiJSLaPx2x49OZq867VsXdHJ78zcFOMCi9OAaoTkqQs3qmCDq7o8lgGgnHEhPSPnUCaHleAn/MIqcWvd6xuNaDV5neyilhli1unvUgra1/7KA/W8o55oT70CBo30c8mVW9VdfIPPnazcFnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908633; c=relaxed/simple;
	bh=17admwWmB2d6L9FqoIo/jNMsNyv0xGeOExpch0HKWgM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tc2Mp4p5QfYJm+XI8vYGT0KTlfDmF2OeGh+/GS1c/alQsJdT7qlDHjoZ3+lUHCkjCWj8OCF8Q/4kLDWrZrA7d+fU7X5fnyywjJzgQSdXrqLLblmN5DGWcLo+6qefPwvM0GWm8ChFoMlsvDGf/M75buDvz+d6hFv8vW54zKMni4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VgTZf0GPxz4f3jHg;
	Fri, 17 May 2024 09:16:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BDE8C1A016E;
	Fri, 17 May 2024 09:17:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCHR58RsEZmphO5Mg--.56729S2;
	Fri, 17 May 2024 09:17:06 +0800 (CST)
Subject: Re: [PATCH] net/sched: unregister root_lock_key in the error path of
 qdisc_alloc()
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
References: <20240516133035.1050113-1-houtao@huaweicloud.com>
 <dbb75bc2-cb09-79e9-2227-16adf957ae05@huaweicloud.com>
 <CAKa-r6u=FiCxzQ0FF-XMdNjEA=LZZ+m-yMZ1KXT9wqMiX2gkPg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3c1c37ce-cc13-9fe9-1da2-0898f2d679f1@huaweicloud.com>
Date: Fri, 17 May 2024 09:17:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKa-r6u=FiCxzQ0FF-XMdNjEA=LZZ+m-yMZ1KXT9wqMiX2gkPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCHR58RsEZmphO5Mg--.56729S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyxKr4xCw1rZr13ArWDArb_yoWkGwc_u3
	yDA34xCFsxXw1jqF42kr1kCrZ5GFnYgFs3JryDGrWjy3WrXa95WFsY9ryfCryrGFWvgF9x
	CwsYvFWxCrs29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

H Davide,

On 5/16/2024 9:45 PM, Davide Caratti wrote:
> hello Hou Tao,
>
> On Thu, May 16, 2024 at 3:33 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Oops. Forgot to add the target git tree for the patch. It is targeted
>> for net- tree.
>>
>>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>>> index 31dfd6c7405b0..d3f6006b563cc 100644
>>> --- a/net/sched/sch_generic.c
>>> +++ b/net/sched/sch_generic.c
>>> @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
>>>
>>>       return sch;
>>>  errout1:
>>> +     lockdep_unregister_key(&sch->root_lock_key);
>>>       kfree(sch);
>>>  errout:
>>>       return ERR_PTR(err);
> AFAIS this line is part of the fix that was merged a couple of weeks
> ago, (see the 2nd hunk of [1]). That patch also protects the error
> path of qdisc_create(), that proved to make kselftest fail with
> similar splats. Can you check if this commit resolves that syzbot?

I missed that commit and didn't check the net-next git tree before
posting the patch. Yes, I think this commit will resolve the reported
problem. Thanks.
>
> thanks a lot!


