Return-Path: <bpf+bounces-66572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54355B37020
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7E25E01DE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD223148DA;
	Tue, 26 Aug 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUJ0LwFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAB30AD03;
	Tue, 26 Aug 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225428; cv=none; b=h5j7u9sLniqtB7qnOSKaYYZSmW5SuHaMp9+pOxMV4caASLImLtXaBTYpncEYIjbsH0P9VPC+oLOblSGLJ8d3LjVOibKJlGF4mfWg4E283HuzCJ0woErPWdqJ0zbciWtrSDckXPrbojKVts2iv7T+ute4i/KpV0xxiQe5CIDNzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225428; c=relaxed/simple;
	bh=zlc4tjwMVJ1a2pKQUQU1t8ELRwEbx7fN24Mex34Vo+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYnILMwhNgbOVjETWZAEIcjlAp6dQ28VKFal6zVd5f5eMlcYVJhWsmZw3tt+koDCkQFCKPmW27Zm4g1lMMWXmtmSIyJk8XHbDVMPnxvQE0bGfKyuzd0QTSaYmnLIQtIfXYwgroc34GCfYAVK/yRQQD96SkBuO28Bt3+EJ5UTkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUJ0LwFT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso7781868b3a.1;
        Tue, 26 Aug 2025 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225425; x=1756830225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbmFneshoTIpSjsddxrK5zLZgEWoOLU1TnIvwRJ2jIk=;
        b=aUJ0LwFTSGKcZuaA1eCyylzvdN6+cw4dUJOaC1wynaFnPeRx+w1pZXfOBKERe53t1Y
         v2CjG2e46JNNZhlNfG623S+CA52oTu+9Eab+8hgIm7YfILJOf6iA5YxiUEoCoFOmixIK
         sCe7MLYaH1gVZK+Zm9uVN8wyBdduYPLhpR0gggz6e+EKpdO1N3UnN3uEIk2tBsg82kks
         KjAmNC1y429t/92VA0Ae4gNrdQnsm/pOsE/5S5dHZ4fq9H2gDpsx6KuNHpkhyNQLrkWV
         uFgL3KCmfO2s1SuJmsr/GVN7g4xesA+D6O02e2y7p43/q5YTuEnRx3LwdzBcFjOGaxSW
         XnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225425; x=1756830225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbmFneshoTIpSjsddxrK5zLZgEWoOLU1TnIvwRJ2jIk=;
        b=NhW5iowx4wwoL96PeUEGb8MYZ1Oza5K5rzTzkrHv0dHuhCTXGopVd2cH6eopN8eMSA
         1Ucf1jOYl2NtoiIje1iIbNbYTbj/2x+T1niUDHIn5FqWMS1QTfm2VphaPQxfpb0ws6Nl
         eJr98LW9yS9OOiQaQ4dCeonyje2p5aOksXVFCTFl3Z+KHbueRSE/tXT/LkAF+0ji2nft
         4XbHgWmh+SSinC5YhtllvvsdV/c7BfX4LZwkeoB5WnSQzoHRBGBBrVpdiBLr+eUbYLXp
         PcYAeoivLdrmCLdWbUWaIS+QGtvw2bSci+f9GHg5Ya2p7O6R05Q95Zcny7PcktLLahXJ
         OHPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVqmZKzWrpBccH/UtduCMaf6RY51+6miSzTSFmJIU1EdpBCWKOuni6qIjm93eH+xCb9U2/VcHuY3MdVh/P@vger.kernel.org, AJvYcCVjGmJ0fThYfjQjBFY68aCHk7XWXM5vSlMaAqKLWs1ewR8CgOfUGGkNi9RPmL1YkGacJEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmoWpVVgc1u8OHjephDRMZFWqO/1LR74vYu6xbUVx7Lx2fbmS
	iKRsDam/1ZI1rPu/ekYQDfOXSo8FOIV37UAMNKgkcFwcSMLWN2yS7bON
X-Gm-Gg: ASbGncs6ZMeCZdYHRyGOi3kN182RB09hvdqXR2sHNfoNaRxNcrgzDVz2mS/CvZuQeqp
	D2basKjfgpqbC9SDRJMpThFt/ROporyJPVt6GWdWeHGZB2EHavF118SD2/L5vNomir472iH2epa
	TwMLt+JaTQr/j0RDHWVvIX2iGbuHz1yA4/t3kotZdeknHz/dVjC7hBszX4o3SMIi50HsQhyqjwz
	hsRWNSp1nrJGQi/8D1w45NAvFbNGsFDBOaBV2gBZckjnBI+EHkEQ5KvLaJe9faAmS5Qn/GcrNeO
	pvpOebcSOvmC9PtRGsC3N7+tFG8Ce/mTRgZpDy6+nFkEG20EQFP3Sqtb4ioYjn2vMnq9ugfWU9l
	zta6X6aHCC6ZvwPFeGLyMOBWTiMbiKmzvF4uFVQeBE2loCW0W1M3nU9I4nHkvwPQmcBLmOblE9A
	wE
