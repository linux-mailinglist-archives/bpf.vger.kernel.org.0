Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42F364DDF
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhDSWyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDSWyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 18:54:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ABFC06174A;
        Mon, 19 Apr 2021 15:54:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so24219147pfn.6;
        Mon, 19 Apr 2021 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bL/C65cK5ETIOGRn+rp+8oiQf3Y9Nb4NWBAXa/S4YGg=;
        b=eUZmUJ9ybn8O+fcNkva++TF1ZumC95PpqJehEI16MwR08pmMiNhozdizhFfVoyaMbP
         Qwkt9kQCjpGQMnVWGRFzb31dvUx0xfuWI9sH3AtdIJ/yVMSuw/dgjvC84XUUsyDR9ocH
         u2iAT0uHkJxu323ZSCqw7lw+c6sw2qGxJuvcjf7kjgaczDZyuGoWdS/WUCQRtm9UL7jV
         ICfjE6gFh2k6NlidIOHy6IlwF49PnX9sUFZHt5ruAkGv6flkNzg9aLzks5v+rPBBcmAv
         5NgdbDjsyOK612vaNe2KWaP1/mS1uoZwjOgGQwhnTLp4gzZenUxwk+wLdm2JWnAmfEVX
         QEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bL/C65cK5ETIOGRn+rp+8oiQf3Y9Nb4NWBAXa/S4YGg=;
        b=knm3qHSUxFV8hZlBB/JaI9PZfAbXK/P6ibo6lrA6BmCL2Nianv42sWhIIxk8+jcwQI
         KOeZ756mxU9JlrWdjoQmUa0sKVlS6kjHtqdEh+NgX2yXRveInLdJZnFaQVT3OGOFKL3w
         AfROUTsCeKKh1xkbw/cVxANB9R5kBXe5Z+oKw8RhWr7Glcw1z9FDSh6VEtXxvfJmO70z
         wv2Cx+T011FF8jel6ZUJXmBnykNtwLF6/GWnX62uBL8YC1DT0XnV1UdfAtgHBiIrLmJt
         CXFuUovh8F8KbZ0w/fuCePsnCVayXdaRZ5qOlqkb6u+y3Y+Wq2TmL6oB0J4/v9G0uIiB
         XA9Q==
X-Gm-Message-State: AOAM531g7fiIbSVzr4qImUq1TgIWHNnUvrQiEulceMrmKb8RjuR/YkBG
        klj0k0QW8t4jGLt3edF8SZs=
X-Google-Smtp-Source: ABdhPJzFDsohB34RC6ivcKAPCb4xryxpRA9tFygXCORzvcBaEpKiYKMz7Ae+N9PsLwL0nePxCkLsZg==
X-Received: by 2002:a63:2265:: with SMTP id t37mr13604890pgm.452.1618872847426;
        Mon, 19 Apr 2021 15:54:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:948])
        by smtp.gmail.com with ESMTPSA id z12sm4503040pfn.195.2021.04.19.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:54:06 -0700 (PDT)
Date:   Mon, 19 Apr 2021 15:54:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument
 type
Message-ID: <20210419225404.chlkiaku5vaxmmyh@ast-mbp.dhcp.thefacebook.com>
References: <20210419155243.1632274-1-revest@chromium.org>
 <20210419155243.1632274-3-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419155243.1632274-3-revest@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 19, 2021 at 05:52:39PM +0200, Florent Revest wrote:
> This type provides the guarantee that an argument is going to be a const
> pointer to somewhere in a read-only map value. It also checks that this
> pointer is followed by a zero character before the end of the map value.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 77d1d8c65b81..c160526fc8bf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -309,6 +309,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
>  	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
>  	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
> +	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
>  	__BPF_ARG_TYPE_MAX,
>  };
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 852541a435ef..5f46dd6f3383 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4787,6 +4787,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
>  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
>  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> +static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
>  
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> @@ -4817,6 +4818,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
>  	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
>  	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
> +	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
>  };
>  
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -5067,6 +5069,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		if (err)
>  			return err;
>  		err = check_ptr_alignment(env, reg, 0, size, true);
> +	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
> +		struct bpf_map *map = reg->map_ptr;
> +		int map_off;
> +		u64 map_addr;
> +		char *str_ptr;
> +
> +		if (reg->type != PTR_TO_MAP_VALUE || !map ||

I think the 'type' check is redundant,
since check_reg_type() did it via compatible_reg_types.
If so it's probably better to remove it here ?

'!map' looks unnecessary. Can it ever happen? If yes, it's a verifier bug.
For example in check_mem_access() we just deref reg->map_ptr without checking
which, I think, is correct.

> +		    !bpf_map_is_rdonly(map)) {

This check is needed, of course.

> +			verbose(env, "R%d does not point to a readonly map'\n", regno);
> +			return -EACCES;
> +		}
> +
> +		if (!tnum_is_const(reg->var_off)) {
> +			verbose(env, "R%d is not a constant address'\n", regno);
> +			return -EACCES;
> +		}
> +
> +		if (!map->ops->map_direct_value_addr) {
> +			verbose(env, "no direct value access support for this map type\n");
> +			return -EACCES;
> +		}
> +
> +		err = check_map_access(env, regno, reg->off,
> +				       map->value_size - reg->off, false);
> +		if (err)
> +			return err;
> +
> +		map_off = reg->off + reg->var_off.value;
> +		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +		if (err) {

since the code checks it here the same check in check_bpf_snprintf_call() should
probably do:
 if (err) {
   verbose("verifier bug\n");
   return -EFAULT;
 }

instead of just "return err;"
?

> +			verbose(env, "direct value access on string failed\n");

I think the message doesn't tell users much, but they probably should never
see it unless they try to do lookup from readonly array with
more than one element.
So I guess it's fine to keep this one as-is. Just flagging.

Anyway the whole set looks great, so I've applied to bpf-next.
Thanks!
