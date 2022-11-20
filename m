Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2861A63158D
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKTRjn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTRjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 12:39:43 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356E1CB1B;
        Sun, 20 Nov 2022 09:39:41 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id c15so6101173qtw.8;
        Sun, 20 Nov 2022 09:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS6W8Uj2CHGPpGwY8BWid1qKNLVHTFW0WXbmUfuRRvA=;
        b=oGOEfLUr/4ppHKq95rwSeaN6c/SheIZRzLPmLSGOLP7wkkObIhfbRVGMd93eqgGJP7
         /v/7siu5BnKQpO9VpFtkc0XTxeaxfvpJSfBDG8TL+GWfBavdq+PP7WOwkOJj4NoD8+Fi
         a6obv6Fj9brBq2wmnCFhJc+mXjK+CrkvgmhjgWvNtI4L370hzmUMZPTWJ0ebfLet5ZQh
         AIm4OjKd67MeLd4mkg9Z8h/9Q3zTzR2BjdzZPiQvLmhU0vrfS72/ohbp2t1y8AlDtBp9
         +YUn9WIJk+qlBG7uFEN3Q4v4BP7HzKe6QObpu+mjBP+wlLUvZkZpCQ1BuCLHQfLe2RSN
         ouog==
X-Gm-Message-State: ANoB5pmO8VjloML721ITSjGYq6wOgv8zh0gWvHulXQ/amCMa1dNgQspC
        RwO3PXzHB93VvBmQLmFW7go=
X-Google-Smtp-Source: AA0mqf4rfb8iHYidBkc7xuxKIhMoA2+iDc2Nze/ktGesCpGlIE4N7o2V6PTQ0IyHXKTzUsDLk7Ty9g==
X-Received: by 2002:a05:622a:5989:b0:3a5:50fa:1a30 with SMTP id gb9-20020a05622a598900b003a550fa1a30mr14452371qtb.442.1668965980730;
        Sun, 20 Nov 2022 09:39:40 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006cbc00db595sm6725619qki.23.2022.11.20.09.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 09:39:39 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:39:44 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 2/4] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y3pmYKTKhdf69MPW@maniforge.lan>
References: <20221120051004.3605026-1-void@manifault.com>
 <20221120051004.3605026-3-void@manifault.com>
 <20221120172815.godn2rt22yk7j22z@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120172815.godn2rt22yk7j22z@macbook-pro-5.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 09:28:15AM -0800, Alexei Starovoitov wrote:
> On Sat, Nov 19, 2022 at 11:10:02PM -0600, David Vernet wrote:
> >  		case KF_ARG_PTR_TO_BTF_ID:
> >  			/* Only base_type is checked, further checks are done here */
> > -			if (reg->type != PTR_TO_BTF_ID &&
> > -			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> > -				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> > +			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
> > +			     bpf_type_has_unsafe_modifiers(reg->type)) &&
> > +			    !reg2btf_ids[base_type(reg->type)]) {
> > +				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
> > +				verbose(env, "expected %s or socket\n",
> > +					reg_type_str(env, base_type(reg->type) |
> > +							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
> ...
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > index 86d6fef2e3b4..3193915c5ee6 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -109,7 +109,7 @@
> >  	},
> >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >  	.result = REJECT,
> > -	.errstr = "arg#0 expected pointer to btf or socket",
> > +	.errstr = "arg#0 is ptr_or_null_ expected ptr_ or socket",
> 
> Nice.
> I missed the fact that reg_type_str() prints only the type.
> We see more verbose prints in print_verifier_state():
>   verbose(env, "%s", reg_type_str(env, t));
>   if (base_type(t) == PTR_TO_BTF_ID)
>           verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
> Since reg_type_str() prints into a buffer maybe we can enhance it with
> struct name printing too?

I like that, and we have a bit of extra space after bumping
TYPE_STR_BUF_LEN to 128 so why not. I'll take care of it in a follow-up
change.

> Not urgent.
> The set looks great. Applied.

Thanks!

> There is an odd arm64 failure in bonding test reported by CI, but looks unrelated.

Hmmm yeah, can't see how this change would have affected that. I'll keep
an eye on it in CI to see if it persists.
