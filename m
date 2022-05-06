Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9251E02A
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347889AbiEFUgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344781AbiEFUgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 16:36:11 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED516D39C
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 13:32:28 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id t16so6848599qtr.9
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 13:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVB1ciUIbxTMzEXFl6eq1tF4eC/Z0kXKOVSSlLEKtjE=;
        b=41nrgrm5Ow9A6Kh+tVC2atZgkYhIEaM37BZLmLyo87HYdKDWujjLyZcaOV3VM8yJ3n
         ajUZjTh5AqOpwu3Ssd1G774TU65SYUDaNoLj8EVYZkdgmVfCFnURUDOWKefatYOZ38vJ
         OKj9MLcH51/+kAZ6rBBWZST1B9lPyZ937+sK5+7tQR4NSv7Bh3kfDmkmN8+rbp3o6sQ/
         KIhRXFcyNfz84eGUXQkNF4hAB1ah8DGVQb7NOIkZfUpW8s8xa11KRblhVvtaUQIstszD
         T5vuir/noqnFm0UFYZbQn0S2RmPasknLKptywUj0ljkivCrLzOPkkp3joGtoxiRApknM
         fH+w==
X-Gm-Message-State: AOAM532vmQeXz4Kej65VOojyqpupd93rS0nIovOum/yZo4sZeMmw8vI9
        mIe73Gldj/cofHgaK0c8/H8=
X-Google-Smtp-Source: ABdhPJxBi20D9hQdxeDMczTv6yQAqmKyjGlKiwpM0X9zWyPaEa/FPOMchYRE7b6fJmwuPhNq4XaT3g==
X-Received: by 2002:a05:622a:104d:b0:2f3:bc09:f05 with SMTP id f13-20020a05622a104d00b002f3bc090f05mr4606569qte.396.1651869147021;
        Fri, 06 May 2022 13:32:27 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id r12-20020ac867cc000000b002f39b99f6b7sm3041911qtp.81.2022.05.06.13.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:32:26 -0700 (PDT)
Date:   Fri, 6 May 2022 13:32:24 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
Message-ID: <20220506203224.e7pdw3jk6kqpe7dh@dev0025.ash9.facebook.com>
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-2-joannelkoong@gmail.com>
 <20220506150727.73dvaiyf5rerggj3@dev0025.ash9.facebook.com>
 <CAJnrk1Yc7G9BamfcNDGXvhMbHcrebROxN97GPPNENJ9_vGF5XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Yc7G9BamfcNDGXvhMbHcrebROxN97GPPNENJ9_vGF5XA@mail.gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 06, 2022 at 12:09:37PM -0700, Joanne Koong wrote:
> I think the bpf philosophy leans more towards conflating related-ish
> patches into the same patchset. I think this patch could be its own
> stand-alone patchset, but it's also related to the dynptr patchset in that
> dynptrs need it to properly describe its initialization helper functions.
> I'm happy to submit this as its own patchset though if that is preferred :)

Totally up to you, if that's the BPF convention then that's fine with me.

> 
> > -     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> > > -                base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> > > +     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
> > >               if (type_may_be_null(arg_type) && register_is_null(reg))
> > >                       return 0;
> > >
> > > @@ -5811,7 +5801,7 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> > >                       verbose(env, "invalid map_ptr to access
> > map->value\n");
> > >                       return -EACCES;
> > >               }
> > > -             meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE);
> > > +             meta->raw_mode = arg_type & MEM_UNINIT;
> >
> > Given that we're stashing in a bool here, should this be:
> >
> >         meta->raw_mode = (arg_type & MEM_UNINIT) != 0;
> >
> I think just arg_type & MEM_UNINIT is okay because it implicitly converts
> from 1 -> true, 0 -> false. This is the convention that's used elsewhere in
> the linux codebase as well

Yeah I think functionally it will work just fine as is. I saw that a few
other places in verifier.c use operators that explicitly make the result 0
or 1, e.g.:

14699
14700         env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);

But the compiler will indeed implicitly convert any nonzero value to 1 if
it's stored in a bool, so it's not necessary for correctness. It looks like
the kernel style guide also implies that using the extra operators isn't
necessary, so I think we can leave it as you have it now:
https://www.kernel.org/doc/html/latest/process/coding-style.html#using-bool

> > What do you think about this as a possibly more concise way to express that
> > the curr and next args differ?
> >
> >         return (base_type(arg_curr) == ARG_PTR_TO_MEM) !=
> >                 arg_type_is_mem_size(arg_next);
> >
> I was trying to decide between this and the more verbose expression above
> and ultimately went with the more verbose expression because it seemed more
> readable to me. But I don't feel strongly :) I'm cool with either one

I don't feel strongly either, if you think your way is more readable then
don't feel obligated to change it.

Thanks,
David