X-Google-Smtp-Source: AGHT+IEH7VEUzI9tKUdXTifEnPc+6oiViRLJY1/GN4MNA6FfwnWXAWpVjWzWt+5dYTW8jJy1IAd/cg==
X-Received: by 2002:a05:6a20:7b30:b0:243:7664:5e43 with SMTP id adf61e73a8af0-2437664631cmr9793984637.36.1756225425166;
        Tue, 26 Aug 2025 09:23:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:14b0:ff2b:98c1:659? ([2620:10d:c090:500::4:9299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8b4b98sm9572268a12.19.2025.08.26.09.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:23:44 -0700 (PDT)
Message-ID: <6dee135b-bf94-48a4-816f-629de071709b@gmail.com>
Date: Tue, 26 Aug 2025 09:23:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Suren Baghdasaryan <surenb@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAJuCfpF2akVnbZgPoDAXea2joJ1DWvBTHC7wGzEJcYX9xF9dSA@mail.gmail.com>
 <878qjf13gx.fsf@linux.dev>
 <CAJuCfpFT1oo0+9f_XQa29UeZseLNNbwc19pLbG0MOthgxrtVuQ@mail.gmail.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <CAJuCfpFT1oo0+9f_XQa29UeZseLNNbwc19pLbG0MOthgxrtVuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/20/25 12:34 PM, Suren Baghdasaryan wrote:
> On Tue, Aug 19, 2025 at 1:06 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>> Suren Baghdasaryan <surenb@google.com> writes:
>>
>>> On Mon, Aug 18, 2025 at 10:01 AM Roman Gushchin
>>> <roman.gushchin@linux.dev> wrote:
>>>> Introduce a bpf struct ops for implementing custom OOM handling policies.
>>>>
>>>> The struct ops provides the bpf_handle_out_of_memory() callback,
>>>> which expected to return 1 if it was able to free some memory and 0
>>>> otherwise.
>>>>
>>>> In the latter case it's guaranteed that the in-kernel OOM killer will
>>>> be invoked. Otherwise the kernel also checks the bpf_memory_freed
>>>> field of the oom_control structure, which is expected to be set by
>>>> kfuncs suitable for releasing memory. It's a safety mechanism which
>>>> prevents a bpf program to claim forward progress without actually
>>>> releasing memory. The callback program is sleepable to enable using
>>>> iterators, e.g. cgroup iterators.
>>>>
>>>> The callback receives struct oom_control as an argument, so it can
>>>> easily filter out OOM's it doesn't want to handle, e.g. global vs
>>>> memcg OOM's.
>>>>
>>>> The callback is executed just before the kernel victim task selection
>>>> algorithm, so all heuristics and sysctls like panic on oom,
>>>> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
>>>> are respected.
>>>>
>>>> The struct ops also has the name field, which allows to define a
>>>> custom name for the implemented policy. It's printed in the OOM report
>>>> in the oom_policy=<policy> format. "default" is printed if bpf is not
>>>> used or policy name is not specified.
>>>>
>>>> [  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
>>>>                 oom_policy=bpf_test_policy
>>>> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
>>>> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
>>>> [  112.698167] Call Trace:
>>>> [  112.698177]  <TASK>
>>>> [  112.698182]  dump_stack_lvl+0x4d/0x70
>>>> [  112.698192]  dump_header+0x59/0x1c6
>>>> [  112.698199]  oom_kill_process.cold+0x8/0xef
>>>> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
>>>> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
>>>> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
>>>> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
>>>> [  112.698250]  out_of_memory+0xab/0x5c0
>>>> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
>>>> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
>>>> [  112.698288]  charge_memcg+0x2f/0xc0
>>>> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
>>>> [  112.698299]  do_anonymous_page+0x40f/0xa50
>>>> [  112.698311]  __handle_mm_fault+0xbba/0x1140
>>>> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  112.698335]  handle_mm_fault+0xe6/0x370
>>>> [  112.698343]  do_user_addr_fault+0x211/0x6a0
>>>> [  112.698354]  exc_page_fault+0x75/0x1d0
>>>> [  112.698363]  asm_exc_page_fault+0x26/0x30
>>>> [  112.698366] RIP: 0033:0x7fa97236db00
>>>>
>>>> It's possible to load multiple bpf struct programs. In the case of
>>>> oom, they will be executed one by one in the same order they been
>>>> loaded until one of them returns 1 and bpf_memory_freed is set to 1
>>>> - an indication that the memory was freed. This allows to have
>>>> multiple bpf programs to focus on different types of OOM's - e.g.
>>>> one program can only handle memcg OOM's in one memory cgroup.
>>>> But the filtering is done in bpf - so it's fully flexible.
>>>>
>>>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>>>> ---
>>>>   include/linux/bpf_oom.h |  49 +++++++++++++
>>>>   include/linux/oom.h     |   8 ++
>>>>   mm/Makefile             |   3 +
>>>>   mm/bpf_oom.c            | 157 ++++++++++++++++++++++++++++++++++++++++
>>>>   mm/oom_kill.c           |  22 +++++-
>>>>   5 files changed, 237 insertions(+), 2 deletions(-)
>>>>   create mode 100644 include/linux/bpf_oom.h
>>>>   create mode 100644 mm/bpf_oom.c
>>>>
>>>> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
>>>> new file mode 100644
>>>> index 000000000000..29cb5ea41d97
>>>> --- /dev/null
>>>> +++ b/include/linux/bpf_oom.h
>>>> @@ -0,0 +1,49 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>> +
>>>> +#ifndef __BPF_OOM_H
>>>> +#define __BPF_OOM_H
>>>> +
>>>> +struct bpf_oom;
>>>> +struct oom_control;
>>>> +
>>>> +#define BPF_OOM_NAME_MAX_LEN 64
>>>> +
>>>> +struct bpf_oom_ops {
>>>> +       /**
>>>> +        * @handle_out_of_memory: Out of memory bpf handler, called before
>>>> +        * the in-kernel OOM killer.
>>>> +        * @oc: OOM control structure
>>>> +        *
>>>> +        * Should return 1 if some memory was freed up, otherwise
>>>> +        * the in-kernel OOM killer is invoked.
>>>> +        */
>>>> +       int (*handle_out_of_memory)(struct oom_control *oc);
>>>> +
>>>> +       /**
>>>> +        * @name: BPF OOM policy name
>>>> +        */
>>>> +       char name[BPF_OOM_NAME_MAX_LEN];
>>> Why should the name be a part of ops structure? IMO it's not an
>>> attribute of the operations but rather of the oom handler which is
>>> represented by bpf_oom here.
>> The ops structure describes a user-defined oom policy. Currently
>> it's just one handler and the policy name. Later additional handlers
>> can be added, e.g. a handler to control the dmesg output.
>>
>> bpf_oom is an implementation detail: it's basically an extension
>> to struct bpf_oom_ops which contains "private" fields required
>> for the internal machinery.
> Ok. I hope we can come up with some more descriptive naming but I
> can't think of something good ATM.
>
>>>> +
>>>> +       /* Private */
>>>> +       struct bpf_oom *bpf_oom;
>>>> +};
>>>> +
>>>> +#ifdef CONFIG_BPF_SYSCALL
>>>> +/**
>>>> + * @bpf_handle_oom: handle out of memory using bpf programs
>>>> + * @oc: OOM control structure
>>>> + *
>>>> + * Returns true if a bpf oom program was executed, returned 1
>>>> + * and some memory was actually freed.
>>> The above comment is unclear, please clarify.
>> Fixed, thanks.
>>
>> /**
>>   * @bpf_handle_oom: handle out of memory condition using bpf
>>   * @oc: OOM control structure
>>   *
>>   * Returns true if some memory was freed.
>>   */
>> bool bpf_handle_oom(struct oom_control *oc);
>>
>>
>>>> + */
>>>> +bool bpf_handle_oom(struct oom_control *oc);
>>>> +
>>>> +#else /* CONFIG_BPF_SYSCALL */
>>>> +static inline bool bpf_handle_oom(struct oom_control *oc)
>>>> +{
>>>> +       return false;
>>>> +}
>>>> +
>>>> +#endif /* CONFIG_BPF_SYSCALL */
>>>> +
>>>> +#endif /* __BPF_OOM_H */
>>>> diff --git a/include/linux/oom.h b/include/linux/oom.h
>>>> index 1e0fc6931ce9..ef453309b7ea 100644
>>>> --- a/include/linux/oom.h
>>>> +++ b/include/linux/oom.h
>>>> @@ -51,6 +51,14 @@ struct oom_control {
>>>>
>>>>          /* Used to print the constraint info. */
>>>>          enum oom_constraint constraint;
>>>> +
>>>> +#ifdef CONFIG_BPF_SYSCALL
>>>> +       /* Used by the bpf oom implementation to mark the forward progress */
>>>> +       bool bpf_memory_freed;
>>>> +
>>>> +       /* Policy name */
>>>> +       const char *bpf_policy_name;
>>>> +#endif
>>>>   };
>>>>
>>>>   extern struct mutex oom_lock;
>>>> diff --git a/mm/Makefile b/mm/Makefile
>>>> index 1a7a11d4933d..a714aba03759 100644
>>>> --- a/mm/Makefile
>>>> +++ b/mm/Makefile
>>>> @@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>>>>   ifdef CONFIG_SWAP
>>>>   obj-$(CONFIG_MEMCG) += swap_cgroup.o
>>>>   endif
>>>> +ifdef CONFIG_BPF_SYSCALL
>>>> +obj-y += bpf_oom.o
>>>> +endif
>>>>   obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>>>>   obj-$(CONFIG_GUP_TEST) += gup_test.o
>>>>   obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
>>>> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
>>>> new file mode 100644
>>>> index 000000000000..47633046819c
>>>> --- /dev/null
>>>> +++ b/mm/bpf_oom.c
>>>> @@ -0,0 +1,157 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * BPF-driven OOM killer customization
>>>> + *
>>>> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
>>>> + */
>>>> +
>>>> +#include <linux/bpf.h>
>>>> +#include <linux/oom.h>
>>>> +#include <linux/bpf_oom.h>
>>>> +#include <linux/srcu.h>
>>>> +
>>>> +DEFINE_STATIC_SRCU(bpf_oom_srcu);
>>>> +static DEFINE_SPINLOCK(bpf_oom_lock);
>>>> +static LIST_HEAD(bpf_oom_handlers);
>>>> +
>>>> +struct bpf_oom {
>>> Perhaps bpf_oom_handler ? Then bpf_oom_ops->bpf_oom could be called
>>> bpf_oom_ops->handler.
>> I don't think it's a handler, it's more like a private part
>> of bpf_oom_ops. Maybe bpf_oom_impl? Idk
> Yeah, we need to come up with some nomenclature and name these structs
> accordingly. In my mind ops means a structure that contains only
> operations, so current naming does not sit well but maybe that's just
> me...

Some existing xxx_ops also have non-operation members. E.g., 
tcp_congestion_ops, Qdisc_ops, vfio_device_ops, or tpm_class_ops. Maybe 
bpf_oom_ops is okay if that doesn't cause too much confusion?

>
>>>
>>>> +       struct bpf_oom_ops *ops;
>>>> +       struct list_head node;
>>>> +       struct srcu_struct srcu;
>>>> +};
>>>> +
>>>> +bool bpf_handle_oom(struct oom_control *oc)
>>>> +{
>>>> +       struct bpf_oom_ops *ops;
>>>> +       struct bpf_oom *bpf_oom;
>>>> +       int list_idx, idx, ret = 0;
>>>> +
>>>> +       oc->bpf_memory_freed = false;
>>>> +
>>>> +       list_idx = srcu_read_lock(&bpf_oom_srcu);
>>>> +       list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false) {
>>>> +               ops = READ_ONCE(bpf_oom->ops);
>>>> +               if (!ops || !ops->handle_out_of_memory)
>>>> +                       continue;
>>>> +               idx = srcu_read_lock(&bpf_oom->srcu);
>>>> +               oc->bpf_policy_name = ops->name[0] ? &ops->name[0] :
>>>> +                       "bpf_defined_policy";
>>>> +               ret = ops->handle_out_of_memory(oc);
>>>> +               oc->bpf_policy_name = NULL;
>>>> +               srcu_read_unlock(&bpf_oom->srcu, idx);
>>>> +
>>>> +               if (ret && oc->bpf_memory_freed)
>>> IIUC ret and oc->bpf_memory_freed seem to reflect the same state:
>>> handler successfully freed some memory. Could you please clarify when
>>> they differ?
>> The idea here is to provide an additional safety measure:
>> if the bpf program simple returns 1 without doing anything,
>> the system won't deadlock.
>>
>> oc->bpf_memory_freed is set by the bpf_oom_kill_process() helper
>> (and potentially some other helpers in the future, e.g.
>> bpf_oom_rm_tmpfs_file()) and can't be modified by the bpf
>> program directly.
> I see. Then maybe we use only oc->bpf_memory_freed and
> handle_out_of_memory() does not return anything?


