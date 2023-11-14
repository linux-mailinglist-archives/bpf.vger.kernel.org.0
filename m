Return-Path: <bpf+bounces-15031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC37EA916
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ED51F23D1A
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516D8BF9;
	Tue, 14 Nov 2023 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j+4a8VJa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6F8813
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 03:23:41 +0000 (UTC)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C34791
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 19:23:40 -0800 (PST)
Message-ID: <05207c41-2e2f-49d6-a8bf-a2820701242f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699932218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3e86WVIsab+nIxh+vo37Xnl/AnLwiK5k+I8kh/dvIk=;
	b=j+4a8VJaepGn2qmvf/ukV/hbFQ3IipOcC/OksIIzdaWarxuAFvnjo1VmGFXPsM4h+s7dG6
	bUb8aKav2+nySAr7g6/fs8I/j6z+H1vAxtQQjaRGLd42oY3eaHPeh2uzDT347lqN91mWGC
	aIeh2K8/Uo3DIz/yHkJvuUber6ibUDI=
Date: Mon, 13 Nov 2023 22:23:32 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: Do not allocate percpu memory at init
 stage
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231111013928.948838-1-yonghong.song@linux.dev>
 <50a70429-169f-0d44-86da-d5fe6a9d59e6@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <50a70429-169f-0d44-86da-d5fe6a9d59e6@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/13/23 4:42 AM, Hou Tao wrote:
> Hi,
>
> On 11/11/2023 9:39 AM, Yonghong Song wrote:
>> Kirill Shutemov reported significant percpu memory consumption increase after
>> booting in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
>> non-fix-size percpu mem allocation"). The percpu memory consumption is
>> increased from 111MB to 969MB. The number is from /proc/meminfo.
>>
>> I tried to reproduce the issue with my local VM which at most supports upto
>> 255 cpus. With 252 cpus, without the above commit, the percpu memory
>> consumption immediately after boot is 57MB while with the above commit the
>> percpu memory consumption is 231MB.
>>
>> This is not good since so far percpu memory from bpf memory allocator is not
>> widely used yet. Let us change pre-allocation in init stage to on-demand
>> allocation when verifier detects there is a need of percpu memory for bpf
>> program. With this change, percpu memory consumption after boot can be reduced
>> signicantly.
>>
>>    [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
>>
>> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
>> Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h   |  2 +-
>>   kernel/bpf/core.c     |  8 +++-----
>>   kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>>   3 files changed, 22 insertions(+), 8 deletions(-)
>>
>> Changelog:
>>    v2 -> v3:
>>      - Use dedicated mutex lock (bpf_percpu_ma_lock)
>>    v1 -> v2:
>>      - Add proper Reported-and-tested-by tag.
>>      - Do a check of !bpf_global_percpu_ma_set before acquiring verifier_lock.
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 35bff17396c0..6762dac3ef76 100644
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
>> index a2267d5ed14e..6da370a047fe 100644
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
>> @@ -336,6 +340,7 @@ struct bpf_kfunc_call_arg_meta {
>>   struct btf *btf_vmlinux;
>>   
>>   static DEFINE_MUTEX(bpf_verifier_lock);
>> +static DEFINE_MUTEX(bpf_percpu_ma_lock);
>>   
>>   static const struct bpf_line_info *
>>   find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>> @@ -12091,8 +12096,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>>   					return -ENOMEM;
>>   
>> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && !bpf_global_percpu_ma_set)
>> -					return -ENOMEM;
>> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>> +					if (!bpf_global_percpu_ma_set) {
>> +						mutex_lock(&bpf_percpu_ma_lock);
>> +						if (!bpf_global_percpu_ma_set) {
>> +							err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>> +							if (!err)
>> +								bpf_global_percpu_ma_set = true;
>> +						}
> A dumb question here: do we need some memory barrier to guarantee the
> memory order between bpf_global_percpu_ma_set and bpf_global_percpu_ma ?

We should be fine. There is a control dependence on '!err' for
'bpf_global_percpu_ma_set = true'.

>> +						mutex_unlock(&bpf_percpu_ma_lock);
>> +						if (err)
>> +							return err;
>> +					}
>> +				}
>>   
>>   				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>>   					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");

