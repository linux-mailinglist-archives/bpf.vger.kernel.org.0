Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96838528B65
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbiEPQ6X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbiEPQ6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 12:58:15 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039527FEF
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 09:56:30 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id z126so12717225qkb.2
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 09:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZrqn9Bq0Hotpn8Ire8ifDoMJPnQzPFf+VXcloBuQWM=;
        b=FKu1Js3IL3E0KEhANexP77mAYNvEsJknwX8YugEdxAZZtgRj4G8kPEcMLmv/ZfKy3F
         5UoJ/JgJdzvzoirLMpZ9PuBgOcqUzIsLtBUmuCT5LQq3iRyrB6kxdBpS+1RZoP1wiwjL
         bz2rl9KGIyV5w8NuiV8aAEhsqRU22y4lpWiZqTNGnkNaRqh8cUt0wGli5xyL4m/k53lg
         K9NpPTCERXF5YW/245cFmss2Uk0ZND4w/z7jfpabXa7peG7r5dc30OCDZc1QQxcGBHKa
         uBmNv/+Tta2rrM0elGHqsQ8c/+62eCXtBL9xtn7OCwHGNQVWEcCmZ8C5xUkOt75fbxAc
         UPeA==
X-Gm-Message-State: AOAM531zjHtk40Zgo4Ybf10ts29ludks8K4oBaCNLosuM8M7jvCclBOE
        W/usP7knPuFD/Dknur8cmyVvZPlyeC0=
X-Google-Smtp-Source: ABdhPJxOQFgXU47oo0IhQc/TNt1aj+jagozfWm4jnisNQGlBoMOvT9mQ563kHF+mNHGbLD6vPUCXRQ==
X-Received: by 2002:a05:620a:448d:b0:6a0:9838:fc16 with SMTP id x13-20020a05620a448d00b006a09838fc16mr13173477qkp.718.1652720189515;
        Mon, 16 May 2022 09:56:29 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id bs41-20020a05620a472900b0069fe1fc72e7sm6314220qkb.90.2022.05.16.09.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:56:29 -0700 (PDT)
Date:   Mon, 16 May 2022 09:56:27 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4 4/6] bpf: Add bpf_dynptr_read and
 bpf_dynptr_write
Message-ID: <20220516165627.4a2kdpgzmln5ejew@dev0025.ash9.facebook.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-5-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509224257.3222614-5-joannelkoong@gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 09, 2022 at 03:42:55PM -0700, Joanne Koong wrote:
> This patch adds two helper functions, bpf_dynptr_read and
> bpf_dynptr_write:
> 
> long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset);
> 
> long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len);
> 
> The dynptr passed into these functions must be valid dynptrs that have
> been initialized.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            | 16 ++++++++++
>  include/uapi/linux/bpf.h       | 19 ++++++++++++
>  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 19 ++++++++++++
>  4 files changed, 110 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8fbe739b0dec..6f4fa0627620 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2391,6 +2391,12 @@ enum bpf_dynptr_type {
>  #define DYNPTR_SIZE_MASK	0xFFFFFF
>  #define DYNPTR_TYPE_SHIFT	28
>  #define DYNPTR_TYPE_MASK	0x7
> +#define DYNPTR_RDONLY_BIT	BIT(31)
> +
> +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +{
> +	return ptr->size & DYNPTR_RDONLY_BIT;
> +}
>  
>  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
>  {
> @@ -2412,6 +2418,16 @@ static inline int bpf_dynptr_check_size(u32 size)
>  	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
>  }
>  
> +static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> +{
> +	u32 size = bpf_dynptr_get_size(ptr);
> +
> +	if (len > size || offset > size - len)
> +		return -E2BIG;
> +
> +	return 0;
> +}

Does this need to be in bpf.h? Or could it be brought into helpers.c as a
static function? I don't think there's any harm in leaving it here, but at
first glance it seems like a helper function that doesn't really need to be
exported.

> +
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
>  		     u32 offset, u32 size);
>  
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 679f960d2514..f0c5ca220d8e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5209,6 +5209,23 @@ union bpf_attr {
>   *		'bpf_ringbuf_discard'.
>   *	Return
>   *		Nothing. Always succeeds.
> + *
> + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> + *	Description
> + *		Read *len* bytes from *src* into *dst*, starting from *offset*
> + *		into *src*.
> + *	Return
> + *		0 on success, -E2BIG if *offset* + *len* exceeds the length
> + *		of *src*'s data, -EINVAL if *src* is an invalid dynptr.
> + *
> + * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len)
> + *	Description
> + *		Write *len* bytes from *src* into *dst*, starting from *offset*
> + *		into *dst*.
> + *	Return
> + *		0 on success, -E2BIG if *offset* + *len* exceeds the length
> + *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
> + *		is a read-only dynptr.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -5411,6 +5428,8 @@ union bpf_attr {
>  	FN(ringbuf_reserve_dynptr),	\
>  	FN(ringbuf_submit_dynptr),	\
>  	FN(ringbuf_discard_dynptr),	\
> +	FN(dynptr_read),		\
> +	FN(dynptr_write),		\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2d6f2e28b580..7206b9e5322f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1467,6 +1467,58 @@ const struct bpf_func_proto bpf_dynptr_put_proto = {
>  	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | OBJ_RELEASE,
>  };
>  
> +BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src, u32, offset)
> +{
> +	int err;
> +
> +	if (!src->data)
> +		return -EINVAL;
> +
> +	err = bpf_dynptr_check_off_len(src, offset, len);
> +	if (err)
> +		return err;
> +
> +	memcpy(dst, src->data + src->offset + offset, len);
> +
> +	return 0;
> +}
> +
> +const struct bpf_func_proto bpf_dynptr_read_proto = {
> +	.func		= bpf_dynptr_read,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
> +	.arg3_type	= ARG_PTR_TO_DYNPTR,
> +	.arg4_type	= ARG_ANYTHING,

I think what you have now is safe / correct, but is there a reason that we
don't use ARG_CONST_SIZE_OR_ZERO for both the len and the offset, given
that they're both bound by the size of a memory region? Same question
applies to the function proto for bpf_dynptr_write() as well.

> +};
> +
> +BPF_CALL_4(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *, src, u32, len)
> +{
> +	int err;
> +
> +	if (!dst->data || bpf_dynptr_is_rdonly(dst))
> +		return -EINVAL;
> +
> +	err = bpf_dynptr_check_off_len(dst, offset, len);
> +	if (err)
> +		return err;
> +
> +	memcpy(dst->data + dst->offset + offset, src, len);
> +
> +	return 0;
> +}
> +
> +const struct bpf_func_proto bpf_dynptr_write_proto = {
> +	.func		= bpf_dynptr_write,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_DYNPTR,
> +	.arg2_type	= ARG_ANYTHING,
> +	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
> +	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
> +};
> +

[...]

Overall looks great.
