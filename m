Return-Path: <bpf+bounces-43623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0009B7290
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 03:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2241E1F21B04
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 02:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054712BF25;
	Thu, 31 Oct 2024 02:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321807581F
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342399; cv=none; b=ZqWB5EDVe8cG3enNhIU77Wy1zmMEO+aMbew96cjlhDomCPWX1KpdWGOLWJCMWTP8lTuGptTZOkdU9vKP/DoHr3CXEG0j6yMr5tKpict1qrgbMX5eIjbTMsifBQoR+0Ose2DDJ+oW32opIaZu366jNjlcBK6/vGs2iqQOulTYHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342399; c=relaxed/simple;
	bh=/IM7YJggCvGyJKlyRYQlqWi8WevqwhKu92JtSP+tNgQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mC9GlH8KY3s/fsXkA8abF5x8NBSGPdjYmUh4GfGVK/JviXmjOPVQX/U9BnQJUcb0ErmqWNT6Zgc0bK4cR0Adm6rcTSstjc8eFb3qnsMBjbFIONL1M1p0b5H532QU6WerI4nXQsNJeCQVJrfOYQMMTBwJ04LPWT30D93CNiuA+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xf7Vt5W1Tz4f3jJ1
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 10:39:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E79C1A018D
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 10:39:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCHLrDx7SJnb2qmAQ--.39769S2;
	Thu, 31 Oct 2024 10:39:49 +0800 (CST)
Subject: Re: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in
 verifier
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com
References: <d204f9ff-81a3-4b07-874f-fe3256a65735@stanley.mountain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9e194526-f667-e462-7778-2b8b4f6f8d5a@huaweicloud.com>
Date: Thu, 31 Oct 2024 10:39:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d204f9ff-81a3-4b07-874f-fe3256a65735@stanley.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCHLrDx7SJnb2qmAQ--.39769S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tFWUCryUKF1rAr1DXrW5KFg_yoWkCr4kpF
	y8WryDWF4jkw1Fva4qv397WFnYyF95A3W5Gw1Ut340vr1jkr9I9ryrWry5WF4fKr18u3WS
	yw18Kr98XrWjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/13/2024 9:07 PM, Dan Carpenter wrote:
> Hi Hou,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/bpf-Introduce-map-flag-BPF_F_DYNPTR_IN_KEY/20241008-171136
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20241008091501.8302-6-houtao%40huaweicloud.com
> patch subject: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in verifier
> config: x86_64-randconfig-161-20241011 (https://download.01.org/0day-ci/archive/20241012/202410120302.bUO1BoP7-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410120302.bUO1BoP7-lkp@intel.com/
>
> smatch warnings:
> kernel/bpf/verifier.c:7471 check_stack_range_initialized() error: we previously assumed 'meta' could be null (see line 7439)
>
> vim +/meta +7471 kernel/bpf/verifier.c

Thanks for the report. Sorry for the late reply. The mail is lost in my
email client. It is a false positive. Because when
ACCESS_F_DYNPTR_READ_ALLOWED is enabled, meta must be no NULL. But I
think it incurs no harm to make dynptr_read_allowed depends on a no-NULL
meta pointer.
>
> 01f810ace9ed37 Andrei Matei            2021-02-06  7361  static int check_stack_range_initialized(
> 01f810ace9ed37 Andrei Matei            2021-02-06  7362  		struct bpf_verifier_env *env, int regno, int off,
> 81b030a7eaa2ee Hou Tao                 2024-10-08  7363  		int access_size, unsigned int access_flags,
> 61df10c7799e27 Kumar Kartikeya Dwivedi 2022-04-25  7364  		enum bpf_access_src type, struct bpf_call_arg_meta *meta)
> 17a5267067f3c3 Alexei Starovoitov      2014-09-26  7365  {
> 2a159c6f82381a Daniel Borkmann         2018-10-21  7366  	struct bpf_reg_state *reg = reg_state(env, regno);
> f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  7367  	struct bpf_func_state *state = func(env, reg);
> f7cf25b2026dc8 Alexei Starovoitov      2019-06-15  7368  	int err, min_off, max_off, i, j, slot, spi;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7369  	char *err_extra = type == ACCESS_HELPER ? " indirect" : "";
> 01f810ace9ed37 Andrei Matei            2021-02-06  7370  	enum bpf_access_type bounds_check_type;
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7371  	struct dynptr_key_state dynptr_key;
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7372  	bool dynptr_read_allowed;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7373  	/* Some accesses can write anything into the stack, others are
> 01f810ace9ed37 Andrei Matei            2021-02-06  7374  	 * read-only.
> 01f810ace9ed37 Andrei Matei            2021-02-06  7375  	 */
> 01f810ace9ed37 Andrei Matei            2021-02-06  7376  	bool clobber = false;
> 17a5267067f3c3 Alexei Starovoitov      2014-09-26  7377  
> 81b030a7eaa2ee Hou Tao                 2024-10-08  7378  	if (access_size == 0 && !(access_flags & ACCESS_F_ZERO_SIZE_ALLOWED)) {
> 01f810ace9ed37 Andrei Matei            2021-02-06  7379  		verbose(env, "invalid zero-sized read\n");
> 01f810ace9ed37 Andrei Matei            2021-02-06  7380  		return -EACCES;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7381  	}
> 01f810ace9ed37 Andrei Matei            2021-02-06  7382  
> 01f810ace9ed37 Andrei Matei            2021-02-06  7383  	if (type == ACCESS_HELPER) {
> 01f810ace9ed37 Andrei Matei            2021-02-06  7384  		/* The bounds checks for writes are more permissive than for
> 01f810ace9ed37 Andrei Matei            2021-02-06  7385  		 * reads. However, if raw_mode is not set, we'll do extra
> 01f810ace9ed37 Andrei Matei            2021-02-06  7386  		 * checks below.
> 01f810ace9ed37 Andrei Matei            2021-02-06  7387  		 */
> 01f810ace9ed37 Andrei Matei            2021-02-06  7388  		bounds_check_type = BPF_WRITE;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7389  		clobber = true;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7390  	} else {
> 01f810ace9ed37 Andrei Matei            2021-02-06  7391  		bounds_check_type = BPF_READ;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7392  	}
> 01f810ace9ed37 Andrei Matei            2021-02-06  7393  	err = check_stack_access_within_bounds(env, regno, off, access_size,
> 01f810ace9ed37 Andrei Matei            2021-02-06  7394  					       type, bounds_check_type);
> 2011fccfb61bbd Andrey Ignatov          2019-03-28  7395  	if (err)
> 2011fccfb61bbd Andrey Ignatov          2019-03-28  7396  		return err;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7397  
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7398  	dynptr_read_allowed = access_flags & ACCESS_F_DYNPTR_READ_ALLOWED;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7399  	if (tnum_is_const(reg->var_off)) {
> 01f810ace9ed37 Andrei Matei            2021-02-06  7400  		min_off = max_off = reg->var_off.value + off;
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7401  
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7402  		if (dynptr_read_allowed && (min_off % BPF_REG_SIZE)) {
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7403  			verbose(env, "R%d misaligned offset %d for dynptr-key\n", regno, min_off);
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7404  			return -EACCES;
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7405  		}
>
> can meta be NULL on this path?  If not then this is a false positive.
>
> 2011fccfb61bbd Andrey Ignatov          2019-03-28  7406  	} else {
> 088ec26d9c2da9 Andrey Ignatov          2019-04-03  7407  		/* Variable offset is prohibited for unprivileged mode for
> 088ec26d9c2da9 Andrey Ignatov          2019-04-03  7408  		 * simplicity since it requires corresponding support in
> 088ec26d9c2da9 Andrey Ignatov          2019-04-03  7409  		 * Spectre masking for stack ALU.
> 088ec26d9c2da9 Andrey Ignatov          2019-04-03  7410  		 * See also retrieve_ptr_limit().
> 088ec26d9c2da9 Andrey Ignatov          2019-04-03  7411  		 */
> 2c78ee898d8f10 Alexei Starovoitov      2020-05-13  7412  		if (!env->bypass_spec_v1) {
> f1174f77b50c94 Edward Cree             2017-08-07  7413  			char tn_buf[48];
> f1174f77b50c94 Edward Cree             2017-08-07  7414  
> 914cb781ee1a35 Alexei Starovoitov      2017-11-30  7415  			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> 01f810ace9ed37 Andrei Matei            2021-02-06  7416  			verbose(env, "R%d%s variable offset stack access prohibited for !root, var_off=%s\n",
> 01f810ace9ed37 Andrei Matei            2021-02-06  7417  				regno, err_extra, tn_buf);
> ea25f914dc164c Jann Horn               2017-12-18  7418  			return -EACCES;
> f1174f77b50c94 Edward Cree             2017-08-07  7419  		}
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7420  
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7421  		if (dynptr_read_allowed) {
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7422  			verbose(env, "R%d variable offset prohibited for dynptr-key\n", regno);
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7423  			return -EACCES;
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7424  		}
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7425  
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7426  		/* Only initialized buffer on stack is allowed to be accessed
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7427  		 * with variable offset. With uninitialized buffer it's hard to
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7428  		 * guarantee that whole memory is marked as initialized on
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7429  		 * helper return since specific bounds are unknown what may
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7430  		 * cause uninitialized stack leaking.
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7431  		 */
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7432  		if (meta && meta->raw_mode)
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7433  			meta = NULL;
> f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7434  
> 01f810ace9ed37 Andrei Matei            2021-02-06  7435  		min_off = reg->smin_value + off;
> 01f810ace9ed37 Andrei Matei            2021-02-06  7436  		max_off = reg->smax_value + off;
> 107c26a70ca81b Andrey Ignatov          2019-04-03  7437  	}
> 17a5267067f3c3 Alexei Starovoitov      2014-09-26  7438  
> 435faee1aae9c1 Daniel Borkmann         2016-04-13 @7439  	if (meta && meta->raw_mode) {
>
> Check for NULL
>
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7440  		/* Ensure we won't be overwriting dynptrs when simulating byte
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7441  		 * by byte access in check_helper_call using meta.access_size.
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7442  		 * This would be a problem if we have a helper in the future
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7443  		 * which takes:
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7444  		 *
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7445  		 *	helper(uninit_mem, len, dynptr)
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7446  		 *
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7447  		 * Now, uninint_mem may overlap with dynptr pointer. Hence, it
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7448  		 * may end up writing to dynptr itself when touching memory from
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7449  		 * arg 1. This can be relaxed on a case by case basis for known
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7450  		 * safe cases, but reject due to the possibilitiy of aliasing by
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7451  		 * default.
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7452  		 */
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7453  		for (i = min_off; i < max_off + access_size; i++) {
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7454  			int stack_off = -i - 1;
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7455  
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7456  			spi = __get_spi(i);
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7457  			/* raw_mode may write past allocated_stack */
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7458  			if (state->allocated_stack <= stack_off)
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7459  				continue;
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7460  			if (state->stack[spi].slot_type[stack_off % BPF_REG_SIZE] == STACK_DYNPTR) {
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7461  				verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7462  				return -EACCES;
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7463  			}
> ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7464  		}
> 435faee1aae9c1 Daniel Borkmann         2016-04-13  7465  		meta->access_size = access_size;
> 435faee1aae9c1 Daniel Borkmann         2016-04-13  7466  		meta->regno = regno;
> 435faee1aae9c1 Daniel Borkmann         2016-04-13  7467  		return 0;
> 435faee1aae9c1 Daniel Borkmann         2016-04-13  7468  	}
> 435faee1aae9c1 Daniel Borkmann         2016-04-13  7469  
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7470  	if (dynptr_read_allowed) {
> cf5a0c90a8bc5f Hou Tao                 2024-10-08 @7471  		err = init_dynptr_key_state(env, meta->map_ptr->key_record, &dynptr_key);
>                                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^
> Unchecked dereference
>
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7472  		if (err)
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7473  			return err;
> cf5a0c90a8bc5f Hou Tao                 2024-10-08  7474  	}
> 2011fccfb61bbd Andrey Ignatov          2019-03-28  7475  	for (i = min_off; i < max_off + access_size; i++) {
> cc2b14d51053eb Alexei Starovoitov      2017-12-14  7476  		u8 *stype;
> cc2b14d51053eb Alexei Starovoitov      2017-12-14  7477  
> 2011fccfb61bbd Andrey Ignatov          2019-03-28  7478  		slot = -i - 1;
> 638f5b90d46016 Alexei Starovoitov      2017-10-31  7479  		spi = slot / BPF_REG_SIZE;
> 6b4a64bafd107e Andrei Matei            2023-12-07  7480  		if (state->allocated_stack <= slot) {
>


