Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857585845E5
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiG1ShF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiG1ShD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 14:37:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65656E891
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 11:37:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ez10so4539521ejc.13
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/Pog/QteASDyvYAiTVWA3IWEoDVpn6O2Kpqtko3DcU=;
        b=RrQgb9PO7rR7b0gbvLvETUFhqp2J12Ep0wmd3aOsr26Gk7uOVoEhIKcju2SEFOiAWS
         9pndNN2ZkIR8NMqHmulDPqpn4tPil+LTb8hl6+3JUbDarlUlLpkfh2IOB/Tx1/Vx8z8Q
         YUMBKN6E3zTiaSWDKl/0ycoJfhf6QIcfdXjJrSGNrbaWlzKlF0YmZGSK2iMt4JzRdRlw
         /LcfqlN+Hccum6T6O7XNTUxVHoQTqbcSnOxC/B8luElYaRWhi0gddo/o4t2ruVAge2uI
         oKuXSekcR4rAgbQREdJdPINtOhRdtSwWQjQHoPfFnyyNQ5CrLUtI+Do2JiXOgCACiPMB
         lVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/Pog/QteASDyvYAiTVWA3IWEoDVpn6O2Kpqtko3DcU=;
        b=v3QQirfolZ+E+Td14P2FjdZ7C8n8RYWrF2SnMLHP+lIWXZjLCqS3v2EH5zlO0i6Yg5
         gNL5QrImfOk4wsnh93VQpDYmr1WOYJNTlCwk+URY0Z0be+OYFkGyOVTi/Pmf6rUa7TRL
         jXCG/WdATqC+erwvpBQhFden2dV2o3v4TohXT5KE7VjJak+JgdT5tFZ8JqrI3qw+1LR8
         ZiKHvVOei/7nfFF+gwt90B5TQZUs1w2p5MMux1c+WR3vsrfEP1ZrYk5ibILgeQaDCYNe
         pjgpMvGksOkJrdY8d77D3HEj3mVdLajZPW6qiDo653ceBe2tWMqJCnqFXToMO/R4j11V
         3Law==
X-Gm-Message-State: AJIora84lbZxxin8JQqV2HNEOkDdvCHWKXcsFcxshaJy0hmK4hs6HtWq
        bg9bHWpZktmC9O8Fl4ud2HkneDax7lKt3U1VKZY=
X-Google-Smtp-Source: AGRyM1smGMPejSHyZGISIpLd0sN33BFLsF4hxDG+NukFfSPt66o6kegFG1xLGJzuhrAIMWE41hOs5//jDJKZ84oggZk=
X-Received: by 2002:a17:907:7d8b:b0:72f:2306:329a with SMTP id
 oz11-20020a1709077d8b00b0072f2306329amr160449ejc.369.1659033421318; Thu, 28
 Jul 2022 11:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <CA+khW7jBsY+N798Rgu5KoHW49zC_MN66LQE++mqn12HJ2hfHqQ@mail.gmail.com>
In-Reply-To: <CA+khW7jBsY+N798Rgu5KoHW49zC_MN66LQE++mqn12HJ2hfHqQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 28 Jul 2022 11:36:49 -0700
Message-ID: <CAJnrk1YfM8sVFWkfEWCsifu78VyOGDpHr7WKMm7afbSnjJGRiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Thu, Jul 28, 2022 at 10:45 AM Hao Luo <haoluo@google.com> wrote:
>
> Hi, Joanne,
>
> On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add skb dynptrs, which are dynptrs whose underlying pointer points
> > to a skb. The dynptr acts on skb data. skb dynptrs have two main
> > benefits. One is that they allow operations on sizes that are not
> > statically known at compile-time (eg variable-sized accesses).
> > Another is that parsing the packet data through dynptrs (instead of
> > through direct access of skb->data and skb->data_end) can be more
> > ergonomic and less brittle (eg does not need manual if checking for
> > being within bounds of data_end).
> >
> > For bpf prog types that don't support writes on skb data, the dynptr is
> > read-only (writes and data slices are not permitted). For reads on the
> > dynptr, this includes reading into data in the non-linear paged buffers
> > but for writes and data slices, if the data is in a paged buffer, the
> > user must first call bpf_skb_pull_data to pull the data into the linear
> > portion.
> >
> > Additionally, any helper calls that change the underlying packet buffer
> > (eg bpf_skb_pull_data) invalidates any data slices of the associated
> > dynptr.
> >
> > Right now, skb dynptrs can only be constructed from skbs that are
> > the bpf program context - as such, there does not need to be any
> > reference tracking or release on skb dynptrs.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            |  8 ++++-
> >  include/linux/filter.h         |  4 +++
> >  include/uapi/linux/bpf.h       | 42 ++++++++++++++++++++++++--
> >  kernel/bpf/helpers.c           | 54 +++++++++++++++++++++++++++++++++-
> >  kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++----
> >  net/core/filter.c              | 53 ++++++++++++++++++++++++++++++---
> >  tools/include/uapi/linux/bpf.h | 42 ++++++++++++++++++++++++--
> >  7 files changed, 229 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 20c26aed7896..7fbd4324c848 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -407,11 +407,14 @@ enum bpf_type_flag {
> >         /* Size is known at compile time. */
> >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +       /* DYNPTR points to sk_buff */
> > +       DYNPTR_TYPE_SKB         = BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >         __BPF_TYPE_FLAG_MAX,
> >         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> >  };
> >
> > -#define DYNPTR_TYPE_FLAG_MASK  (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF)
> > +#define DYNPTR_TYPE_FLAG_MASK  (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB)
> >
>
> I wonder if we could maximize the use of these flags by combining them
> with other base types, not just DYNPTR. For example, does TYPE_LOCAL
> indicate memory is on stack? If so, can we apply LOCAL on PTR_TO_MEM?
> If we have PTR_TO_MEM + LOCAL, can it be used to replace PTR_TO_STACK
> in some scenarios?
>
> WDYT?

Hi Hao. I love the idea but unfortunately I don't think it applies
neatly in this case. "local" in the context of dynptrs means memory
that is local to the bpf program (eg includes not just memory on the
stack).

>
> >  /* Max number of base types. */
> >  #define BPF_BASE_TYPE_LIMIT    (1UL << BPF_BASE_TYPE_BITS)
> > @@ -2556,12 +2559,15 @@ enum bpf_dynptr_type {
> >         BPF_DYNPTR_TYPE_LOCAL,
> >         /* Underlying data is a ringbuf record */
> >         BPF_DYNPTR_TYPE_RINGBUF,
> > +       /* Underlying data is a sk_buff */
> > +       BPF_DYNPTR_TYPE_SKB,
> >  };
> >
> <...>
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > --
> > 2.30.2
> >
