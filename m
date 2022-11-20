Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4174E6315B5
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKTSoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKTSoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:44:00 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D5AE5A
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:43:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k15so9466963pfg.2
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnWNECmMKGrP9r6987JMW2RqzFfkCK2+Ct3YH5AM99Q=;
        b=TF9/48PqYMUe0MtoPoIYxAXV7t/H4FMMICbucNrrRlqWEq/bF4HKigpRUvOVhsGFYO
         IiqFrYt5rh692X2AMq5xtTEWXIXEcu1KzVaWuRgI1yM0mXTDwXnpja7bhxvU1fRk9ybr
         poh4uYY0VvEGIxo4ZjP4UoEuSxTBzrkBz2qLmi5iAFSJ+rWNWPEGtfZ+k0wQkUlP5KeE
         Pwo/ZP+0DTIpFzvkRQC5cW9Kdpmm/ZA9ewHKmpMywiILp/MZKj0Jte/ZrbxSDORAQF9t
         45hqAa7ZQXLFOynWTjn4TkXKwMHJQJth2Dp2E42Jqgir5sr8jzEpCsmS1Dx6z/+/XrYD
         E+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnWNECmMKGrP9r6987JMW2RqzFfkCK2+Ct3YH5AM99Q=;
        b=zWN6xYWS/30zhzeDcHWBsSDTXNIyXiW74JPs/8yL6vT02WrvF+uNJUaAL6oZp339IN
         BmDFZ3q8PqbKipir5Riya48gBoEDy4y87vj5r869bOC7wdS9t+jGYTfzuRqqRaVt3lmn
         YDiB5zhBVXp1unOHlJV0El/WVhjtsq0PEMyS2Ye76F+xKTY783UngiiTlsJKbXEnXStl
         Scbuy5npoxRGhsDfw4e5FGtjjDZV6/B4dnH6IeNLoMX3wo37Q4Jflu5dOA44UvJc5jYF
         XBc8RntG5XAqRbbz1yJr/Kf+Eg0DRBsmjNodU7a21p5emmxJSqTmcXug5Z4SWzYsL1vW
         A4hQ==
X-Gm-Message-State: ANoB5pmXItXB9mDRdtOcQgUrjyHDa/2M1lq0VLMOVAkUy2+K2BHsuxqq
        vcR/07YmKx3MG4KbjcFo80U5iV0bt3I=
X-Google-Smtp-Source: AA0mqf4wpYNBzYEQI7G/sMhW6YPoI7ZhqaeeNK40VMkCOudSpsqlLso1KHt0v/6Ql9fDMl9fYPJ29Q==
X-Received: by 2002:a62:e717:0:b0:572:df9e:d57d with SMTP id s23-20020a62e717000000b00572df9ed57dmr17512393pfh.10.1668969838555;
        Sun, 20 Nov 2022 10:43:58 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0018691ce1696sm7890945plf.131.2022.11.20.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 10:43:58 -0800 (PST)
Date:   Sun, 20 Nov 2022 10:43:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Add a kfunc to type cast from bpf
 uapi ctx to kernel ctx
Message-ID: <20221120184355.46xdvn62lycdeypy@macbook-pro-5.dhcp.thefacebook.com>
References: <20221120183651.2180232-1-yhs@fb.com>
 <20221120183702.2180724-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120183702.2180724-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 10:37:02AM -0800, Yonghong Song wrote:
> Implement bpf_cast_to_kern_ctx() kfunc which does a type cast
> of a uapi ctx object to the corresponding kernel ctx. Previously
> if users want to access some data available in kctx but not
> in uapi ctx, bpf_probe_read_kernel() helper is needed.
> The introduction of bpf_cast_to_kern_ctx() allows direct
> memory access which makes code simpler and easier to understand.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/btf.h   |  5 +++++
>  kernel/bpf/btf.c      | 25 +++++++++++++++++++++++++
>  kernel/bpf/helpers.c  |  6 ++++++
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index d38aa4251c28..9ed00077db6e 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -487,6 +487,7 @@ const struct btf_member *
>  btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  		      const struct btf_type *t, enum bpf_prog_type prog_type,
>  		      int arg);
> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2);
>  #else
> @@ -531,6 +532,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  {
>  	return NULL;
>  }
> +static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
> +				      enum bpf_prog_type prog_type) {
> +	return -EINVAL;
> +}
>  static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  				      const struct btf *btf2, u32 id2)
>  {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1c78d4df9e18..3c662b00d54a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5603,6 +5603,31 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
>  	return kern_ctx_type->type;
>  }
>  
> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type)
> +{
> +	const struct btf_member *kctx_member;
> +	const struct btf_type *conv_struct;
> +	const struct btf_type *kctx_type;
> +	u32 kctx_type_id;
> +
> +	conv_struct = bpf_ctx_convert.t;
> +	if (!conv_struct) {
> +		bpf_log(log, "btf_vmlinux is malformed\n");
> +		return -EINVAL;
> +	}

same comments as in v2.
