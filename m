Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0586F6039BC
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJSGZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJSGZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 02:25:18 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847784F6B3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:25:17 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so19482408fac.11
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgIDicRund6sZhUM3OXCikDozuVkkEI9VOExs76EPEI=;
        b=L10Z16x4HDCvsM4tHTZccJcdnbw0SlSV73NKSvpkbZlCYGarnvrxhhLpuZ8piewVUf
         kLXBpELjRcmwGHnzZj7uM41O06qwEPt9M8NuGTE9wF9XQjPkwHALB2HG/c1JpSCJpEG1
         oJx05R247NDeGpwz7h+bXO5W9igrZMCUvgudNbYICL8cXF5aSHt0ICrsXpBPDo6WZ68G
         mRMPVZJ+9tMNmDHwxRfhmBsK2/M0IeDMwmh5Y4Qjzn4hRSFJCyg9WJNu6O0NJPsLwlCV
         2L9Q3ISOrF6szlCKzf0eoRqkYqeuRVQqu76G72dOMDOv+HUpo7dQ7B5N7VMMsYejpWl3
         J3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgIDicRund6sZhUM3OXCikDozuVkkEI9VOExs76EPEI=;
        b=2Swi+FyRSd2CvIYiDSTV9hEAGqj8oApGFmjSzNNLUqbS5cEUXMtXuEfAlHe6X4/Qif
         WCLQjeOHcFbVzdfEHGc+w0t4tnG495mUD/7fa+KuuGja9xepaLBgZ9zvU9w0BmtmFQre
         Dk9rzFzbKLPBy+EaV9zsEmCL0mlVFaMI/6akKDRSLfJ/mdSAFBUi0lIyUicpUkEfrPWa
         Pe44pQSzVjrkgReLLWxtPur4IZh7od9IOJ5eT9l5a8rennEfprOcueYjCGDbpfOpcPk3
         A/0c4O1AbizL35SIwUXW1VD06WUInXi2SayMehLgRBjGs8WsZxGQecd0BfXdrDYjer0o
         iZFg==
X-Gm-Message-State: ACrzQf2uL8dkjICNveQXNrdGWgbMLdKWm1qa1JU3X1H+t6deFhdZaaU1
        Wk6Z2e0CR1jmOmMSSrrvltMQcjq+CeX62Q==
X-Google-Smtp-Source: AMsMyM5pNX8s9qc838RDFJT8r5VJt7JQFJEMvnJ1NlyoTkthLiJEKbPQkLFmh/oWez4YsxWkAVjKIw==
X-Received: by 2002:a17:90b:4c52:b0:20d:7917:4cb3 with SMTP id np18-20020a17090b4c5200b0020d79174cb3mr43758750pjb.6.1666160706289;
        Tue, 18 Oct 2022 23:25:06 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00181e55d02dcsm9782896pla.139.2022.10.18.23.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:25:05 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:54:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 04/13] bpf: Rework check_func_arg_reg_off
Message-ID: <20221019062451.z7ho6keovbjsn7wv@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-5-memxor@gmail.com>
 <Y08gyUs+HCBYw0Q5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08gyUs+HCBYw0Q5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 03:25:21AM IST, sdf@google.com wrote:
> On 10/18, Kumar Kartikeya Dwivedi wrote:
> > While check_func_arg_reg_off is the place which performs generic checks
> > needed by various candidates of reg->type, there is some handling for
> > special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> > ARG_PTR_TO_ALLOC_MEM.
>
> > This commit aims to streamline these special cases and instead leave
> > other things up to argument type specific code to handle.
>
> > This is done primarily for two reasons: associating back reg->type to
> > its argument leaves room for the list getting out of sync when a new
> > reg->type is supported by an arg_type.
>
> > The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> > we already handle, whenever a release argument is expected, it should
> > be passed as the pointer that was received from the acquire function.
> > Hence zero fixed and variable offset.
>
> > There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> > its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> > with non-zero offset to other helper functions, which makes sense.
>
> > Hence, lift the arg_type_is_release check for reg->off and cover all
> > possible register types, instead of duplicating the same kind of check
> > twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).
>
> > Finally, for the release argument, arg_type_is_dynptr is the special
> > case, where we go to actual object being freed through the dynptr, so
> > the offset of the pointer still needs to allow fixed and variable offset
> > and process_dynptr_func will verify them later for the release argument
> > case as well.
>
> > Finally, since check_func_arg_reg_off is meant to be generic, move
> > dynptr specific check into process_dynptr_func.
>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   kernel/bpf/verifier.c                         | 55 +++++++++++++++----
> >   .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
> >   2 files changed, 44 insertions(+), 13 deletions(-)
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a49b95c1af1b..a8c277e51d63 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5654,6 +5654,14 @@ int process_dynptr_func(struct bpf_verifier_env
> > *env, int regno,
> >   		return -EFAULT;
> >   	}
>
> > +	/* CONST_PTR_TO_DYNPTR has fixed and variable offset as zero, ensured by
> > +	 * check_func_arg_reg_off, so this is only needed for PTR_TO_STACK.
> > +	 */
> > +	if (reg->off % BPF_REG_SIZE) {
> > +		verbose(env, "cannot pass in dynptr at an offset\n");
> > +		return -EINVAL;
> > +	}
>
> This is what I'm missing here and in the original code as well, maybe you
> can clarify?
>
> "if (reg->off & BPF_REG_SIZE)" here vs "if (reg->off)" below. What's the
> difference?
>

That second one happens earlier in check_func_arg_reg_off, this check happens
later.

Usually when we have release arguments, we want pointer to object unmodified.
So the fixed and variable offset must be 0. The check_func_arg_reg_off checks
ensure that. But PTR_TO_STACK in case of dynptr release functions point to the
dynptr object on the stack which has to be released.

In this case fp will have some fixed offset. So we make an exception for it and
fallback to normal checks for PTR_TO_STACK.

Later when we come here, we reach the function for two kinds of registers,
CONST_PTR_TO_DYNPTR and PTR_TO_STACK. PTR_TO_STACK reg->off must be aligned
to 8-byte alignment since we want to find stack slot index (each representing 8
byte slot) of the dynptr to operate on it.

For CONST_PTR_TO_DYNPTR it directly points to dynptr with 0 offset, which
check_func_arg_reg_off already ensures for it.

Note that this reg->off check is actually broken, the correct one is in patch 6
which takes into account the variable offset.

You can consider check_func_arg_reg_off to only do high level checks which are
common for all helpers, and later processing builds upon those guarantees and
does further checking.
