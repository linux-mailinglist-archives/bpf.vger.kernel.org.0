Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A76DFD0F
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 19:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDLRxn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDLRxg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 13:53:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1D40F4
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:53:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63255e756bfso874339b3a.2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681322015; x=1683914015;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DCoX899z8CUiLCRvn/AeqNPe6lm7wbr80nSwfg/+Nck=;
        b=fMdyEvMbCb4Fr/r3FdOijxh+HzVY0jd0xVNsLDAwx36A1agVjyXL5Hi0DF20Z+GsVp
         pGrmJfTfS4BNsoOzkLw4nrKofF915+ZmXuQ6FWjKkbrwld2zXdmKk2Qzu5uOMmcttt7y
         JYp4iSjZYrCoWKtnMNviS0IJeFm4/7ErPz4+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322015; x=1683914015;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCoX899z8CUiLCRvn/AeqNPe6lm7wbr80nSwfg/+Nck=;
        b=RCMYngRumsZFdYPSJuq5uZpr632HJAg0Hs81Da8f/0ldco4Ui72MCK0WFtOL7J1WYo
         XfkiBcx3d1XlNeftylnxPYQ1XcH47ZdNdg/o7Wm03z0Yn93qQ14dKO/ilSeQeY0w4E5i
         bkRzbkmoVsHyE/YaCVtzZWYdO9sByUtn00WireZkpVF29YDB3yeioq33aH99CKJzB5iB
         z9B5a6xrkY2V5PcXHinfR2yySEoF9Y0bgPOCuNGBBAvA+OPwpeRYQOH4zeo6y5G5J1sh
         RznhvVH7BZizVVoyxUtLDooAof5iNU8nPK8MLjLAsvVEBjBeTD9PMwwmbPEgGOB+peZF
         AjOA==
X-Gm-Message-State: AAQBX9cxLfIJ22w203BLLYddL66ql6ShUz0O0l2UoZE7n+7PFiu3c0gj
        nXjg6O9xQD2G4koUSNXRnSXPIu2X/6R5w65i/k8=
X-Google-Smtp-Source: AKy350bv9IJCrLcsEQS+3ujGEGfHCjqAuNNgx+bx62104+d4h8ExjVFOGWptLytn4th0aA/dnM8tVg==
X-Received: by 2002:aa7:9521:0:b0:63a:f682:a8bf with SMTP id c1-20020aa79521000000b0063af682a8bfmr3813041pfp.17.1681322015063;
        Wed, 12 Apr 2023 10:53:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k8-20020aa792c8000000b0062dbafced27sm12070286pfa.27.2023.04.12.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:53:34 -0700 (PDT)
Message-ID: <6436f01e.a70a0220.e12e2.828e@mx.google.com>
X-Google-Original-Message-ID: <202304121051.@keescook>
Date:   Wed, 12 Apr 2023 10:53:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: inline map creation logic in
 map_create() function
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-3-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-3-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 09:32:54PM -0700, Andrii Nakryiko wrote:
> Keep all the relevant generic sanity checks, permission checks, and
> creation and initialization logic in one linear piece of code. Currently
> helper function that handles memory allocation and partial
> initialization is split apart and is about 1000 lines higher in the
> file, hurting readability.

At first glance, this seems like a step in the wrong direction: having a
single-purpose function pulled out of a larger one seems like a good
thing for stuff like unit testing, etc. Unless there's a reason later in
the series for this inlining (which should be called out in the
changelog here), I would say if it is only readability, just move the
function down 1000 lines but leave it a separate function.

-Kees

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/syscall.c | 54 ++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c1d268025985..a090737f98ea 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -108,37 +108,6 @@ const struct bpf_map_ops bpf_map_offload_ops = {
>  	.map_mem_usage = bpf_map_offload_map_mem_usage,
>  };
>  
> -static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
> -{
> -	const struct bpf_map_ops *ops;
> -	u32 type = attr->map_type;
> -	struct bpf_map *map;
> -	int err;
> -
> -	if (type >= ARRAY_SIZE(bpf_map_types))
> -		return ERR_PTR(-EINVAL);
> -	type = array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
> -	ops = bpf_map_types[type];
> -	if (!ops)
> -		return ERR_PTR(-EINVAL);
> -
> -	if (ops->map_alloc_check) {
> -		err = ops->map_alloc_check(attr);
> -		if (err)
> -			return ERR_PTR(err);
> -	}
> -	if (attr->map_ifindex)
> -		ops = &bpf_map_offload_ops;
> -	if (!ops->map_mem_usage)
> -		return ERR_PTR(-EINVAL);
> -	map = ops->map_alloc(attr);
> -	if (IS_ERR(map))
> -		return map;
> -	map->ops = ops;
> -	map->map_type = type;
> -	return map;
> -}
> -
>  static void bpf_map_write_active_inc(struct bpf_map *map)
>  {
>  	atomic64_inc(&map->writecnt);
> @@ -1124,7 +1093,9 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  /* called via syscall */
>  static int map_create(union bpf_attr *attr)
>  {
> +	const struct bpf_map_ops *ops;
>  	int numa_node = bpf_map_attr_numa_node(attr);
> +	u32 map_type = attr->map_type;
>  	struct btf_field_offs *foffs;
>  	struct bpf_map *map;
>  	int f_flags;
> @@ -1167,9 +1138,28 @@ static int map_create(union bpf_attr *attr)
>  		return -EINVAL;
>  
>  	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
> -	map = find_and_alloc_map(attr);
> +	map_type = attr->map_type;
> +	if (map_type >= ARRAY_SIZE(bpf_map_types))
> +		return -EINVAL;
> +	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
> +	ops = bpf_map_types[map_type];
> +	if (!ops)
> +		return -EINVAL;
> +
> +	if (ops->map_alloc_check) {
> +		err = ops->map_alloc_check(attr);
> +		if (err)
> +			return err;
> +	}
> +	if (attr->map_ifindex)
> +		ops = &bpf_map_offload_ops;
> +	if (!ops->map_mem_usage)
> +		return -EINVAL;
> +	map = ops->map_alloc(attr);
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
> +	map->ops = ops;
> +	map->map_type = map_type;
>  
>  	err = bpf_obj_name_cpy(map->name, attr->map_name,
>  			       sizeof(attr->map_name));
> -- 
> 2.34.1
> 

-- 
Kees Cook
