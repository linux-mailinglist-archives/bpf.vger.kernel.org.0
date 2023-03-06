Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6DE6ACD95
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 20:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCFTIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 14:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCFTIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 14:08:07 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35B28235
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 11:08:05 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6B6EC320031A;
        Mon,  6 Mar 2023 14:08:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Mar 2023 14:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1678129682; x=1678216082; bh=M0
        KjM6Xy6NuCHLOWX5Aw2dLCeZ3nec4AG1m4+XJ4DQE=; b=s/hnYzmVjbaM0AGal1
        C+WT2gA7ozYp6alCm9tjH+Rm7x3hvsMkb7hzwUo6o5iTEnVNe/pGUdbPP6lRddWc
        70ZTXhwIOYfgZ6Gy9Jm9f4h21X7d9dHe7B+ozB5GEKG7AiOhcCvocx+NB5M9h+xO
        jOpc/SEFazOTg/kqmB8s5PZvgf78mpWQMpuc9OJP4nvvJf5EwvuoEUoKHw5WLsOX
        yVvNHIDtJgNXLtxZ3IJIxLvRE6rCO1eZZfcU9wvAqAM67SUTwFEMqTlVYL//R69a
        yYUwAQpnwbNESBN3AxZyOn35d26LDLbt1/y1XG4/+RAmRZ/WH4iWtFgCuLCtPvNz
        kdXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678129682; x=1678216082; bh=M0KjM6Xy6NuCH
        LOWX5Aw2dLCeZ3nec4AG1m4+XJ4DQE=; b=B2mejyV/YfGF87g7OCquDUUTHV2Bi
        WFCiw3y1Cm5VmnpwGxX32todIspYo9192tTKPvKiWOsvboasHgj214Eyt3DxI1iR
        rHDv15WHXNBQsCDkcllw/nupk8hKKG//VBbGwSMa2kl18FDRZQvMdrpXH9ZnyFpp
        AKVrisnFglUFbuSE+V67XIiisR/UE9yEbRcnIorNOQ4A0AuSJj5w29TIbTsyDEbP
        Rm2ccEFe8Ng7Zmj/v8jbmZBPHiqytYo7Ao+LAfqI9DYI1OPc1F7R3qHkKvM8ENDy
        awSjyAAmLqDlebrmbVnJnmrKZM4HuUyaBOxwLtkUkMU3NhLmHbiGUuiZw==
X-ME-Sender: <xms:EToGZJpVHtF7IsCP2VGtq0G6dy2gE0aed4PaLEpGj2uVfh1ldUm7mw>
    <xme:EToGZLrqwAgEKbhRIfEO0QKtnbNPRVpOFsF-aseb3xpUec_g59hD3mCap2IZ2hfrS
    6aNCAkmWknY_nbrIQ>
X-ME-Received: <xmr:EToGZGNl37ManwvO1-hp4iMIN5rAt9yVxZYUYHC045fciNUd4dYNKH0ZqqPtydU92OS_rjfER2XoJ3OFF9Q1brAIkFKTL3jnCIkTXaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepffffvdefhfduhfefjeejvdeiudeigfdvgffhjeekheeuuefh
    vdeifedtuefgfffhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:EToGZE6JXOFras--2fOlchs_OBLnuJAxAYu8IR1hV4aUYUoz_JZa8Q>
    <xmx:EToGZI5O7ovJYx3Cub3W9bDob0CwUe_TzGN9tFV0d8xjqgFcaOphxA>
    <xmx:EToGZMii2b7G7uasSZoi3zhu01Pld8fDiWIHvlt4dxHQbEC37Av_dw>
    <xmx:EjoGZGQw0uu9Scm9SX2bdyjKKb_J8hBMdP5oxBl6cpJFLCS8Pz35Rg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Mar 2023 14:08:01 -0500 (EST)
Date:   Mon, 6 Mar 2023 12:07:54 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] vmtest: Reusable virtual machine
 testing infrastructure
