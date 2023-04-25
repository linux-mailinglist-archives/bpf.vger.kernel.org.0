Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FBF6EEB0F
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjDYXqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 19:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjDYXqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:46:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C4EB1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:46:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66e7a52d3so49712555ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682466410; x=1685058410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZtryVy3MLXzNI9DhXIyRZGghnoksb16EGt0G+Vm9W80=;
        b=AYaZE9wkuc8AtQbl1E7KI6qy037mDXTN+g/FX5YRy1Wx2AZuhr3mlD3pISSZL3ZpHs
         m2o+9UC7Z+fwgIoYialQC57sE93jNAHtAOjYdrvQS4pTEIC1n671IfOw10A42bXO+Bjk
         vki6sMobe3uEnVKMpfgsW1li7SB4GimEx+WrKrxzWwnh8YrxY+bwa6g1Pj73Lll7IrBB
         xl2IQMMJ5vW9fQX8HUvLG6bYpcL8h2+zQvzs42Br6lqK1l3q3qxpP3mOyyzoEtmBDpVU
         F8QsEv1YoKF5GuZb4ZAdA4gAHwydWFjkbaoB17C764dMA70Z4dTW6funUeiBc5sRSf34
         OEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682466410; x=1685058410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtryVy3MLXzNI9DhXIyRZGghnoksb16EGt0G+Vm9W80=;
        b=DJ7dj9ZInkxS/aZ6aJMl7L5zcEn4DOqPmciupfFJejRV8AyeSEhzAy1UO9oRYEGx0m
         wzylcAdjya2/WhqSJRmyF3hMvysnGQF1zg5+edQYcmqpWYchn19hNTvrW8251hLnTUjf
         AakHzXKIqDxxo2P42SqQolw3HRYwovX6wRYX/mSzXD0uZiF6PO8ls/xktXOEJaFpemJY
         7hdfc6zGkS7njz4J1Vl3qd8XCFzBLD35NLBEpa50bxRMcngomKeN7BHYzIMZc5TBIXds
         VK0DWp8WV2A5G5LDTNsNkbrcPb2EwxNzmg+V2MkSazkSWd0BVwXL/zkbKK+BnZIfwW0S
         6NZw==
X-Gm-Message-State: AAQBX9eOZVs3cxFCkoeOlu6l2fowZWlNIivdM4QebPM92sVkUIrrHW8V
        j9qSMV38xQc1HG36dQVpXow=
X-Google-Smtp-Source: AKy350YObBLqFSKE4s5kc2n00lNkX012ue4g4ToK9tq4YsEXQuKAMLAtdvuHId7u/aFlUeui0Db86g==
X-Received: by 2002:a17:903:2444:b0:19e:6cb9:4c8f with SMTP id l4-20020a170903244400b0019e6cb94c8fmr24758137pls.41.1682466410406;
        Tue, 25 Apr 2023 16:46:50 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f9d6])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001a6dc4a98f9sm8771935plz.195.2023.04.25.16.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 16:46:49 -0700 (PDT)
Date:   Tue, 25 Apr 2023 16:46:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
Message-ID: <20230425234647.upbut3vz4g32yz6z@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com>
 <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
 <CAJnrk1Z_FQatT2-utcMR0NjwQt-3RWv6Vbr871fX8xCHE-buDA@mail.gmail.com>
 <CAADnVQJ_LGrfAFfcDKkx5nEAXQi19jKPhVJzK8nUX9u7WYf-hQ@mail.gmail.com>
 <CAJnrk1b5m+J77aVqMqruSX9X15jwrv+vibFGf5OMvSjcJ9Zxqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b5m+J77aVqMqruSX9X15jwrv+vibFGf5OMvSjcJ9Zxqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 10:05:32PM -0700, Joanne Koong wrote:
