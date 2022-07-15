Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB525767AF
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGOTqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGOTqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 15:46:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2076A13F49;
        Fri, 15 Jul 2022 12:46:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0D1AE3200D25;
        Fri, 15 Jul 2022 15:46:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Jul 2022 15:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1657914377; x=1658000777; bh=ECRZbqD30U
        /yjZK+otG1kCGiTz9MGMJ0mNBRNxu2Ji8=; b=tWuwEKeCg0cT1B6In+V9K+1Rad
        sttYpa1HFhdm6bRRhSjkCTgXEokQfmGJwFRCJQUJOYbXkyTGg2hmHVIGyEccjGUV
        fgTzCu5ZEBRMlil3GQ0dyrtvWf4RMUwtGzuBwrNHkg/nzWVwKUVZOdxlbu5JpdJu
        lXZjUMhE0FhgMitd90NU7mN5NAr9lczkQ68uNLzz/r7d8SaQIfLFLuv9+Fow8nur
        Dd4g0Lm9YsgkqFYQq/P9Nd9hch/LDcO4ejs1g3bDa7MGAGmHHlHhw7qK9TMIPVm6
        eKpH/OwKKWJQFza11CoG2kKu1gIFj8ZHmk0WXBBtuoyADVHvJYs6vqS+do+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657914377; x=1658000777; bh=ECRZbqD30U/yjZK+otG1kCGiTz9M
        GMJ0mNBRNxu2Ji8=; b=oxr84gMx8t417a4Wgq7NvUVOZ5yxPJAaW0WWFrrWA8/k
        J4zAHzQlnWnYveujvINORMIm1KcyAj6t7FIYgxFfOVSxhc8pldvY8ifI9V9hrjg2
        7Hp6sqdtd0OBbhR1ysf+Tp8LDZshHVYvjBMt+L2KH1cqJJEYUZAAxKDXq5NelxCy
        5nRw71cN9Ks6gmZxi40vhBCNyacPru/cqX26JIljY9UGVK2JW5M2K7fuD2n4SO4D
        GDRda5ce0cd3+rbABW7OuV8UO0FYOdz2vsxh+T3lWTeu5Z1C1CaxnMIWx6q0aG7F
        bDT08uwHbC8irnfCJ+oA79wVuoI6JIKILvMXy/Mnsg==
X-ME-Sender: <xms:CcTRYoC2KpPBGiZPd9PsrZwIi_-F3WqP6yM-Qlz7CHuUT_7e4qD3dg>
    <xme:CcTRYqjQHI-iEfSQyfrSCTlxoK13e0HzgbkqvAOzVWUE3i0RF8VnDd15NbE1Y5G6g
    1mX_oZ2ujyYY9LezQ>
X-ME-Received: <xmr:CcTRYrkf_NTB3qZj_NOBR1kcJl_nT1aM2VkFiB9C5V1z3rjtYBCo99Kcprsh2QVeDcy1g6-J-bokBmtBkLczX6R-kae8_e1IH3X3hWDbbORg9AYP1uv6wo3AQCRS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekuddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:CcTRYuwjSSUq5-vqESX8JCvxmBvAhhazQhqJO6qb7FwmmthMFQigRQ>
    <xmx:CcTRYtQXPphv7gKdc_PxsN4dkWt0H_BzAVfulV1jVdhEHpa-I7vw0A>
    <xmx:CcTRYpY5L-xZu2FM-BNrFF5XGYYia_8zVRMge7JjAAvLsaol3JRfrA>
    <xmx:CcTRYmIRZwXg1AXLNHKNpg_zawyk8p1Z1tbFaspDMhqWEEg0EGc2NQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 15:46:17 -0400 (EDT)
Date:   Fri, 15 Jul 2022 12:46:16 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v2 2/5] tools include: add dis-asm-compat.h to handle
 version differences
Message-ID: <20220715194616.6w7ra6mcdvfsmld3@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <20220703212551.1114923-3-andres@anarazel.de>
 <fc1be6d4-446b-2b34-21cb-5e364742c3a2@isovalent.com>
 <20220715193927.x6xy4h7n5rrh2ndc@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715193927.x6xy4h7n5rrh2ndc@awork3.anarazel.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-15 12:39:27 -0700, Andres Freund wrote:
> On 2022-07-05 14:44:07 +0100, Quentin Monnet wrote:
> > > diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
> > > new file mode 100644
> > > index 000000000000..d1d003ee3e2f
> > > --- /dev/null
> > > +++ b/tools/include/tools/dis-asm-compat.h
> > > @@ -0,0 +1,53 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > 
> > Any chance you could contribute this wrapper as dual-licenced
> > (GPL-2.0-only OR BSD-2-Clause), for better compatibility with the rest
> > of bpftool's code?
> 
> Happy to do that from my end - however, right now it includes
> linux/compiler.h, which is GPL-2.0. I don't know what the policy around that
> is - is it just a statement about the licence of the header itself, or does it
> effectively include its dependencies?

FWIW, dis-asm.h itself is GPL-3-or-later.

Greetings,

Andres Freund
