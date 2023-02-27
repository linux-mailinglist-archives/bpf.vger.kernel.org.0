Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBF6A4C03
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 21:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjB0UH4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 15:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjB0UHz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 15:07:55 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA410DA
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 12:07:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F39B13200955;
        Mon, 27 Feb 2023 15:07:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Feb 2023 15:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1677528470; x=
        1677614870; bh=W/E7eOuzfM5fNI8eRc6DqY11PO1+hvSblOhieGwjyQI=; b=c
        v++M7DhSlXzaPbVqVVE43iuXzFgXkuN0q8JzVhCGChksnQ7EhgohazR5+x/Cmx9N
        HvLXgU3MMXu/L1b+5UgRsfa0wzHGOI+JFxG0RVKgvAcML9rArL7MkCA40cv0Zufu
        A3viU3uZc1liyVVC3q2ApVbZ2a9MJUMhfiKBBlUtK/uBK76nNkLFaLrOfUpYEJsL
        IlE6jDLAQqxAfeNqhjJ1YZXKec1Uyj0wkZYJZ0qRDTKSrjmwDBGsHu9YkyLrkvqk
        ZdOQeVBcone0ZyTxge//RCgG/d0FeXUCKWpeyLcDdgLdOtr8iIufWlQuepFcQmI3
        9b06/nURQEu6Ssh+YKyaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677528470; x=
        1677614870; bh=W/E7eOuzfM5fNI8eRc6DqY11PO1+hvSblOhieGwjyQI=; b=h
        9+m3JZ2Ge9G4uru5RPCEQGGS+srbIwTBE6fQYh+BuUL4sPr4um9t+t1qANGTQkS2
        gR8+eHEFl53cQaHtUygWV4R5cePROzVQOVvfOT5bHuxfV7raw2cPiHU9GUZkraR/
        KxtRMxypcQtaP0LbFU6buKNaessV7JEvxGoyMrz8nTWbHaf7aZlZLz9zVq4DUF9R
        TghfxgtWGkxAztbXnkXl/r/gnJzbcic4p/4K+6qBtMgj9qBUHZsiLaOSYD03GhVv
        +vZOt73FIAA6T7oJ5yljyHL7GXfY27iL3XAULH4UctGzrOnlJwr/TkH3Ql++a0WU
        u4lC87Tu7vNlUhDqXoKkg==
X-ME-Sender: <xms:lg39Y__zZTux_o_-G1yZPezWFGga-j5KhRsUqj3fFW9Mh875w31NyQ>
    <xme:lg39Y7sZqjzxxzgF42Ds9JbZ6VjF26sVRp2KdM7Ole_R9G5XX2Hp1rzOTgWhlmLjf
    8zloqIu4CeTMmf1lA>
X-ME-Received: <xmr:lg39Y9BOT4H4jgWoAcIQ8bX0UMncNypmFtScBbJh16Vw7r8zveTT8qfU9E69vJAxGh3w4SkFPdF4W98tMbZieL7OzqAOZbUxZtac9ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepff
    fhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeffrghnihgvlhcuighu
    uceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgedvjeevuedvie
    fgjeejueefhfffteefkedutdduvdeutdeuffdvjeelheegteffnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:lg39Y7faNpwSJql9jwv_CDj1U5R75EU80okxu_Rj3q1YaYuvjCH0JQ>
    <xmx:lg39Y0NO01q24CxZ7VGWhrdwbKcv2vZBGmbfvz4p1LVlf0B0ULI7Yw>
    <xmx:lg39Y9kg80TcdnK2Z0fSYoNnQ0WElwYm2nq2ILn01EfA4_S9ee_vXQ>
    <xmx:lg39Y-3ls5VCoOp5f2eU-vYHkimh_Cz7Z6RD2ScAdPIr_dh4UDQecA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 15:07:49 -0500 (EST)
Date:   Mon, 27 Feb 2023 13:07:48 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Batteries-included symbolization with blazesym
Message-ID: <20230227200748.xdkhnht2w4mtbj2u@kashmir.localdomain>
References: <20230227193456.jbxt3mba6xfntieu@muellerd-fedora-PC2BDTX9>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227193456.jbxt3mba6xfntieu@muellerd-fedora-PC2BDTX9>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Mon, Feb 27, 2023 at 07:34:56PM +0000, Daniel Müller wrote:
> Symbolization of addresses is a commonly encountered problem, maybe most so in
> the context of BPF and tracing with the capturing of stack traces. Perhaps
> superficially straightforward-looking, there a variety of considerations and
> intricacies, such as:
> - different formats/standards (e.g., ELF symbol information, DWARF, GSYM) cater
>   to different use cases and require vastly different steps to work with
>   - on top of that, even if a library such as libelf or libdwarf is relied on,
>     plenty of format specific details need to be known to symbolize addresses
>     properly
> - discovery of symbolization sources (e.g., DWARF debug files)
> - symbolization trade-offs (performance, memory usage)
> - system-specific details and corner cases
> 
> We are working on blazesym [0], a library that aims to provide users with a
> batteries-included experience for symbolizing addresses (but also the reverse:
> mapping symbols to addresses).
> 
> We would like to provide a brief overview of the library and its goals and then
> open up for discussion. Some topics we are specifically interested in
> understanding better:
> - What are current issues with symbolization that would be great to support?
> - Does the usage of Rust pose a problem in your context? (C bindings are
>   available, but a Rust toolchain is required for building; are pre-built
>   binaries and packages for common distributions sufficient for your use cases?)
> 
> In general, we'd be interested in hearing your use cases and in discussing
> whether blazesym is a fit or could be made to work.

I didn't look super close at blazesym yet, but was wondering if it would
support a use case I have in mind.

Context is it's tricky to determine why a packet was dropped by kernel.
kfree_skb_reason() with caller address in `location` is a good start but
we can do better I think.

The issue is the call stack alone is not enough detail. I want to see
all the branches taken in the case a single call frame has multiple ways
to drop.

Vague idea is to use the recent LBR work (also haven't looked hard yet,
so this may not be possible) to take LBR stack at
`tracepoint:skb:kfree_skb` tracepoint. Then map the branches to line
numbers.

So my question is this: can/will blazesym be able to map kernel
addresses to line numbers / file names?

Thanks,
Daniel
