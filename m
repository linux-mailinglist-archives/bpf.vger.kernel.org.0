Return-Path: <bpf+bounces-14781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF07E7DD5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530511C20AB7
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608751805C;
	Fri, 10 Nov 2023 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxM4wODu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3318E08
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:36:21 +0000 (UTC)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A63F34A
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:36:20 -0800 (PST)
Message-ID: <d2c25841-93da-49da-914d-c86da6f8f2f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699634178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3xj3Ta4WeOz+XbmppCo6thBElQ0GzSlVteCfAIbptI=;
	b=hxM4wODutNYSwKGp6t+7ZH4s6J4R5sH7RkEhjO+lc8XcqPnBPPFKvIyfxAKfXg5hLZ/JlC
	Eb8hbq5WmnFn2tNGHhsytdWGF/vZnblfbzK0l7K4F+luFDjke2ufun4zLE6eSBxWXTZZyf
	OFLXB6kW7HnYwlkEyj9pj3voqgBA0js=
Date: Fri, 10 Nov 2023 08:36:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Do not allocate percpu memory at init stage
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20231110061734.2958678-1-yonghong.song@linux.dev>
 <e17dafc1-6fac-3e87-f8d4-e54e7898e0aa@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e17dafc1-6fac-3e87-f8d4-e54e7898e0aa@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/10/23 1:01 AM, Hou Tao wrote:
>
> On 11/10/2023 2:17 PM, Yonghong Song wrote:
>> Kirill Shutemov reported significant percpu memory increase after booting
>> in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
>> non-fix-size percpu mem allocation"). The percpu memory is increased
>> from 111MB to 969MB. The number is from /proc/meminfo.
>>
>> I tried to reproduce the issue with my local VM which at most supports
>> upto 255 cpus. With 252 cpus, without the above commit, the percpu memory
>> immediately after boot is 57MB while with the above commit the percpu
>> memory is 231MB.
>>
>> This is not good since so far percpu memory from bpf memory allocator
>> is not widely used yet. Let us change pre-allocation in init stage
>> to on-demand allocation when verifier detects there is a need of
>> percpu memory for bpf program. With this change, percpu memory
>> consumption after boot can be reduced signicantly.
>>
>>    [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
>>
>> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h   |  2 +-
>>   kernel/bpf/core.c     |  8 +++-----
>>   kernel/bpf/verifier.c | 17 +++++++++++++++--
>>   3 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index b4825d3cdb29..3df67a04d32e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -56,7 +56,7 @@ extern struct idr btf_idr;
>>   extern spinlock_t btf_idr_lock;
>>   extern struct kobject *btf_kobj;
>>   extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
>> -extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>> +extern bool bpf_global_ma_set;
>>   
>>   typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>>   typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 08626b519ce2..cd3afe57ece3 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -64,8 +64,8 @@
>>   #define OFF	insn->off
>>   #define IMM	insn->imm
>>   
>> -struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
>> -bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>> +struct bpf_mem_alloc bpf_global_ma;
>> +bool bpf_global_ma_set;
>>   
>>   /* No hurry in this branch
>>    *
>> @@ -2934,9 +2934,7 @@ static int __init bpf_global_ma_init(void)
>>   
>>   	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>>   	bpf_global_ma_set = !ret;
>> -	ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>> -	bpf_global_percpu_ma_set = !ret;
>> -	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>> +	return ret;
>>   }
>>   late_initcall(bpf_global_ma_init);
>>   #endif
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index bd1c42eb540f..7d485c8b794f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/poison.h>
>>   #include <linux/module.h>
>>   #include <linux/cpumask.h>
>> +#include <linux/bpf_mem_alloc.h>
>>   #include <net/xdp.h>
>>   
>>   #include "disasm.h"
>> @@ -41,6 +42,9 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>>   #undef BPF_LINK_TYPE
>>   };
>>   
>> +struct bpf_mem_alloc bpf_global_percpu_ma;
>> +static bool bpf_global_percpu_ma_set;
>> +
>>   /* bpf_check() is a static code analyzer that walks eBPF program
>>    * instruction by instruction and updates register/stack state.
>>    * All paths of conditional branches are analyzed until 'bpf_exit' insn.
>> @@ -12074,8 +12078,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>>   					return -ENOMEM;
>>   
>> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && !bpf_global_percpu_ma_set)
>> -					return -ENOMEM;
>> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>> +					mutex_lock(&bpf_verifier_lock);
> Instead of acquiring the global lock each time, can we test whether or
> bpf_global_percpu_ma_set is set before acquiring the global lock ?

Currently, in verifier we have two places to use bpf_verifier_lock:
(1) to get btf_vmlinux:
         if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
                 mutex_lock(&bpf_verifier_lock);
                 if (!btf_vmlinux)
                         btf_vmlinux = btf_parse_vmlinux();
                 mutex_unlock(&bpf_verifier_lock);
         }
This will only lock once if btf_parse_vmlinux() is successful.

(2) for unprividged bpf programs in bpf_check().
A big chunk of it is under bpf_verifier_lock.

I didn't use style (1) since I assume unprividged bpf programs
is rare and it should seldomly collide with percpu_obj_new_impl.

But my assumption related to (2) may be wrong and in the future
verifier_lock() could be used in other places which may cause
more contention.

So I now agree with you and will make appropriate change. Thanks!

>> +					if (!bpf_global_percpu_ma_set) {
>> +						err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>> +						if (!err)
>> +							bpf_global_percpu_ma_set = true;
>> +					}
>> +					mutex_unlock(&bpf_verifier_lock);
>> +					if (err)
>> +						return err;
>> +				}
>>   
>>   				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>>   					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");

