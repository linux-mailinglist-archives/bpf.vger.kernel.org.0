Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5746DFD5F
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDLSUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLSUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:20:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E8193
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:20:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id my14-20020a17090b4c8e00b0024708e8e2ddso1552841pjb.4
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681323643; x=1683915643;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IUOH+LA9GXi0KOe5LKkxH+Mmq3U6XooWB0q1LJJoxPU=;
        b=VCXShN8X5oPpAtA8OQa/GeAHjMzXR1t4hGrrwLIpd/jAEJlBNMDDPvBFKvevOxtSbN
         yKAtHOEnVRBAiZqEIxzIm9sYBIE5h7MsHxfjD5tzTIjmC/GcWKQsEVdxDLJpYKKdwjKD
         DhV01ylb4XFb27VQ+8FPqxo9yoSgB0b8pY0iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323643; x=1683915643;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUOH+LA9GXi0KOe5LKkxH+Mmq3U6XooWB0q1LJJoxPU=;
        b=Jibkp/A7538gB1s3UTt5AYrxTQV1MMZnKjuNADfQroI5NnSM4SP0YNJCAX9Hn0t2XB
         8KRRyHA0XB/2DsDR1vw4gxAuKC9Fc1Md7N83FpbnenCUfzDrlSzN3STcsaXZJgSutYMt
         0h+hdl/kdU1KOKkZrCibCHgKslM8AVGicY+CqAZCPFzfPJ2MzaK2yF0nZgkedDZHMLIQ
         +brAMZw59H5NVT57Fv01ubuGt2CzqiM5PPD+7OBOFHeFdvQ5Qtb1xQYEaUO5ntLwMAaL
         BDcKQvGovwY1OTzTDfAXugqKz7wdZYauqIlZjKoKC+wuCXQZnsEqdkqMnpLwk3VEI7U4
         OMig==
X-Gm-Message-State: AAQBX9fZHnXHOnm7qqK5AcaZJk7tbTZc1sXFx/IoR13SVb7QozbGaNsh
        MVJbOIo3S36BIo+3jGek7XdHxw==
X-Google-Smtp-Source: AKy350ZYiC9FqECE9ihGxGejFyOPPBwXqEwrhX7KeUXebk7WQBWziq8nU7o906RWoQFZegwuN5r8HA==
X-Received: by 2002:a05:6a20:4998:b0:da:5ab7:8cf3 with SMTP id fs24-20020a056a20499800b000da5ab78cf3mr3704553pzb.30.1681323643142;
        Wed, 12 Apr 2023 11:20:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0062d859a33d1sm11954525pfn.84.2023.04.12.11.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:20:42 -0700 (PDT)
Message-ID: <6436f67a.a70a0220.58151.7529@mx.google.com>
X-Google-Original-Message-ID: <202304121101.@keescook>
Date:   Wed, 12 Apr 2023 11:20:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: implement bpf_map_create_security
 LSM hook
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-5-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 09:32:56PM -0700, Andrii Nakryiko wrote:
> Add new LSM hook, bpf_map_create_security, that allows custom LSM
> security policies controlling BPF map creation permissions granularly
> and precisely.

Naming nit-pick: the hook name doesn't need the "_security" suffix, if I'm
reading this correctly. The LSM hooks with that are really around the
allocation/initialization of LSM-specific memory (i.e. attach
LSM-specific allocation to an inode, etc).

The hook looks like it's "only" policy, so it can just be called
"bpf_map_create".

> This new LSM hook allows to implement both LSM policy that could enforce
> more granular and restrictive decisions about which processes can create
> which BPF maps, by rejecting BPF map creation based on passed in
> bpf_attr attributes. But also it allows to bypass CAP_BPF and
> CAP_NET_ADMIN restrictions, normally enforced by kernel, for
> applications that LSM policy deems trusted. Trustworthiness
> determination of the process/user/cgroup/etc is left up to custom LSM
> hook implementation and will dependon particular production setup of
> each individual use case.

