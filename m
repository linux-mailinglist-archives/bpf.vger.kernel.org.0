Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0358A2EF
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiHDVza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbiHDVz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:55:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0013F26
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 14:55:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e13so1238083edj.12
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnTtHPUlTuUcTBiVFV4AkAseSUfZM3l9BOJP7dLKA9I=;
        b=UuUqTq4yKHxM3QniVqd3N216GfI9SIlGM7cozLRkzaNORfYujGyHea4Ya9EolTznBH
         MHfE4qeOvK3RJOO6vE8UH26UtDMRnoPdUq9LZwxNqK2iqH9n3rXoyDovkcRLQfMR3M1R
         xEPzQWxDAkefUwcoDs5tZWt8oxiWJqnBnmp2Ez2gDsG6SL1XXYVbLW33nJEA5gV9wvaD
         7sFc0EsguihS+bfkKmf14iYyPjqCGw5KzIAnqvtRga7WQMWWL5TD/ssfO9ajE29/SmKw
         C8EpaLMLURidU+sXv5ZUc+/7+KUz8iv2d6NEbpbqGBZYz7QLKwP+KR2Yskx4b2Iuw4Mq
         UV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnTtHPUlTuUcTBiVFV4AkAseSUfZM3l9BOJP7dLKA9I=;
        b=xN2EQVKf87ax4PLULGHIzg2O5Q/qUsanx1yYLYrDcmvFbCcOyDQC1tEYV5+U2UWpms
         7R4EQxWOmTxLBVz8tbqu1nPKPqLCk0Afm3jiLZt23LIvOF3DEtPkz3t+LNCiwISYfrK1
         EK2/E5XlAbe/o/opk2DUthc+fePnJwMSWnpK8IbKMyskXlKHsdPJdwBTTq7oUD7+yTk+
         eIKzoxcKQP+vCh6c9WGEzbeSyg0TUSQYECb+VJRvNhbWnft3j3yWaikApvWVQFygt+hc
         MVl9U9DL4+DdTVVOkN86lZlXbML+MWKIMHEKTD2Vonm7j6uZsmxCydbAih1U6TSWoIFJ
         jk/g==
X-Gm-Message-State: ACgBeo3s6QrGFq8M6zXMRSOF7AUH71DxRI6qnxNpI5TODS6ieOxaPet/
        JN/U66OtNhe5f2hUbYzCPEvkfWTkr2Ww8xkex+0=
X-Google-Smtp-Source: AA6agR5rO/YJZqHHZujLMz+4oqYenuMA/1w6LDOkHT+zQWKDDwwtnR/NyfPjCIqUed4PeCKgzzrH0oFjypm/11D1QSQ=
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id
 d19-20020a50fb13000000b0043cef2b0d29mr3994890edq.378.1659650126037; Thu, 04
 Aug 2022 14:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220801163349.4a28d154@kernel.org>
 <CAJnrk1bow8je9VkTAQHiOOPQLWGDg1uDqDRN+tr43bMYtTSGjw@mail.gmail.com>
In-Reply-To: <CAJnrk1bow8je9VkTAQHiOOPQLWGDg1uDqDRN+tr43bMYtTSGjw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 4 Aug 2022 14:55:14 -0700
Message-ID: <CAJnrk1aq719=e07tP2Udn3FVXgzMdsPgyQ9KUp2GK=E=paZEzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
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

On Mon, Aug 1, 2022 at 7:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 4:33 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > (consider cross-posting network-related stuff to netdev@)
>
> Great, I will start cc-ing netdev@
>
> >
> > On Tue, 26 Jul 2022 11:47:04 -0700 Joanne Koong wrote:
> > > Add skb dynptrs, which are dynptrs whose underlying pointer points
> > > to a skb. The dynptr acts on skb data. skb dynptrs have two main
> > > benefits. One is that they allow operations on sizes that are not
> > > statically known at compile-time (eg variable-sized accesses).
> > > Another is that parsing the packet data through dynptrs (instead of
> > > through direct access of skb->data and skb->data_end) can be more
> > > ergonomic and less brittle (eg does not need manual if checking for
> > > being within bounds of data_end).
> >
> > Is there really a need for dynptr_from_{skb,xdp} to be different
> > function IDs? I was hoping this work would improve portability of
> > networking BPF programs across the hooks.
>
> Awesome, I like this idea of having just one generic API named
> something like bpf_dynptr_from_packet. I'll add this for v2!
>

Thinking about this some more, I don't think we get a lot of benefits
from combining it into one API (bpf_dynptr_from_packet) instead of 2
separate APIs (bpf_dynptr_from_skb / bpf_dynptr_from_xdp). The
bpf_dynptr_write behavior will be inconsistent (eg bpf_dynptr_write
into xdp frags will work whereas bpf_dynptr_write into skb frags will
fail). Martin also pointed out that he'd prefer bpf_dynptr_write() to
succeed for writing into frags and invalidate data slices (instead of
failing the write and always keeping data slices valid), which we
can't do if we combine xdp + skb, without always (needlessly)
invalidating xdp data slices whenever there's a write. Additionally,
in the verifier, there's no organic mapping between prog type -> prog
ctx, so we'll have to hardcode some mapping between prog type -> skb
vs. xdp ctx. I think for these reasons it makes more sense to have 2
separate APIs, instead of having 1 API that both hooks can call.

> >
> > > For bpf prog types that don't support writes on skb data, the dynptr is
> > > read-only (writes and data slices are not permitted). For reads on the
> > > dynptr, this includes reading into data in the non-linear paged buffers
> > > but for writes and data slices, if the data is in a paged buffer, the
> > > user must first call bpf_skb_pull_data to pull the data into the linear
> > > portion.
> > >
> > > Additionally, any helper calls that change the underlying packet buffer
> > > (eg bpf_skb_pull_data) invalidates any data slices of the associated
> > > dynptr.
> >
> > Grepping the verifier did not help me find that, would you mind
> > pointing me to the code?
>
> The base reg type of a skb data slice will be PTR_TO_PACKET - this
> gets set in this patch in check_helper_call() in verifier.c:
>
> + if (func_id == BPF_FUNC_dynptr_data &&
> +    meta.type == BPF_DYNPTR_TYPE_SKB)
> + regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
>
> Anytime there is a helper call that changes the underlying packet
> buffer [0], the verifier iterates through the registers and marks all
> PTR_TO_PACKET reg types as unknown, which invalidates them. The dynptr
> data slice will be invalidated since its base reg type is
> PTR_TO_PACKET
>
> The stack trace is:
>    check_helper_call() -> clear_all_pkt_pointers() ->
> __clear_all_pkt_pointers() -> mark_reg_unknown()
>
>
> I will add this explanation to the commit message for v2 since it is non-obvious
>
>
> [0] https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L7143
>
> [1] https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L6489
>
>
> >
> > > Right now, skb dynptrs can only be constructed from skbs that are
> > > the bpf program context - as such, there does not need to be any
> > > reference tracking or release on skb dynptrs.
