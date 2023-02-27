Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74866A4D6F
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjB0Vla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0Vl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:41:29 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D0B1CAFA
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:41:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 03BC332007E8;
        Mon, 27 Feb 2023 16:41:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 16:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1677534077; x=
        1677620477; bh=wbNTgF7HuDyTTfAmxYQhhsSTdpyQid543ozIzYNnCh4=; b=O
        4ZUovR9CW6TOD+AdFe3nk9EhIcce8MZGBzSsQtlJVMsL64Nv2/HgD8TYLxjX6gTp
        /MOHwo4jqlk1/LpMliYrFk0f/G9TswO4Diex3s1a7PP+5tx0JVod5hkq91H/xeZI
        Zvm09YLetiPJB3vJ+CkxWHdgCYd6GJkUqYUpsNc0oXQ37ADRM+MnrYNrtGWyEwO4
        3NcYyxjcAN7RucjCa+EMwdIh9bKk2p5trVInTIL7QeZ880AfLmRVb7ze+DPI1zpx
        BYsqmiiDEign4/eepi8z2BhUCx86kJk3the1XvcC1Xr1ZxtomW7mZjkex1TPD+jX
        RV89TFcSccx94ez8Im3TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677534077; x=
        1677620477; bh=wbNTgF7HuDyTTfAmxYQhhsSTdpyQid543ozIzYNnCh4=; b=e
        CcGqOer4aPDWqB3iq/EEegPXuvz4gRKzBd4vPKHhmPhfTbZn+HlccEezAipFyaBL
        L2ciZkZDRu93YxIfusmmeahq/45XScwc1Iqgpxr6/488nOmcSQxoHnMHPwqI+bpD
        IgQNwimDve/yGGmkT/K0sq1Pm7O/aepcdyXb7EIIz2tT7WQ4xp4ea0keduelX9/N
        hAOIj4aT1ferCK4kQyzjG1ImA+viGfiNGgrQJH7aI0r6RPXpBc66Ud4TDUK31zcw
        OHG/uzfcA8E1NTHGdKQVh0uwmoWbyE5wH4Xab2Qkzs2qEFGWgES4CeqLz/MP3ih/
        SYmKFvA1gUPYbo4Yb425Q==
X-ME-Sender: <xms:fSP9Y_4qnpIP6zt4yb2-9-ABEP-_dGu2707TvJ2a3yV5wdffyjQIFA>
    <xme:fSP9Y06eFrbVDi4QcUuvkQXyP6ncVW4JNGkcs8wrYb_4OlWriSX0bu8ElzaiA_0id
    G6AqKq55Hz2IdHYPQ>
X-ME-Received: <xmr:fSP9Y2fTI2UU0FUInYmFYRrlXd3_JGDTdSyS2-GI9FK2iVovH__LC8eeB5fiPuESKW1uTHYhuAX6H0XOdzwFZ1T2e55QWz0LCFw_lhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepff
    fhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeffrghnihgvlhcuighu
    uceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgedvjeevuedvie
    fgjeejueefhfffteefkedutdduvdeutdeuffdvjeelheegteffnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:fSP9YwL5BrqVJJiTxANuI5gzihYOvoGN3g7zwwixZxT126CuP79Clg>
    <xmx:fSP9YzKWy_7ZMXjDuef3BvMtbNKai3r4-siVCqUekSQptsn4xI0m_Q>
    <xmx:fSP9Y5x7nrivIpCdijEywuXGAz9M6T8RlxrG3gVY29NpPlTe384dDQ>
    <xmx:fSP9Y5hiL6bQKuU0b8JS1XhvDCoVgapinNnSxhHIPa1O_NP2hPLqKg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 16:41:16 -0500 (EST)
Date:   Mon, 27 Feb 2023 14:41:15 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Batteries-included symbolization with blazesym
Message-ID: <20230227214115.p5ohjcnkl2rz4mkt@kashmir.localdomain>
References: <20230227193456.jbxt3mba6xfntieu@muellerd-fedora-PC2BDTX9>
 <20230227200748.xdkhnht2w4mtbj2u@kashmir.localdomain>
 <20230227213430.qxfrupne3g4lvsla@muellerd-fedora-PC2BDTX9>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227213430.qxfrupne3g4lvsla@muellerd-fedora-PC2BDTX9>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Mon, Feb 27, 2023 at 09:34:30PM +0000, Daniel Müller wrote:
> Hi Daniel,
> 
> On Mon, Feb 27, 2023 at 01:07:48PM -0700, Daniel Xu wrote:
> > On Mon, Feb 27, 2023 at 07:34:56PM +0000, Daniel Müller wrote:
> > > Symbolization of addresses is a commonly encountered problem, maybe most so in
> > > the context of BPF and tracing with the capturing of stack traces. Perhaps
> > > superficially straightforward-looking, there a variety of considerations and
> > > intricacies, such as:
> > > - different formats/standards (e.g., ELF symbol information, DWARF, GSYM) cater
> > >   to different use cases and require vastly different steps to work with
> > >   - on top of that, even if a library such as libelf or libdwarf is relied on,
> > >     plenty of format specific details need to be known to symbolize addresses
> > >     properly
> > > - discovery of symbolization sources (e.g., DWARF debug files)
> > > - symbolization trade-offs (performance, memory usage)
> > > - system-specific details and corner cases
> > > 
> > > We are working on blazesym [0], a library that aims to provide users with a
> > > batteries-included experience for symbolizing addresses (but also the reverse:
> > > mapping symbols to addresses).
> > > 
> > > We would like to provide a brief overview of the library and its goals and then
> > > open up for discussion. Some topics we are specifically interested in
> > > understanding better:
> > > - What are current issues with symbolization that would be great to support?
> > > - Does the usage of Rust pose a problem in your context? (C bindings are
> > >   available, but a Rust toolchain is required for building; are pre-built
> > >   binaries and packages for common distributions sufficient for your use cases?)
> > > 
> > > In general, we'd be interested in hearing your use cases and in discussing
> > > whether blazesym is a fit or could be made to work.
> > 
> > I didn't look super close at blazesym yet, but was wondering if it would
> > support a use case I have in mind.
> > 
> > Context is it's tricky to determine why a packet was dropped by kernel.
> > kfree_skb_reason() with caller address in `location` is a good start but
> > we can do better I think.
> > 
> > The issue is the call stack alone is not enough detail. I want to see
> > all the branches taken in the case a single call frame has multiple ways
> > to drop.
> > 
> > Vague idea is to use the recent LBR work (also haven't looked hard yet,
> > so this may not be possible) to take LBR stack at
> > `tracepoint:skb:kfree_skb` tracepoint. Then map the branches to line
> > numbers.
> > 
> > So my question is this: can/will blazesym be able to map kernel
> > addresses to line numbers / file names?
> 
> Blazesym should be able to help with the symbolization aspect, yes. That is, it
> can convert the addresses you captured into symbol name + source file + line
> information as you asked for (you may need DWARF debug information for anything
> beyond mere symbol names). In general, the library is able to handle both user
> space and kernel addresses.

Awesome, sounds great. After looking slightly more carefully, how about
split debug info support and debuginfod support? Extremely unlikely
anybody ships production kernels with debug symbols. But debuginfod
service is more likely.

> It is not designed, however, to help you capture those addresses. So how you get
> them (e.g., using LBR as you mentioned) is up to you.

Makes sense.

Thanks,
Daniel
