Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B365B2DF66B
	for <lists+bpf@lfdr.de>; Sun, 20 Dec 2020 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgLTSI3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Dec 2020 13:08:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgLTSI3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Dec 2020 13:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608487622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wC6925RUdwnOWULkOoUOrNkkpuduWiXS0s9QV8Mu2A=;
        b=M8Kkx5VovNCW1No8EZ9tt4mp/9baF1EnidI389lU5c3K5f64C4Kp4x8YmdYVMCrOSyk2J4
        09tYFsg2Hpf0Zsc37GXlUPoq70eLzH55PQAA/3U2aUSiZmLt2PItFchavO0b88NZhHQR9P
        xslGfaUB8pMwZUN0ozFfcUxq+kW3Ayo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-vErWgrNzOE2msPzQvG_wLg-1; Sun, 20 Dec 2020 13:07:00 -0500
X-MC-Unique: vErWgrNzOE2msPzQvG_wLg-1
Received: by mail-yb1-f200.google.com with SMTP id d187so11533489ybc.6
        for <bpf@vger.kernel.org>; Sun, 20 Dec 2020 10:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wC6925RUdwnOWULkOoUOrNkkpuduWiXS0s9QV8Mu2A=;
        b=mM2j8SusoFnIvVuEFrvwzc7OJXT0I88zWffuGV/yY/KdBqdeUBPAyQr1THRYLwHyZl
         vX0a6tTeN2WcixscxOoaKe75vHQMQiBw2ojrk9meEHQVWn4CWvD0jq9D+PaD4ErwFnjr
         EmlOqFAEJ4A91x+zwNw47O+CQzfhFFE2p2gIgVJDOpmsoWl7dtjmUx/3KQ3bsZG1t5k6
         vYuEsLf+fPGQCAQ1ATyygOwtl2tdnAB+RvceS3n5JaNDrjtO9J/NOE+3ArgEfnW5+TQQ
         j2mPQDNqjlkiFBek48IBBreEuacXcUnqnSyRDZE1XC7zzvGt5amOj9zy2x8KZKtyImdx
         SfZQ==
X-Gm-Message-State: AOAM530kWSb9jGdyxL/5AFx2h+I17Ug7xXuTULneKo8lXllO4NVO7OhA
        eM5KfE3zYekjHSZqksJ06iWiAlM8mJ2KffEgol9pmdMVE7Qwwh9SFXpSci9MwPA7yrbcWIgi5IU
        Coy+AmvgMgzWs337iuNYW8ks6GQAx
X-Received: by 2002:a25:dc7:: with SMTP id 190mr18137232ybn.73.1608487619967;
        Sun, 20 Dec 2020 10:06:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRGo97tZJiV3Qqn1a+pmbVfcUP+6oubUCyA0D12F68fTdXKxtujCPRyDphaJXw1ZNt3Q2d0shUDUrpsLzeGKc=
X-Received: by 2002:a25:dc7:: with SMTP id 190mr18137210ybn.73.1608487619764;
 Sun, 20 Dec 2020 10:06:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607349924.git.lorenzo@kernel.org> <f3d2937208eae9644f36d805cd5b30e0985767a6.1607349924.git.lorenzo@kernel.org>
 <pj41zlh7ohpz6h.fsf@u68c7b5b1d2d758.ant.amazon.com>
In-Reply-To: <pj41zlh7ohpz6h.fsf@u68c7b5b1d2d758.ant.amazon.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 20 Dec 2020 19:06:56 +0100
Message-ID: <CAJ0CqmXB1yUzBAxjeyxDw2smpOMXqN=3TdqwwAkr49k8-6x8qA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 06/14] net: mvneta: add multi buffer support
 to XDP_TX
To:     Shay Agroskin <shayagr@amazon.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jubran, Samih" <sameehj@amazon.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 19, 2020 at 4:56 PM Shay Agroskin <shayagr@amazon.com> wrote:
>
>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> > Introduce the capability to map non-linear xdp buffer running
> > mvneta_xdp_submit_frame() for XDP_TX and XDP_REDIRECT
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 94
> >  ++++++++++++++++-----------
> >  1 file changed, 56 insertions(+), 38 deletions(-)
> [...]
> >                       if (napi && buf->type ==
> >  MVNETA_TYPE_XDP_TX)
> >                               xdp_return_frame_rx_napi(buf->xdpf);
> >                       else
> > @@ -2054,45 +2054,64 @@ mvneta_xdp_put_buff(struct mvneta_port
> > *pp, struct mvneta_rx_queue *rxq,
> >
> >  static int
> >  mvneta_xdp_submit_frame(struct mvneta_port *pp, struct
> >  mvneta_tx_queue *txq,
> > -                     struct xdp_frame *xdpf, bool dma_map)
> > +                     struct xdp_frame *xdpf, int *nxmit_byte,
> > bool dma_map)
> >  {
> > -     struct mvneta_tx_desc *tx_desc;
> > -     struct mvneta_tx_buf *buf;
> > -     dma_addr_t dma_addr;
> > +     struct xdp_shared_info *xdp_sinfo =
> > xdp_get_shared_info_from_frame(xdpf);
> > +     int i, num_frames = xdpf->mb ? xdp_sinfo->nr_frags + 1 :
> > 1;
> > +     struct mvneta_tx_desc *tx_desc = NULL;
> > +     struct page *page;
> >
> > -     if (txq->count >= txq->tx_stop_threshold)
> > +     if (txq->count + num_frames >= txq->size)
> >               return MVNETA_XDP_DROPPED;
> >
> > -     tx_desc = mvneta_txq_next_desc_get(txq);
> > +     for (i = 0; i < num_frames; i++) {
> > +             struct mvneta_tx_buf *buf =
> > &txq->buf[txq->txq_put_index];
> > +             skb_frag_t *frag = i ? &xdp_sinfo->frags[i - 1] :
> > NULL;
> > +             int len = frag ? xdp_get_frag_size(frag) :
> > xdpf->len;
>
> nit, from branch prediction point of view, maybe it would be
> better to write
>      int len = i ? xdp_get_frag_size(frag) : xdpf->len;
>

ack, I will fix it in v6.

Regards,
Lorenzo

> since the value of i is checked one line above
> Disclaimer: I'm far from a compiler expert, and don't know whether
> the compiler would know to group these two assignments together
> into a single branch prediction decision, but it feels like using
> 'i' would make this decision easier for it.
>
> Thanks,
> Shay
>
> [...]
>

