Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80B62FC26
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiKRSCw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiKRSCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:02:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA417617A
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:02:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x2so8239629edd.2
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQwe5hOIpQ95CdXIvE4BQL63fWx38sjQSc/r5uYQCLA=;
        b=lTu3zStQh9ZcYywX+ac11oKQhQJLnY1h3FWEfRhfF2ZfvsDw2Bo815evXDfzN4q2IE
         N2SK2Qa5XPPIprpV8TXrF7mSbSnrXlFaeC5AXP8bKGMzT0BMihfx3WkEqd5zZbbm6osK
         o/3qLsO6mXBM++7ouu5F9u3MPX2dLC5NqsMQNSDHnUt4+zWE+Ca30i+WuIizmAuW8xMm
         ztFtecySDuKUsSgjwZpAgJ13nDnscFMbT/KhZ+IX+62mYTOvkV4y3csQncIRBWBbl9km
         CV1sZfDuY8Al+ROYiqGfrUVm0A2UuS63FYlXIghqhH+bGJrZIl3mgWIjLuf8QahgxNa0
         VL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQwe5hOIpQ95CdXIvE4BQL63fWx38sjQSc/r5uYQCLA=;
        b=h5GFl+lFUJLFig16Kpu4oPglQobQKIDQ/L77IKFkOZRvudi9S0zhZ3FbDWhm/5WHqH
         HgGZN3ByDKjavv3hB5y7O/eQ32zB+au1/QmerPW0mSWSdzWYaMecHFAuuP5FNr7toIPL
         OhwhkVPtPW+R1cAROMi4WLtWvyPStYCDq5fSiAHuCCbbQ4n/4+9B25Ru2OCzuThsY5K0
         F5u18nPNZ2HtOoHV3w/yn3yF9dCfh52pjHAqLYkCiA4DMDmRvlq8DmdIeFEslXEfPnL4
         Szc8FNt2vOEadV9NUDGymmtnievSOxrfTH9G0qV1BY0mEkGbYml/Dgidor4VbUjrD+Dj
         vldw==
X-Gm-Message-State: ANoB5pkBcNxPV7RvXs9+C31S5NWBZpGf6ddeXIKeYtaTHgFgYCDRfDUg
        WjdQwRlBZsW7aHvyVFxmFWuWIYr4ygchHQlB5tg=
X-Google-Smtp-Source: AA0mqf6B57PDFUYICrhLYbw0JuoVHJHNo+Th6+yCgKa0egGGxhsr3cwsKz1lrdWb/oYhOPYaWwZMTqJCpvjtW/hEeyU=
X-Received: by 2002:a05:6402:389:b0:459:2515:b27b with SMTP id
 o9-20020a056402038900b004592515b27bmr7223292edv.338.1668794553104; Fri, 18
 Nov 2022 10:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20221118015614.2013203-1-memxor@gmail.com> <20221118015614.2013203-12-memxor@gmail.com>
 <20221118033415.vpy2v2ypb4c2n6cn@MacBook-Pro-5.local> <20221118103730.nbai3gzifkjk45eo@apollo>
In-Reply-To: <20221118103730.nbai3gzifkjk45eo@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Nov 2022 10:02:21 -0800
Message-ID: <CAADnVQLxkVKggTwXQJN48yvi4mh9o8qGoF4M4VGifHzygfq+cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, Nov 18, 2022 at 09:04:15AM IST, Alexei Starovoitov wrote:
> > On Fri, Nov 18, 2022 at 07:26:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > >  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >                                 const struct btf *btf, u32 func_id,
> > >                                 struct bpf_reg_state *regs,
> > >                                 bool ptr_to_mem_ok,
> > > -                               struct bpf_kfunc_arg_meta *kfunc_meta,
> > >                                 bool processing_call)
> >
> > Something odd here.
> > Benjamin added the processing_call flag in
> > commit 95f2f26f3cac ("bpf: split btf_check_subprog_arg_match in two")
> > and we discussed to remove it.
> >
> > >             } else if (ptr_to_mem_ok && processing_call) {
> >
> > since kfunc bit is gone from here the processing_call can be removed.
> > ptr_to_mem_ok and processing_call are two bool flags for the same thing, right?
> >
>
> I think so, I'll check it out and send a follow up patch.
>
> > > +static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
> >
> > I fixed this bit while applying.
> >
>
> Thanks.
>
> > > +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> >
> > This function looks much better now.
> > The split of kfunc vs helper was long overdue.
> > Thank you for doing this.
> >
> > I'm not convinced that KF_ARG_* is necessary, but it's much better than before.
> > So it's a step forward.
> >
>
> Yes. Eventually we should be merging checks for both helpers and kfuncs, but
> that needs more work and would have been out of scope for this set. We can
> probably synthesize a bpf_func_proto for the kfunc from BTF and then offload to
> check_helper_call.

Yeah. If kfunc BTFs plus KF_ flags can be synthesized to bpf_func_proto
that would be the best. If such conversion is possible then it
should be possible to do it in resolve_btfid in user space.

One more thing that I forgot to mention earlier.
Could you follow up with a patch to get rid of bpf_global_ma_set
check in the run-time and variable itself?
If bpf_mem_alloc_init fails the boot fails too.
If we're paranoid we can add:
special_kfunc_list[KF_bpf_obj_new_impl] = 0;
to bpf_mem_alloc_init() to prevent bpf_obj_new to ever be called.
