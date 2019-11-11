Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4770BF7A1B
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 18:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKKRip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 12:38:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40772 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKRip (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 12:38:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id j26so3433260lfh.7
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2019 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJFz9zTY/pPP/lruUjbdvSb0szMloxDkdcjSFe0zdXk=;
        b=QNQHT1jv0FP5wV/sCjlMJWmOfD5GpGNnTLK2vtxwwCkyWNQdhTQHQ9dvm+RGhAkEk8
         pvw+WCMoxDbJNkzQC8oR9CUPWtlW0BZ0mAxjJ9/6OtYGtpktTkudlMCfA39yjGp8T4nS
         lOAA42hLo2wfFwZKNenm22/4J0VUa3ks4WLL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJFz9zTY/pPP/lruUjbdvSb0szMloxDkdcjSFe0zdXk=;
        b=r0wr+YwcDf5o8vJODF3MTIk+2HDl+is0q2ZEckTEFbw16vjt85qduRz8BL3AVOl+qz
         K7N5fZcAAeeWqVetcwkpzuf9+BbZYfSANd80vIjwOKDfm8aJX+gGDX3arqHGhmgZi+3F
         N49/QqmELsMbAOlwmMjpfuJkl8EbErr3haU54+ttI/UG1D17IqTznY3NT5YRZ4yu+Lf/
         ydZCipHqQHM3xV4zBtQloqjuK3XCfBcNyoEr/dS+reDuoyqgZhTRXdqWoQfO97lSAAh0
         i8lU4ytaZms2epTpFLROfjMA2wu4ob62x37gm3+payb4NkAkiPacvp6OdX3ZWUCKQKZs
         pBQQ==
X-Gm-Message-State: APjAAAX1NnyF1KsHHW2S3/g6JIlBNHMbub4qMputOQ5e7qocpWD/xPMf
        Ugjs8+l5F0e6ykcXi8zUkFqcma+io4gZtbcmnhNHbQ==
X-Google-Smtp-Source: APXvYqyMhsY+dr5r5Pl9qpAKBj6HyRGST9YHSmAZ+4FVc+whsd+I3SZ5d+xsacpQ1FEFHthtN+KnL8mtCqv5Fz2Wg+U=
X-Received: by 2002:a05:6512:509:: with SMTP id o9mr6230498lfb.28.1573493921419;
 Mon, 11 Nov 2019 09:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20191111105100.2992-1-afabre@cloudflare.com> <f58a73a8-631c-a9a1-25e9-a5f0050df13c@solarflare.com>
In-Reply-To: <f58a73a8-631c-a9a1-25e9-a5f0050df13c@solarflare.com>
From:   Arthur Fabre <afabre@cloudflare.com>
Date:   Mon, 11 Nov 2019 17:38:29 +0000
Message-ID: <CAOn4ftvqib3y+Gfhq+dS4cUeWQVyGDM+rNeLnoVoYz9O_VLYLA@mail.gmail.com>
Subject: Re: [PATCH net-next] sfc: trace_xdp_exception on XDP failure
To:     Edward Cree <ecree@solarflare.com>
Cc:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Charles McLachlan <cmclachlan@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 11, 2019 at 5:27 PM Edward Cree <ecree@solarflare.com> wrote:
>
> On 11/11/2019 10:51, Arthur Fabre wrote:
> > diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
> > index a7d9841105d8..5bfe1f6112a1 100644
> > --- a/drivers/net/ethernet/sfc/rx.c
> > +++ b/drivers/net/ethernet/sfc/rx.c
> > @@ -678,6 +678,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >                                 "XDP is not possible with multiple receive fragments (%d)\n",
> >                                 channel->rx_pkt_n_frags);
> >               channel->n_rx_xdp_bad_drops++;
> > +             trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> >               return false;
> >       }
> AIUI trace_xdp_exception() is improper here as we have not run
>  the XDP program (and xdp_act is thus uninitialised).
>
> The other three, below, appear to be correct.
> -Ed
>

Good point. Do you know under what conditions we'd end up with
"fragmented" packets? As far as I can tell this isn't IP
fragmentation?

On Mon, Nov 11, 2019 at 5:27 PM Edward Cree <ecree@solarflare.com> wrote:
>
> On 11/11/2019 10:51, Arthur Fabre wrote:
> > The sfc driver can drop packets processed with XDP, notably when running
> > out of buffer space on XDP_TX, or returning an unknown XDP action.
> > This increments the rx_xdp_bad_drops ethtool counter.
> >
> > Call trace_xdp_exception everywhere rx_xdp_bad_drops is incremented to
> > easily monitor this from userspace.
> >
> > This mirrors the behavior of other drivers.
> >
> > Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> > ---
> >  drivers/net/ethernet/sfc/rx.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
> > index a7d9841105d8..5bfe1f6112a1 100644
> > --- a/drivers/net/ethernet/sfc/rx.c
> > +++ b/drivers/net/ethernet/sfc/rx.c
> > @@ -678,6 +678,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >                                 "XDP is not possible with multiple receive fragments (%d)\n",
> >                                 channel->rx_pkt_n_frags);
> >               channel->n_rx_xdp_bad_drops++;
> > +             trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> >               return false;
> >       }
> AIUI trace_xdp_exception() is improper here as we have not run
>  the XDP program (and xdp_act is thus uninitialised).
>
> The other three, below, appear to be correct.
> -Ed
>
> >
> > @@ -724,6 +725,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >                               netif_err(efx, rx_err, efx->net_dev,
> >                                         "XDP TX failed (%d)\n", err);
> >                       channel->n_rx_xdp_bad_drops++;
> > +                     trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> >               } else {
> >                       channel->n_rx_xdp_tx++;
> >               }
> > @@ -737,6 +739,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >                               netif_err(efx, rx_err, efx->net_dev,
> >                                         "XDP redirect failed (%d)\n", err);
> >                       channel->n_rx_xdp_bad_drops++;
> > +                     trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> >               } else {
> >                       channel->n_rx_xdp_redirect++;
> >               }
> > @@ -746,6 +749,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >               bpf_warn_invalid_xdp_action(xdp_act);
> >               efx_free_rx_buffers(rx_queue, rx_buf, 1);
> >               channel->n_rx_xdp_bad_drops++;
> > +             trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> >               break;
> >
> >       case XDP_ABORTED:
>
