Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228F55400A
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiFVB1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiFVB1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 21:27:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B432ED9
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 18:27:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e63so13211743pgc.5
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gk53SgIM1kb26FHt5W1qOlN+kVFOLRhu0KMSVUCNKdw=;
        b=DDpEiPSm1+Ahj1k5HwMbYyoYhrzwR+qP95TsjNhnR9A6tmVN2VauB2V/uDhKYH8+gp
         UVr4TYYaWOhZT0eoeYhU5sY0uwOPY/f+2IXa2OwRkK6kYVWJA9Q3uJ+6cix7w/YyBR+y
         DOLlhEK39dfDKxr/1pNvMo24ZdNDwbR9g12AxU1SNYUSmFvR2G+fnYKdpPD4PW43ES+q
         jq4HamtpTzEu5STQz8GRVhv2VD2RWQXPtlIcDiVCm9Kaxmg6sYimvfRp60WhHjCMQpgr
         CpxmgTK9/9x102AsmlIWu8Qg+iD60ZT+3Ptu5XE+a7/N/zSFHl1rpOxvdst3TULtxSOF
         8z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gk53SgIM1kb26FHt5W1qOlN+kVFOLRhu0KMSVUCNKdw=;
        b=AyTS1ZW/SYoXOaQTasmcBONW3SyqbCoW9taLiiWKoXKoDahjv4wkcUdopgNMVw/sp1
         9QFo4XgKTL74bczewm2ecdj98sXXyBWV2JNtZUxi9Og7JWM1M6NcUvIhzCq+DLDn6ny1
         Mo0tE3mwLKisJDmeZiNkbDup9J1xdVwkK8hew3xxJXhTsi7AeyLA8byhtV6bwkaJ4MbI
         dhtG7m2du75jo2ly5Dpb4CJRGKpSR5r2lrVQQL3xkFSJWyxKYAigmAFcFaE/kaRg02P/
         JIOq5qaJjPxDYCTqUVLTj97iXJTAw4C0P29iFAYjbVLbX1hukRPuvvDGFhg6TuORk3AO
         j+8g==
X-Gm-Message-State: AJIora82/UR6BSHo57kSaKnqC3qj6kO+VgYJyGzdxvKhnp2l+0XHJEtj
        qWMsk9Ql0Mk+ezXIVF4l1oc=
X-Google-Smtp-Source: AGRyM1smoceLbHGul6l+ypLQdXFDhpIyF84IUATrp/4nGzgM7Akdep4P+OlAtTvaBotnJvWD7OolYg==
X-Received: by 2002:a05:6a00:339b:b0:525:22ee:d8ab with SMTP id cm27-20020a056a00339b00b0052522eed8abmr13409603pfb.83.1655861222710;
        Tue, 21 Jun 2022 18:27:02 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0c0:79de:f3f4:353c:8616])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090ae98c00b001ec8d191db4sm6982035pjy.17.2022.06.21.18.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:27:02 -0700 (PDT)
Date:   Wed, 22 Jun 2022 06:56:54 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: kfunc support for
 ARG_PTR_TO_CONST_STR
Message-ID: <20220622012654.xl5bax75muwdd764@apollo.legion>
References: <20220621204642.2891979-1-kpsingh@kernel.org>
 <20220621204642.2891979-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621204642.2891979-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 02:16:39AM IST, KP Singh wrote:
