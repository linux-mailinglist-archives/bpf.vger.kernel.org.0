Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6876EDB06
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDYFFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 01:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYFFq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 01:05:46 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D47EF1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 22:05:44 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fe2e39156so62402577b3.2
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682399143; x=1684991143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4NP/vn7C7QZ5EHPeV3lUYcFD2gXJrIxdSbZFhmjjuQ=;
        b=ox9kzEhPzxbo0Zg4SqlB3Vqcun/GjeeWOAQdnludXoL8ZYnPVpLcfM9nE2LLIvp+kf
         BRZLuc4uD+VU2fsc028T0qJfYGbKCkJNVTbDNuRUliPKLEFzQZ24UaRWlnwfan76NuNW
         iwFRfhSHjOc7LxppNQ6WlB/oJ+QoFP05kb7pW+kimY6V0Y8RJf7UhRdQaArnimb2gxxy
         kmm9XpvkhUwHZPxf+dlE71CJ6qTzgTFU7fi/F0KoZ79sAm/LLUF0Wf9lHhV8esAZ5KUA
         U8cdsoovfeQ95lQ8+b0u+uuErBpt5k8K0ITv+YqXcwVKTUUjQhbpveWb3/9ngeIxC6oB
         l3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682399143; x=1684991143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4NP/vn7C7QZ5EHPeV3lUYcFD2gXJrIxdSbZFhmjjuQ=;
        b=dwAMny9dPvuHyje/61SNBngwbQZM2LE0exGhPT5jwrxjj8iCYmRv2lGNjHAc5t+O6N
         vdjZDtDgOCmacOQrvWa/Itu2dgX/cszqqyTTmmLeNd95MzQkFIEErlMRk22bKWYHz46q
         dJVZoQAthcuoQeJEIsrln8tDiAzRIqEgI45TnPit3Cfh2qb7bKwCkzWxBk/uqC3nF2+o
         CSfv8plzXjQMTJhBGzEXOZcw8eTMkF7AjbkVcq4d0whJS8lFLGcUHbmLVUXdh9aLIeFT
         sBwotBg4bfAeMow2HkqGxP5xxm1zkstAB/gfQ/ERHm9FxIpJEFTEmWhQWWGH+X8Oytl8
         cdkA==
X-Gm-Message-State: AAQBX9e4BlhhysmX+4S60X1VO5fRNuW0MqAoQMX0ULySa/LQ4tw3sxdZ
        gbhja7LWZHLAbWEDoR1SnMmWTa3Fk+k+qqrZhLI=
X-Google-Smtp-Source: AKy350ZZz9/v7W79ZAnYzJMmfeEE2gb6bEgZT+yXatqZjpet1YOylbKBq5FKLdUMcKNKlzXNlV9Wg+0PmnRU3VW+UHM=
X-Received: by 2002:a0d:d753:0:b0:544:9cfb:72bb with SMTP id
 z80-20020a0dd753000000b005449cfb72bbmr9354676ywd.52.1682399143439; Mon, 24
 Apr 2023 22:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com> <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
 <CAJnrk1Z_FQatT2-utcMR0NjwQt-3RWv6Vbr871fX8xCHE-buDA@mail.gmail.com> <CAADnVQJ_LGrfAFfcDKkx5nEAXQi19jKPhVJzK8nUX9u7WYf-hQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ_LGrfAFfcDKkx5nEAXQi19jKPhVJzK8nUX9u7WYf-hQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 24 Apr 2023 22:05:32 -0700
Message-ID: <CAJnrk1b5m+J77aVqMqruSX9X15jwrv+vibFGf5OMvSjcJ9Zxqw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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

On Sat, Apr 22, 2023 at 4:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 20, 2023 at 8:46=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Thu, Apr 20, 2023 at 11:38=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 20, 2023 at 12:14:10AM -0700, Joanne Koong wrote:
> > > >       return obj;
> > > > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_=
RET_NULL)
> > > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> > > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > >
> > > I've missed this earlier.
> > > Shouldn't we change all the existing dynptr kfuncs to be KF_TRUSTED_A=
RGS?
> > > Otherwise when people start passing bpf_dynptr-s from kernel code
> > > (like fuse-bpf is planning to do)
> > > the bpf prog might get vanilla ptr_to_btf_id to bpf_dynptr_kern.
> > > It's probably not possible right now, so not a high-pri issue, but st=
ill.
> > > Or something in the verifier makes sure that dynptr-s are all trusted=
?
> >
> > In my understanding, the checks the verifier enforces for
> > KF_TRUSTED_ARGS are that the reg->offset is 0 and the reg may not be
> > null. The verifier logic does this for dynptrs currently, it enforces
> > that reg->offset is 0 (in stack_slot_obj_get_spi()) and that the
> > reg->type is PTR_TO_STACK or CONST_PTR_TO_DYNPTR (in
> > check_kfunc_args() for KF_ARG_PTR_TO_DYNPTR case). But maybe it's a
> > good idea to add the KF_TRUSTED_ARGS flag anyways in case more safety
> > checks are added to KF_TRUSTED_ARGS in the future?
>
> Yeah. You're right.
> The verifier is doing the same checks for dynptr and for trusted ptrs.
> So adding KF_TRUSTED_ARGS to bpf_dynptr_adjust is not mandatory.
> Maybe an opportunity to generalize the checks between
> KF_ARG_PTR_TO_BTF_ID and KF_ARG_PTR_TO_DYNPTR.
> But KF_TRUSTED_ARGS is necessary for bpf_dynptr_from_skb
> otherwise old style ptr_to_btf_id skb can be passed in.
>
> For example the following passes test_progs:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d9ce04ca22ce..abb14036b455 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11718,6 +11718,7 @@ static int __init bpf_kfunc_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT,
> &bpf_kfunc_set_skb);
>         ret =3D ret ?:
> register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL,
> &bpf_kfunc_set_skb);
>         ret =3D ret ?:
> register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER,
> &bpf_kfunc_set_skb);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> &bpf_kfunc_set_skb);
>         return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> &bpf_kfunc_set_xdp);
>  }
>  late_initcall(bpf_kfunc_init);
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
> b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index b2fa6c47ecc0..bd8fbc3e04ea 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -4,6 +4,7 @@
>  #include <string.h>
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
>  #include "bpf_kfuncs.h"
>  #include "errno.h"
> @@ -187,6 +188,15 @@ int test_skb_readonly(struct __sk_buff *skb)
>         return 1;
>  }
>
> +SEC("fentry/__kfree_skb")
> +int BPF_PROG(test_skb, struct __sk_buff *skb)
> +{
> +       struct bpf_dynptr ptr;
> +
> +       bpf_dynptr_from_skb(skb, 0, &ptr);
> +       return 0;
> +}
>
> but shouldn't. skb in fentry is not trusted.
> It's not an issue right now, because bpf_dynptr_from_skb()
> is enabled for networking prog types only,
> but BPF_PROG_TYPE_NETFILTER is already blending the boundary.
> It's more networking than tracing and normal tracing should
> be able to examine skb. dynptr allows to do it nicely.
> Not a blocker for this set. Just something to follow up.

Ahh I see, thanks for the explanation. I'm trying to find where this
happens in the code - i see the check in the verifier for
is_trusted_reg() (when we call check_kfunc_args() for the
KF_ARG_PTR_TO_BTF_ID case) so it seems like the skb ctx reg is trusted
if it's been marked as either MEM_ALLOC or PTR_TRUSTED, and it's
untrusted if it's not. But where does this get marked as PTR_TRUSTED
for networking prog types?
