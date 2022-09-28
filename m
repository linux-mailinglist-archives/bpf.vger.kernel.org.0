Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158245EE993
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiI1Wr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI1Wr6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:47:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9310F728
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:47:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rk17so16837543ejb.1
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s3re6Nu7iVgiv3BqNvhilQcHLb3DI4siVjYK3jSY8vU=;
        b=WLzMGUvr8lQIwvIGjE8DNFFiSRJgckNhHmLLjvdsoexuNdS+EzH7OGRNcvY1jMSGte
         tLK0vKePBjgcDG4Fmnm5i7CrGKtvnD6P+kr+4o041uCILKrPdbFG2ZDCUNd8zp8tlJei
         mN1b3xk17bkhNi7ZMc8RsegKjSIUP8WDfP8J5k/TcOWHS+xZ+UFHvpXWxI4gZH1wrmzV
         lRZmngfr2pTypItBPYJ6ibeYwWbTrlw2Qp3rnEEtT6MwWI6RIGiq32PJ8o4dvwHsDpqS
         cPK5JkLDtNUHrJOnA3Kc5Nrp3y0+nUdGsL9HMm//b+pKDcd82DoaxAKw4KDxqai3GTjw
         YakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s3re6Nu7iVgiv3BqNvhilQcHLb3DI4siVjYK3jSY8vU=;
        b=xOea0AklH7z55LP0ky2FzwHcHUDvtZP6qC4VQ4pGSsJjUkIWZzOmLadkaLsorwntwQ
         qduyN8Ccv7rqWld69qC0ORcPbic8FuOt6BAcRF2QRibkMNbjm5/aAHKQMsP4gR8KWZuS
         SSf/JIF69AhJKVERmLIk/GPVcVtQGnHrrB5DHdF7sYOV7o4lzs/2jv1UuJ92YiAcdpZC
         IntMg530Z0RD/uEZzB67MZol4WCwvvS7OfPN1NBpAdf3DCR8GOhwYvawG2p8hIlOZ0TW
         ZrI+Z39niPMFtLAaigRwFJ0z5+pAsg10cV+wIEvVvPZBzahwbG6trbboZfUzl1AK+H4i
         QkRg==
X-Gm-Message-State: ACrzQf0Kdv/1wabN1TeK9qkrdBEu9hRjlZlqDPCa3i/T8V95JuKR95Zi
        50ENvg5vbuUJnXxxVkX6gmdtJlzl/MRTd+gZjA8=
X-Google-Smtp-Source: AMsMyM5puvoRtAAEBI4PIbHrcw9GOFD2I1MhRDx/6XrcG2kRupVsMhmSKAjXqZeFj2wnYm7lxUcKd8rke+mtFkasxew=
X-Received: by 2002:a17:907:72c1:b0:783:34ce:87b9 with SMTP id
 du1-20020a17090772c100b0078334ce87b9mr152936ejc.115.1664405275042; Wed, 28
 Sep 2022 15:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-8-joannelkoong@gmail.com> <CAP01T76YjXcxYsYue5Sxyp+Ppa3XR3nQq2nz8gV9VnWcD6Tdgg@mail.gmail.com>
In-Reply-To: <CAP01T76YjXcxYsYue5Sxyp+Ppa3XR3nQq2nz8gV9VnWcD6Tdgg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:47:43 -0700
Message-ID: <CAEf4BzawD+_buWqp_U3cu71QZH_OVTseuSUyEcva9qCd1=GQ-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: Add bpf_dynptr_iterator
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com
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

On Sun, Sep 18, 2022 at 5:08 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 8 Sept 2022 at 02:16, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add a new helper function, bpf_dynptr_iterator:
> >
> >   long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> >                            void *callback_ctx, u64 flags)
> >
> > where callback_fn is defined as:
> >
> >   long (*callback_fn)(struct bpf_dynptr *ptr, void *ctx)
> >
> > and callback_fn returns the number of bytes to advance the
> > dynptr by (or an error code in the case of error). The iteration
> > will stop if the callback_fn returns 0 or an error or tries to
> > advance by more bytes than available.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
>
> This is buggy as is.
>
> A user can just reinitialize the dynptr from inside the callback, and
> then you will never stop advancing it inside your helper, therefore an
> infinite loop can be constructed. The stack frame of the caller is
> accessible using callback_ctx.
>
> For example (modifying your selftest)
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
> b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index 22164ad6df9d..a9e78316c508 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -540,6 +540,19 @@ struct iter_ctx {
>
>  static int iter_callback(struct bpf_dynptr *ptr, struct iter_ctx *ctx)
>  {
> +       struct map_value *map_val;
> +       int key = 0;
> +
> +       map_val = bpf_map_lookup_elem(&array_map2, &key);
> +       if (!map_val) {
> +               return 0;
> +       }
> +
> +       *(void **)ptr = 0;
> +       *((void **)ptr + 1) = 0;
> +       bpf_dynptr_from_mem(map_val, 2, 0, ptr);
> +       return 1;
> +
>         if (ctx->trigger_err_erange)
>                 return bpf_dynptr_get_size(ptr) + 1;
>
> ... leads to a lockup.
>
> It doesn't have to be ringbuf_reserver_dynptr, it can just be
> dynptr_from_mem, which also gets around reference state restrictions
> inside callbacks.
>
> You cannot prevent overwriting dynptr stack slots in general. Some of
> them don't have to be released. It would be prohibitive for stack
> reuse.
>
> So it seems like you need to temporarily mark both the slots as
> immutable for the caller stack state during exploration of the
> callback.
> Setting some flag in r1 for callback is not enough (as it can reload
> PTR_TO_STACK of caller stack frame pointing at dynptr from
> callback_ctx). It needs to be set in spilled_ptr.

This sounds overcomplicated. We need a local copy of dynptr for the
duration of iteration and work with it. Basically internal
bpf_dynptr_clone(). See my other reply in this thread.

>
> Then certain operations modifying the view of the dynptr do not accept
> dynptr with that type flag set (e.g. trim, advance, init functions).
> While for others which only operate on the underlying view, you fold
> the flag (e.g. read/write/dynptr_data).
>
> It is the difference between struct bpf_dynptr *, vs const struct
> bpf_dynptr *, we need to give the callback access to the latter.
> I.e. it should still allow accessing the dynptr's view, but not modifying it.
>
> And at the risk of sounding like a broken record (and same suggestion
> as Martin in skb/xdp v6 set), the view's mutability should ideally
> also be part of the verifier's state. That doesn't preclude runtime
> tracking later, but there seems to be no strong motivation for that
> right now.

The unexpected NULL for bpf_dynptr_data() vs bpf_dynptr_data_rdonly()
argument from Martin is pretty convincing, I agree. So I guess I don't
mind tracking it statically at this point.

>
> >  include/uapi/linux/bpf.h       | 20 ++++++++++++++
> >  kernel/bpf/helpers.c           | 48 +++++++++++++++++++++++++++++++---
> >  kernel/bpf/verifier.c          | 27 +++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++
> >  4 files changed, 111 insertions(+), 4 deletions(-)
> >

please trim irrelevant parts

[...]
