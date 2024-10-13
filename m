Return-Path: <bpf+bounces-41826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC699B981
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C68281919
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7541442E8;
	Sun, 13 Oct 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imW/5TlA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A1231CA5
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824845; cv=none; b=pEF1Pii6ijaaoh/bbCEGLh78fqgMYItz/I32HF6LXfXQWxQ+G2Amy0HUDhx7j415+mhEuYmvs3FZQwa1Tz+eM2Yzs42qfvlHSH6Z1bY06muyN5ChhGheXD5ASnU3ZN0lTuVzfWfLXnK05/pv+Et0pV8xfF2c7GGUqorVHMvTgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824845; c=relaxed/simple;
	bh=dI8t32lrGIdOQRDrKiyOxS2wO4mvoIV1pN8x/YkshYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Kod9705O2edO0R6IJR7mFqpuiEsDW++HZcN9RRQR0HOO/t7BvyY2eaJksGSheGdwK7xMTWQBKmPY6kN4iyJcmYNGPaa7+QGrGgrTq+TfI/vsm/M9pvYFkVyQDmz+0nD2RAOdFCYU2KWRhIEmYKyVsoXunPB3pEapb5fH+RyetKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imW/5TlA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99fa009adcso88389266b.0
        for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728824842; x=1729429642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOLk9YRGA3snVdrkCuTid7bDs/38RjfvWPDAu1xZZv0=;
        b=imW/5TlAJGsDG6mbHVQ8l82oECoyNZdSB8/JGFUH1m/EMC7lx1nfY9QFQZ4AxKm+nj
         p77OVwjn83b+p+9zOoZUz7PTsmlC//JJ86GHzDBj2z2sQX6oQcaoP5A+imdeklwnV0fQ
         Dt+JvMrEh9CsFkWJnQoxxYaL7tmqZ8L7usajjQQvbXLslhsognX4A5dooLq8a2Lh43io
         ZWKIK59yLgwpEneRINGN9ypUAeT2f9UhA1VkTehY04NC7B81tB8lfFVcgrHPQQdQzZnl
         dOvpAb/wzb0cGU+JjTJhiU6O615freI+ICU4gYOVPL/xVpI0bdh20UblUuF2FqbkE/Rk
         hItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824842; x=1729429642;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOLk9YRGA3snVdrkCuTid7bDs/38RjfvWPDAu1xZZv0=;
        b=FvIGjdD+KWRKmu2qJ5TXdxFnEIASbClKqmhAGAYXv7ofEBprgddJFr9b8vC8JEFJIi
         NVEimwrQXq1p3hMtz6eYMHcxrQwk5DZ0zixXFTSnEmSc7w3N4Vgbryuot480k7yRtkgP
         GqrwIGuhty8G595fkEeov9huG4gLjJAK4T07SuC6KhlpnayNuLAHsyhJ5U2EolTuAnZm
         3R+r+r95AMrAtD78ZGfLEYhyIO//r6M//7VarMCTD3qJhcSI6tBWiZqrYjK4a5ckOwlB
         o+avYY4D1cXwr+yajt3N81qT26GBiqOV4DFiEu1zhS5uNgElHVzhiBPNRHxi2PnHKaeo
         3G4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWst6RbjuOGKPFz25ch96anCe8UuCFMlalk/W4QTfmSNNwlwdpCbW0cQzS96pZqvoPkqKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4TsYyROhEFJw6EbxJYDVLml7PuHf/WtEeZFKegzQGIISOj9P
	lZOsJaZujvTcWoKLrxPRrP7sKflFr1ZYPzYmQqpGYkjNi+rg5piZJEPvtGK3YYI=
X-Google-Smtp-Source: AGHT+IFgsY6uql2InzN2ZUNHBzLIuKUNVrhzqcOfcjZEwLAdmqfACoCzOijaGcAK8n3t3MeTvRSJzQ==
X-Received: by 2002:a05:6402:35c8:b0:5c9:7401:394a with SMTP id 4fb4d7f45d1cf-5c974013f57mr3546159a12.7.1728824841833;
        Sun, 13 Oct 2024 06:07:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93726052fsm3781079a12.73.2024.10.13.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:07:21 -0700 (PDT)
Date: Sun, 13 Oct 2024 16:07:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Hou Tao <houtao@huaweicloud.com>,
	bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in
 verifier
Message-ID: <d204f9ff-81a3-4b07-874f-fe3256a65735@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008091501.8302-6-houtao@huaweicloud.com>

