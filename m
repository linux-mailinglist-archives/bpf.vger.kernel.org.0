Return-Path: <bpf+bounces-14991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C777E9C4C
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539991F20F10
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B41D527;
	Mon, 13 Nov 2023 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8CB156CE
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 12:42:15 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDD171A
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:42:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4STTb53ZYdz4f3mLl
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:42:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA6AD1A0183
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:42:10 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAXJkacGVJl+xhfAw--.35390S2;
	Mon, 13 Nov 2023 20:42:08 +0800 (CST)
Subject: Re: [PATCH bpf-next v3] bpf: Do not allocate percpu memory at init
 stage
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231111013928.948838-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <50a70429-169f-0d44-86da-d5fe6a9d59e6@huaweicloud.com>
Date: Mon, 13 Nov 2023 20:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231111013928.948838-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAXJkacGVJl+xhfAw--.35390S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW7XrWDKF43Xw1rZry7KFg_yoW7WFy8pa
	1kJF1Yyr4qqFs7W343Jw48AryFqwn5WF1xK343Ary7CrsIqrn7Gr4vkr4rZF909FZ0kFy0
	yFyvvr1agFW5CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/11/2023 9:39 AM, Yonghong Song wrote:
> Kirill Shutemov reported significant percpu memory consumption increase after
> booting in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"). The percpu memory consumption is
> increased from 111MB to 969MB. The number is from /proc/meminfo.
>
> I tried to reproduce the issue with my local VM which at most supports upto
> 255 cpus. With 252 cpus, without the above commit, the percpu memory
> consumption immediately after boot is 57MB while with the above commit the
> percpu memory consumption is 231MB.
>
> This is not good since so far percpu memory from bpf memory allocator is not
> widely used yet. Let us change pre-allocation in init stage to on-demand
> allocation when verifier detects there is a need of percpu memory for bpf
> program. With this change, percpu memory consumption after boot can be reduced
> signicantly.
>
>   [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
>
> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
> Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/core.c     |  8 +++-----
>  kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> Changelog:
>   v2 -> v3:
>     - Use dedicated mutex lock (bpf_percpu_ma_lock)
>   v1 -> v2:
>     - Add proper Reported-and-tested-by tag.
>     - Do a check of !bpf_global_percpu_ma_set before acquiring verifier_lock.
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 35bff17396c0..6762dac3ef76 100644
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
> index a2267d5ed14e..6da370a047fe 100644
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
> @@ -336,6 +340,7 @@ struct bpf_kfunc_call_arg_meta {
>  struct btf *btf_vmlinux;
>  
>  static DEFINE_MUTEX(bpf_verifier_lock);
> +static DEFINE_MUTEX(bpf_percpu_ma_lock);
>  
>  static const struct bpf_line_info *
>  find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
> @@ -12091,8 +12096,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>  					return -ENOMEM;
>  
> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && !bpf_global_percpu_ma_set)
> -					return -ENOMEM;
> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +					if (!bpf_global_percpu_ma_set) {
> +						mutex_lock(&bpf_percpu_ma_lock);
> +						if (!bpf_global_percpu_ma_set) {
> +							err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> +							if (!err)
> +								bpf_global_percpu_ma_set = true;
> +						}

A dumb question here: do we need some memory barrier to guarantee the
memory order between bpf_global_percpu_ma_set and bpf_global_percpu_ma ?
> +						mutex_unlock(&bpf_percpu_ma_lock);
> +						if (err)
> +							return err;
> +					}
> +				}
>  
>  				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>  					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");


