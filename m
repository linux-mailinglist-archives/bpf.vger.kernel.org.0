Return-Path: <bpf+bounces-18497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0881AEC1
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 07:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8593B23A76
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 06:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6CB654;
	Thu, 21 Dec 2023 06:27:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C0D2E1
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwgSj2Bl6z4f3jZR
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:27:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE67D1A0964
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:27:02 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCH40Oy2oNlOcNVEQ--.18809S2;
	Thu, 21 Dec 2023 14:27:02 +0800 (CST)
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231221045954.1969955-1-yonghong.song@linux.dev>
 <20231221050010.1971932-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <58e11994-6f73-20de-eab8-f4d7a4f71d80@huaweicloud.com>
Date: Thu, 21 Dec 2023 14:26:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231221050010.1971932-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCH40Oy2oNlOcNVEQ--.18809S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8CFWDuF1DCF18ZrW7CFg_yoWrJr4rp3
	Wvgrn0yrn0qF9Fgw1fta18Wr1rXw10g3W8G34YyryjkrsxXrn7Gr1vyr4rZa45Cr48KF1x
	taykZF12qFW2kFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/21/2023 1:00 PM, Yonghong Song wrote:
> Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem allocation")
> added support for non-fix-size percpu memory allocation.
> Such allocation will allocate percpu memory for all buckets on all
> cpus and the memory consumption is in the order to quadratic.
> For example, let us say, 4 cpus, unit size 16 bytes, so each
> cpu has 16 * 4 = 64 bytes, with 4 cpus, total will be 64 * 4 = 256 bytes.
> Then let us say, 8 cpus with the same unit size, each cpu
> has 16 * 8 = 128 bytes, with 8 cpus, total will be 128 * 8 = 1024 bytes.
> So if the number of cpus doubles, the number of memory consumption
> will be 4 times. So for a system with large number of cpus, the
> memory consumption goes up quickly with quadratic order.
> For example, for 4KB percpu allocation, 128 cpus. The total memory
> consumption will 4KB * 128 * 128 = 64MB. Things will become
> worse if the number of cpus is bigger (e.g., 512, 1024, etc.)
>
> In Commit 41a5db8d8161, the non-fix-size percpu memory allocation is
> done in boot time, so for system with large number of cpus, the initial
> percpu memory consumption is very visible. For example, for 128 cpu
> system, the total percpu memory allocation will be at least
> (16 + 32 + 64 + 96 + 128 + 196 + 256 + 512 + 1024 + 2048 + 4096)
>   * 128 * 128 = ~138MB.
> which is pretty big. It will be even bigger for larger number of cpus.

SNIP
> +
>  static void drain_mem_cache(struct bpf_mem_cache *c)
>  {
>  	bool percpu = !!c->percpu_size;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f13008d27f35..08f9a49cc11c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12141,20 +12141,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>  					return -ENOMEM;
>  
> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> -					if (!bpf_global_percpu_ma_set) {
> -						mutex_lock(&bpf_percpu_ma_lock);
> -						if (!bpf_global_percpu_ma_set) {
> -							err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> -							if (!err)
> -								bpf_global_percpu_ma_set = true;
> -						}
> -						mutex_unlock(&bpf_percpu_ma_lock);
> -						if (err)
> -							return err;
> -					}
> -				}
> -
>  				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>  					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
>  					return -EINVAL;
> @@ -12175,6 +12161,26 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  					return -EINVAL;
>  				}
>  
> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +					if (!bpf_global_percpu_ma_set) {
> +						mutex_lock(&bpf_percpu_ma_lock);
> +						if (!bpf_global_percpu_ma_set) {
> +							err = bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);

Because ma->objcg is assigned as get_obj_cgroup_from_current(), so I
think the memory account will be incorrect, right ? Maybe we should pass
objcg to bpf_mem_alloc_percpu_init() explicit. For root memcg, I think
the objcg is NULL.
> +							if (!err)
> +								bpf_global_percpu_ma_set = true;
> +						}
> +						mutex_unlock(&bpf_percpu_ma_lock);
> +						if (err)
> +							return err;
> +					}
> +
> +					mutex_lock(&bpf_percpu_ma_lock);
> +					err = bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
> +					mutex_unlock(&bpf_percpu_ma_lock);
> +					if (err)
> +						return err;
> +				}
> +
>  				struct_meta = btf_find_struct_meta(ret_btf, ret_btf_id);
>  				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>  					if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {


