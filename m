Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13316DFD2C
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDLSB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDLSBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:01:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272B6E95
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:01:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o2-20020a17090a0a0200b00246da660bd2so4653433pjo.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681322478; x=1683914478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0jtJZ0Cr/j5wJPShgJjoWc8vomxLbua/Kr28TIzH0vY=;
        b=MbeYxqFy75/BFGkk+wYaSuWMJ3hJSok+ISwKN0Z1ww+RGm2O/xcK0W/DfLA1x+rnYx
         CNO94TRSyAFP9e/nTgGvTeKjyms5KcctT+CTD7jv98XRod1YAyRzHonlvY4+gVSeVYfg
         S62u1nHgzFF9tuF9HKLtbbWzGmibbB9Lvf9DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322478; x=1683914478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jtJZ0Cr/j5wJPShgJjoWc8vomxLbua/Kr28TIzH0vY=;
        b=aCWaocqDCD3MRsPDCBEeJT7BR+OJMpCKM9kswfy8IYce9vBtwMS/9imjTF90ou+0gx
         WZRyuWKCi22VJI8AFmKxKzZzIpnxnumFIwPpwubsL3LOJNgiyq4dMj5zELQILY+QCUIO
         JAl+kDMEbISE9HEV7aPaXGTHasQu7z7ELKctdRYogRSAM50NZy1vjPxKVBGjGq/i/H5n
         XvhQ/TqaW79tFgINVUQJ5W+4KB3aT4iX1cRSYFap0EsNavAx7aISnhqNVnP2PEi1EQmB
         lbTgdPzEpLtiSerDmOEviH77K0fEWScnd76hr3DkuYK4uQVxytNWZ9Y2Af+xmKXP1W26
         rOlQ==
X-Gm-Message-State: AAQBX9dORVRgcofBJm3qpH52hez6Vpcefcg5QkpQymk5KBfe+Ft+m6c+
        knfpmlOtZF1o4yHYKEcVegRdBZov8AmW4ibdIa0=
X-Google-Smtp-Source: AKy350bsX5Eh0bfcX6a9ejRaIJb8WEHDOer/Jwh6RXonUnh6M/muoeaiHvJ61VZy8c6T3fRYSR4u7w==
X-Received: by 2002:a17:902:d482:b0:1a6:4c2b:9e7f with SMTP id c2-20020a170902d48200b001a64c2b9e7fmr5212982plg.1.1681322477639;
        Wed, 12 Apr 2023 11:01:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902b70d00b001a1d553de0fsm11905029pls.271.2023.04.12.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:01:17 -0700 (PDT)
Message-ID: <6436f1ed.170a0220.6cc4d.79f3@mx.google.com>
X-Google-Original-Message-ID: <202304121054.@keescook>
Date:   Wed, 12 Apr 2023 11:01:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/8] bpf: centralize permissions checks for all
 BPF map types
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 09:32:55PM -0700, Andrii Nakryiko wrote:
> This allows to do more centralized decisions later on, and generally
> makes it very explicit which maps are privileged and which are not.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 00c253b84bf5..c69db80fc947 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -422,12 +422,6 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>  	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
>  		     offsetof(struct htab_elem, hash_node.pprev));
>  
> -	if (lru && !bpf_capable())
> -		/* LRU implementation is much complicated than other
> -		 * maps.  Hence, limit to CAP_BPF.
> -		 */
> -		return -EPERM;
> -

The LRU part of this check gets lost, doesn't it? More specifically,
doesn't this make the security check for htab_map_alloc_check() more
strict than before? (If that's okay, please mention the logical change
in the commit log.)

> [...]
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a090737f98ea..cbea4999e92f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1101,17 +1101,6 @@ static int map_create(union bpf_attr *attr)
>  	int f_flags;
>  	int err;
>  
> -	/* Intent here is for unprivileged_bpf_disabled to block key object
> -	 * creation commands for unprivileged users; other actions depend
> -	 * of fd availability and access to bpffs, so are dependent on
> -	 * object creation success.  Capabilities are later verified for
> -	 * operations such as load and map create, so even with unprivileged
> -	 * BPF disabled, capability checks are still carried out for these
> -	 * and other operations.
> -	 */
> -	if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> -		return -EPERM;
> -

Given that this was already performing a centralized capability check,
why were the individual functions doing checks before too?

(I'm wondering if the individual functions remain the better place to do
this checking?)

>  	err = CHECK_ATTR(BPF_MAP_CREATE);
>  	if (err)
>  		return -EINVAL;
> @@ -1155,6 +1144,65 @@ static int map_create(union bpf_attr *attr)
>  		ops = &bpf_map_offload_ops;
>  	if (!ops->map_mem_usage)
>  		return -EINVAL;
> +
> +	/* Intent here is for unprivileged_bpf_disabled to block key object
> +	 * creation commands for unprivileged users; other actions depend
> +	 * of fd availability and access to bpffs, so are dependent on
> +	 * object creation success.  Capabilities are later verified for
> +	 * operations such as load and map create, so even with unprivileged
> +	 * BPF disabled, capability checks are still carried out for these
> +	 * and other operations.
> +	 */
> +	if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> +		return -EPERM;
> +
> +	/* check privileged map type permissions */
> +	switch (map_type) {
> +	case BPF_MAP_TYPE_SK_STORAGE:
> +	case BPF_MAP_TYPE_INODE_STORAGE:
> +	case BPF_MAP_TYPE_TASK_STORAGE:
> +	case BPF_MAP_TYPE_CGRP_STORAGE:
> +	case BPF_MAP_TYPE_BLOOM_FILTER:
> +	case BPF_MAP_TYPE_LPM_TRIE:
> +	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
> +	case BPF_MAP_TYPE_STACK_TRACE:
> +	case BPF_MAP_TYPE_QUEUE:
> +	case BPF_MAP_TYPE_STACK:
> +	case BPF_MAP_TYPE_LRU_HASH:
> +	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +	case BPF_MAP_TYPE_STRUCT_OPS:
> +	case BPF_MAP_TYPE_CPUMAP:
> +		if (!bpf_capable())
> +			return -EPERM;
> +		break;
> +	case BPF_MAP_TYPE_SOCKMAP:
> +	case BPF_MAP_TYPE_SOCKHASH:
> +	case BPF_MAP_TYPE_DEVMAP:
> +	case BPF_MAP_TYPE_DEVMAP_HASH:
> +	case BPF_MAP_TYPE_XSKMAP:
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +		break;
> +	case BPF_MAP_TYPE_ARRAY:
> +	case BPF_MAP_TYPE_PERCPU_ARRAY:
> +	case BPF_MAP_TYPE_PROG_ARRAY:
> +	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
> +	case BPF_MAP_TYPE_CGROUP_ARRAY:
> +	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> +	case BPF_MAP_TYPE_HASH:
> +	case BPF_MAP_TYPE_PERCPU_HASH:
> +	case BPF_MAP_TYPE_HASH_OF_MAPS:
> +	case BPF_MAP_TYPE_RINGBUF:
> +	case BPF_MAP_TYPE_USER_RINGBUF:
> +	case BPF_MAP_TYPE_CGROUP_STORAGE:
> +	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> +		/* unprivileged */
> +		break;
> +	default:
> +		WARN(1, "unsupported map type %d", map_type);
> +		return -EPERM;

Thank you for making sure this fails safe! :)

> +	}
> +
>  	map = ops->map_alloc(attr);
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 7c189c2e2fbf..4b67bb5e7f9c 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -32,8 +32,6 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
>  {
>  	struct bpf_stab *stab;
>  
> -	if (!capable(CAP_NET_ADMIN))
> -		return ERR_PTR(-EPERM);
>  	if (attr->max_entries == 0 ||
>  	    attr->key_size    != 4 ||
>  	    (attr->value_size != sizeof(u32) &&
> @@ -1085,8 +1083,6 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
>  	struct bpf_shtab *htab;
>  	int i, err;
>  
> -	if (!capable(CAP_NET_ADMIN))
> -		return ERR_PTR(-EPERM);
>  	if (attr->max_entries == 0 ||
>  	    attr->key_size    == 0 ||
>  	    (attr->value_size != sizeof(u32) &&
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index 2c1427074a3b..e1c526f97ce3 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -5,7 +5,6 @@
>  
>  #include <linux/bpf.h>
>  #include <linux/filter.h>
> -#include <linux/capability.h>
>  #include <net/xdp_sock.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> @@ -68,9 +67,6 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
>  	int numa_node;
>  	u64 size;
>  
> -	if (!capable(CAP_NET_ADMIN))
> -		return ERR_PTR(-EPERM);
> -
>  	if (attr->max_entries == 0 || attr->key_size != 4 ||
>  	    attr->value_size != 4 ||
>  	    attr->map_flags & ~(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY))
> diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> index 8383a99f610f..0adf8d9475cb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> +++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> @@ -171,7 +171,11 @@ static void test_unpriv_bpf_disabled_negative(struct test_unpriv_bpf_disabled *s
>  				prog_insns, prog_insn_cnt, &load_opts),
>  		  -EPERM, "prog_load_fails");
>  
> -	for (i = BPF_MAP_TYPE_HASH; i <= BPF_MAP_TYPE_BLOOM_FILTER; i++)
> +	/* some map types require particular correct parameters which could be
> +	 * sanity-checked before enforcing -EPERM, so only validate that
> +	 * the simple ARRAY and HASH maps are failing with -EPERM
> +	 */
> +	for (i = BPF_MAP_TYPE_HASH; i <= BPF_MAP_TYPE_ARRAY; i++)
>  		ASSERT_EQ(bpf_map_create(i, NULL, sizeof(int), sizeof(int), 1, NULL),
>  			  -EPERM, "map_create_fails");
>  
> -- 
> 2.34.1
> 

-- 
Kees Cook
