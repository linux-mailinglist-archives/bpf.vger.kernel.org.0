Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3124BEF3
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHTNg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 09:36:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25664 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728879AbgHTNgp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 09:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597930603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJFZdfzFerIu9POmyMKy1vvOc271UPpP8stdY8b9km0=;
        b=d2FMaoXAhmEkHWOtlV5aDg3xnb+1v+Roq+B0cgthmeMUkvzi6EgV4b1zW5kcmlBqtRFkFA
        oYBAFpdiK7wH0HyX1yfu0UPZ4tmW0b/GoWwJulOle/VzSlPnCL8qeGvonyl45JbrwjQ/Vi
        YQro8Rrn+41crVJ/xIrn2cFLELhmpgA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-4EVRXf4hNnaJCoIVrSP_cA-1; Thu, 20 Aug 2020 09:36:41 -0400
X-MC-Unique: 4EVRXf4hNnaJCoIVrSP_cA-1
Received: by mail-vk1-f198.google.com with SMTP id i185so438742vki.7
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 06:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJFZdfzFerIu9POmyMKy1vvOc271UPpP8stdY8b9km0=;
        b=SN6aUOB95roIdIHBe/N4eUhhDV90EpSH/ZHpFWkXsBlf52AHVoGgDDxkXps/n9lXSW
         k6HBg8Y5gAOSdPSPI8dtwLJFqSLRLrGtQTbzhyuPQuYy32AWnHTJZ2+FClq8+BDn4gkZ
         Liaj7uKsaoB+NDXp+ycSNAx8u+H4oO9hF5C0vQWdubGreI1Wa/tkUL88YMT6INjP1w1q
         SAnE86+xna9t5C7FsTuL1z32IyK8LRBeu426Rh0ZpbaWbd9ZInnql7FwK+nbMl8uQD1F
         IHW+GU77zm6NU9jvi9BuMQ/PguONIyQ/71XiZW8cKTWI4p7pgGs0oap4OjU2PGjP1HG2
         R7QQ==
X-Gm-Message-State: AOAM533in+y/94shnPq3e2l0kibRkZZk3JJetGLfiys5hTt230mq/L6g
        sSbp90E5YjRJac4idlNyMefXyMVGR9pkwT1pq0iCjx+97sqklVu8BDnTRHnToL7zsk38CgL3kFL
        clntff30DdNVHsG0g2VZZO3200AEC
X-Received: by 2002:a67:fd17:: with SMTP id f23mr1661789vsr.161.1597930600477;
        Thu, 20 Aug 2020 06:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3esja4NRlaAgbmQLfQyoOhLU9wonUoDgOOH0wJbsBKP92LWYMPOrmrXG5ZLffHaPBPmZYhAtDALk+Hpk3hks=
X-Received: by 2002:a67:fd17:: with SMTP id f23mr1661777vsr.161.1597930600267;
 Thu, 20 Aug 2020 06:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597842004.git.lorenzo@kernel.org> <20200820151644.00e6c87c@carbon>
In-Reply-To: <20200820151644.00e6c87c@carbon>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Thu, 20 Aug 2020 15:36:29 +0200
Message-ID: <CAJ0CqmWGmPf8WDr0ofejFJZVaVWubeh9GNBYjusqLfLqBd6NFA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] mvneta: introduce XDP multi-buffer support
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eelco Chaudron <echaudro@redhat.com>,
        "Jubran, Samih" <sameehj@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
>
> General issue (that I think must be resolved/discussed as part of this initial
> patchset).

I was thinking about this issue as well.

>
> When XDP_REDIRECT'ing a multi-buffer xdp_frame out of another driver's
> ndo_xdp_xmit(), what happens if the remote driver doesn't understand the
> multi-buffer format?
>
> My guess it that it will only send the first part of the packet (in the
> main page). Fortunately we don't leak memory, because xdp_return_frame()
> handle freeing the other segments. I assume this isn't acceptable
> behavior... or maybe it is?
>
> What are our options for handling this:
>
> 1. Add mb support in ndo_xdp_xmit in every driver?

I guess this is the optimal approach.

>
> 2. Drop xdp->mb frames inside ndo_xdp_xmit (in every driver without support)?

Probably this is the easiest solution.
Anyway if we drop patch 6/6 this is not a real issue since the driver
is not allowed yet to receive frames bigger than one page and we have
time to address this issue in each driver.

Regards,
Lorenzo

>
> 3. Add core-code check before calling ndo_xdp_xmit()?
>
> --Jesper
>
> On Wed, 19 Aug 2020 15:13:45 +0200 Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Finalize XDP multi-buffer support for mvneta driver introducing the capability
> > to map non-linear buffers on tx side.
> > Introduce multi-buffer bit (mb) in xdp_frame/xdp_buffer to specify if
> > shared_info area has been properly initialized.
> > Initialize multi-buffer bit (mb) to 0 in all XDP-capable drivers.
> > Add multi-buff support to xdp_return_{buff/frame} utility routines.
> >
> > Changes since RFC:
> > - squash multi-buffer bit initialization in a single patch
> > - add mvneta non-linear XDP buff support for tx side
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>