As Paul mentioned, we need to give a careful examination of the access
control logic here. BPF is not deal with POSIX or DAC rules, so I think
there isn't a problem being flexible here, but it would be nice to find
a way to make this be "default reject" via capabilities that doesn't
differ much from the way things happen normally in the LSM (so that it
can be successfully reasoned about without need to consider BPF-specific
"special cases").

> If LSM policy wants to rely on default kernel logic, it can return
> 0 to delegate back to kernel. If it returns >0 return code,
> kernel will bypass its normal checks. This way it's possible to perform
> a delegation of trust (specifically for BPF map creation) from
> privileged LSM custom policy implementation to unprivileged user
> process, verifier and trusted by custom LSM policy.

At the least, I think the language of "bypass" is going to cause a not
of friction. :) We make to make sure this fails safe -- if there is no
loaded policy, capable() needs to remain the back-stop.

> Such model allows flexible and secure-by-default approach where user
> processes that need to use BPF features (BPF map creation, in this case)
> are left unprivileged with no CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON, etc.
> capabilities, but specific exceptions are implemented (usually in
> a centralized server fleet-wide fashion) for trusted
> processes/containers/users, allowing them to manipulate BPF facilities,
> as long as they are allowed and known apriori.

if (!unprivileged_allowed(...) && !capable(...))
	return -EPERM;

and uprivileged_allowed() is looking at the sysctl and LSM policy.

> 
> This patch implements first required part for full-fledged BPF usage:
> map creation. The other one, BPF program load, will be addressed in
> follow up patches.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     | 12 ++++++++++++
>  include/linux/security.h      |  6 ++++++
>  kernel/bpf/bpf_lsm.c          |  1 +
>  kernel/bpf/syscall.c          | 19 ++++++++++++++++---
>  security/security.c           |  4 ++++
>  6 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 094b76dc7164..b4fe9ed7021a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -396,6 +396,7 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
>  LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
>  LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
>  LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
> +LSM_HOOK(int, 0, bpf_map_create_security, const union bpf_attr *attr)
>  LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
>  LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
>  LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 6e156d2acffc..42bf7c0aa4d8 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1598,6 +1598,18 @@
>   *	@prog: bpf prog that userspace want to use.
>   *	Return 0 if permission is granted.
>   *
> + * @bpf_map_create_security:
> + *	Do a check to determine permission to create requested BPF map.
> + *	Implementation can override kernel capabilities checks according to
> + *	the rules below:
> + *	  - 0 should be returned to delegate permission checks to other
> + *	    installed LSM callbacks and/or hard-wired kernel logic, which
> + *	    would enforce CAP_BPF/CAP_NET_ADMIN capabilities;
> + *	  - reject BPF map creation by returning -EPERM or any other
> + *	    negative error code;
> + *	  - allow BPF map creation, overriding kernel checks, by returning
> + *	    a positive result.
> + *
>   * @bpf_map_alloc_security:
>   *	Initialize the security field inside bpf map.
>   *	Return 0 on success, error on failure.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5984d0d550b4..e5374fe92ef6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2023,6 +2023,7 @@ struct bpf_prog_aux;
>  extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
>  extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
>  extern int security_bpf_prog(struct bpf_prog *prog);
> +extern int security_bpf_map_create(const union bpf_attr *attr);
>  extern int security_bpf_map_alloc(struct bpf_map *map);
>  extern void security_bpf_map_free(struct bpf_map *map);
>  extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
> @@ -2044,6 +2045,11 @@ static inline int security_bpf_prog(struct bpf_prog *prog)
>  	return 0;
>  }
>  
> +static inline int security_bpf_map_create(const union bpf_attr *attr)
> +{
> +	return 0;
> +}

I would expect this to be something like:

	return sysctl_unprivileged_bpf_disabled ? -EPERM : 0;

