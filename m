Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD8623057
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKIQmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 11:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKIQl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 11:41:56 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F007C23BC9
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 08:41:55 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id o7so17234009pjj.1
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSGshsuSYN8Khd18l9SfQP3i4fSC3oR8W6yhg6ZPPoY=;
        b=DqcxBo4qOe+e/Gd484jHQZRfFb+1UQi0aU39Hvt6Q1VY2ZMQNtOq0MJY86tn5uEF12
         dWkVa+CSpDXmgKkku9lkvd8OXPT2eF4j+pTo05cOgxF3uyc+cOxnebyh6P7EtjJxjzZj
         hz/cQrFDjtnW6p9eSGQlNbPFoYr1dddH2URGKp5natGsn3ia/M0IIFTY+P/MVcd0Dwdh
         3gJfStS6d9E0rROP7Q6U63l1wwV55olwbLu4B5NrsHKOP4HUQ6QNc1kvrhAwahFgvP+0
         rjYVbGWfkdJfGiKmtM1shVQ/Xa59WJTOMsTmk35XV6FUoTYv80nV0sYTVB3OxDLScVOe
         OGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSGshsuSYN8Khd18l9SfQP3i4fSC3oR8W6yhg6ZPPoY=;
        b=atlPIrhbFFsP6VxGbQd4JIumYy7nCckjkuZ2TN6qDF0ZYV+nzZ6cdF2tzWShM142FH
         zhpvwU/4ONIVWpa3hC7mT7SUptKsonlstXHwB4TcCQO/LR/BNkCy9QTkM8IKQLqRIzYe
         Sy5xzFb518fT3vglpn+kMghYBFXeasuoA/Pt+Lqm+cfRkUO4xku+/38SE3IbgYImkuhN
         ZTZfSzPcDXeFWhRhvSD9T0Fz5hSluFsRDEcNISBXFW3qZw7Qk1B91cgcQpqOeejXAJgM
         pM4+d49F2emmRpVXI04sxNz9NAi67+NiPu4+sQTIIV1Z10fEPYt4WfJVPnkMt0EWkVXy
         Sz9A==
X-Gm-Message-State: ACrzQf1jqAvHgefF5xzwfiTVmc2srwF02klMkudCN0G00sUhb+Wfc1qk
        5GJQ14Goy+KNz7JImTqxrKE=
X-Google-Smtp-Source: AMsMyM4EcQCuSoZu5oJACXtpxzvjehivpzrULwzKQjex/7svL+uuVxdORVofEoMyts1DFtonqVU87g==
X-Received: by 2002:a17:902:c745:b0:186:b287:7d02 with SMTP id q5-20020a170902c74500b00186b2877d02mr62809376plq.87.1668012115417;
        Wed, 09 Nov 2022 08:41:55 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id n190-20020a6227c7000000b0056cea9530b6sm8481271pfn.202.2022.11.09.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:41:55 -0800 (PST)
Date:   Wed, 9 Nov 2022 22:11:49 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map
 values
Message-ID: <20221109164149.iri66bbgjrhjea62@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
 <20221108233944.o6ktnoinaggzir7t@apollo>
 <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
 <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 06:33:25AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 8, 2022 at 4:23 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > > >  struct bpf_offload_dev;
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index 94659f6b3395..dd381086bad9 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -6887,6 +6887,16 @@ struct bpf_dynptr {
> > > > >         __u64 :64;
> > > > >  } __attribute__((aligned(8)));
> > > > >
> > > > > +struct bpf_list_head {
> > > > > +       __u64 :64;
> > > > > +       __u64 :64;
> > > > > +} __attribute__((aligned(8)));
> > > > > +
> > > > > +struct bpf_list_node {
> > > > > +       __u64 :64;
> > > > > +       __u64 :64;
> > > > > +} __attribute__((aligned(8)));
> > > >
> > > > Dave mentioned that this `__u64 :64` trick makes vmlinux.h lose the
> > > > alignment information, as the struct itself is empty, and so there is
> > > > nothing indicating that it has to be 8-byte aligned.
>
> Since it's not a new issue let's fix it for all.
> Whether it's a combination of pahole + bpftool or just pahole.
>

Would it make sense to do that as a follow up? The selftest does work right now
because I specified __attribute__((aligned(8))) manually for the variables.

> > > >
> > > > So what if we have
> > > >
> > > > struct bpf_list_node {
> > > >     __u64 __opaque[2];
> > > > } __attribute__((aligned(8)));
> > > >
> > > > ?
> > > >
> > >
> > > Yep, can do that. Note that it's also potentially an issue for existing cases,
> > > like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
> > > things now is possible, but if it is, we should probably make it for all of
> > > them?
> >
> > Why not? We are not removing anything or changing sizes, so it's
> > backwards compatible.
> > But I have a suspicion Alexei might not like
> > this __opaque field, so let's see what he says.
>
> I prefer to fix them all at once without adding a name.
>
> >
> > > > >                 off = vsi->offset;
> > > > > +               if (i && !off)
> > > > > +                       return -EFAULT;
> > > >
> > > > similarly, I'd say that either we'd need to calculate the exact
> > > > expected offset, or just not do anything here?
> > > >
> > >
> > > This thread is actually what prompted this check:
> > > https://lore.kernel.org/bpf/CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com
> > >
> > > Unless loaded using libbpf all offsets are zero. So I think we need to reject it
> > > here, but I think the same zero sized field might be an issue for this as well,
> > > so maybe we remember the last field size and check whether it was zero or not?
> > >
> > > I'll also include some more tests for these cases.
> >
> > The question is whether this affects correctness from the verifier
> > standpoint? If it does, there must be some other place where this will
> > cause problem and should be caught and reported.

The problem here is that if the BTF is incorrect like this, where you have same
off for multiple items (bpf_spin_lock, bpf_list_head, etc.) like off=0 here,
they essentially get the same offset in our btf_record array.

I can check for it when appending items to the array (i.e. next offset must be
atleast prev_off + prev_sz at the very minimum).

>
> If it's an issue with BTF then we should probably check it
> during generic datasec verification.
> Here it's kinda late to warn.
>

There's also a concern that clang produces this BTF by default. If you're not
using libbpf as a loader, BTF that loaded previously will fail now (since
DATASEC var offs are always 0 and we will complain during validation and return
an error). Not sure what the impact will be, but just putting it out there.

Let me know what should be better. In either case I'll add a test case.
