Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6466DAAC
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbjAQKNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 05:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjAQKNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 05:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF72717
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673950349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kA5/O15aN6rRa78EEt4CPVXRHIiNG4dfLErcW4uc6s=;
        b=UIBPinqYH1SQ66dBINu6edl5cfYALq0NQQSTRPw6QB8x25pLKoceYZmg4ZNZYIiL6xcox3
        9duHaNuFSyXjztIRCq6SXia71dPKuvFG2z2xplXP6Px/U1Gk9ACTuyoxrFjWjFlCkJAeLg
        zoS8RB1JMsFDvc/0nfCJwtvbDeIFwo4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-Sy4-gmaRMyiu7xWx7V_swQ-1; Tue, 17 Jan 2023 05:12:28 -0500
X-MC-Unique: Sy4-gmaRMyiu7xWx7V_swQ-1
Received: by mail-wm1-f69.google.com with SMTP id o22-20020a05600c511600b003db02b921f1so1613447wms.8
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 02:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kA5/O15aN6rRa78EEt4CPVXRHIiNG4dfLErcW4uc6s=;
        b=kKMn1m6laKX6Ojj/ROH5/vJysoVNikeGEnTBpbr8701ZMgA6XCqJKrlfq/SPJo2zdm
         YyxqK0XzTOlT+rjMW5v8rRoWhxTEObOeefKR4TY1s07b8wR2WJRH+PKHlKy5n4YGZ+PP
         /gPQ5mw2aiRm4EDZ+ZTGgUsqE9q7Mm2UV6lAWg4OBa0pHlEYXa7wbXvpj1wyLJXreoun
         /pI79Yx/I4VygQSE+7Q0dgLF9uKKD/Is7A33/Ma43uBSmWoINmpm4sC7q1Tr1d+weyH0
         Onl7Elyie/KmjHNEHJeUM7W9t/gEYLP2jUQSvWSXSnCEr0BpLT5pOHO/lODwX9+U/Vg6
         R2Ew==
X-Gm-Message-State: AFqh2kqy4GiE7XdVanwDa7idWCt5tU5HaRUerA1CKxXI5mz46n4rquQm
        Y55bsXdCk1TOKdLvwRakZ4UOxA/Ric0wQjEuflW4rx7+enZdOWu+h7TPjZp8++I+9ejJfRzR0YA
        kRmaq+u6oLGTu
X-Received: by 2002:a7b:c4c9:0:b0:3d1:f882:43eb with SMTP id g9-20020a7bc4c9000000b003d1f88243ebmr2475316wmk.10.1673950347122;
        Tue, 17 Jan 2023 02:12:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtVBmP4JWU8py8xfSxM2n99t/CdXDtaPIZ5/rCi1+WZVv1wwkgB4XpgJsENCWv0laiiu1+ngg==
X-Received: by 2002:a7b:c4c9:0:b0:3d1:f882:43eb with SMTP id g9-20020a7bc4c9000000b003d1f88243ebmr2475305wmk.10.1673950346842;
        Tue, 17 Jan 2023 02:12:26 -0800 (PST)
Received: from redhat.com ([2.52.132.216])
        by smtp.gmail.com with ESMTPSA id s18-20020adfecd2000000b002bdfcd8c77csm6248511wro.101.2023.01.17.02.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:12:26 -0800 (PST)
Date:   Tue, 17 Jan 2023 05:12:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, toke@redhat.com, pabeni@redhat.com,
        davem@davemloft.net, aelior@marvell.com, manishc@marvell.com,
        horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        jasowang@redhat.com, ioana.ciornei@nxp.com, madalin.bucur@nxp.com,
        bpf@vger.kernel.org
Subject: Re: [PATCH net 0/5] net: xdp: execute xdp_do_flush() before
 napi_complete_done()
Message-ID: <20230117050759-mutt-send-email-mst@kernel.org>
References: <20230117092533.5804-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117092533.5804-1-magnus.karlsson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 10:25:28AM +0100, Magnus Karlsson wrote:
> Make sure that xdp_do_flush() is always executed before
> napi_complete_done(). This is important for two reasons. First, a
> redirect to an XSKMAP assumes that a call to xdp_do_redirect() from
> napi context X on CPU Y will be follwed by a xdp_do_flush() from the
> same napi context and CPU. This is not guaranteed if the
> napi_complete_done() is executed before xdp_do_flush(), as it tells
> the napi logic that it is fine to schedule napi context X on another
> CPU. Details from a production system triggering this bug using the
> veth driver can be found in [1].
> 
> The second reason is that the XDP_REDIRECT logic in itself relies on
> being inside a single NAPI instance through to the xdp_do_flush() call
> for RCU protection of all in-kernel data structures. Details can be
> found in [2].
> 
> The drivers have only been compile-tested since I do not own any of
> the HW below. So if you are a manintainer, please make sure I did not
> mess something up. This is a lousy excuse for virtio-net though, but
> it should be much simpler for the vitio-net maintainers to test this,
> than me trying to find test cases, validation suites, instantiating a
> good setup, etc. Michael and Jason can likely do this in minutes.

This kind of thing doesn't scale though. There are more contributors
than maintainers. Also, I am not 100% sure what kind of XDP workload
do I need to be a good test.

> 
> Note that these were the drivers I found that violated the ordering by
> running a simple script and manually checking the ones that came up as
> potential offenders. But the script was not perfect in any way. There
> might still be offenders out there, since the script can generate
> false negatives.
> 
> [1] https://lore.kernel.org/r/20221220185903.1105011-1-sbohrer@cloudflare.com
> [2] https://lore.kernel.org/all/20210624160609.292325-1-toke@redhat.com/
> 
> Thanks: Magnus
> 
> Magnus Karlsson (5):
>   qede: execute xdp_do_flush() before napi_complete_done()
>   lan966x: execute xdp_do_flush() before napi_complete_done()
>   virtio-net: execute xdp_do_flush() before napi_complete_done()
>   dpaa_eth: execute xdp_do_flush() before napi_complete_done()
>   dpaa2-eth: execute xdp_do_flush() before napi_complete_done()
> 
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        | 6 +++---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c      | 9 ++++++---
>  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 6 +++---
>  drivers/net/ethernet/qlogic/qede/qede_fp.c            | 7 ++++---
>  drivers/net/virtio_net.c                              | 6 +++---
>  5 files changed, 19 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 87b93b678e95c7d93fe6a55b0e0fbda26d8c7760
> --
> 2.34.1