> kfuncs can handle pointers to memory when the next argument is
> the size of the memory that can be read and verify these as
> ARG_CONST_SIZE_OR_ZERO
>
> Similarly add support for string constants (const char *) and
> verify it similar to ARG_PTR_TO_CONST_STR.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/btf.c             | 26 +++++++++++
>  kernel/bpf/verifier.c        | 89 +++++++++++++++++++++---------------
>  3 files changed, 79 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 3930c963fa67..60d490354397 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -548,6 +548,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		   u32 regno, u32 mem_size);
> +int check_const_str(struct bpf_verifier_env *env,
> +		    const struct bpf_reg_state *reg, int regno);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 668ecf61649b..6608e8a0c5ca 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6162,6 +6162,23 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
>  	return true;
>  }
>
> +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> +				       const struct btf_param *param)
> +{
> +	const struct btf_type *t;
> +
> +	t = btf_type_by_id(btf, param->type);
> +	if (!btf_type_is_ptr(t))
> +		return false;
> +
> +	t = btf_type_by_id(btf, t->type);
> +	if (!(BTF_INFO_KIND(t->info) == BTF_KIND_CONST))
> +		return false;
> +

Forgot to change this to !=.

> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> +	return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
> +}
> +
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				    const struct btf *btf, u32 func_id,
>  				    struct bpf_reg_state *regs,
> @@ -6344,6 +6361,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		} else if (ptr_to_mem_ok) {
>  			const struct btf_type *resolve_ret;
>  			u32 type_size;
> +			int err;
>
>  			if (is_kfunc) {
>  				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> @@ -6354,6 +6372,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				 * When arg_mem_size is true, the pointer can be
>  				 * void *.
>  				 */
> +				if (btf_param_is_const_str_ptr(btf, &args[i])) {
> +					err = check_const_str(env, reg, regno);
> +					if (err < 0)
> +						return err;
> +					i++;

Sorry for not seeing it before, I think this i++ is incorrect. It is skipping
over the next argument. Which means mem, len pair is not being seen, otherwise
it should have given an error with the void * argument, because the next
argument does not have __sz prefix, so there is no mem, len pair in the kfunc
args.

The i++ is done for arg_mem_size case because we processed both argno and argno + 1
together, so the next size arg doesn't need to be processed.

So the bpf_getxattr declaration needs to change from:

noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
				     const char *name, void *value, int size)

to

noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
				     const char *name, void *value, int value__sz)

You only need the __sz suffix, the part before that is your choice.
Then it will actually check the size for the value pointer.
Also, I think neither noinline nor __weak are needed.

> +					continue;
> +				}
> +
>  				if (!btf_type_is_scalar(ref_t) &&
>  				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
>  				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2859901ffbe3..7ac501122df0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5840,6 +5840,56 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
>  	return state->stack[spi].spilled_ptr.id;
>  }
>
> +int check_const_str(struct bpf_verifier_env *env,
> +		    const struct bpf_reg_state *reg, int regno)
> +{
> +	struct bpf_map *map;
> +	int map_off;
> +	u64 map_addr;
> +	char *str_ptr;
> +	int err;
> +
> +	if (reg->type != PTR_TO_MAP_VALUE)
> +		return -EACCES;
> +
> +	map = reg->map_ptr;
> +	if (!bpf_map_is_rdonly(map)) {
> +		verbose(env, "R%d does not point to a readonly map'\n", regno);
> +		return -EACCES;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env, "R%d is not a constant address'\n", regno);
> +		return -EACCES;
> +	}
> +
> +	if (!map->ops->map_direct_value_addr) {
> +		verbose(env,
> +			"no direct value access support for this map type\n");
> +		return -EACCES;
> +	}
> +
> +	err = check_map_access(env, regno, reg->off, map->value_size - reg->off,
> +			       false, ACCESS_HELPER);
> +	if (err)
> +		return err;
> +
> +	map_off = reg->off + reg->var_off.value;
> +	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +	if (err) {
> +		verbose(env, "direct value access on string failed\n");
> +		return err;
> +	}
> +
> +	str_ptr = (char *)(long)(map_addr);
> +	if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> +		verbose(env, "string is not zero-terminated\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn)
> @@ -6074,44 +6124,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			return err;
>  		err = check_ptr_alignment(env, reg, 0, size, true);
>  	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
> -		struct bpf_map *map = reg->map_ptr;
> -		int map_off;
> -		u64 map_addr;
> -		char *str_ptr;
> -
> -		if (!bpf_map_is_rdonly(map)) {
> -			verbose(env, "R%d does not point to a readonly map'\n", regno);
> -			return -EACCES;
> -		}
> -
> -		if (!tnum_is_const(reg->var_off)) {
> -			verbose(env, "R%d is not a constant address'\n", regno);
> -			return -EACCES;
> -		}
> -
> -		if (!map->ops->map_direct_value_addr) {
> -			verbose(env, "no direct value access support for this map type\n");
> -			return -EACCES;
> -		}
> -
> -		err = check_map_access(env, regno, reg->off,
> -				       map->value_size - reg->off, false,
> -				       ACCESS_HELPER);
> -		if (err)
> -			return err;
> -
> -		map_off = reg->off + reg->var_off.value;
> -		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> -		if (err) {
> -			verbose(env, "direct value access on string failed\n");
> -			return err;
> -		}
> -
> -		str_ptr = (char *)(long)(map_addr);
> -		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> -			verbose(env, "string is not zero-terminated\n");
> -			return -EINVAL;
> -		}
> +		err = check_const_str(env, reg, regno);
>  	} else if (arg_type == ARG_PTR_TO_KPTR) {
>  		if (process_kptr_func(env, regno, meta))
>  			return -EACCES;
> --
> 2.37.0.rc0.104.g0611611a94-goog
>

--
Kartikeya
