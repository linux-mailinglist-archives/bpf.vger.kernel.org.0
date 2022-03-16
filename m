Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6107E4DB141
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 14:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbiCPNWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiCPNWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 09:22:36 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F010AE;
        Wed, 16 Mar 2022 06:21:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BA62F32020D9;
        Wed, 16 Mar 2022 09:16:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 16 Mar 2022 09:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkourt.io; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=mesmtp; bh=90OeKVGOPpYqWEU3AOG66DxVVcdCRb3E77c
        fePRVBC0=; b=MWxdSfT861B2tYyIRaJ+WUyoikI+ZX/ZKtjkPE6nZIRXtxOouzg
        8KpXZIl0AFP52HDmWrSw3IThNZdBcNQeNZqqouoJ0M0TdEzHitIeMsMHuXj40r3q
        9FzEWSTIz6VLRRTVjtBsxUMWl0sT/bCPBJ6N9w0Gz1AQMloLWfyZibeg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=90OeKVGOPpYqWEU3A
        OG66DxVVcdCRb3E77cfePRVBC0=; b=kUn8kfdsDssEkJs9xDkx0+uLsI0LxzGkx
        gmOOHI+8wxUYDm9PjdeqRaFlHji7DyvaB45cpFbSbRw+NAZbjuDuSCml0Mku+XRS
        NJiJxial2dyxjCfm3S2d3/gMFLxqrv3hmMuFy5oArrTAXJbpk+EH5jpqT84Gc5SA
        UMfCeG/YvpvzAwZOUoD0Y9Vco0/f18xT8OcbAxvvtnqRV3d1MeFqBOoZOY3Di8UD
        QFigDpk/2iNUT+rvF6uEsLnU/TP88ze8LlLVZGJoJfN7geUFyo9ik0CS+SMmJX4O
        +BX7QOvL+Sm8QbVSqysA3FC+Ak07ZlqotQAuRe8jMRy40t+D5eq0Q==
X-ME-Sender: <xms:MeMxYoiRlM_UjO5ZBpk0v9vxfvogvrc_l7-E9RAImB5ZsmqR5WhhmQ>
    <xme:MeMxYhBDWD7_otaXemqKxHCWZ-hz1eqIL1fBkQ6mS7E_HqMIiBhMlLisORYed7xn1
    271C-gmfXBQ3pH0sw>
X-ME-Received: <xmr:MeMxYgFG9YGFHpyM87QpB2z82FrKucTUwI0VZfhHL1c3fvobYIftb6_CJf6WCrL4r-Gr01rpKgp9DVZoT4NLbYPKeUqX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepmfhorhhnihhlihhoshcumfhouhhrthhishcuoehkkhhouhhr
    theskhhkohhurhhtrdhioheqnecuggftrfgrthhtvghrnhepvefhtdelhefhhfekueefge
    fftdeufeehgeevffeltdeugeetvdeiueettdeuuefgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhkohhurhhtsehkkhhouhhrthdrihho
X-ME-Proxy: <xmx:MeMxYpQgI15Wrrp0PV1AtdRZyTNuzKqYTikTQjAW_MFDeTTWC1n8PQ>
    <xmx:MeMxYlyb7UBs9fVKPP2E6Ws9aqLHr5NXgm1HsxJygI-vMCExsA-5rg>
    <xmx:MeMxYn5qdqDPk1KwHonMDelOISi5zUUpVjLS0UizJcG5cVOnOWFO2Q>
    <xmx:MeMxYt9hRsdVX6ce1HQiRmZho2KGcNmBPMpm8dBOCE5GrDJqAv6oiA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Mar 2022 09:16:32 -0400 (EDT)
Received: by kkourt.io (Postfix, from userid 1000)
        id 371C82541AD8; Wed, 16 Mar 2022 14:16:30 +0100 (CET)
Date:   Wed, 16 Mar 2022 14:16:30 +0100
From:   Kornilios Kourtis <kkourt@kkourt.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: Re: [PATCH] pahole: avoid segfault when parsing a problematic file
Message-ID: <YjHjLkYBk/XfXSK0@tinh>
References: <20220304113821.2366328-1-kkourt@kkourt.io>
 <YiOw06rlBwdw2uYx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiOw06rlBwdw2uYx@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

Apologies for the delayed reply.

On Sat, Mar 05, 2022 at 03:49:55PM -0300, Arnaldo Carvalho de Melo wrote:
> Can you break this into two patches, one for checking dwfl_getmodules()
> failure and the second setting errno?
> 
> We should try to avoid these patches that do multiple fixes, as
> sometimes one of the fixes isn't really correct and we end up not being
> able to use 'git revert' which should be the case when we figure out
> that some previous fix wasn't correct.

Yap, makes perfect sense. I will reply to this email with the two patches
momentarily.

-- 
Kornilios Kourtis.
