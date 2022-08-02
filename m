Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF25874C1
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 02:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHBAPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 20:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBAPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 20:15:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502167659
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 17:15:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so23191537ejc.7
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 17:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0Gfgl0uOdov+c/45H6mS/xzIAw2syYs+lj9FOpahv4=;
        b=FBoHOE4ANsVWiFcJgmz3rwzy8IkNlDidzHBLH9ITke5Wm8p3bu+t3BeQsvz17ApjEL
         019SjUYoVWCdzX1srWXOb8C2KrwvMi/cWCQWa6n+xh9oOttC2K8BE/3SC8w5hIgX0d8r
         wOdHrAvY4LAY2h4iQ7a0W5uBQzQ94hkkD+rA8jval7s1gcQkxyFGusbeRHdnVzYiajts
         OtVDJ0YqQNHUCyHWyctqguncAqC26Fph3yvUlCqY83KqeiC0tQmiEkOA3/7ZbO+vounw
         Nn5+3PYasxCMTMJftKl/1KciZqBNoiw/JJ/+fsA6d97PKY1+Vy6AHufBv9YgPtTuH+We
         YTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0Gfgl0uOdov+c/45H6mS/xzIAw2syYs+lj9FOpahv4=;
        b=Zd9ZukSpuI7NkukQmGu1ufDuf+ii+WxKNx7xBjGhoGGSNxDJ17uOGY3yY1fsk57qZJ
         riOfQEuB93lBR48MAcrsDJpnwPJ15piPZysV+sx94EpJRqI4be8ALvxwjAdAqYcolAx9
         KGNCMP0H8AmpnxkJuvuB3o5LzQY5x70oH7p7qsvmIzZBrLtEKk5WMmQT4TXDt7XEC20v
         yiX7eT8xFyc4d2xVOSx/LFVaaQUmTCj2kODsBiMz2IMixbgc/fzb3vW7+wG/RCT2uZYd
         q5+b6B9IZ1yoPNWvgiTBPPJVixKWVgw5W8/kotLi01tt22V2jUuKdsLrs4bI6Lc5ccOs
         tOdQ==
X-Gm-Message-State: AJIora+YKY0hoqDn0cRgDyxYan4C0POgJPtTp5Pyt8n4NxxwSUg25hdl
        MHfyjAoqFrJiAHTXmEbm/RIR8JyrnnFHMLjZNxz3kRV9
X-Google-Smtp-Source: AGRyM1sIGf4MweZ5Tk1UcbMD0nusCCG1a8fVlpTSwkc8G32vbVTMOHO83EBNt5y8Rc6Y2RfKTXLyu0AFUSGo1/rHse4=
X-Received: by 2002:a17:907:3d94:b0:72b:54bc:aa38 with SMTP id
 he20-20020a1709073d9400b0072b54bcaa38mr14485532ejc.679.1659399334757; Mon, 01
 Aug 2022 17:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <CAEf4BzbDbve0ouE3FVFf+uoYH6b84FrWGHF1xmjmwsmzLAjPaQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbDbve0ouE3FVFf+uoYH6b84FrWGHF1xmjmwsmzLAjPaQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 1 Aug 2022 17:15:23 -0700
Message-ID: <CAJnrk1bi50H7FwfWrGoby-hMJUp4=gMC7k0oCqC9Eba3z1tujQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Aug 1, 2022 at 3:11 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
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
>
> [...]
>
> > +       type = bpf_dynptr_get_type(dst);
> > +
> > +       if (flags) {
> > +               if (type == BPF_DYNPTR_TYPE_SKB) {
> > +                       if (flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH))
> > +                               return -EINVAL;
> > +               } else {
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       if (type == BPF_DYNPTR_TYPE_SKB) {
> > +               struct sk_buff *skb = dst->data;
> > +
> > +               /* if the data is paged, the caller needs to pull it first */
> > +               if (dst->offset + offset + len > skb->len - skb->data_len)
> > +                       return -EAGAIN;
> > +
> > +               return __bpf_skb_store_bytes(skb, dst->offset + offset, src, len,
> > +                                            flags);
> > +       }
>
> It seems like it would be cleaner to have a switch per dynptr type and
> each case doing its extra error checking (like CSUM and HASH flags for
> TYPE_SKB) and then performing write operation.
>
>
> memcpy can be either a catch-all default case, or perhaps it's safer
> to explicitly list TYPE_LOCAL and TYPE_RINGBUF to do memcpy, and then
> default should WARN() and return error?

Sounds great, I will make these changes (and the one below) for v2

>
> > +
> >         memcpy(dst->data + dst->offset + offset, src, len);
> >
> >         return 0;
> > @@ -1555,6 +1594,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
> >
> >  BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
> >  {
> > +       enum bpf_dynptr_type type;
> >         int err;
> >
> >         if (!ptr->data)
> > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> >         if (bpf_dynptr_is_rdonly(ptr))
> >                 return 0;
> >
> > +       type = bpf_dynptr_get_type(ptr);
> > +
> > +       if (type == BPF_DYNPTR_TYPE_SKB) {
> > +               struct sk_buff *skb = ptr->data;
> > +
> > +               /* if the data is paged, the caller needs to pull it first */
> > +               if (ptr->offset + offset + len > skb->len - skb->data_len)
> > +                       return 0;
> > +
> > +               return (unsigned long)(skb->data + ptr->offset + offset);
> > +       }
> > +
> >         return (unsigned long)(ptr->data + ptr->offset + offset);
>
> Similarly, all these dynptr helpers effectively dispatch different
> implementations based on dynptr type. I think switch is most
> appropriate for this.
>
> >  }
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0d523741a543..0838653eeb4e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -263,6 +263,7 @@ struct bpf_call_arg_meta {
> >         u32 subprogno;
> >         struct bpf_map_value_off_desc *kptr_off_desc;
> >         u8 uninit_dynptr_regno;
> > +       enum bpf_dynptr_type type;
> >  };
> >
>
> [...]
