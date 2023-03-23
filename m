Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC206C5B75
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 01:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCWAle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCWAlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 20:41:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C2E385;
        Wed, 22 Mar 2023 17:41:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B87A5C017F;
        Wed, 22 Mar 2023 20:41:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Mar 2023 20:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679532085; x=1679618485; bh=fw
        Wq3lyBha3V3xT4Js7aLvEkW2Q7xE4uLpJeFplJepE=; b=uv+uwFRK6+nvB4qrT4
        vVBfEpPVqREQc5djiGlsB0I4xjdipC6bZXnfFQmG7A5ZwFFJnD9l/SmvvhS+9HP1
        L7U7mT9NE4mYZi22ruXig6kWOx+5S0sZqI71MhQmqUCfFNkq5K4owJ1TfNAW3dzM
        6Ej2JdKIEN1fpv8q/iO3GePyGaip+ayln90mCfnGD9lsPUJrFuohvDxo0FnJrC+9
        6bduGz+PAYwp1Z4XCI7NiAsYRpZSnJgNF9xvVA0LPZn71clG+YztUaUBeBfOP6SR
        ynECfupuuLeA9LPlBPzxUrMlcFUnpASQgYmnQqMAFQfpTgiWHvmDy46lifgm4v8E
        0H4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679532085; x=1679618485; bh=fwWq3lyBha3V3
        xT4Js7aLvEkW2Q7xE4uLpJeFplJepE=; b=FvR50T7DyFxfApdEPBwe6mphUFvib
        UgnHWr3atHRURskhNfF2+qtgWIZc1uV57+n4/vcIYTsu19nDeOx30v3GyMuTA3Cl
        jCfo/Fa4B/BEK5SH+4NCSZTWSaLbDTDWubhuCwRUw1jqRKRDPLLQ873Esj8VynxG
        wPyai6W2VPDZVIz2EEBmSYwGqJL7ULhTnRZty0OCww5n44vr1HrxBl39fHkTc05c
        Cz+44jR82RGFKx88J5KiK18H8rOAcPEHk9nbzM0DdPX0SVeauH9LalG3m0WP/fqB
        8b0OQQjT2abTFzwJJ3trQpBEW4WF+FWXcJlqxGNzOG+RJEWPIvzUoUBMw==
X-ME-Sender: <xms:NaAbZHRRjA75UK-WzHCgL_iFE7B9oJ0Jaqic7qU8UimSUDKSpK4igQ>
    <xme:NaAbZIwC0zma-GywvqhsrdDxG-M0AkvPK8N4SjW-j1-JlnjIzZOsJKRkNvUhS9a1r
    vncy9UdxVZ0ggK-3g>
X-ME-Received: <xmr:NaAbZM01kuszEErgnshVMeXIuWg666qfxSZpQEzKXZHTHf4cMCmTITNuNTye43NIWqoM-mRC_E48y6CgA49eVtWL5DcMIuOj3Wcev6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepheeltedvgffhgfduudelleeguddtueefgfefvdeukeffvdeg
    uddtvdeuteehteevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:NaAbZHCCdk0gowZXZg_tYnfaIcoJV6n5-b0AwB0JIyIo4R1wOZTbOA>
    <xmx:NaAbZAjuKRCkafcizG9Dse53QND-DeX6R-lAC0pBMFrk5sk6rFLVbQ>
    <xmx:NaAbZLol_G0qMSR43uuCZDcMeq93eWgCAP_JbTXZ7IIoprLisRLj_Q>
    <xmx:NaAbZDu0MTz8qLFuTmuCqWFdpCbsZwMjIzDJFw3-HVQsdiciWvwa-w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 20:41:24 -0400 (EDT)
Date:   Wed, 22 Mar 2023 18:41:23 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Florian Westphal <fw@strlen.de>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC v2 bpf-next 1/3] bpf: add bpf_link support for
 BPF_NETFILTER programs
Message-ID: <20230323004123.lkdsxqqto55fs462@kashmir.localdomain>
References: <20230302172757.9548-1-fw@strlen.de>
 <20230302172757.9548-2-fw@strlen.de>
 <ZAEG1gtoXl125GlW@google.com>
 <20230303002752.GA4300@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303002752.GA4300@breakpoint.cc>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Florian, Stan,

On Fri, Mar 03, 2023 at 01:27:52AM +0100, Florian Westphal wrote:
> Stanislav Fomichev <sdf@google.com> wrote:
> > On 03/02, Florian Westphal wrote:
> > > +			struct {
> > > +				__u32		pf;
> > > +				__u32		hooknum;
> > > +				__s32		prio;
> > > +			} netfilter;
> > 
> > For recent tc BPF program extensions, we've discussed that it might be
> > better
> > to have an option to attach program before/after another one in the chain.
> > So the API essentially would receive a before/after flag + fd/id of the
> >
> > Should we do something similar here? See [0] for the original
> > discussion.
> > 
> > 0: https://lore.kernel.org/bpf/YzzWDqAmN5DRTupQ@google.com/
> 
> Thanks for the pointer, I will have a look.
> 
> The above exposes the "prio" of netfilter hooks, so someone
> that needs their hook to run early on, say, before netfilters
> nat engine, could just use INT_MIN.
> 
> We could -- for nf bpf -- make the bpf_link fail if a hook
> with the same priority already exists to avoid the "undefined
> behaviour" here (same prio means register order decides what
> hook function runs first ...).
> 
> This could be relevant if you have e.g. one bpf program collecting
> statistics vs. one doing drops.
> 
> I'll dig though the thread and would try to mimic the tc link
> mechanism as close as possible.

While I think the direction the TC link discussion took is totally fine,
TC has the advantage (IIUC) of being a somewhat isolated hook. Meaning
it does not make sense for a user to mix priority values && before/after
semantics.

Netfilter is different in that there is by default modules active with
fixed priority values. So mixing in before/after semantics here could
get confusing.

Thanks,
Daniel
