Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA44F1CA1
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382371AbiDDV2H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380163AbiDDTGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 15:06:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C3027CC0
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 12:04:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e16so19029869lfc.13
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMBfc7eL+6zjLdy0vSSw1qZlaczmxaLzkc9n5aXfXlk=;
        b=j5orvnr202OY0tbmNTqcYsXPmh8DqYP2lR2d4TxUKEIJhAOW+cyfNGVyk42mOtvwjt
         Qq2u/zxlYFYqCAYorKAclT35X3nldPvO1OMEFnM0a07jFJb288uJlPx28UXvHIeJtW3R
         XtYAQUz/brIkyJDSVxboelcbWa7s8m014zXph/GA3TSQpDVlwIOovrvQbeOPPnImLdSQ
         oQB/B3SQqVLK43/4DD7QHWK+pFnnQnHBo9W0p3aaJDasWbRBqXIlkUAqFUTzmvUvxpcb
         cqJJB3FjUeOvzrVAtfCcnhvTXSEWZEePej7n7gOTZQk1LbZJMSKkuNGpOVJm8Ox2F/ev
         oblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMBfc7eL+6zjLdy0vSSw1qZlaczmxaLzkc9n5aXfXlk=;
        b=yJuBQ6U0ULq5uEZK9UifArwM/DvgjBsC+NpIhIe0zJQtgJLtjK64pg1Rl11GYD2Lem
         MnwlqVInYAREYPJpnRPW+xswGQkZgCFfWXa65Bkx+M+WGCHUw8L+BGzvwTRUDTgD/b0t
         AWfloWbRyU0xd/U/MOwE19UX2iyz2lTRJanEHyb+T8QOArS3Kse9T1fHwq5OFVyUaNPY
         55GWiVTJdHrSuqNbWOIHeAaq5NJ61AAIYp+QhWEsrH40iOtRVHOQ97fdH5h6F3vjn4/9
         sKrqXh8F4qPwzr2wC+/flJvH197c+7P+y2Hu0JhU0lP9kJRg5KMzo8Ic2YSvHG13jVZ2
         mvnw==
X-Gm-Message-State: AOAM532u8GAhbxsJDEEwhD5XWXwGuFLfWU7dbs9KdGSz5AORiyLnxvoy
        SjEzQlACIr11Z9DMaDDMCdgZ5KfqzooN1hLdaLU=
X-Google-Smtp-Source: ABdhPJxn+CRsYZaukOxGftlFj13woBtDFAOsDIRsSGGz1DVoNAbeVCyD18lqr3Q7WVbcWbzMd+t2JK1QQ0ULi9NCTDo=
X-Received: by 2002:a05:6512:2311:b0:44b:4bb:3425 with SMTP id
 o17-20020a056512231100b0044b04bb3425mr644546lfu.288.1649099051489; Mon, 04
 Apr 2022 12:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-3-joannekoong@fb.com>
 <20220404073437.htzs76gxcm6cpert@apollo.legion>
In-Reply-To: <20220404073437.htzs76gxcm6cpert@apollo.legion>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 4 Apr 2022 12:04:00 -0700
Message-ID: <CAJnrk1ad_DtfgjskQ0Rkcmuk_A2TBYbGn2xcgz3dPuf-8cOkOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf: Add MEM_RELEASE as a bpf_type_flag
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 12:34 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Apr 02, 2022 at 07:28:21AM IST, Joanne Koong wrote:
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > Currently, we hardcode in the verifier which functions are release
> > functions. We have no way of differentiating which argument is the one
> > to be released (we assume it will always be the first argument).
> >
> > This patch adds MEM_RELEASE as a bpf_type_flag. This allows us to
> > determine which argument in the function needs to be released, and
> > removes having to hardcode a list of release functions into the
> > verifier.
> >
> > Please note that currently, we only support one release argument in a
> > helper function. In the future, if/when we need to support several
> > release arguments within the function, MEM_RELEASE is necessary
> > since there needs to be a way of differentiating which arguments are the
> > release ones.
> >
> > In the near future, MEM_RELEASE will be used by dynptr helper functions
> > such as bpf_free.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
[...]
> > @@ -6693,7 +6693,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                       return err;
> >       }
> >
> > -     if (is_release_function(func_id)) {
> > +     if (meta.ref_obj_id) {
>
> The meta.ref_obj_id field is set unconditionally whenever we see a
> reg->ref_obj_id, e.g. when we pass a refcounted argument to non-release
> function. Wouldn't making this conditional only on meta.ref_obj_id lead to
> release of that register now? Or did I miss some change above which prevents
> this case?
>
Yes, unfortunately you are right. This wouldn't work for the cases
where a refcounted arg is passed to a non-release function, since that
also sets the meta.ref_obj_id. Thanks for catching this!

> To make things clear, I'm talking of this sequence:
>
> p = acquire();
> helper_foo(p);   // meta.ref_obj_id would be set, and p is released
> release(p);      // error, as p.ref_obj_id has no reference state
>
> Besides, in my series this PTR_RELEASE / MEM_RELEASE tagging is only needed
> because the release function can take a NULL pointer, so we need to know the
> register of the argument to be released, and then make sure it is refcounted,
> otherwise it must be NULL (and whether NULL is permitted or not is checked
> earlier during argument checks). That doesn't seem to be true for bpf_free in
> your series, as it can only take ARG_PTR_TO_DYNPTR (but maybe it should also
> set PTR_MAYBE_NULL).
>
In the dynptr case, there will be several release-type functions (eg
bpf_free, bpf_ringbuf_discard, bpf_ringbuf_submit). The motivation
behind this patch was to have some way of signifying this instead of
having to specify in the verifier the particular functions. Please let
me know if this addresses your comment or if there's something in
between the lines in your reply that I'm missing


> >               err = release_reference(env, meta.ref_obj_id);
> >               if (err) {
> >                       verbose(env, "func %s#%d reference has not been acquired before\n",
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9aafec3a09ed..a935ce7a63bc 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
> >       .func           = bpf_sk_release,
> >       .gpl_only       = false,
> >       .ret_type       = RET_INTEGER,
> > -     .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> > +     .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | MEM_RELEASE,
> >  };
> >
> >  BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
> > --
> > 2.30.2
> >
>
> --
> Kartikeya
