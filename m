Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5156EF99E
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjDZRun (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDZRun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 13:50:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91978E6D
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:50:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f6c285d22so1394485266b.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682531439; x=1685123439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaVGLSjmLHzK/ndyc9w/IEEHm/Kn1LiScFHeuEwVTr4=;
        b=DpSpmqFnVbD+qWRlbfumLhJpSR1nps0uKMjCDHRdngy1XIBxkjeK7ofSGNN0YHq7cP
         vevqrX8nFap8crBm5Qc0iV8CucXoDo7KVumP1qAT+G7L8dT75qRkfs4cecdzGDXot7T7
         C8WuN7liW4A5/E5PTueJ7X7n0cSux+Kj1U1DapKWakcO5jNOPI0MKwYb3V9ENwyl2SG4
         PvalDCHSgX3j8f0gTBUdTvs+CQgZ0dp3OliDqG7LNMkvLWhFlB7EjyrNvIC6I70NwRfc
         YiSkdh/H/2zvitItWPpWst2gB/MPlqhQewUozd348hXXjjzC/sOnFSWZwtKJq5viOmky
         oKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531439; x=1685123439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaVGLSjmLHzK/ndyc9w/IEEHm/Kn1LiScFHeuEwVTr4=;
        b=DqNF9tD7KL5g+YwipdvRXgynfy3s1EvxsEXeDfshJeNixeussywDvMMwlNDqUJtc9C
         He5SaSF0mcmDFVzw1zWjrp9QYER5yBER/4Gqm77kyAtVSIkT3KCLF9cfMV3u44t2EoHd
         N6itBOlhKSvaHxwxajrcfQeol03xmvVL1PfhkusFEnSEAQjQgkxYbH2tee/5W+jcbBMG
         5qXGwprnGDeQVMU8ZS7olJfQSITmz37ek+QrG5X0IjuLpLPofd8fiv4VGZOGfGHAKsbR
         eW0UDKrt1mZd/sm08KL8CzfE42kCFEDGpC01VGjVf9srvMoux+QlOAw4XcxinJiNySpE
         J4Lw==
X-Gm-Message-State: AAQBX9fkeYhBJep4YMblx0axbDD3JI/GQPgLxwDnk18zCG4MusBXiJRo
        7sFNoM7LXBlQF4+vjstknn+uZ3l/fuJtPU8kHTc=
X-Google-Smtp-Source: AKy350ZUCOq5H8tkIGmReq7Y1mhqxK31Eo1zkIPsUTLUfgS0/Xxy36p3fTbtLHiLLPCwhlbFurWlw+wpJxKQ2oWVjbc=
X-Received: by 2002:a05:6402:298:b0:506:965f:c8cf with SMTP id
 l24-20020a056402029800b00506965fc8cfmr18401127edv.34.1682531438787; Wed, 26
 Apr 2023 10:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com> <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
 <CAJnrk1Z_FQatT2-utcMR0NjwQt-3RWv6Vbr871fX8xCHE-buDA@mail.gmail.com>
 <CAADnVQJ_LGrfAFfcDKkx5nEAXQi19jKPhVJzK8nUX9u7WYf-hQ@mail.gmail.com>
 <CAJnrk1b5m+J77aVqMqruSX9X15jwrv+vibFGf5OMvSjcJ9Zxqw@mail.gmail.com> <20230425234647.upbut3vz4g32yz6z@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230425234647.upbut3vz4g32yz6z@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 10:50:27 -0700
Message-ID: <CAEf4Bza=ZGzALWsyLxBpEygJoy7viWjPW1-NbG7C6ZaOm_z8gA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 4:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 24, 2023 at 10:05:32PM -0700, Joanne Koong wrote:
> > On Sat, Apr 22, 2023 at 4:44=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 20, 2023 at 8:46=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Thu, Apr 20, 2023 at 11:38=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Apr 20, 2023 at 12:14:10AM -0700, Joanne Koong wrote:
> > > > > >       return obj;
> > > > > > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr,=
 KF_RET_NULL)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NU=
