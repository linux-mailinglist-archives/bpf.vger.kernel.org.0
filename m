Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE47587473
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiHAXdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 19:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiHAXdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 19:33:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD22F389
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 16:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CA6FB815FE
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 23:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F171AC433C1;
        Mon,  1 Aug 2022 23:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659396831;
        bh=QzekXH1La6BlxRQqc31UK+rVSKF3IhK0zz52C6U5Kfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qp8FtpQBiJ3ZqMg+J3v+BZBkUc7cop2E6gOCYkTUjSEEnL74Ew86c+6Ob554lQCOx
         JNgRvGPikhLWWxE497Er8Li3Iv5kAYvnIXqDRAuikkAx/hTwP8u3Vu+VNvtWXiikVB
         UexYC+gEL/zsaDrmzdOwU9Ncg+5Eo0Lp7xtGgvG8/lparC1UmwqvCUmoogipeqT1xG
         pTjYuhT+85jRtCcax0zt0/nWZKVeUa/zrakURpHU+Lb/LvkyuxOmPy3DfX2CPENZlq
         ujFcnXoUEI4vr50Lij1y/UjomLxrkEeOzyjWgSrzWZCPk03k4bMU1pvIC/kcQLwYSy
         33qIPU1ndwbQA==
Date:   Mon, 1 Aug 2022 16:33:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220801163349.4a28d154@kernel.org>
In-Reply-To: <20220726184706.954822-2-joannelkoong@gmail.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
        <20220726184706.954822-2-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

(consider cross-posting network-related stuff to netdev@)

On Tue, 26 Jul 2022 11:47:04 -0700 Joanne Koong wrote:
> Add skb dynptrs, which are dynptrs whose underlying pointer points
> to a skb. The dynptr acts on skb data. skb dynptrs have two main
> benefits. One is that they allow operations on sizes that are not
> statically known at compile-time (eg variable-sized accesses).
> Another is that parsing the packet data through dynptrs (instead of
> through direct access of skb->data and skb->data_end) can be more
> ergonomic and less brittle (eg does not need manual if checking for
> being within bounds of data_end).

Is there really a need for dynptr_from_{skb,xdp} to be different
function IDs? I was hoping this work would improve portability of
networking BPF programs across the hooks.

> For bpf prog types that don't support writes on skb data, the dynptr is
> read-only (writes and data slices are not permitted). For reads on the
> dynptr, this includes reading into data in the non-linear paged buffers
> but for writes and data slices, if the data is in a paged buffer, the
> user must first call bpf_skb_pull_data to pull the data into the linear
> portion.
> 
> Additionally, any helper calls that change the underlying packet buffer
> (eg bpf_skb_pull_data) invalidates any data slices of the associated
> dynptr.

Grepping the verifier did not help me find that, would you mind
pointing me to the code?

> Right now, skb dynptrs can only be constructed from skbs that are
> the bpf program context - as such, there does not need to be any
> reference tracking or release on skb dynptrs.
