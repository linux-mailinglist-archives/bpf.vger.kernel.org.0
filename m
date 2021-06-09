Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2203A1B84
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFIRJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 13:09:49 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:44749 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhFIRJs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 13:09:48 -0400
Received: by mail-qt1-f176.google.com with SMTP id t17so18555194qta.11
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEsFi6rO4MHKgEXC6vig8dvK754LxLMuTykgEyj39fE=;
        b=iRW5rn4UJKSkBapsxQQDBN2vpREcEJsdspbX+SFia7Lw7s3NJB1EPttoiCffvYmwil
         k1f8uhqvTTnAT6hJXQQd0UDdTRzphUxGbE42nCxJzeQm3PHROG7dSGMON7OqpMUvJt7R
         RSj6V9ErDo5fuLYya3uqmp71uNo6V8oR2E3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEsFi6rO4MHKgEXC6vig8dvK754LxLMuTykgEyj39fE=;
        b=uUdCuwxH2nVlKQEpHB5HzA49hyrt05UcTaHU2VL7HLviACq4MTOMaD6dWLmhc2rlzm
         6YREXCWCnLydYDLmIhe9EKmWmycmlKjET29P2mwc8mjskjy/JPjlunrcYNm6A5kxYIrw
         2Xpk6A00pmQA/F7cZBeIfQysqwO2K3uQST4m7gyewKosflbNUVydE8+i3Kx+FQMgVmbs
         IdSdO/CQOdWoVMg4JAKZtar9opgYNJ+FmT+q4rK3zZN68Uv9cPmQzilEXiQmcrChywzB
         c+EjX8oQtFraJUJoBshnPACcOy6K/TPudxEzzs8EcN9JjoMTeodND/91frOsvWwtakpu
         07Qw==
X-Gm-Message-State: AOAM530Rzhz3ni2PoimPXDNgF0CChd614xY5BAQkE9/jyrx47XStnueE
        Ypco/cRXvu4mXYrprdFROEkCV2XvBdwQ/jVQm1lJLQ==
X-Google-Smtp-Source: ABdhPJxPanB8XhvteVrtOC1n5AXgdnKfQrT9b+ssxypfUwossTuB3Jo3ccCMedjU3+FZkDy7uSEQZFGgK/T4n/JbYn4=
X-Received: by 2002:a05:622a:14a:: with SMTP id v10mr903141qtw.307.1623258413546;
 Wed, 09 Jun 2021 10:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210604220235.6758-1-zeffron@riotgames.com> <20210604220235.6758-2-zeffron@riotgames.com>
 <f3c5a8d9-6d23-dde6-e9a3-178d9f572f29@fb.com>
In-Reply-To: <f3c5a8d9-6d23-dde6-e9a3-178d9f572f29@fb.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Wed, 9 Jun 2021 12:06:42 -0500
Message-ID: <CAC1LvL1oRTN=F26eOeTvzWUU+_9=8-q++Z+cjFXxZa+A7cLRzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 5, 2021 at 10:17 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/4/21 3:02 PM, Zvi Effron wrote:
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -687,6 +687,38 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >       return ret;
> >   }
> >
> > +static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
>
> Should the order of parameters be switched to (xdp_md, xdp)?
> This will follow the convention of below function xdp_convert_buff_to_md().
>

The order was done to match the skb versions of these functions, which seem to
have the output format first and the input format second, which is why the
order flips between conversion functions. We're not particular about order, so
we can definitely make it consistent.

> > +{
> > +     void *data;
> > +
> > +     if (!xdp_md)
> > +             return 0;
> > +
> > +     if (xdp_md->egress_ifindex != 0)
> > +             return -EINVAL;
> > +
> > +     if (xdp_md->data > xdp_md->data_end)
> > +             return -EINVAL;
> > +
> > +     xdp->data = xdp->data_meta + xdp_md->data;
> > +
> > +     if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> > +             return -EINVAL;
>
> It would be good if you did all error checking before doing xdp->data
> assignment. Also looks like xdp_md error checking happens here and
> bpf_prog_test_run_xdp(). If it is hard to put all error checking
> in bpf_prog_test_run_xdp(), at least put "xdp_md->data >
> xdp_md->data_end) in bpf_prog_test_run_xdp(), so this function only
> checks *_ifindex and rx_queue_index?
>

bpf_prog_test_run_xdp() was already a large function, which is why this was
turned into a helper. Initially, we tried to have all xdp_md related logic in
the helper, with only the required logic in bpf_prog_test_run_xdp(). Based on
a prior suggestion, we moved one additional check from the helper to
bpf_prog_test_run_xdp() as it simplified the logic. It's not clear to us what
benefit moving the other checks to bpf_prog_test_run_xdp() provides, but it
does reduce the benefit of having the helper function.

> > @@ -696,36 +728,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> >       u32 repeat = kattr->test.repeat;
> >       struct netdev_rx_queue *rxqueue;
> >       struct xdp_buff xdp = {};
> > +     struct xdp_md *ctx;
>
> Let us try to maintain reverse christmas tree?

Sure.


>
> >       u32 retval, duration;
> >       u32 max_data_sz;
> >       void *data;
> >       int ret;
> >
> > -     if (kattr->test.ctx_in || kattr->test.ctx_out)
> > -             return -EINVAL;
> > +     ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
> > +     if (IS_ERR(ctx))
> > +             return PTR_ERR(ctx);
> > +
> > +     /* There can't be user provided data before the metadata */
> > +     if (ctx) {
> > +             if (ctx->data_meta)
> > +                     return -EINVAL;
> > +             if (ctx->data_end != size)
> > +                     return -EINVAL;
> > +             if (unlikely((ctx->data & (sizeof(__u32) - 1)) ||
> > +                          ctx->data > 32))
>
> Why 32? Should it be sizeof(struct xdp_md)?

This is not checking the context itself, but the amount of metadata. XDP allows
at most 32 bytes of metadata.

>
> > +             /* Metadata is allocated from the headroom */
> > +             headroom -= ctx->data;
>
> sizeof(struct xdp_md) should be smaller than headroom
> (XDP_PACKET_HEADROOM), so we don't need to a check, but
> some comments might be helpful so people looking at the
> code doesn't need to double check.

We're not sure what check you're referring to, as there's no check here. This
subtraction is, as the comment says, because the XDP metadata is allocated out
of the XDP headroom, so the headroom size needs to be reduced by the metadata
size.