LL)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > > > > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > > > >
> > > > > I've missed this earlier.
> > > > > Shouldn't we change all the existing dynptr kfuncs to be KF_TRUST=
ED_ARGS?
> > > > > Otherwise when people start passing bpf_dynptr-s from kernel code
> > > > > (like fuse-bpf is planning to do)
> > > > > the bpf prog might get vanilla ptr_to_btf_id to bpf_dynptr_kern.
> > > > > It's probably not possible right now, so not a high-pri issue, bu=
t still.
> > > > > Or something in the verifier makes sure that dynptr-s are all tru=
sted?
> > > >
> > > > In my understanding, the checks the verifier enforces for
> > > > KF_TRUSTED_ARGS are that the reg->offset is 0 and the reg may not b=
e
> > > > null. The verifier logic does this for dynptrs currently, it enforc=
es
> > > > that reg->offset is 0 (in stack_slot_obj_get_spi()) and that the
> > > > reg->type is PTR_TO_STACK or CONST_PTR_TO_DYNPTR (in
> > > > check_kfunc_args() for KF_ARG_PTR_TO_DYNPTR case). But maybe it's a
> > > > good idea to add the KF_TRUSTED_ARGS flag anyways in case more safe=
ty
> > > > checks are added to KF_TRUSTED_ARGS in the future?
> > >
> > > Yeah. You're right.
> > > The verifier is doing the same checks for dynptr and for trusted ptrs=
.
> > > So adding KF_TRUSTED_ARGS to bpf_dynptr_adjust is not mandatory.
> > > Maybe an opportunity to generalize the checks between
> > > KF_ARG_PTR_TO_BTF_ID and KF_ARG_PTR_TO_DYNPTR.
> > > But KF_TRUSTED_ARGS is necessary for bpf_dynptr_from_skb
> > > otherwise old style ptr_to_btf_id skb can be passed in.
> > >
> > > For example the following passes test_progs:
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index d9ce04ca22ce..abb14036b455 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -11718,6 +11718,7 @@ static int __init bpf_kfunc_init(void)
> > >         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XM=
IT,
> > > &bpf_kfunc_set_skb);
> > >         ret =3D ret ?:
> > > register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL,
> > > &bpf_kfunc_set_skb);
> > >         ret =3D ret ?:
> > > register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER,
> > > &bpf_kfunc_set_skb);
> > > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACIN=
G,
> > > &bpf_kfunc_set_skb);
> > >         return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> > > &bpf_kfunc_set_xdp);
> > >  }
> > >  late_initcall(bpf_kfunc_init);
> > > diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > > b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > > index b2fa6c47ecc0..bd8fbc3e04ea 100644
> > > --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > > +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > > @@ -4,6 +4,7 @@
> > >  #include <string.h>
> > >  #include <linux/bpf.h>
> > >  #include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > >  #include "bpf_misc.h"
> > >  #include "bpf_kfuncs.h"
> > >  #include "errno.h"
> > > @@ -187,6 +188,15 @@ int test_skb_readonly(struct __sk_buff *skb)
> > >         return 1;
> > >  }
> > >
> > > +SEC("fentry/__kfree_skb")
> > > +int BPF_PROG(test_skb, struct __sk_buff *skb)
> > > +{
> > > +       struct bpf_dynptr ptr;
> > > +
> > > +       bpf_dynptr_from_skb(skb, 0, &ptr);
> > > +       return 0;
> > > +}
> > >
> > > but shouldn't. skb in fentry is not trusted.
> > > It's not an issue right now, because bpf_dynptr_from_skb()
> > > is enabled for networking prog types only,
> > > but BPF_PROG_TYPE_NETFILTER is already blending the boundary.
> > > It's more networking than tracing and normal tracing should
> > > be able to examine skb. dynptr allows to do it nicely.
> > > Not a blocker for this set. Just something to follow up.
> >
> > Ahh I see, thanks for the explanation. I'm trying to find where this
> > happens in the code - i see the check in the verifier for
> > is_trusted_reg() (when we call check_kfunc_args() for the
> > KF_ARG_PTR_TO_BTF_ID case) so it seems like the skb ctx reg is trusted
> > if it's been marked as either MEM_ALLOC or PTR_TRUSTED, and it's
> > untrusted if it's not. But where does this get marked as PTR_TRUSTED
> > for networking prog types?
>
> is_trusted_reg() applies to PTR_TO_BTF_ID pointers.
> For networking progs skb comes as PTR_TO_CTX which are implicitly trusted
> and from safety pov equivalent to PTR_TO_BTF_ID | PTR_TRUSTED.
> But tracing progs are different. Arguments of tp_btf progs
> are also trusted, but fexit args are not. They're old legacy PTR_TO_BTF_I=
D
> without flags. Neither PTR_TRUSTED nor PTR_UNTRUSTED.
> The purpose of KF_TRUSTED_ARGS is to filter out such pointers.

I need to do a thorough look at how FUSE BPF is using bpf_dynptr, but
I'd rather us starting strict and not allowing to pass bpf_dynptr as
PTR_TO_BTF_ID, at least right now until we can think this through
thoroughly. One fundamental aspect of current on the stack dynptr or
dynptr passed from user_ringbuf's drain helper is that we have a
guarantee that no one else besides program (on a single current
thread) can modify its state.

Anyways, I'd expect that if some kfunc accepts `struct bpf_dynptr` we
force that it's PTR_TO_DYNPTR_ID or PTR_TO_STACK register, at least
for now. If that's not the case right now, let's make sure it is?