> +
>  static inline int security_bpf_map_alloc(struct bpf_map *map)
>  {
>  	return 0;
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index e14c822f8911..931d4dda5dac 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -260,6 +260,7 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  BTF_SET_START(sleepable_lsm_hooks)
>  BTF_ID(func, bpf_lsm_bpf)
>  BTF_ID(func, bpf_lsm_bpf_map)
> +BTF_ID(func, bpf_lsm_bpf_map_create_security)
>  BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
>  BTF_ID(func, bpf_lsm_bpf_map_free_security)
>  BTF_ID(func, bpf_lsm_bpf_prog)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cbea4999e92f..7d1165814efc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -980,7 +980,7 @@ int map_check_no_btf(const struct bpf_map *map,
>  }
>  
>  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> -			 u32 btf_key_id, u32 btf_value_id)
> +			 u32 btf_key_id, u32 btf_value_id, bool priv_checked)
>  {
>  	const struct btf_type *key_type, *value_type;
>  	u32 key_size, value_size;
> @@ -1008,7 +1008,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  	if (!IS_ERR_OR_NULL(map->record)) {
>  		int i;
>  
> -		if (!bpf_capable()) {
> +		if (!priv_checked && !bpf_capable()) {
>  			ret = -EPERM;
>  			goto free_map_tab;
>  		}
> @@ -1097,10 +1097,12 @@ static int map_create(union bpf_attr *attr)
>  	int numa_node = bpf_map_attr_numa_node(attr);
>  	u32 map_type = attr->map_type;
>  	struct btf_field_offs *foffs;
> +	bool priv_checked = false;
>  	struct bpf_map *map;
>  	int f_flags;
>  	int err;
>  
> +	/* sanity checks */
>  	err = CHECK_ATTR(BPF_MAP_CREATE);
>  	if (err)
>  		return -EINVAL;
> @@ -1145,6 +1147,15 @@ static int map_create(union bpf_attr *attr)
>  	if (!ops->map_mem_usage)
>  		return -EINVAL;
>  
> +	/* security checks */
> +	err = security_bpf_map_create(attr);
> +	if (err < 0)
> +		return err;
> +	if (err > 0) {
> +		priv_checked = true;
> +		goto skip_priv_checks;
> +	}

I think we can refactor this to avoid the concept of "skipping" checks.

Also, I think passing "priv_checked" is kind of confusing -- I feel like
access control should either be centralized or in each individual
function. Why is there a need to split this up?

> +
>  	/* Intent here is for unprivileged_bpf_disabled to block key object
>  	 * creation commands for unprivileged users; other actions depend
>  	 * of fd availability and access to bpffs, so are dependent on
> @@ -1203,6 +1214,8 @@ static int map_create(union bpf_attr *attr)
>  		return -EPERM;
>  	}
>  
> +skip_priv_checks:
> +	/* create and init map */
>  	map = ops->map_alloc(attr);
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
> @@ -1243,7 +1256,7 @@ static int map_create(union bpf_attr *attr)
>  
>  		if (attr->btf_value_type_id) {
>  			err = map_check_btf(map, btf, attr->btf_key_type_id,
> -					    attr->btf_value_type_id);
> +					    attr->btf_value_type_id, priv_checked);
>  			if (err)
>  				goto free_map;
>  		}
> diff --git a/security/security.c b/security/security.c
> index cf6cc576736f..f9b885680966 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2682,6 +2682,10 @@ int security_bpf_prog(struct bpf_prog *prog)
>  {
>  	return call_int_hook(bpf_prog, 0, prog);
>  }
> +int security_bpf_map_create(const union bpf_attr *attr)
> +{
> +	return call_int_hook(bpf_map_create_security, 0, attr);

And the default return value here wouldn't be 0, but:

	sysctl_unprivileged_bpf_disabled ?  -EPERM : 0

> +}
>  int security_bpf_map_alloc(struct bpf_map *map)
>  {
>  	return call_int_hook(bpf_map_alloc_security, 0, map);
> -- 
> 2.34.1
> 

-- 
Kees Cook
