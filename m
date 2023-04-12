Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD86DF880
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDLOat (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDLOas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 10:30:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C6273F
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 07:30:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q23so19886624ejz.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681309844; x=1683901844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hV5Ne4/31d5bZz3cd3WidbbAZPsQ2K5R5VgJmtESd3c=;
        b=Ef3ZNyIwfn2tgIn5VYdodtKoHofTHBF48vSKjvDgvzzyd7icYtwHpA8gR9eWcXBzE4
         uMsgHSi7oGwf2Z5CYEWmvPh2f1WFFVM2zu98iJObrG71TI0vefPpJXtdZ4g0+8pizmJa
         7kEP6uY+ScqoziGvRMQWQQ2rjDj/GaJnHz3qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309844; x=1683901844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV5Ne4/31d5bZz3cd3WidbbAZPsQ2K5R5VgJmtESd3c=;
        b=kVqysnxGR12MvX+8KLRrlWmAAlur6htlHuovkq+D2gIA7DHx2p/LlkMsJVTb+xJ/Ei
         Yg8tLn8nTsxy9cqto6bWHsFrb+I185p1xBW1dUlqo91NPxNUmCgrDp2P/7O3T56OCZ7G
         Pah/O67UhNvNb2sjWNAywRzgrlmUXsmm0krOmYD44A9Zwhcu5cpKHB3fFFFlEFMuN9RR
         9V2UoOuPqRxqAMwGHAnVKnjnxoNt5olcXOrIyO4VUoUlqC9TodbZ0h9/oOQtUczOF1jB
         VEgl0akuS3nOR782F1YEdEFAabIyb1lC1iBcEvM7pkVufO5u9dL1oIzR38jyE8gLiRAl
         LKAQ==
X-Gm-Message-State: AAQBX9cms6lgPF9/qzJY7uMCBH2Ar0DtQB6Rsg+nPCStXvy/xTHJN3T2
        RTPSctK8mR59rjzcsOAytNkbWxoqngBFxwx/CnSj0w==
X-Google-Smtp-Source: AKy350Yt4SeQfT6MmpPED1unBq6lSFhE49tsPdIDsDUP8eL1G0arDIPgCt7yuQGlyQRpwnW9Oj6ijxAmPvq0B8EgHvI=
X-Received: by 2002:a17:907:d310:b0:931:6f5b:d27d with SMTP id
 vg16-20020a170907d31000b009316f5bd27dmr1417968ejc.0.1681309843846; Wed, 12
 Apr 2023 07:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230410120629.642955-1-kal.conley@dectris.com>
 <20230410120629.642955-3-kal.conley@dectris.com> <CAJ8uoz0NczOxbs7xqwC4B9YDP5fN1oECBi53yHoaZbvTxcm_fg@mail.gmail.com>
In-Reply-To: <CAJ8uoz0NczOxbs7xqwC4B9YDP5fN1oECBi53yHoaZbvTxcm_fg@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 12 Apr 2023 16:35:27 +0200
Message-ID: <CAHApi-kp5FVfHm4tVObbOz7yu6o7PjaFLw8XgLB0OFY=pSuaKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/4] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > -       pool->unaligned = unaligned;
> >         pool->frame_len = umem->chunk_size - umem->headroom -
> >                 XDP_PACKET_HEADROOM;
> > +       pool->unaligned = unaligned;
>
> nit: This change is not necessary.

Do you mind if we keep it? It makes the assignments better match the
order in the struct declaration.

> > -static void xp_check_dma_contiguity(struct xsk_dma_map *dma_map)
> > +static void xp_check_dma_contiguity(struct xsk_dma_map *dma_map, u32 page_size)
> >  {
> >         u32 i;
> >
> > -       for (i = 0; i < dma_map->dma_pages_cnt - 1; i++) {
> > -               if (dma_map->dma_pages[i] + PAGE_SIZE == dma_map->dma_pages[i + 1])
> > +       for (i = 0; i + 1 < dma_map->dma_pages_cnt; i++) {
>
> I think the previous version is clearer than this new one.

I like using `i + 1` since it matches the subscript usage. I'm used to
writing it like this for SIMD code where subtraction may wrap if the
length is unsigned, that doesn't matter in this case though. I can
restore the old way if you want.
