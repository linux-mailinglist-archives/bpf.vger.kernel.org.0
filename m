Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC26EBC1B
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDVXpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 19:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVXpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 19:45:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9825210A
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 16:45:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so4360272a12.0
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682207099; x=1684799099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/Bcvlm4r9NJrrlLyA+GRVfU9nRWOwxDywFj+l7uYBI=;
        b=ecaQvBomEVMv9nt1/cAJM6kyNcyqTKJGQBkgThLxO4plJkgbnz9V5zqD4pBwtu5F7J
         Lfsbr8BnW4LAu9wNrbbqxD2i0V+rm4FK6JLfegKhAbDFcN5BbaacQE0hOnTuRmlvdMuo
         1zjo7iarYOCRxhEhV447/rzhalwSzLVeVAedz8dJR5NmfMvWMq5zIVSxps2XidayRKCj
         vqbL55kpyxe5cSIb7nSqvcxEMQsCKOfCxihk2H2G3er/kZZ81wFEdeGq6QdCKHUFEfb9
         xvckeHQsxkuQG4NISNFdqVSY5pJzle8BzoXoExkatGtaDM708PxWh+rSRPTW8nY9YiEZ
         Ybpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682207099; x=1684799099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/Bcvlm4r9NJrrlLyA+GRVfU9nRWOwxDywFj+l7uYBI=;
        b=OJsADNX/OCD3WcY6VV16M6h+IfP9o0+blANP5VWKXgAy3PYeOULS7KQitR7YochRuJ
         OJevXR1psJW8E+O0XZCgiuvRfJWKlFsDa4rVRUSSoY/oafzB7OhFkcjQ5zkryBELfRh7
         oAEx/knXrR/i4NJEmNGWu5VPlSz8AhPMqJrER8FIZ4vfn1dP9E6cC/zULoI3v3VDlZBM
         a5L0EmTx7DDrGJbxHRX7dLfufRpYo+kTkiNyydnUYUlrS729Kj9Tqws5xExgsHfd7wtw
         mYF99QdKUeMXUsDqoIjBIH5TGW9MMittojsx22vL+CeLHWSAh28gQE5EibryZ4NwUuWI
         67CQ==
X-Gm-Message-State: AAQBX9eLReowJlV4k0mnmCqr2zLcIoKhJGesDYxOKMENAd6MuIMCVjE8
        0iqSRrvLoG7FTF1udkuLIrmHkDVWzUmCGbALyg6A9SMRyQg=
X-Google-Smtp-Source: AKy350ZpjTUx2+ADN/dNkAMM6kpj4qJ4q38bL+aLlK7t7ByLuM4NTOtpQ78bHpQRmKQ5PcZwt/OKaddcci07CWXp2Oc=
X-Received: by 2002:a05:6402:14c7:b0:506:9cdd:fc89 with SMTP id
 f7-20020a05640214c700b005069cddfc89mr8239626edx.34.1682207099025; Sat, 22 Apr
 2023 16:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com> <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
 <CAJnrk1Z_FQatT2-utcMR0NjwQt-3RWv6Vbr871fX8xCHE-buDA@mail.gmail.com>
In-Reply-To: <CAJnrk1Z_FQatT2-utcMR0NjwQt-3RWv6Vbr871fX8xCHE-buDA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 22 Apr 2023 16:44:47 -0700
Message-ID: <CAADnVQJ_LGrfAFfcDKkx5nEAXQi19jKPhVJzK8nUX9u7WYf-hQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Thu, Apr 20, 2023 at 8:46=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Thu, Apr 20, 2023 at 11:38=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 20, 2023 at 12:14:10AM -0700, Joanne Koong wrote:
> > >       return obj;
> > > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RE=
T_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >
> > I've missed this earlier.
> > Shouldn't we change all the existing dynptr kfuncs to be KF_TRUSTED_ARG=
S?
> > Otherwise when people start passing bpf_dynptr-s from kernel code
> > (like fuse-bpf is planning to do)
> > the bpf prog might get vanilla ptr_to_btf_id to bpf_dynptr_kern.
> > It's probably not possible right now, so not a high-pri issue, but stil=
l.
> > Or something in the verifier makes sure that dynptr-s are all trusted?
>
> In my understanding, the checks the verifier enforces for
> KF_TRUSTED_ARGS are that the reg->offset is 0 and the reg may not be
> null. The verifier logic does this for dynptrs currently, it enforces
> that reg->offset is 0 (in stack_slot_obj_get_spi()) and that the
> reg->type is PTR_TO_STACK or CONST_PTR_TO_DYNPTR (in
> check_kfunc_args() for KF_ARG_PTR_TO_DYNPTR case). But maybe it's a
> good idea to add the KF_TRUSTED_ARGS flag anyways in case more safety
> checks are added to KF_TRUSTED_ARGS in the future?

Yeah. You're right.
The verifier is doing the same checks for dynptr and for trusted ptrs.
So adding KF_TRUSTED_ARGS to bpf_dynptr_adjust is not mandatory.
Maybe an opportunity to generalize the checks between
KF_ARG_PTR_TO_BTF_ID and KF_ARG_PTR_TO_DYNPTR.
But KF_TRUSTED_ARGS is necessary for bpf_dynptr_from_skb
otherwise old style ptr_to_btf_id skb can be passed in.

For example the following passes test_progs:
diff --git a/net/core/filter.c b/net/core/filter.c
index d9ce04ca22ce..abb14036b455 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11718,6 +11718,7 @@ static int __init bpf_kfunc_init(void)
        ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT,
&bpf_kfunc_set_skb);
        ret =3D ret ?:
register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL,
&bpf_kfunc_set_skb);
        ret =3D ret ?:
register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER,
&bpf_kfunc_set_skb);
+       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
&bpf_kfunc_set_skb);
        return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
&bpf_kfunc_set_xdp);
 }
 late_initcall(bpf_kfunc_init);
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..bd8fbc3e04ea 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
 #include "errno.h"
@@ -187,6 +188,15 @@ int test_skb_readonly(struct __sk_buff *skb)
        return 1;
 }

+SEC("fentry/__kfree_skb")
+int BPF_PROG(test_skb, struct __sk_buff *skb)
+{
+       struct bpf_dynptr ptr;
+
+       bpf_dynptr_from_skb(skb, 0, &ptr);
+       return 0;
+}

but shouldn't. skb in fentry is not trusted.
It's not an issue right now, because bpf_dynptr_from_skb()
is enabled for networking prog types only,
but BPF_PROG_TYPE_NETFILTER is already blending the boundary.
It's more networking than tracing and normal tracing should
be able to examine skb. dynptr allows to do it nicely.
Not a blocker for this set. Just something to follow up.
