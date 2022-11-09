Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01436236E3
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 23:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKIW6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 17:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKIW62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 17:58:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FD810E7
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 14:58:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l11so459836edb.4
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 14:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAykvIWURzfbG50+ww2b6A9Ao1Nb23pzix2NZITnOeQ=;
        b=oLfKpGjYP3At6KlaivVaPVcGRg7InLxkQDsRi35o9sjnB/v1Qn/Qu+i7W7nlLhYpml
         ozK3SQAKiCztrxYEyoZsbsfbgkQBu3yg9ZcUZEO9lrohwXyETRXlzed7ZC8ynZfpaY5e
         4NqOg5rfo7zoIAOUC55NGvG26NoHzV4RCFb7v0rDjuSpKBAWZunoNla+3y+bQXs1V2FZ
         UI5L33qBRw7wmLE6xUy7wOyxzCgY7mhhdnR3eeVHzIcQABSQvpsuPz19rWQXLnnHQ3V4
         nCc1O6VVlcygRgRhUK8PkasiMRNmWPknFbc0RwjwV6HVZO4BB69jbZSkxswK4GWvzUp7
         cC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAykvIWURzfbG50+ww2b6A9Ao1Nb23pzix2NZITnOeQ=;
        b=V1l1t8XQG8QuLEEWbtgJvR7i8Ie5kFqZKK9WHfIXcpQsKaI7U/DirTZMv8NMcq5IZv
         tutfBJzEveCPn3uSiDZA3YZYmLjNyO5kMXhm4xgzA1MGgh0gRehtdovqBC/AeJ9Ob54J
         higTn/q8uwCCC+eYhcJT+MT/4hwKaI3Ns3RdJIYrstMbZW+msiHFh1ev2ryJ6IePxVeU
         HeS1RWhioHyWDac2hePK6EBPWNQ5Wo/rLx3i54jhM9w5Oj4FOEumuA8udcBayejAysDd
         i+Bi02feorgP4Axjhb+FcWfVjt5rnhRQySWia5JtiqNzam1Vm+gRe29bzYZt2IqlOwKt
         Lb6Q==
X-Gm-Message-State: ACrzQf0f45kzr8LPITuJ3Pp8AeNF3vJrK7bkMo2SehBVzRKpGKnzz/TD
        Vcr8A5dl26zw3MPcxH01bF19heWi7/nG6JS2j6M=
X-Google-Smtp-Source: AMsMyM6sOxmo0rhpUveywHsqpKSq1y72zrkaw2o/3p5P2C7dAP2p1YtGt9jCO1lGCeiOq1gqD7tYU3LA5KKGarG6zvM=
X-Received: by 2002:aa7:d58f:0:b0:461:524f:a8f4 with SMTP id
 r15-20020aa7d58f000000b00461524fa8f4mr1244450edq.260.1668034704309; Wed, 09
 Nov 2022 14:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-6-memxor@gmail.com>
 <CAEf4BzZ180YJ+fbynJSR2fXXMVuKZTyginHyRdxydvOm-po7TA@mail.gmail.com>
 <20221108234901.erzrj2b6bsvqkzir@apollo> <CAEf4BzZJBeBr69QFdbj0L_76uViBsJJ1EzTiTFni+eUtTCG9mQ@mail.gmail.com>
 <CAADnVQJnHLu30fxj3rpzNNMDseJDk2Rs37e9PrqLQ3n=UEtZcQ@mail.gmail.com>
In-Reply-To: <CAADnVQJnHLu30fxj3rpzNNMDseJDk2Rs37e9PrqLQ3n=UEtZcQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 14:58:12 -0800
Message-ID: <CAEf4BzZ2rtdx2WVOzojCWA8-qPdTe1kCQXQvk5Lg7LypJ21SXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/25] bpf: Rename MEM_ALLOC to MEM_RINGBUF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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

