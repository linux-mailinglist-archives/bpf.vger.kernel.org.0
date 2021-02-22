Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4D32210B
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 22:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBVU74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 15:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBVU7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 15:59:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C718C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 12:59:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 75so10979773pgf.13
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 12:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C8+rlGF88iIEJCLjuY28fW5S2OfD5dM6RG2o6G3v3TY=;
        b=EF8R+CnTjSiM2bPdc9lwbt0SsIJX6n3cnVyeaOkwuJWcLCinK7329KtVTEOGNz/B4P
         eOrVMlv7Cw2Pt5Vs13V5pUNGcX8/5yIuI0u5hXjV24o5ZWTozFPVD/FOKkyxysBLtIbG
         baHGfW1BmSRx3aWKUlG4FSXzCY1IupZwz1ktuAeGs073Q4UOvQKSOZjDK03fif2gP5Rk
         nTY0d2Jo6uyU/3wa6ZX5bvi29zioRP8yVJdFFBFl1mfgfOxcT3Iq6CDL0R09B6PoDuLU
         9IR539B1u7yxC42n3hLUfN8mKyBdCwhJIKf+hl9kyew/vRmuQuOHnp+w6m4+YwyVRD9I
         yKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8+rlGF88iIEJCLjuY28fW5S2OfD5dM6RG2o6G3v3TY=;
        b=BdNb2yHCDIvfOeE0b0suhbfQ1+jW6qa4RiUxagPzJKccXx/9/hlRB8HAVaZaieasat
         HyPorufzH5aiRyrsrrUlVbPQPkHSjzBT9rq8breH602mHFUh6JCXf/m23xG2f1CSztIS
         5IrAxXMaUoQYnoEFu2HiQN6agNMEoo7UoEMZeSQ0EEzqqqgnO8+Xs/svZHEZtBcdFfu3
         DVv9kbiFBLa0CPxp5N2/6qgWnq2aa4TmLjHeq4b1RwoSnJ1fq02YOVEUV32fwiXYi8N7
         JWreqs76KM+M39K+9DqNfy9dwX/5CexGQgL6VysOrV8TIl+4rZGaXJa78JP4n8WnKQIJ
         F0Pg==
X-Gm-Message-State: AOAM532jTaJRusawwgCdhNIlAoHd5VgVu9Yzjz7UzTcxGy8NO8NHyOhQ
        2dt008MY5QkBBVxNoHqezOo=
X-Google-Smtp-Source: ABdhPJzWY7afCP7rAZ/kIElLCQaaND8wZc3tRtE4EJr15H/taEOulzh+u58e+Uj/i+rtR4NBK+yjdA==
X-Received: by 2002:a63:724a:: with SMTP id c10mr21425889pgn.124.1614027554900;
        Mon, 22 Feb 2021 12:59:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b9ca])
        by smtp.gmail.com with ESMTPSA id t2sm15287112pfg.152.2021.02.22.12.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:59:14 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:59:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 04/11] bpf: add bpf_for_each_map_elem() helper
Message-ID: <20210222205912.hucaxodzk7csrdyj@ast-mbp.dhcp.thefacebook.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181807.3190187-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217181807.3190187-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 10:18:07AM -0800, Yonghong Song wrote:
> @@ -5893,6 +6004,14 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
>  		else
>  			*ptr_limit = -off;
>  		return 0;
> +	case PTR_TO_MAP_KEY:
> +		if (mask_to_left) {
> +			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
> +		} else {
> +			off = ptr_reg->smin_value + ptr_reg->off;
> +			*ptr_limit = ptr_reg->map_ptr->key_size - off;
> +		}
> +		return 0;

This part cannot be exercised because for_each will require cap_bpf.
Eventually we might relax this requirement and above code will be necessary.
Could you manually test it that it's working as expected by forcing
sanitize_ptr_alu() to act on it?

>  	case PTR_TO_MAP_VALUE:
>  		if (mask_to_left) {
>  			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
> @@ -6094,6 +6213,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>  		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
>  			dst, reg_type_str[ptr_reg->type]);
>  		return -EACCES;
> +	case PTR_TO_MAP_KEY:
>  	case PTR_TO_MAP_VALUE:
>  		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
>  			verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
> @@ -8273,6 +8393,21 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		return 0;
>  	}
>  
> +	if (insn->src_reg == BPF_PSEUDO_FUNC) {
> +		struct bpf_prog_aux *aux = env->prog->aux;
> +		u32 subprogno = insn[1].imm;
> +
> +		if (aux->func_info &&
> +		    aux->func_info_aux[subprogno].linkage != BTF_FUNC_STATIC) {

Could you change above to "!aux->func_info || aux..." ?
That will force for_each to be available only when funcs are annotated.
The subprogs without annotations were added only to be able to manually
craft asm test cases for subprogs in test_verifier.
The for_each selftests in patches 10 and 11 are strong enough.
The asm test would not add any value.
So I would like to avoid supporting something that has no real use.
