Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9AB6C8368
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 18:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCXRdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXRdj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 13:33:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6EC64C;
        Fri, 24 Mar 2023 10:33:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E9D45C0097;
        Fri, 24 Mar 2023 13:33:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Mar 2023 13:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679679214; x=1679765614; bh=EuXYb9TeJZhs+tUOrapHWz7sygSXVApbwOk
        14wNE16s=; b=nOTse7+uDrlRg7b7vlEx2KpXor2QNwqDPvWMaKAXebUcIqvscny
        s4MTOc6g4YyAOJZ8nr5vkye3hgv5pEy2J2PydBLIYi0yk35jMt+4ftqh1z6lMdeE
        WD/9C7fRvFEywjTdn7PYhnboK6UWglpQoMKWaohZjNNPKlf05v77RntssD2hw6AN
        IDIRCfjNSm6IMlm/xuvP/Ukilb2O/kE8MzcxjzNIMUFIiMfIWM9S0tfqJQ2kU0ye
        YVZ4WQgLMsw+wjfsv4DId4uLQVs0pgV7OvBXgwrxM62HrK/Ta0nlW3Xq15tvxRoY
        A70q/mFN6IzsCdzvbh7ike1QSx8bCxFz/IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679679214; x=1679765614; bh=EuXYb9TeJZhs+tUOrapHWz7sygSXVApbwOk
        14wNE16s=; b=NMZ5XwAAnSbYRk6woyq83M0BhjPxYDBgXOS24zdFW5sJ5WxpuDg
        cFJfj4HiFQ3iVo6ATNf1iv8GC5lDETsqWuYAzKSEGLx76MKB2k5VI7LXYo6+kal1
        kDmWk99fm4ghUxD8sQ6SiqSr2oTq5bMBPWlUfnz7A5GofFq8JLtKL7J4FHiI3WKJ
        BJ76E3RAzKHKc03ZiYgX+uqk4oCq1tCVo9vfVdAVwu966FkliEXd0T4pc7v1LZMG
        DIohm+outBc1LHI5bzM6l7/qmLW5Tm/bxfPrjREHy3KsWBHUJlzzFr1nMJmTsbV5
        IFOKkvu6iACYhkUIINydt6gs45LuxupGvJA==
X-ME-Sender: <xms:7t4dZEp3pKGX8KSmDAkSPKQp_QYczNeuj4wvMPa-xOAlNEclKzr96A>
    <xme:7t4dZKpiYQKT-CAH1WOOzXa3hjKCJOxcK5spIsevYXEilqGIkPboe1yvlxcQyUvA1
    4JKXV0-6i5nkDfQZw>
X-ME-Received: <xmr:7t4dZJMWNNoTocfeERO-1pEZjROLRc_lzU-slDdGe5zcygz_GgOcf5tt2nEmIsYasoFX_xUqh4xoDFMR-BrObguox5ViBGLH6EFw4rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeer
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepgeetudevtdefvdegjeevgeehjeetgfeijeeutdehjeff
    tdfhkeelveetgedtleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:7t4dZL4a3UKgf3zN1jn2rnxZ0EBxs8PQ5kHxPq5UHVWuJ4HhlyTRKQ>
    <xmx:7t4dZD7blsU_8jjjzLZHdBhLp7hSXFbbCAVXFHvIAx0T0ftxYhJr5Q>
    <xmx:7t4dZLipQwx0vQQRe_r9f50hw33Zr8HzXzJJBxiGuHWYEoqrhXNuag>
    <xmx:7t4dZDHSXhldT2ZtqhKzVp_4a5tirnjOOepfM08G7IwcVA90wBr1yg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 13:33:33 -0400 (EDT)
Date:   Fri, 24 Mar 2023 11:33:32 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC v2 bpf-next 1/3] bpf: add bpf_link support for
 BPF_NETFILTER programs
Message-ID: <20230324173332.vt6wpjm4wqwcrdfs@kashmir.localdomain>
References: <20230302172757.9548-1-fw@strlen.de>
 <20230302172757.9548-2-fw@strlen.de>
 <ZAEG1gtoXl125GlW@google.com>
 <20230303002752.GA4300@breakpoint.cc>
 <20230323004123.lkdsxqqto55fs462@kashmir.localdomain>
 <CAKH8qBvw58QyazkSh2U80iVPmbMEOGY0T8dLKX5PWg4b+bxqMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBvw58QyazkSh2U80iVPmbMEOGY0T8dLKX5PWg4b+bxqMw@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Stan,

On Thu, Mar 23, 2023 at 11:31:14AM -0700, Stanislav Fomichev wrote:
> On Wed, Mar 22, 2023 at 5:41 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Florian, Stan,
> >
> > On Fri, Mar 03, 2023 at 01:27:52AM +0100, Florian Westphal wrote:
> > > Stanislav Fomichev <sdf@google.com> wrote:
> > > > On 03/02, Florian Westphal wrote:
> > > > > +                 struct {
> > > > > +                         __u32           pf;
> > > > > +                         __u32           hooknum;
> > > > > +                         __s32           prio;
> > > > > +                 } netfilter;
> > > >
> > > > For recent tc BPF program extensions, we've discussed that it might be
> > > > better
> > > > to have an option to attach program before/after another one in the chain.
> > > > So the API essentially would receive a before/after flag + fd/id of the
> > > >
> > > > Should we do something similar here? See [0] for the original
> > > > discussion.
> > > >
> > > > 0: https://lore.kernel.org/bpf/YzzWDqAmN5DRTupQ@google.com/
> > >
> > > Thanks for the pointer, I will have a look.
> > >
> > > The above exposes the "prio" of netfilter hooks, so someone
> > > that needs their hook to run early on, say, before netfilters
> > > nat engine, could just use INT_MIN.
> > >
> > > We could -- for nf bpf -- make the bpf_link fail if a hook
> > > with the same priority already exists to avoid the "undefined
> > > behaviour" here (same prio means register order decides what
> > > hook function runs first ...).
> > >
> > > This could be relevant if you have e.g. one bpf program collecting
> > > statistics vs. one doing drops.
> > >
> > > I'll dig though the thread and would try to mimic the tc link
> > > mechanism as close as possible.
> >
> > While I think the direction the TC link discussion took is totally fine,
> > TC has the advantage (IIUC) of being a somewhat isolated hook. Meaning
> > it does not make sense for a user to mix priority values && before/after
> > semantics.
> >
> > Netfilter is different in that there is by default modules active with
> > fixed priority values. So mixing in before/after semantics here could
> > get confusing.
> 
> I don't remember the details, so pls correct me, but last time I
> looked, this priority was basically an ordering within a hook?

Yeah, that is my understanding as well.

> And there were a bunch of kernel-hardcoded values. So either that
> whole story has to become a UAPI (so the bpf program knows
> before/after which kernel hook it has to run), or we need some other
> ordering mechanism.

I'm not sure what you mean by "whole story" but netfilter kernel modules
register via a priority value as well. As well as the modules the kernel
ships. So there's that to consider.

(I'm not sure what's the story with bpf vs kernel
> hooks interop, so maybe it's all moot?)
> Am I missing something? Can you share more about why those fixed
> priorities are fine?

I guess I wouldn't say it's ideal (for all the reasons brought up in the
previous discussion), but trying to use before/after semantics here
would necessarily pull in a netfilter rework too, no? Or maybe there's
some clever way to merge the two worlds and get both subsystems what
they want.

Thanks,
Daniel