Message-ID: <20230306190754.sxlq4faiigclsiec@kashmir.localdomain>
References: <f1ea109c-5f07-4734-83f5-12c4252fa5ae@app.fastmail.com>
 <CAEzrpqcC4Z_wpcnfVp8oL5-k8s9RL=W=9rz5Z6P5emd3w1tndw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcC4Z_wpcnfVp8oL5-k8s9RL=W=9rz5Z6P5emd3w1tndw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Josef,

Sorry about the late reply; I messed up my domain last week and emails
were getting black holed.

On Tue, Feb 28, 2023 at 10:38:18AM -0500, Josef Bacik wrote:
> On Mon, Feb 27, 2023 at 6:02 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > === Introduction ===
> >
> > Testing is paradoxically one of BPF's great strengths as well as one of it's
> > current weaknesses. Fortunately, this weakness is not too far from being
> > corrected.
> >
> > BPF_PROG_RUN is somewhat of a double edged sword. On the one hand, you can run
> > reproducibly run progs in near-production context. On the other hand, since BPF
> > is so deeply intertwined with the running kernel, you must make the kernel you
> > run tests on as close to your production kernel as possible to get full testing
> > benefits.
> >
> > This is going to be more of an issue going forward through the growth of kfuncs
> > because kfuncs do not possess a stable ABI [5]. Proper testing should be
> > encouraged at a community-wide level in order to avoid accidental surprises and
> > potential loss of faith in BPF "stability".
> >
> > Most successful kernel-dependent projects deploy some form of
> > virtual-machine-based testing [1][2][3][4] to solve the above issues. However,
> > there are two problems with this:
> >
> > 1. VM-based testing is not quite common knowledge yet and remains somewhat of
> >    a dark art to successfully implement.
> >
> > 2. Multiple implementations of what is essentially the same thing is somewhat
> >    of a drain on resources.
> >
> > (These are not necessarily bad things -- it is useful and necessary to explore a
> > problem space before settling on best practices)
> >
> > vmtest [0] aims to solve both problems.
> >
> > === Goals ===
> >
> > I'd like to do a short presentation on the design and ideas behind vmtest. I'd
> > also like to show a quick demo. It shouldn't take very long. I'll probably
> > also share what I'd like to implement next. I don't know what that's going
> > to be at time of writing b/c I'm probably going to get to it before LSFMMBPF.
> >
> > For the rest of the time I'd like to discuss what the community would like to
> > see in vmtest. And to hear what it'd take to see adoption from other projects.
> > Obviously no one can be required to adopt vmtest but I think it'll save everyone
> > a good deal of effort if done correctly.
> >
> 
> FYI a lot of us have been working on kdevops
> (https://github.com/linux-kdevops/kdevops), which has similar goals,
> tho yours feels more in line with virt-me which I've used a bunch as
> well.
> 
> I would very much love it if we could all get behind one project.  The
> benefit of kdevops is it's very extensible, and being able to select
> some config options and have an entire testing suite up and running is
> very handy for new developers.

Thanks for the tip; I had not heard of kdevops. I'll spend some time
this week playing with it.

> That being said I can definitely get behind have two sort of options,
> the bigger swiss army knife that is kdevops, and something smaller
> that's easier to do one-off runs.
> 
> kdevops using vagrant makes a lot of the pain of setting up the full
> VM environments that existed before go away.  I can easily tear down
> my 8 CI vm's and rebuild them all and having them testing again in 4
> commands.  Nowadays I probably wouldn't use virt-me/anything lighter
> because this is actually pretty easy to get up and running.
> 
> Again no trying to be discouraging, but you're absolutely right that
> there's been a lot of fragmentation here, which is why I've spent
> probably a lot more time than I should have making kdevops work for
> me, as well have a lot of other kernel developers, and it's getting
> pretty solid.  Thanks,

Yep, ideally I'd like to have pulled something off the shelf and moved
on. But nothing looked like it would solve my problem. So if kdevops is
close enough then I wouldn't mind contributing to that instead.


Thanks,
Daniel