Hi Hou,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/bpf-Introduce-map-flag-BPF_F_DYNPTR_IN_KEY/20241008-171136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241008091501.8302-6-houtao%40huaweicloud.com
patch subject: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in verifier
config: x86_64-randconfig-161-20241011 (https://download.01.org/0day-ci/archive/20241012/202410120302.bUO1BoP7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410120302.bUO1BoP7-lkp@intel.com/

smatch warnings:
kernel/bpf/verifier.c:7471 check_stack_range_initialized() error: we previously assumed 'meta' could be null (see line 7439)

vim +/meta +7471 kernel/bpf/verifier.c

01f810ace9ed37 Andrei Matei            2021-02-06  7361  static int check_stack_range_initialized(
01f810ace9ed37 Andrei Matei            2021-02-06  7362  		struct bpf_verifier_env *env, int regno, int off,
81b030a7eaa2ee Hou Tao                 2024-10-08  7363  		int access_size, unsigned int access_flags,
61df10c7799e27 Kumar Kartikeya Dwivedi 2022-04-25  7364  		enum bpf_access_src type, struct bpf_call_arg_meta *meta)
17a5267067f3c3 Alexei Starovoitov      2014-09-26  7365  {
2a159c6f82381a Daniel Borkmann         2018-10-21  7366  	struct bpf_reg_state *reg = reg_state(env, regno);
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  7367  	struct bpf_func_state *state = func(env, reg);
f7cf25b2026dc8 Alexei Starovoitov      2019-06-15  7368  	int err, min_off, max_off, i, j, slot, spi;
01f810ace9ed37 Andrei Matei            2021-02-06  7369  	char *err_extra = type == ACCESS_HELPER ? " indirect" : "";
01f810ace9ed37 Andrei Matei            2021-02-06  7370  	enum bpf_access_type bounds_check_type;
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7371  	struct dynptr_key_state dynptr_key;
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7372  	bool dynptr_read_allowed;
01f810ace9ed37 Andrei Matei            2021-02-06  7373  	/* Some accesses can write anything into the stack, others are
01f810ace9ed37 Andrei Matei            2021-02-06  7374  	 * read-only.
01f810ace9ed37 Andrei Matei            2021-02-06  7375  	 */
01f810ace9ed37 Andrei Matei            2021-02-06  7376  	bool clobber = false;
17a5267067f3c3 Alexei Starovoitov      2014-09-26  7377  
81b030a7eaa2ee Hou Tao                 2024-10-08  7378  	if (access_size == 0 && !(access_flags & ACCESS_F_ZERO_SIZE_ALLOWED)) {
01f810ace9ed37 Andrei Matei            2021-02-06  7379  		verbose(env, "invalid zero-sized read\n");
01f810ace9ed37 Andrei Matei            2021-02-06  7380  		return -EACCES;
01f810ace9ed37 Andrei Matei            2021-02-06  7381  	}
01f810ace9ed37 Andrei Matei            2021-02-06  7382  
01f810ace9ed37 Andrei Matei            2021-02-06  7383  	if (type == ACCESS_HELPER) {
01f810ace9ed37 Andrei Matei            2021-02-06  7384  		/* The bounds checks for writes are more permissive than for
01f810ace9ed37 Andrei Matei            2021-02-06  7385  		 * reads. However, if raw_mode is not set, we'll do extra
01f810ace9ed37 Andrei Matei            2021-02-06  7386  		 * checks below.
01f810ace9ed37 Andrei Matei            2021-02-06  7387  		 */
01f810ace9ed37 Andrei Matei            2021-02-06  7388  		bounds_check_type = BPF_WRITE;
01f810ace9ed37 Andrei Matei            2021-02-06  7389  		clobber = true;
01f810ace9ed37 Andrei Matei            2021-02-06  7390  	} else {
01f810ace9ed37 Andrei Matei            2021-02-06  7391  		bounds_check_type = BPF_READ;
01f810ace9ed37 Andrei Matei            2021-02-06  7392  	}
01f810ace9ed37 Andrei Matei            2021-02-06  7393  	err = check_stack_access_within_bounds(env, regno, off, access_size,
01f810ace9ed37 Andrei Matei            2021-02-06  7394  					       type, bounds_check_type);
2011fccfb61bbd Andrey Ignatov          2019-03-28  7395  	if (err)
2011fccfb61bbd Andrey Ignatov          2019-03-28  7396  		return err;
01f810ace9ed37 Andrei Matei            2021-02-06  7397  
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7398  	dynptr_read_allowed = access_flags & ACCESS_F_DYNPTR_READ_ALLOWED;
01f810ace9ed37 Andrei Matei            2021-02-06  7399  	if (tnum_is_const(reg->var_off)) {
01f810ace9ed37 Andrei Matei            2021-02-06  7400  		min_off = max_off = reg->var_off.value + off;
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7401  
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7402  		if (dynptr_read_allowed && (min_off % BPF_REG_SIZE)) {
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7403  			verbose(env, "R%d misaligned offset %d for dynptr-key\n", regno, min_off);
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7404  			return -EACCES;
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7405  		}

can meta be NULL on this path?  If not then this is a false positive.

2011fccfb61bbd Andrey Ignatov          2019-03-28  7406  	} else {
088ec26d9c2da9 Andrey Ignatov          2019-04-03  7407  		/* Variable offset is prohibited for unprivileged mode for
088ec26d9c2da9 Andrey Ignatov          2019-04-03  7408  		 * simplicity since it requires corresponding support in
088ec26d9c2da9 Andrey Ignatov          2019-04-03  7409  		 * Spectre masking for stack ALU.
088ec26d9c2da9 Andrey Ignatov          2019-04-03  7410  		 * See also retrieve_ptr_limit().
088ec26d9c2da9 Andrey Ignatov          2019-04-03  7411  		 */
2c78ee898d8f10 Alexei Starovoitov      2020-05-13  7412  		if (!env->bypass_spec_v1) {
f1174f77b50c94 Edward Cree             2017-08-07  7413  			char tn_buf[48];
f1174f77b50c94 Edward Cree             2017-08-07  7414  
914cb781ee1a35 Alexei Starovoitov      2017-11-30  7415  			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
01f810ace9ed37 Andrei Matei            2021-02-06  7416  			verbose(env, "R%d%s variable offset stack access prohibited for !root, var_off=%s\n",
01f810ace9ed37 Andrei Matei            2021-02-06  7417  				regno, err_extra, tn_buf);
ea25f914dc164c Jann Horn               2017-12-18  7418  			return -EACCES;
f1174f77b50c94 Edward Cree             2017-08-07  7419  		}
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7420  
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7421  		if (dynptr_read_allowed) {
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7422  			verbose(env, "R%d variable offset prohibited for dynptr-key\n", regno);
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7423  			return -EACCES;
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7424  		}
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7425  
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7426  		/* Only initialized buffer on stack is allowed to be accessed
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7427  		 * with variable offset. With uninitialized buffer it's hard to
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7428  		 * guarantee that whole memory is marked as initialized on
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7429  		 * helper return since specific bounds are unknown what may
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7430  		 * cause uninitialized stack leaking.
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7431  		 */
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7432  		if (meta && meta->raw_mode)
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7433  			meta = NULL;
f2bcd05ec7b839 Andrey Ignatov          2019-04-03  7434  
01f810ace9ed37 Andrei Matei            2021-02-06  7435  		min_off = reg->smin_value + off;
01f810ace9ed37 Andrei Matei            2021-02-06  7436  		max_off = reg->smax_value + off;
107c26a70ca81b Andrey Ignatov          2019-04-03  7437  	}
17a5267067f3c3 Alexei Starovoitov      2014-09-26  7438  
435faee1aae9c1 Daniel Borkmann         2016-04-13 @7439  	if (meta && meta->raw_mode) {

Check for NULL

ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7440  		/* Ensure we won't be overwriting dynptrs when simulating byte
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7441  		 * by byte access in check_helper_call using meta.access_size.
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7442  		 * This would be a problem if we have a helper in the future
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7443  		 * which takes:
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7444  		 *
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7445  		 *	helper(uninit_mem, len, dynptr)
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7446  		 *
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7447  		 * Now, uninint_mem may overlap with dynptr pointer. Hence, it
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7448  		 * may end up writing to dynptr itself when touching memory from
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7449  		 * arg 1. This can be relaxed on a case by case basis for known
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7450  		 * safe cases, but reject due to the possibilitiy of aliasing by
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7451  		 * default.
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7452  		 */
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7453  		for (i = min_off; i < max_off + access_size; i++) {
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7454  			int stack_off = -i - 1;
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7455  
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7456  			spi = __get_spi(i);
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7457  			/* raw_mode may write past allocated_stack */
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7458  			if (state->allocated_stack <= stack_off)
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7459  				continue;
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7460  			if (state->stack[spi].slot_type[stack_off % BPF_REG_SIZE] == STACK_DYNPTR) {
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7461  				verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7462  				return -EACCES;
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7463  			}
ef8fc7a07c0e16 Kumar Kartikeya Dwivedi 2023-01-21  7464  		}
435faee1aae9c1 Daniel Borkmann         2016-04-13  7465  		meta->access_size = access_size;
435faee1aae9c1 Daniel Borkmann         2016-04-13  7466  		meta->regno = regno;
435faee1aae9c1 Daniel Borkmann         2016-04-13  7467  		return 0;
435faee1aae9c1 Daniel Borkmann         2016-04-13  7468  	}
435faee1aae9c1 Daniel Borkmann         2016-04-13  7469  
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7470  	if (dynptr_read_allowed) {
cf5a0c90a8bc5f Hou Tao                 2024-10-08 @7471  		err = init_dynptr_key_state(env, meta->map_ptr->key_record, &dynptr_key);
                                                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference

cf5a0c90a8bc5f Hou Tao                 2024-10-08  7472  		if (err)
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7473  			return err;
cf5a0c90a8bc5f Hou Tao                 2024-10-08  7474  	}
2011fccfb61bbd Andrey Ignatov          2019-03-28  7475  	for (i = min_off; i < max_off + access_size; i++) {
cc2b14d51053eb Alexei Starovoitov      2017-12-14  7476  		u8 *stype;
cc2b14d51053eb Alexei Starovoitov      2017-12-14  7477  
2011fccfb61bbd Andrey Ignatov          2019-03-28  7478  		slot = -i - 1;
638f5b90d46016 Alexei Starovoitov      2017-10-31  7479  		spi = slot / BPF_REG_SIZE;
6b4a64bafd107e Andrei Matei            2023-12-07  7480  		if (state->allocated_stack <= slot) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