On Tue, Nov 8, 2022 at 5:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 8, 2022 at 4:26 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 8, 2022 at 3:49 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Wed, Nov 09, 2022 at 04:44:16AM IST, Andrii Nakryiko wrote:
> > > > On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > >
> > > > > Currently, verifier uses MEM_ALLOC type tag to specially tag memory
> > > > > returned from bpf_ringbuf_reserve helper. However, this is currently
> > > > > only used for this purpose and there is an implicit assumption that it
> > > > > only refers to ringbuf memory (e.g. the check for ARG_PTR_TO_ALLOC_MEM
> > > > > in check_func_arg_reg_off).
> > > > >
> > > > > Hence, rename MEM_ALLOC to MEM_RINGBUF to indicate this special
> > > > > relationship and instead open the use of MEM_ALLOC for more generic
> > > > > allocations made for user types.
> > > > >
> > > > > Also, since ARG_PTR_TO_ALLOC_MEM_OR_NULL is unused, simply drop it.
> > > > >
> > > > > Finally, update selftests using 'alloc_' verifier string to 'ringbuf_'.
> > > > >
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > >
> > > > Ok, so you are doing what I asked in the previous patch, nice :)
> > > >
> > > > >  include/linux/bpf.h                               | 11 ++++-------
> > > > >  kernel/bpf/ringbuf.c                              |  6 +++---
> > > > >  kernel/bpf/verifier.c                             | 14 +++++++-------
> > > > >  tools/testing/selftests/bpf/prog_tests/dynptr.c   |  2 +-
> > > > >  tools/testing/selftests/bpf/verifier/ringbuf.c    |  2 +-
> > > > >  tools/testing/selftests/bpf/verifier/spill_fill.c |  2 +-
> > > > >  6 files changed, 17 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 2fe3ec620d54..afc1c51b59ff 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -488,10 +488,8 @@ enum bpf_type_flag {
> > > > >          */
> > > > >         MEM_RDONLY              = BIT(1 + BPF_BASE_TYPE_BITS),
> > > > >
> > > > > -       /* MEM was "allocated" from a different helper, and cannot be mixed
> > > > > -        * with regular non-MEM_ALLOC'ed MEM types.
> > > > > -        */
> > > > > -       MEM_ALLOC               = BIT(2 + BPF_BASE_TYPE_BITS),
> > > > > +       /* MEM points to BPF ring buffer reservation. */
> > > > > +       MEM_RINGBUF             = BIT(2 + BPF_BASE_TYPE_BITS),
> > > >
> > > > What do we gain by having ringbuf memory as additional modified flag
> > > > instead of its own type like PTR_TO_MAP_VALUE or PTR_TO_PACKET? It
> > > > feels like here separate register type is more justified and is less
> > > > error prone overall.
> > > >
> > >
> > > I'm not sure it's all that different. It only matters when checking argument
> > > during release. We want to ensure it came from ringbuf_reserve. That's all,
> > > apart from that it's no different from PTR_TO_MEM. In all other places it's
> > > folded and code for PTR_TO_MEM is used. Same idea as PTR_TO_BTF_ID | MEM_ALLOC.
> > >
> > > But I don't feel too strongly, so if you still think it's better I can make the
> > > switch.
> >
> > Not strongly, but I think having this as a flag is more error prone.
> > For cases where ringbuf memory should be treated just as memory, we
> > should use the same mechanism we have for MAP_VALUE. But I haven't
> > checked how we deal with MAP_VALUE, if that's a special case
> > everywhere, in addition to generic PTR_TO_MEM, then fine. But if
> > having PTR_TO_RINGBUF_MEM is converted to PTR_TO_MEM generically where
> > needed, I'd have dedicated PTR_TO_RINGBUF_MEM.
>
> I don't think we can or at least it's not as easy to generalize
> ringbuf mem as map_value.
> iirc MEM_ALLOC was there to make sure reserver->commit is the same mem.
> That's what MEM_RINGBUF will doing after this patch.

I'm not sure we are talking about the same thing. My only point was to
have RINGBUF_MEM as *base type* instead of as an *add-on flag*.
MAP_VALUE was an example of another special register type that is base
type but behaves like PTR_TO_MEM for helpers that don't care about
where specifically memory is coming from. I didn't mean to unify
RINGBUF_MEM and MAP_VALUE in any way (if that's what you are
proposing, I'm actually not sure exactly).

But as I said, no big deal with a flag, we can always change that in
the future as well.