> On Sat, Apr 22, 2023 at 4:44 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 20, 2023 at 8:46 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Thu, Apr 20, 2023 at 11:38 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 20, 2023 at 12:14:10AM -0700, Joanne Koong wrote:
> > > > >       return obj;
> > > > > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > > > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > > >
> > > > I've missed this earlier.
> > > > Shouldn't we change all the existing dynptr kfuncs to be KF_TRUSTED_ARGS?
> > > > Otherwise when people start passing bpf_dynptr-s from kernel code
> > > > (like fuse-bpf is planning to do)
> > > > the bpf prog might get vanilla ptr_to_btf_id to bpf_dynptr_kern.
> > > > It's probably not possible right now, so not a high-pri issue, but still.
> > > > Or something in the verifier makes sure that dynptr-s are all trusted?
> > >
> > > In my understanding, the checks the verifier enforces for
> > > KF_TRUSTED_ARGS are that the reg->offset is 0 and the reg may not be
> > > null. The verifier logic does this for dynptrs currently, it enforces
> > > that reg->offset is 0 (in stack_slot_obj_get_spi()) and that the
> > > reg->type is PTR_TO_STACK or CONST_PTR_TO_DYNPTR (in
> > > check_kfunc_args() for KF_ARG_PTR_TO_DYNPTR case). But maybe it's a
> > > good idea to add the KF_TRUSTED_ARGS flag anyways in case more safety
> > > checks are added to KF_TRUSTED_ARGS in the future?
> >
> > Yeah. You're right.
> > The verifier is doing the same checks for dynptr and for trusted ptrs.
> > So adding KF_TRUSTED_ARGS to bpf_dynptr_adjust is not mandatory.
> > Maybe an opportunity to generalize the checks between
> > KF_ARG_PTR_TO_BTF_ID and KF_ARG_PTR_TO_DYNPTR.
> > But KF_TRUSTED_ARGS is necessary for bpf_dynptr_from_skb
> > otherwise old style ptr_to_btf_id skb can be passed in.
> >
> > For example the following passes test_progs:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index d9ce04ca22ce..abb14036b455 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -11718,6 +11718,7 @@ static int __init bpf_kfunc_init(void)
> >         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT,
> > &bpf_kfunc_set_skb);
> >         ret = ret ?:
> > register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL,
> > &bpf_kfunc_set_skb);
> >         ret = ret ?:
> > register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER,
> > &bpf_kfunc_set_skb);
> > +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > &bpf_kfunc_set_skb);
> >         return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> > &bpf_kfunc_set_xdp);
> >  }
> >  late_initcall(bpf_kfunc_init);
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > index b2fa6c47ecc0..bd8fbc3e04ea 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > @@ -4,6 +4,7 @@
> >  #include <string.h>
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> >  #include "bpf_misc.h"
> >  #include "bpf_kfuncs.h"
> >  #include "errno.h"
> > @@ -187,6 +188,15 @@ int test_skb_readonly(struct __sk_buff *skb)
> >         return 1;
> >  }
> >
> > +SEC("fentry/__kfree_skb")
> > +int BPF_PROG(test_skb, struct __sk_buff *skb)
> > +{
> > +       struct bpf_dynptr ptr;
> > +
> > +       bpf_dynptr_from_skb(skb, 0, &ptr);
> > +       return 0;
> > +}
> >
> > but shouldn't. skb in fentry is not trusted.
> > It's not an issue right now, because bpf_dynptr_from_skb()
> > is enabled for networking prog types only,
> > but BPF_PROG_TYPE_NETFILTER is already blending the boundary.
> > It's more networking than tracing and normal tracing should
> > be able to examine skb. dynptr allows to do it nicely.
> > Not a blocker for this set. Just something to follow up.
> 
> Ahh I see, thanks for the explanation. I'm trying to find where this
> happens in the code - i see the check in the verifier for
> is_trusted_reg() (when we call check_kfunc_args() for the
> KF_ARG_PTR_TO_BTF_ID case) so it seems like the skb ctx reg is trusted
> if it's been marked as either MEM_ALLOC or PTR_TRUSTED, and it's
> untrusted if it's not. But where does this get marked as PTR_TRUSTED
> for networking prog types?

is_trusted_reg() applies to PTR_TO_BTF_ID pointers.
For networking progs skb comes as PTR_TO_CTX which are implicitly trusted
and from safety pov equivalent to PTR_TO_BTF_ID | PTR_TRUSTED.
But tracing progs are different. Arguments of tp_btf progs
are also trusted, but fexit args are not. They're old legacy PTR_TO_BTF_ID
without flags. Neither PTR_TRUSTED nor PTR_UNTRUSTED.
The purpose of KF_TRUSTED_ARGS is to filter out such pointers.
