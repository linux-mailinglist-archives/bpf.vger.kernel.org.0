Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED6587036
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHASKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiHASK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:10:29 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D29B120BC;
        Mon,  1 Aug 2022 11:10:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 70CE75C012E;
        Mon,  1 Aug 2022 14:10:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 01 Aug 2022 14:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659377427; x=1659463827; bh=LogpDSeo1A
        6PXvYxv3ErSmrzLvCcwrfut/h5Re9qqjU=; b=PLXtmaifjVtwiRqc3fWArR4Zwf
        9/JCeW0dOPx7qcV6AfwYG/akFaitXHXAgM0fhO7sBhogxXGVsMpMByXS2J/ZbFF9
        SGkXF3OWLhsNC1kyRbqw86CBSVnbBZAC7lu00KVNc2jubKge8H2wYQpmk9YfbNPs
        FFE6zbiUd8EUe+jASnL3XspDe3fHd0nozj74IWTDXz+r0mxbxf8ffmg+VOYjjaw4
        ZJwivOhTDgUaP+sXYliBsxw1kb9csKHkp4dZuFV7ziLpXWFkhZIiqWgBIxJvdJf6
        TplOlbaG0vQo8E1Y2Qd6sUZ7X8jw/nyHeF2FH0zxF7I6dRNddtBk4ZcnjHNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659377427; x=1659463827; bh=LogpDSeo1A6PXvYxv3ErSmrzLvCc
        wrfut/h5Re9qqjU=; b=Bp+AI7ukIM4IGuUXrqCEuQfHRHQVm34XOgZdd6pvuw2F
        L4DFnTQhIlHI+2bs4kAIo1noTaZpVZzzwX2bHdpkqQF/TI2TCYRZk2ODiacB5sYM
        o3iY8kWv1sALjOZREc7qthSUtxklIh4RtlFvQDkmnNx2CP3cmUrbfwM3FEvbrNzt
        RjmSvB5LmT7izqFyju13f0UlzCR0SxfyPOmokZ3K68UbHVHkQpWiOERX9ppJnOCw
        u4R7VrRQH4eHp48zX2cuZHm7viciPVIAOyBHrS8//H/ED/p7RFg7hfB3T7hhKlHI
        0s/BJTikHNP4iIeziNqwBS+x5Ys3fNBFMYlN1g12WQ==
X-ME-Sender: <xms:ExfoYu9Nrpixf5tnWJ2okvmxXgps9hy1xZaJ5csF3U13YcbaeNPiNQ>
    <xme:ExfoYusEhv6wt5rDjqDhGDZYw1bCmmz4JHAiGShXFWe3C8Vs0hCRnB_AxIydGDyVN
    Gtv2WL1JWT8SndfQQ>
X-ME-Received: <xmr:ExfoYkCSfxHQaZskJzj4hDHJtsqCuBPHCJCsQ_UPoMZQwZN2uKxHEGOrAMfPr1OaNZyVZYT8NE0lTp6PGfqBngVG9DReZ5fK4F_0qQykD6gQd4-v1zt8ASJc2Pcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeuteevjefgvdeuteelkeekgedtleefgfffieefffdvheejueejheff
    lefhhfdvleenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:ExfoYmcxmqjzIj4mMSXuVvF3B8FaQSKQkW9E9ifAXeT2LenKrxHRCA>
    <xmx:ExfoYjNXQWv6LOGCYrSkjydwa8NMxQl5o1yHOkQHVnDaai_-zm9gjQ>
    <xmx:ExfoYgmPFH2kYFbIF4fvJEFJWzGq0RidtHhz65wgDp2jEmyWmJLKgg>
    <xmx:ExfoYuef9vi1vjR4kzZw7VE63oWOUv9f6yEkEVO9EFk6sv4NfZ7Iog>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 14:10:26 -0400 (EDT)
Date:   Mon, 1 Aug 2022 11:10:25 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ben Hutchings <benh@debian.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v3 3/8] tools include: add dis-asm-compat.h to handle
 version differences
Message-ID: <20220801181025.xcgiui7hmp3rfmyr@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <20220801013834.156015-4-andres@anarazel.de>
 <YugVzJqQhp2rYRvS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YugVzJqQhp2rYRvS@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-08-01 15:05:00 -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jul 31, 2022 at 06:38:29PM -0700, Andres Freund escreveu:
> > binutils changed the signature of init_disassemble_info(), which now causes
> > compilation failures for tools/{perf,bpf}, e.g. on debian unstable.
> > Relevant binutils commit:
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> > 
> > This commit introduces a wrapper for init_disassemble_info(), to avoid
> > spreading #ifdef DISASM_INIT_STYLED to a bunch of places. Subsequent
> > commits will use it to fix the build failures.
> > 
> > It likely is worth adding a wrapper for disassember(), to avoid the already
> > existing DISASM_FOUR_ARGS_SIGNATURE ifdefery.
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Cc: Quentin Monnet <quentin@isovalent.com>
> > Cc: Ben Hutchings <benh@debian.org>
> > Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> > Signed-off-by: Andres Freund <andres@anarazel.de>
> > Signed-off-by: Ben Hutchings <benh@debian.org>
> 
> So, who is the author of this patch? Ben? b4 complained about it:

I squashed a fixup of Ben into my patch (moving the include in annotate.c into
the HAVE_LIBBFD_SUPPORT section). I don't know what the proper procedure is
for that - I'd asked in
https://lore.kernel.org/20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de


> NOTE: some trailers ignored due to from/email mismatches:
>     ! Trailer: Signed-off-by: Ben Hutchings <benh@debian.org>
>      Msg From: Andres Freund <andres@anarazel.de>
> NOTE: Rerun with -S to apply them anyway
> 
> If it is Ben, then we would need a:
> 
> From: Ben Hutchings <benh@debian.org>
> 
> At the beginning of the patch, right?

I don't know, I interact with the kernel processes too rarely...

Greetings,

Andres Freund
