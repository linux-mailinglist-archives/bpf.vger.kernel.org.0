Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57A6315D8
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTTZz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTZz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:25:55 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1E2DAA1
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:25:54 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id t17so8026943pjo.3
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhKbWBlvPMiTYA8lBeAxy1J0FJv7qY0PuKG5KDFiEYc=;
        b=FZX6q82MWRODmUIAdSCaloCNxl0RpDuU5Cts0fmP+cYE4ZwBJmGLYNgpzZmkQD3Qy3
         WvArIFTD30WRJsW7vmQp/LssgWq22Sx20awFyzIAueoalB3vT4bMCVtB/VIuvgIAkCM4
         egwCCpmcCG+maT+mcm+1tZYmCX3JhpWWQfoGikvCiQm4vG1mwU5DusPAcoGSx1wXxqN9
         PHQ7XY4QbRU46chQo2NfAa7ssWuW3oHyHScxHjyimBKE5sFuJDd/wOwCfK4s7BtHcohg
         PnZf9IkdLesi5c3kCg6mzOExpWuXCku3s16kHGdf+ZQM+AVWu5p2JH+jxsPMeB3Hgb43
         bHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhKbWBlvPMiTYA8lBeAxy1J0FJv7qY0PuKG5KDFiEYc=;
        b=2aM3r4DpUDDOk3Tm2rnZT31ifScHNrIhrMSifSc4fSKPrEaktpFvm+IobRFhTbkZo6
         /tzKh62zwV/+mD1wcUoJm6OQWdeSdcekaz1fRmq9xOPQOBkQctHrczGWyDlA+7uTgAKp
         dy8uCFRN5wabiO0TvGX58+ZnKiYZpPREM9mlwaeTmq6ymMARFe8K4ibPagAEzzGeQcLB
         DPzgzlGwzS+ZKbZ8r2bxM1MjZTTztJaLYTUQlRUAHT4vlPoKziYvPkDydvYOTUgzTDGD
         3kn8YkyzN7BtJsI25+8fkNQpLv5NQ7kcRJvLugJ5qemhbieaRSeIHFfgfd6S5zRyCnGV
         CLuw==
X-Gm-Message-State: ANoB5pkN0gOy/aMGMu7B20lV1ZQy7pyd5xe9DNO5YgdhwyAUPoI6bc9Y
        4EYG9Csq3dhMLu7cTXBuwPY=
X-Google-Smtp-Source: AA0mqf5BY3vJslbcsHn4VXbIyu6k7/o5y65Bu9BQ/SoA7q2LxxPUjIDxaPFLJWvuag+gyqv7aYTxVw==
X-Received: by 2002:a17:90a:1a07:b0:212:fbab:446b with SMTP id 7-20020a17090a1a0700b00212fbab446bmr17643070pjk.146.1668972353449;
        Sun, 20 Nov 2022 11:25:53 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id c15-20020a63ea0f000000b004393f60db36sm6203306pgi.32.2022.11.20.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 11:25:52 -0800 (PST)
Date:   Mon, 21 Nov 2022 00:55:41 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
Message-ID: <20221120192541.swwnqsrk3mxv5vdt@apollo>
References: <20221118015614.2013203-1-memxor@gmail.com>
 <20221118015614.2013203-12-memxor@gmail.com>
 <Y3ffnATsq8kg7Js1@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ffnATsq8kg7Js1@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 19, 2022 at 01:10:12AM IST, David Vernet wrote:
> On Fri, Nov 18, 2022 at 07:26:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > As we continue to add more features, argument types, kfunc flags, and
> > different extensions to kfuncs, the code to verify the correctness of
> > the kfunc prototype wrt the passed in registers has become ad-hoc and
> > ugly to read. To make life easier, and make a very clear split between
> > different stages of argument processing, move all the code into
> > verifier.c and refactor into easier to read helpers and functions.
> >
> > This also makes sharing code within the verifier easier with kfunc
> > argument processing. This will be more and more useful in later patches
> > as we are now moving to implement very core BPF helpers as kfuncs, to
> > keep them experimental before baking into UAPI.
> >
> > Remove all kfunc related bits now from btf_check_func_arg_match, as
> > users have been converted away to refactored kfunc argument handling.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Thanks for working on this. I'm relieved to see this work being done. I
> have a few comments but overall this is great. I'll take a closer look
> later.
>
> > ---
> > [...]
> > +static bool is_kfunc_arg_mem_size(const struct btf *btf,
> > +				  const struct btf_param *arg,
> > +				  const struct bpf_reg_state *reg)
> > +{
> > +	int len, sfx_len = sizeof("__sz") - 1;
> > +	const struct btf_type *t;
> > +	const char *param_name;
> > +
> > +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> > +	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
> > +		return false;
> > +
> > +	/* In the future, this can be ported to use BTF tagging */
> > +	param_name = btf_name_by_offset(btf, arg->name_off);
> > +	if (str_is_empty(param_name))
> > +		return false;
> > +	len = strlen(param_name);
> > +	if (len < sfx_len)
> > +		return false;
> > +	param_name += len - sfx_len;
> > +	if (strncmp(param_name, "__sz", sfx_len))
> > +		return false;
>
> Oh, I thought we weren't doing this arg-type-by-name-suffix thing? I see
> that you're just moving it around so it's fine to move it here, but it
> seems to diverge from the discussions I've seen in the past. Don't want
> to distract from the patch but is there a plan to get rid of this at
> some point?
>

I think unless we have BTF tags in GCC, it's not possible to drop this suffix
based tagging. Also not sure I remember/was part of the discussion you're
referring to.

> > +
> > +	return true;
> > +}
> > +
> > +static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
> > +					  const struct btf_param *arg,
> > +					  const char *name)
> > +{
> > +	int len, target_len = strlen(name);
> > +	const char *param_name;
> > +
> > +	param_name = btf_name_by_offset(btf, arg->name_off);
> > +	if (str_is_empty(param_name))
> > +		return false;
> > +	len = strlen(param_name);
> > +	if (len != target_len)
> > +		return false;
> > +	if (strcmp(param_name, name))
> > +		return false;
> > +
> > +	return true;
> > +}
>
> It doesn't look like this function has anything to do with the arg being
> a scalar, does it? Should we just rename it something like,
> "kfunc_arg_has_name()"?
>

The scalar_with_name was a suggestion from Alexei, but I think it's fine.
Since this already got applied not sure it's worth it now.

> > [...]
> > +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +	const char *func_name = meta->func_name, *ref_tname;
> > +	const struct btf *btf = meta->btf;
> > +	const struct btf_param *args;
> > +	u32 i, nargs;
> > +	int ret;
> > +
> > +	args = (const struct btf_param *)(meta->func_proto + 1);
>
> Not your change and it's fine to not block this cleanup on fixing an
> issue that's been in the verifier for a while, but it's unfortunate that
> we never built proper encapsulations for fetching params from the func
> proto. This is pretty brittle. A cleanup for another day...
>

This was just kept same as the older code, but we do have an accessor for this
case: btf_params (in include/linux/btf.h). I will roll it in with a few other
clean ups (or you can beat me to it).

> [...]
> > -	if (acq && !btf_type_is_struct_ptr(desc_btf, t)) {
> > +	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
> >  		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
> >  		return -EINVAL;
> >  	}
>
> Can you move this up to where we check is_kfunc_desctructive(),
> is_kfunc_sleepable(), etc to group logically similar code together?
>

I think I prefer it here, unlike those checks which apply to the kfunc, this is
located along with other checks for the return type, post argument processing.
But let me know if you think otherwise.
