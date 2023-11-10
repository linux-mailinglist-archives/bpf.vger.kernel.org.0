Return-Path: <bpf+bounces-14748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898E7E7A5C
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 10:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AE42814B7
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03ED506;
	Fri, 10 Nov 2023 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B67D269
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:01:41 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA023A5F4
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:01:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRXqy18Z0z4f41Tn
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:01:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8760C1A0175
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:01:36 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAXLLpq8U1lVggbAg--.10775S2;
	Fri, 10 Nov 2023 17:01:34 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Do not allocate percpu memory at init stage
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20231110061734.2958678-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e17dafc1-6fac-3e87-f8d4-e54e7898e0aa@huaweicloud.com>
Date: Fri, 10 Nov 2023 17:01:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231110061734.2958678-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAXLLpq8U1lVggbAg--.10775S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DGr1DCw45CrWrGFyDZFb_yoWrtry5pa
	1kJF1Fyr4qqFs7Ww13Jw4UCryFqwn5WF1xK343Ary7ZrsIqwn7Kr4vyF4rZF90gFZ0kF18
	tF1v9r1a9FW5CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 11/10/2023 2:17 PM, Yonghong Song wrote:
> Kirill Shutemov reported significant percpu memory increase after booting
> in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"). The percpu memory is increased
> from 111MB to 969MB. The number is from /proc/meminfo.
>
> I tried to reproduce the issue with my local VM which at most supports
> upto 255 cpus. With 252 cpus, without the above commit, the percpu memory
> immediately after boot is 57MB while with the above commit the percpu
> memory is 231MB.
>
> This is not good since so far percpu memory from bpf memory allocator
> is not widely used yet. Let us change pre-allocation in init stage
> to on-demand allocation when verifier detects there is a need of
> percpu memory for bpf program. With this change, percpu memory
> consumption after boot can be reduced signicantly.
>
>   [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
>
> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/core.c     |  8 +++-----
>  kernel/bpf/verifier.c | 17 +++++++++++++++--
>  3 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..3df67a04d32e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -56,7 +56,7 @@ extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
>  extern struct kobject *btf_kobj;
>  extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> -extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
> +extern bool bpf_global_ma_set;
>  
>  typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>  typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 08626b519ce2..cd3afe57ece3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -64,8 +64,8 @@
>  #define OFF	insn->off
>  #define IMM	insn->imm
>  
> -struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> -bool bpf_global_ma_set, bpf_global_percpu_ma_set;
> +struct bpf_mem_alloc bpf_global_ma;
> +bool bpf_global_ma_set;
>  
>  /* No hurry in this branch
>   *
> @@ -2934,9 +2934,7 @@ static int __init bpf_global_ma_init(void)
>  
>  	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>  	bpf_global_ma_set = !ret;
> -	ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> -	bpf_global_percpu_ma_set = !ret;
> -	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
> +	return ret;
>  }
>  late_initcall(bpf_global_ma_init);
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bd1c42eb540f..7d485c8b794f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -26,6 +26,7 @@
>  #include <linux/poison.h>
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
> +#include <linux/bpf_mem_alloc.h>
>  #include <net/xdp.h>
>  
>  #include "disasm.h"
> @@ -41,6 +42,9 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>  #undef BPF_LINK_TYPE
>  };
>  
> +struct bpf_mem_alloc bpf_global_percpu_ma;
> +static bool bpf_global_percpu_ma_set;
> +
>  /* bpf_check() is a static code analyzer that walks eBPF program
>   * instruction by instruction and updates register/stack state.
>   * All paths of conditional branches are analyzed until 'bpf_exit' insn.
> @@ -12074,8 +12078,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>  					return -ENOMEM;
>  
> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && !bpf_global_percpu_ma_set)
> -					return -ENOMEM;
> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +					mutex_lock(&bpf_verifier_lock);

Instead of acquiring the global lock each time, can we test whether or
bpf_global_percpu_ma_set is set before acquiring the global lock ?
> +					if (!bpf_global_percpu_ma_set) {
> +						err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> +						if (!err)
> +							bpf_global_percpu_ma_set = true;
> +					}
> +					mutex_unlock(&bpf_verifier_lock);
> +					if (err)
> +						return err;
> +				}
>  
>  				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>  					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");


