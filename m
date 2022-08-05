Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045D958B2BB
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiHEXWR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiHEXWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 19:22:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2627FFC
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 16:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D77FBB81EB2
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 23:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FB3C433D7;
        Fri,  5 Aug 2022 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659741732;
        bh=5DTVvBaoRp2Exll7FeNbNKQT+Nu06YkcZKEDCav+S4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q3+i2eusDtEdR6Lrlc1yeNDbbZV+L0KttAx6kBfYihkBCt+LqJwUTf/Rg+J6XGXDW
         wn54uT1jcT9zDp7DisEBq0vn7mp+OZskJa18yl1rJb3nvj6ejDOr1piSVBVDNaVtUa
         C+YGs9C38eR5E0lt0MfB/T9r3h9mX9id5ciCMrqiW2JrsHzhFCNV+mdLexJ7TUyCEO
         HDrhqz7MqGGg0ECTQEUdHv3e77eRcHAD+cQC76gsKmvvsk2A95XK1q/Vxo+5MIOXcp
         /i+ak470nBxrW+QZmAr0y069GXzbJXATErufJcEZq8uudZscwAetG4rrf0xBS23sl1
         J+4JYL8uYU43w==
Date:   Fri, 5 Aug 2022 16:22:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220805162211.48d2f032@kernel.org>
In-Reply-To: <CAJnrk1aq719=e07tP2Udn3FVXgzMdsPgyQ9KUp2GK=E=paZEzg@mail.gmail.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
        <20220726184706.954822-2-joannelkoong@gmail.com>
        <20220801163349.4a28d154@kernel.org>
        <CAJnrk1bow8je9VkTAQHiOOPQLWGDg1uDqDRN+tr43bMYtTSGjw@mail.gmail.com>
        <CAJnrk1aq719=e07tP2Udn3FVXgzMdsPgyQ9KUp2GK=E=paZEzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 4 Aug 2022 14:55:14 -0700 Joanne Koong wrote:
> Thinking about this some more, I don't think we get a lot of benefits
> from combining it into one API (bpf_dynptr_from_packet) instead of 2
> separate APIs (bpf_dynptr_from_skb / bpf_dynptr_from_xdp).

Ease of use is not a big benefit? We'll continue to have people trying
to run XDP generic in prod because they wrote their program for XDP,
not tc :(

> The bpf_dynptr_write behavior will be inconsistent (eg bpf_dynptr_write
> into xdp frags will work whereas bpf_dynptr_write into skb frags will
> fail). Martin also pointed out that he'd prefer bpf_dynptr_write() to
> succeed for writing into frags and invalidate data slices (instead of
> failing the write and always keeping data slices valid), which we
> can't do if we combine xdp + skb, without always (needlessly)
> invalidating xdp data slices whenever there's a write. Additionally,
> in the verifier, there's no organic mapping between prog type -> prog
> ctx, so we'll have to hardcode some mapping between prog type -> skb
> vs. xdp ctx. I think for these reasons it makes more sense to have 2
> separate APIs, instead of having 1 API that both hooks can call.

Feels like pushing complexity onto users because the infra is not in
place. One day the infra will be in place yet the uAPI will remain for
ever. But enough emails exchanged, take your pick and time will tell :)
