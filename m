Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB84CA104
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 10:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiCBJnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 04:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiCBJnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 04:43:07 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99203E94
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 01:42:21 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so736810pjd.1
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 01:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9WvC3LW+EIOoI5SMHeHiDzdrZG65UGPs0L2NwlURnw8=;
        b=YOl205+UyOyFpHPOGI0pDXq8pwx/gLawGoa9O1pRQkNdFioh55aMS+xv6pfl4jSfKe
         XmZKpodakPuzCdXITo552CPC8SCcdTY5Bhlqg0HMhVgbUTA0OAz5/Hx9Nc0QTqtk8vnK
         CLv/cpT2vF9dWxCsdfdumu3jOAgjPUMJvd/zdS0IRoXIrpsskcyCZKD+fflqZuqO92Vq
         ZovINYTc8LSC2CVFExhA1j/m10TvSUk+SVtrdMKN/D5to223psLsX2frlNGNRSz0VRlb
         qtDGheuKCfa5EZy2YMyXV6vLdtGacCg64gJye27G/OAk/7JsYuLTslRHbD+2e1xQSEOS
         VUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WvC3LW+EIOoI5SMHeHiDzdrZG65UGPs0L2NwlURnw8=;
        b=IyoZC+gQEYf3Uo28IT35BQHt0QwPh0mey1jlPSyM2sntxpDDQeFvoEuxY83lZ5djAt
         n+XoBZ/Dp80kmohmOj9Lu9yxv8vDyxk0iZQq7YHLj9GRqEKafogMP7zXq1q1gt2Ayib3
         2QnQHfZPKDZOlAwmK4RF5OUbqFm+WvmtWwO7ymhSD1hQSQbGw2WON/6XGtP+OAICBrVf
         ca0B9nWPxlZBNdXM8r6nMNz8xnx9enaRK4A83zc11A2ewyp6Bxr80eSh3EdOfVOIn6+T
         w2/e/2at9aPlA8roUalc+H1sqP3ZiT80fXNABUhmmz3SIa3jrOLJxBsmMA+Mr6SZAgcj
         xAQQ==
X-Gm-Message-State: AOAM533tqKjtg+T7zUdTayTvVqbbCWP5HSL1L0xA363tUPMLTMN5aTkZ
        uci5Pjm0wMHN0GIkewYHjmsG8qmANc8=
X-Google-Smtp-Source: ABdhPJzr8i1AoG6bIVB/o0vkzxlJXzGks3YMUbyhcX/ODfXVSnq2xPWEy8pWZrQyf0UKAkKUtBBFgA==
X-Received: by 2002:a17:902:f68b:b0:14f:c84c:ad6d with SMTP id l11-20020a170902f68b00b0014fc84cad6dmr29918035plg.155.1646214140953;
        Wed, 02 Mar 2022 01:42:20 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm21270087pfv.49.2022.03.02.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:42:20 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:12:18 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 02, 2022 at 08:50:24AM IST, Martin KaFai Lau wrote:
