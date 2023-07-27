Return-Path: <bpf+bounces-6028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3E76435E
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 03:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D328E282086
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E615A6;
	Thu, 27 Jul 2023 01:21:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834E7C
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:21:57 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A2A3
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 18:21:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RBCfK1pWfz4f3mKk
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 09:21:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB337KoxsFkvoWUOw--.19749S2;
	Thu, 27 Jul 2023 09:21:47 +0800 (CST)
Subject: Re: [PATCH bpf 1/2] bpf/memalloc: Non-atomically allocate freelist
 during prefill
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
References: <cover.1689885610.git.zhuyifei@google.com>
 <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
 <0f90694e-308c-65e6-5360-a3d5dc7337b1@huaweicloud.com>
 <CAA-VZPmhm3SoD+tX-xPSj6wuOvFg=uZoar0b=sgAyLRz=5n+2A@mail.gmail.com>
 <0d242e21-3f53-87ca-7aa8-bb55b5223552@huaweicloud.com>
 <CAA-VZPmretQpaGan_w=VMpvL_gKsAb_fT-x8Q4Eci8dE4EPvHQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8a8ab9b4-e2f1-9f53-f9ab-a3affadf332b@huaweicloud.com>
Date: Thu, 27 Jul 2023 09:21:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAA-VZPmretQpaGan_w=VMpvL_gKsAb_fT-x8Q4Eci8dE4EPvHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB337KoxsFkvoWUOw--.19749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5WF1UCF4Uur1rGFWrGrg_yoW8WrykpF
	WxGF1jya98Xr45CwnFvwnYgr45tw4rKryxXrWjqr15Zr9a9F9akrW7Aa18uFyrGrn7CFyj
	yrZ8W3s7XF1UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/27/2023 2:44 AM, YiFei Zhu wrote:
> On Wed, Jul 26, 2023 at 4:38 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 7/21/2023 10:31 AM, YiFei Zhu wrote:
>>> On Thu, Jul 20, 2023 at 6:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> On 7/21/2023 4:44 AM, YiFei Zhu wrote:
>>>>> Sometimes during prefill all precpu chunks are full and atomic
>>>>> __alloc_percpu_gfp would not allocate new chunks. This will cause
>>>>> -ENOMEM immediately upon next unit_alloc.
>>>>>
>>>>> Prefill phase does not actually run in atomic context, so we can
>>>>> use this fact to allocate non-atomically with GFP_KERNEL instead
>>>>> of GFP_NOWAIT. This avoids the immediate -ENOMEM. Unfortunately
>>>>> unit_alloc runs in atomic context, even from map item allocation in
>>>>> syscalls, due to rcu_read_lock, so we can't do non-atomic
>>>>> workarounds in unit_alloc.
>>>>>
>>>>> Fixes: 4ab67149f3c6 ("bpf: Add percpu allocation support to bpf_mem_alloc.")
>>>>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>>>> Make sense to me, so
>>>>
>>>> Acked-by: Hou Tao <houtao1@huawei.com>
>>>>
>>>> But I don't know whether or not it is suitable for bpf tree.
>>> I don't mind either way :) If changing to bpf-next requires a resend I
>>> can do that too.
>> Please resend and rebase the patch again bpf-next tree.
>>
> Will do. Should I drop the Fixes tag then?

Before the introduction of bpf memory allocator, the allocation flag for
per-cpu memory allocation in hash map is GFP_NOWAIT. BPF memory
allocator doesn't change that, so I think we could drop the Fixes tag.
>
> YiFei Zhu
>
> .


