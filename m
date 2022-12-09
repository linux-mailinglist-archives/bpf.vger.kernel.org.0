Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC118647C60
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 03:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLICrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 21:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLICra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 21:47:30 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB386F4E
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 18:47:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 21so2751217pfw.4
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMpGivl/Cw43XFHijvF2uj1g/w63hF8HA17jV06PE0U=;
        b=S6TzAyDVAbGG1ENwTtD5RFrEMochXfcUQ9onMrsvBMP5BA5XECUUIr+O9Oo3v7IFyv
         4OgkkZN/s/LetFk8KjK36i9UPLfzQt1Ike3NJcrVFpI+FSwX70mVOWmq9T2PcOPgxF1w
         9vO86aottB4rLG8JoCehLe/tMZI9LijqUcWdgYefFJXpayvalHokIGzqC4l8qv47yUSg
         ESKdHGXDm6cUju/DD4xKPAkE68DlQCeeB1XKfFMv3MvMe8Jgz8CqK5BUcO2jh8qcDg4w
         qlHiuFCoJeSUxEjMtcFRFkvWfmZewvV45jiQc2VDNp9UnqLV3OEeeq1cVBsrOA0Th4bg
         fSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMpGivl/Cw43XFHijvF2uj1g/w63hF8HA17jV06PE0U=;
        b=nZBtBdTjorki05N7/7LC/kXvMsxK0dlQ19lXF9OC9A/jzPjRBke0Tb0OGbtLMqG8PK
         HbX5q7FGURUYhZ91J2LFFvupBwdjw6JN5PVAzpNB2URGQ5CxwJWhPgAoSsdglq8hNigX
         M48R2qweuksVFrOdS0aFVar/VkM9fpoTW0Aj4OealT5qB4d45nP1vjcIme+3oQABErjp
         9GXXlJcCm/ajfXyXEu1oA+AkyiLUJ3+sDp4CrMz2hO5YaWTOKx6iNfsgPKuXGcwBLXbf
         nbuzgXqAxAdqFP3TxT6r9XJcznHR5w5cv3dqk8wriNEbKXQNT5tguem3mYEC2BZR9ibk
         IQxA==
X-Gm-Message-State: ANoB5pmmbu8DHB5MCtJVOc7D2qTz8wUHzMYtf7ceyRrrwf6eGckGmtvP
        Y+YJNumaXSo2aDrlAj9T/5pgsNHPGrw=
X-Google-Smtp-Source: AA0mqf4i8LZDKZQsVDGhVKnWQ/AWGObmqrH5h4ps6k6g0cj5h9oRFKmmXKQAJftOdvEwrJQDpCFs2g==
X-Received: by 2002:a62:6204:0:b0:577:a0d:b091 with SMTP id w4-20020a626204000000b005770a0db091mr4628933pfb.14.1670554049459;
        Thu, 08 Dec 2022 18:47:29 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b005754106e364sm170403pfv.199.2022.12.08.18.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:47:28 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:47:25 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 4/7] bpf: Rework check_func_arg_reg_off
Message-ID: <20221209024725.hjcywagxv2yrvzcp@macbook-pro-6.dhcp.thefacebook.com>
References: <20221207204141.308952-1-memxor@gmail.com>
 <20221207204141.308952-5-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207204141.308952-5-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 02:11:38AM +0530, Kumar Kartikeya Dwivedi wrote:
> While check_func_arg_reg_off is the place which performs generic checks
> needed by various candidates of reg->type, there is some handling for
> special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> ARG_PTR_TO_ALLOC_MEM.

commit log is obsolete.
I cleaned it up s/ARG_PTR_TO_ALLOC_MEM/ARG_PTR_TO_RINGBUF_MEM/

> This commit aims to streamline these special cases and instead leave
> other things up to argument type specific code to handle. The function
> will be restrictive by default, and cover all possible cases when
> OBJ_RELEASE is set, without having to update the function again (and
> missing to do that being a bug).
> 
> This is done primarily for two reasons: associating back reg->type to
> its argument leaves room for the list getting out of sync when a new
> reg->type is supported by an arg_type.
> 
> The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> we already handle, whenever a release argument is expected, it should
> be passed as the pointer that was received from the acquire function.
> Hence zero fixed and variable offset.
> 
> There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> its target register type PTR_TO_MEM | MEM_ALLOC can already be passed

and MEM_RINGBUF here.

> with non-zero offset to other helper functions, which makes sense.
> 
> Hence, lift the arg_type_is_release check for reg->off and cover all
> possible register types, instead of duplicating the same kind of check
> twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).
> 
> For the release argument, arg_type_is_dynptr is the special case, where
> we go to actual object being freed through the dynptr, so the offset of
> the pointer still needs to allow fixed and variable offset and
> process_dynptr_func will verify them later for the release argument case
> as well.
> 
> This is not specific to ARG_PTR_TO_DYNPTR though, we will need to make
> this exception for any future object on the stack that needs to be
> released. In this sense, PTR_TO_STACK as a candidate for object on stack
> argument is a special case for release offset checks, and they need to
> be done by the helper releasing the object on stack.
> 
> Since the check has been lifted above all register type checks, remove
> the duplicated check that is being done for PTR_TO_BTF_ID.
> 
> Acked-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 64 +++++++++++--------
>  tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
>  .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
>  3 files changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdbaf22cdaf2..cadcf0233326 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6269,11 +6269,38 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
>  			   enum bpf_arg_type arg_type)
>  {
> -	enum bpf_reg_type type = reg->type;
> -	bool fixed_off_ok = false;
> +	u32 type = reg->type;
>  
> -	switch ((u32)type) {
> -	/* Pointer types where reg offset is explicitly allowed: */
> +	/* When referenced register is passed to release function, its fixed
> +	 * offset must be 0.
> +	 *
> +	 * We will check arg_type_is_release reg has ref_obj_id when storing
> +	 * meta->release_regno.
> +	 */
> +	if (arg_type_is_release(arg_type)) {
> +		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
> +		 * may not directly point to the object being released, but to
> +		 * dynptr pointing to such object, which might be at some offset
> +		 * on the stack. In that case, we simply to fallback to the
> +		 * default handling.
> +		 */
> +		if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {

also removed one indent, inverted above and added direct 'return 0'
I know that it's not exactly the same, but together with patch 5
it makes it cleaner and this special case (that David didn't like)
doesn't look as horrible anymore.

> +			/* Doing check_ptr_off_reg check for the offset will
> +			 * catch this because fixed_off_ok is false, but
> +			 * checking here allows us to give the user a better
> +			 * error message.
> +			 */
> +			if (reg->off) {
> +				verbose(env, "R%d must have zero offset when passed to release func or trusted arg to kfunc\n",
> +					regno);
> +				return -EINVAL;
> +			}
> +			return __check_ptr_off_reg(env, reg, regno, false);
> +		}
> +		/* Fallback to default handling */

No 'fallback to default' either.
It wasn't easy to follow this logic.

And applied.
See how it looks now.

Overall looks like great cleanup. Thanks!
