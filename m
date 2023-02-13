Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A7B694F6C
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 19:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBMSd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjBMSd1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 13:33:27 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A972007A
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:33:16 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d13so8916908qvj.8
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SeHkY1KlPiFj4F5SimEuxKmkYgWQe8TYG7dqQ/3+0i0=;
        b=UU9DbzuoGpEyNvRQzNIHw3x00kOq08BIkFYOSaO+SUGJHNXzrCgtFcLnRKjM8jcvp5
         M3Zkt6+UE9pa+IvTl89gtJ5kCeoFK+rbVGih78+UlgNEE9HmGbqSuH8ozuA9F8sJdbS4
         dJ4xLy2NxEaGLj8Bq3iWLLHJpeETTlSffCXJpeWDAAg8bSAtPH7v84JcWKSwLRexNPfG
         E5HTuzU2q+7RxSzkRaUkRGJLHGUlBoezi7CPpjgQqOWzjCJwLSUvAK/jex4zkf/JuGXw
         erI0vhry7sJAwGsJzDpXWHVBvTtlc4Azw8sLYiz4R2GmIFKZFiSddEyZYDPmEf4g8RBG
         hGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeHkY1KlPiFj4F5SimEuxKmkYgWQe8TYG7dqQ/3+0i0=;
        b=javiYFBiSM0AtYcOPtTZPVhxt/Mh97WHLxh8HaG/dquYS6vnO6GZhYeXVQ9DXetYkF
         c3eUNvAdGaIEYxTjRLrLullfvDqmZIQOdU2wOOWYlIPNh5mrN3MNfW6dYXYVgTfgSiaS
         ylay4FkvATGJ6uI8w3zrzwOfuoMkt1l2OhPnUxrpEqQdWcAWiU2DnT/6jJtnGj+RA7AO
         n5hwkTy0h9OZnTXgJxV9BDyHDYqoiluwiXFIyIP3xlTX/8yg2HQ2wkwuj1VdCUr+lwgX
         Nn7lqkukyXiEboha2ZXlbSzwHGPjaiCYah55CtICtWgVMd/itzc301mew2py24rCGfP0
         I/8Q==
X-Gm-Message-State: AO0yUKV6T4WMcZsO8aUoDmOZyd4F1z+zERYNGDvW9cNuxm2QQzQrsU+Q
        aLz5eDHb+OnAmfTrmHplJcE=
X-Google-Smtp-Source: AK7set/hCybx0iiYgIAxPJR6QKBASwiDRSZcMS+MrAxxIkBNNef9eLS0EaKDO1qfiGvqxqLrKdcSSw==
X-Received: by 2002:a05:6214:21eb:b0:56b:f28e:628a with SMTP id p11-20020a05621421eb00b0056bf28e628amr34668703qvj.6.1676313195802;
        Mon, 13 Feb 2023 10:33:15 -0800 (PST)
Received: from krava ([213.208.157.36])
        by smtp.gmail.com with ESMTPSA id u124-20020a376082000000b00702d1c6e7bbsm10152235qkb.130.2023.02.13.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:33:15 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 13 Feb 2023 19:33:02 +0100
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <Y+qCXoh+HcV5U5S/@krava>
References: <cover.1676302508.git.vmalik@redhat.com>
 <14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 04:59:58PM +0100, Viktor Malik wrote:

SNIP

> @@ -248,8 +223,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
>  	}
>  
> -	if (ret)
> -		bpf_trampoline_module_put(tr);
>  	return ret;
>  }
>  
> @@ -719,8 +692,11 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>  
>  	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
>  	tr = bpf_trampoline_get(key, &tgt_info);
> -	if (!tr)
> +	if (!tr) {
> +		if (tgt_info.tgt_mod)
> +			module_put(tgt_info.tgt_mod);
>  		return  -ENOMEM;
> +	}
>  
>  	mutex_lock(&tr->mutex);
>  
> @@ -800,6 +776,14 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>  		return NULL;
>  
>  	mutex_lock(&tr->mutex);
> +	if (tgt_info->tgt_mod) {
> +		if (tr->mod)
> +			/* we already have the module reference, release tgt_info reference */
> +			module_put(tgt_info->tgt_mod);
> +		else
> +			/* take ownership of the module reference */
> +			tr->mod = tgt_info->tgt_mod;

this seems tricky, should we take and save module reference in bpf_prog
struct and release it when the program goes out? IIUC the module for
which the program was verified for should stay as long as the program
is loaded

jirka

> +	}
>  	if (tr->func.addr)
>  		goto out;
>  
> @@ -819,6 +803,10 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>  	mutex_lock(&trampoline_mutex);
>  	if (!refcount_dec_and_test(&tr->refcnt))
>  		goto out;
> +	if (tr->mod) {
> +		module_put(tr->mod);
> +		tr->mod = NULL;
> +	}
>  	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
>  
>  	for (i = 0; i < BPF_TRAMP_MAX; i++)

SNIP