> On Tue, Mar 01, 2022 at 12:27:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
> > always has its offset set to 0. While not a real problem now, there's a
> > very real possibility this will become a problem when more and more
> > kfuncs are exposed.
> >
> > Previous commits already protected against non-zero var_off. The case we
> > are concerned about now is when we have a type that can be returned by
> > acquire kfunc:
> >
> > struct foo {
> > 	int a;
> > 	int b;
> > 	struct bar b;
> > };
> >
> > ... and struct bar is also a type that can be returned by another
> > acquire kfunc.
> >
> > Then, doing the following sequence:
> >
> > 	struct foo *f = bpf_get_foo(); // acquire kfunc
> > 	if (!f)
> > 		return 0;
> > 	bpf_put_bar(&f->b); // release kfunc
> >
> > ... would work with the current code, since the btf_struct_ids_match
> > takes reg->off into account for matching pointer type with release kfunc
> > argument type, but would obviously be incorrect, and most likely lead to
> > a kernel crash. A test has been included later to prevent regressions in
> > this area.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 7f6a0ae5028b..ba6845225b65 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  		return -EINVAL;
> >  	}
> >
> > +	if (is_kfunc)
> > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> >  	/* check that BTF function arguments match actual types that the
> >  	 * verifier sees.
> >  	 */
> > @@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  							regno, reg->ref_obj_id, ref_obj_id);
> >  						return -EFAULT;
> >  					}
> > +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> > +					 * always zero, when passed to release function.
> > +					 * var_off has already been checked to be 0 by
> > +					 * check_func_arg_reg_off.
> > +					 */
> > +					if (rel && reg->off) {
> Here is another reg->off check for PTR_TO_BTF_ID on top of the
> one 'check_func_arg_reg_off' added to the same function in patch 2.
> A nit, I also found passing ARG_DONTCARE in patch 2 a bit convoluted
> considering the btf func does not need ARG_* to begin with.
>

Right, arg_type doesn't really matter here (unless we start indicating in BTF we
want to take ringbuf allocation directly without size parameter or getting size
from BTF type).

> How about directly use the __check_ptr_off_reg() here instead of
> check_func_arg_reg_off()?  Then patch 1 is not needed.
>
> Would something like this do the same thing (uncompiled code) ?
>

I should have included a link to the previous discussion, sorry about that:
https://lore.kernel.org/bpf/20220223031600.pvbhu3dbwxke4eia@apollo.legion

Yes, this should also do the same thing, but the idea was to avoid keeping the
same checks in multiple places. For now, there is only the special case of
ARG_TYPE_PTR_TO_ALLOC_MEM and PTR_TO_BTF_ID that require some special handling,
the former of which is currently not relevant for kfunc, but adding some future
type and ensuring kfunc, and helper do the offset checks correctly just means
updating check_func_arg_reg_off.

reg->off in case of PTR_TO_BTF_ID reg for release kfunc is a bit of a special
case. We should also do the same thing for BPF helpers, now that I look at it,
but there's only one which takes a PTR_TO_BTF_ID right now (bpf_sk_release), and
it isn't problematic currently, but now that referenced PTR_TO_BTF_ID is used it
is quite possible to support it in more BPF helpers later and forget to prevent
such case.

So, it would be possible to move this check inside check_func_arg_reg_off, based
on a new bool is_release_func parameter, and relying on the assumption that only
one referenced register can be passed to helper or kfunc at a time (already
enforced for both BPF helpers and kfuncs).

Basically, instead of doing type == PTR_TO_BTF_ID for fixed_off_ok inside it, we
will do:

	fixed_off_ok = false;
	if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
		fixed_off_ok = true;

Again, given we can only pass one referenced reg, if we see release func and a
reg with ref_obj_id, it is the one being released.

In the end, it's more of a preference thing, if you feel strongly about it I can
go with the __check_ptr_off_reg call too.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7f6a0ae5028b..768cef4de4cc 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5794,6 +5797,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  			}
>  		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
>  			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
> +			bool fixed_off_ok = reg->type == PTR_TO_BTF_ID;
>  			const struct btf_type *reg_ref_t;
>  			const struct btf *reg_btf;
>  			const char *reg_ref_tname;
> @@ -5816,6 +5820,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  							regno, reg->ref_obj_id, ref_obj_id);
>  						return -EFAULT;
>  					}
> +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> +					 * always zero, when passed to release function.
> +					 * var_off has already been checked to be 0 by
> +					 * check_func_arg_reg_off.
> +					 */
> +					if (rel)
> +						fixed_off_ok = false;
>  					ref_regno = regno;
>  					ref_obj_id = reg->ref_obj_id;
>  				}
> @@ -5824,6 +5835,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
>  			}
>
> +			__check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
>  							    &reg_ref_id);
>  			reg_ref_tname = btf_name_by_offset(reg_btf,
>

--
Kartikeya
