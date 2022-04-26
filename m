Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FD50EF45
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 05:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiDZDjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 23:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243189AbiDZDi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 23:38:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800413A1A0
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:35:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so29054930plg.5
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7uaqHc0sM1fpYyxy77gzMWBvx8ETrxIvjDrs9e7DNRk=;
        b=fcdft7jqjLVesIW4EdGNV1ny9q427I8xtq9OodCwTz4oyYP8C+Tzx44TLmCc2rjbZa
         9tZhFlQJCe2/Q/t92vEyHHOg3p2Z48BiixUNgG7ZYFLMj/ERjXg+lyy9rgtTDzTiPFcu
         V2zhbTA68c9FlRPWW3psiMKKqLBKA05YOeMkjuondGCgomwdf+QVhzXcZoci6BzBTAcB
         AWNuklY5nbn/IoiSrT/xiURzZdmXVtAX5qPe29Nr9D4ZsU9Pboiszj4TAYsLKmLt4dUw
         4bNl1iGDUQZLmbxMi/ZJkJdoyL69P6LhHVpGdSivlO4n0XalWh3dNTALJ8AXj9eseXS4
         pL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7uaqHc0sM1fpYyxy77gzMWBvx8ETrxIvjDrs9e7DNRk=;
        b=MJGmF0S7M8hwZkIdBGbaJ6EHDOODZNvZg5dGgFVbG9M9+hO+M8lUzSIRk0boWjTa3A
         y9Vvja9V3n4pFjWjAfcMzjiVsuueIvr5iHqrmxN7/PhCp1MGlxGeCqPivQgA+VfnNsHS
         CGCvX2i524QKdbH6j9CE4Il6FJ87ZFzCWUKzGpzYODiys8/qBIZZZSjZYNAsgRdIxV9/
         uny9HIBQsXufRjowqQJR+Qw+xnfRDr8X12N8jDhTVWkb5EEmPWFhxj65yUOXsq6P+3mV
         6HyRtvJ6Xu/Wodz+apO3jrLdMbczcOxdX04SiThIhVZ7yEhK0ULHVcRmhhysOCA80ph5
         5BPw==
X-Gm-Message-State: AOAM5310tTGYqzUvD3I9T8TZ17sjprr7L9L0eiWp4LmJvHN3daV7MePI
        knuD51CdTOF32yolhDttCcM=
X-Google-Smtp-Source: ABdhPJy2ME955ICc5yUXcjpwYzLFknvBK8vl0hIfPhVxu0HSAYaeGUhdWcyfJhQ1eKqZPvIMitnfkA==
X-Received: by 2002:a17:902:da85:b0:15d:3a9a:aad1 with SMTP id j5-20020a170902da8500b0015d3a9aaad1mr260742plx.113.1650944147304;
        Mon, 25 Apr 2022 20:35:47 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b249000000b003aae4f10d86sm8602104pgo.94.2022.04.25.20.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:35:47 -0700 (PDT)
Date:   Mon, 25 Apr 2022 20:35:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Add verifier tests for
 kptr
Message-ID: <20220426033544.lxxnz6epet6qrzq6@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
 <20220424214901.2743946-13-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424214901.2743946-13-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 25, 2022 at 03:19:00AM +0530, Kumar Kartikeya Dwivedi wrote:
> Reuse bpf_prog_test functions to test the support for PTR_TO_BTF_ID in
> BPF map case, including some tests that verify implementation sanity and
> corner cases.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  net/bpf/test_run.c                            |  45 +-
>  tools/testing/selftests/bpf/test_verifier.c   |  55 +-
>  .../testing/selftests/bpf/verifier/map_kptr.c | 469 ++++++++++++++++++
>  3 files changed, 562 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index e7b9c2636d10..29fe32821e7e 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -584,6 +584,12 @@ noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
>  {
>  }
>  
> +noinline struct prog_test_ref_kfunc *
> +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b)
> +{
> +	return &prog_test_struct;
> +}
> +
>  struct prog_test_pass1 {
>  	int x0;
>  	struct {
> @@ -669,6 +675,7 @@ BTF_ID(func, bpf_kfunc_call_test3)
>  BTF_ID(func, bpf_kfunc_call_test_acquire)
>  BTF_ID(func, bpf_kfunc_call_test_release)
>  BTF_ID(func, bpf_kfunc_call_memb_release)
> +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
>  BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
>  BTF_ID(func, bpf_kfunc_call_test_pass1)
>  BTF_ID(func, bpf_kfunc_call_test_pass2)
> @@ -682,6 +689,7 @@ BTF_SET_END(test_sk_check_kfunc_ids)
>  
>  BTF_SET_START(test_sk_acquire_kfunc_ids)
>  BTF_ID(func, bpf_kfunc_call_test_acquire)
> +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
>  BTF_SET_END(test_sk_acquire_kfunc_ids)
>  
>  BTF_SET_START(test_sk_release_kfunc_ids)
> @@ -691,8 +699,13 @@ BTF_SET_END(test_sk_release_kfunc_ids)
>  
>  BTF_SET_START(test_sk_ret_null_kfunc_ids)
>  BTF_ID(func, bpf_kfunc_call_test_acquire)
> +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
>  BTF_SET_END(test_sk_ret_null_kfunc_ids)
>  
> +BTF_SET_START(test_sk_kptr_acquire_kfunc_ids)
> +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> +BTF_SET_END(test_sk_kptr_acquire_kfunc_ids)
> +
>  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>  			   u32 size, u32 headroom, u32 tailroom)
>  {
> @@ -1579,14 +1592,36 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>  
>  static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
>  	.owner        = THIS_MODULE,
> -	.check_set    = &test_sk_check_kfunc_ids,
> -	.acquire_set  = &test_sk_acquire_kfunc_ids,
> -	.release_set  = &test_sk_release_kfunc_ids,
> -	.ret_null_set = &test_sk_ret_null_kfunc_ids,
> +	.check_set        = &test_sk_check_kfunc_ids,
> +	.acquire_set      = &test_sk_acquire_kfunc_ids,
> +	.release_set      = &test_sk_release_kfunc_ids,
> +	.ret_null_set     = &test_sk_ret_null_kfunc_ids,
> +	.kptr_acquire_set = &test_sk_kptr_acquire_kfunc_ids
>  };

This hunk probably should have been in the previous patch,
but since it's not affecting bisect I left it as-is.

> +BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
> +BTF_ID(struct, prog_test_ref_kfunc)
> +BTF_ID(func, bpf_kfunc_call_test_release)
> +BTF_ID(struct, prog_test_member)
> +BTF_ID(func, bpf_kfunc_call_memb_release)

dtor of prog_test_member doesn't seem to be used ?

Please improve dtor and kptr_get test methods for
struct prog_test_ref_kfunc and prog_test_member to do the real refcnting.
Empty methods are not testing things fully.
