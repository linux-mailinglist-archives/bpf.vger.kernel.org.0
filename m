Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F67623756
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKIXOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIXOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:14:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2DC64D6
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 15:14:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v17so482145edc.8
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 15:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBTYaMqujpg3uyM5IN6GW8j8os2XRtixjabFsG9R77k=;
        b=dyjCRyp14r5bCcfld9BI97GTv8evXuxrIV4rZ3nCAeqzzIVTe2b9PDGccQ4cSv0oHX
         lUcRZuKn2bC0av4T+yx02EZLdHeNe0CvpTBPoLZnd9wkudD7hb6JY/cEx7pfpRuCvM99
         9doX+93uiXfZnYi5fsh58r5mhXU3ja4WwUIOys6ngeQOSvifnJZtOuxbSa/3Z4kqJzMu
         zsJislWvHze29wQMRT9vLSSHtXhowjV0DxsDWHnbiNkbbUl68cei28Y7YTbsPDrbXlyx
         GxrqchlIoQ0tnI5BPMNFOfkSIpbu1iwq88Z8gCYCE0R04p37J3P3mx2J/DamSNhVvMJl
         ZEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBTYaMqujpg3uyM5IN6GW8j8os2XRtixjabFsG9R77k=;
        b=Rk4v4OV8sT+eOllx9f00t6zKF5uh52yYb1N0M0y0kUl2gBtbt3IZAbxH+wUMG7fik/
         oiIziEslF2oHRyRAgo/2RqIQBiKzBtr94bEHUi86/zJx2M2EdRPaod4PRFZZty5C5ATD
         hcEd8XCMKJr6D1OUi83H+WU+LRRl+6VIM235fl3MUMclQPdT09ESm5laMDOzhcCwzHDo
         zoehVUsmcxbndEiKGBqeEtUYfGmYoRlyNrmxNuizedakLy5LUyzUsHtYu98jaQhsh0re
         0kZqA5TyqG9qV9kyCXqhl0rEfnhSvN6YV/iT0x++iROjS6uI1hoqSQEJpwvkYcTnEbuT
         xKLg==
X-Gm-Message-State: ACrzQf3HhFCTH9N4m46cIaRzNpeLN8BJ/7c2LUT0YMS3f4gD1fV5y3qA
        Wk4pLKmJIqRHz2Rh0cU87JwcNCiyNK/WFMs684E=
X-Google-Smtp-Source: AMsMyM4K9vtXsZ8SosMEkY2V9mepSybqE2mBKGjnzqgDioPKI4b9KxFImG5tI/Ssb5I7pKAJn3fZHhj5FmVv/oWmcGM=
X-Received: by 2002:a05:6402:951:b0:459:aa70:d4b6 with SMTP id
 h17-20020a056402095100b00459aa70d4b6mr1248727edz.224.1668035654380; Wed, 09
 Nov 2022 15:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
 <20221108233944.o6ktnoinaggzir7t@apollo> <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
 <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com> <20221109164149.iri66bbgjrhjea62@apollo>
In-Reply-To: <20221109164149.iri66bbgjrhjea62@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 15:14:02 -0800
Message-ID: <CAEf4BzZL310efUG3xpm3hykVvQ=oY_UP15U0h7muhGN+K_hpsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map values
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Wed, Nov 9, 2022 at 8:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, Nov 09, 2022 at 06:33:25AM IST, Alexei Starovoitov wrote:
> > On Tue, Nov 8, 2022 at 4:23 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > > > >  struct bpf_offload_dev;
> > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > > index 94659f6b3395..dd381086bad9 100644
> > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > @@ -6887,6 +6887,16 @@ struct bpf_dynptr {
> > > > > >         __u64 :64;
> > > > > >  } __attribute__((aligned(8)));
> > > > > >
> > > > > > +struct bpf_list_head {
> > > > > > +       __u64 :64;
> > > > > > +       __u64 :64;
> > > > > > +} __attribute__((aligned(8)));
> > > > > > +
> > > > > > +struct bpf_list_node {
> > > > > > +       __u64 :64;
> > > > > > +       __u64 :64;
> > > > > > +} __attribute__((aligned(8)));
> > > > >
> > > > > Dave mentioned that this `__u64 :64` trick makes vmlinux.h lose the
> > > > > alignment information, as the struct itself is empty, and so there is
> > > > > nothing indicating that it has to be 8-byte aligned.
> >
> > Since it's not a new issue let's fix it for all.
> > Whether it's a combination of pahole + bpftool or just pahole.
> >
>
> Would it make sense to do that as a follow up? The selftest does work right now
> because I specified __attribute__((aligned(8))) manually for the variables.
>
> > > > >
> > > > > So what if we have
> > > > >
> > > > > struct bpf_list_node {
> > > > >     __u64 __opaque[2];
> > > > > } __attribute__((aligned(8)));
> > > > >
> > > > > ?
> > > > >
> > > >
> > > > Yep, can do that. Note that it's also potentially an issue for existing cases,
> > > > like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
> > > > things now is possible, but if it is, we should probably make it for all of
> > > > them?
> > >
> > > Why not? We are not removing anything or changing sizes, so it's
> > > backwards compatible.
> > > But I have a suspicion Alexei might not like
> > > this __opaque field, so let's see what he says.
> >
> > I prefer to fix them all at once without adding a name.
> >
> > >
> > > > > >                 off = vsi->offset;
> > > > > > +               if (i && !off)
> > > > > > +                       return -EFAULT;
> > > > >
> > > > > similarly, I'd say that either we'd need to calculate the exact
> > > > > expected offset, or just not do anything here?
> > > > >
> > > >
> > > > This thread is actually what prompted this check:
> > > > https://lore.kernel.org/bpf/CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com
> > > >
> > > > Unless loaded using libbpf all offsets are zero. So I think we need to reject it
> > > > here, but I think the same zero sized field might be an issue for this as well,
> > > > so maybe we remember the last field size and check whether it was zero or not?
> > > >
> > > > I'll also include some more tests for these cases.
> > >
> > > The question is whether this affects correctness from the verifier
> > > standpoint? If it does, there must be some other place where this will
> > > cause problem and should be caught and reported.
>
> The problem here is that if the BTF is incorrect like this, where you have same
> off for multiple items (bpf_spin_lock, bpf_list_head, etc.) like off=0 here,
> they essentially get the same offset in our btf_record array.
>
> I can check for it when appending items to the array (i.e. next offset must be
> atleast prev_off + prev_sz at the very minimum).

yes, that would be more correct, because you can still generate bad
BTF where you have different non-zero offsets, but overlapping
variables. Such a situation should be prevented anyways, right?

>
> >
> > If it's an issue with BTF then we should probably check it
> > during generic datasec verification.
> > Here it's kinda late to warn.
> >
>
> There's also a concern that clang produces this BTF by default. If you're not
> using libbpf as a loader, BTF that loaded previously will fail now (since
> DATASEC var offs are always 0 and we will complain during validation and return
> an error). Not sure what the impact will be, but just putting it out there.
>
> Let me know what should be better. In either case I'll add a test case.

So on one hand all BPF loaders like libbpf should be adjusting and
fixing such incomplete BTFs coming from Clang. On the other hand, we
can add such enforcements only if such special global variables are
present. I.e., if we care about DATASEC layout for correctness.
