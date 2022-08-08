Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6258CA75
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbiHHOXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbiHHOXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AC101FF;
        Mon,  8 Aug 2022 07:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962DB60E08;
        Mon,  8 Aug 2022 14:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D918C433C1;
        Mon,  8 Aug 2022 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659968587;
        bh=Oi083GUnRL2Ooq6SehAATCVZjiwIxg1ihlElGrqV/kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fS5d5P8DoCknCPMWDBgZRxF7c3MRFWL9LW/t1k7j0KHMl3+oucSQufcfPlImfBoZq
         wR9uKymToHc7ayoPJ0zjPdWGWJtwcvUymn2aDpnzhI8WqD5oi/pORfM9AGS4GLEDHW
         KHfcC+wT7Usxv050rb+VZwyVWlzDzD24ghgWKfdM=
Date:   Mon, 8 Aug 2022 16:23:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     mingo@kernel.org, andrew.cooper3@citrix.com, bp@alien8.de,
        bp@suse.de, bpf@vger.kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH v3] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Message-ID: <YvEcSGxAh9qbOxPH@kroah.com>
References: <Yu66YlFzd4VRZq6/@gmail.com>
 <20220808141702.10439-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808141702.10439-1-kim.phillips@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 09:17:02AM -0500, Kim Phillips wrote:
> AMD's "Technical Guidance for Mitigating Branch Type Confusion,
> Rev. 1.0 2022-07-12" whitepaper, under section 6.1.2 "IBPB On
> Privileged Mode Entry / SMT Safety" says:
> 
> "Similar to the Jmp2Ret mitigation, if the code on the sibling thread
> cannot be trusted, software should set STIBP to 1 or disable SMT to
> ensure SMT safety when using this mitigation."
> 
> So, like already being done for retbleed=unret, the also for
> retbleed=ibpb, force STIBP on machines that have it, and report
> its SMT vulnerability status accordingly.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Fixes: 3ebc17006888 ("x86/bugs: Add retbleed=ibpb")
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
> v3:  "unret and ibpb mitigations" -> "UNRET and IBPB mitigations" (Mingo)
> v2:  Justify and explain STIBP's role with IBPB (Boris)
> 
>  .../admin-guide/kernel-parameters.txt         | 20 ++++++++++++++-----
>  arch/x86/kernel/cpu/bugs.c                    | 10 ++++++----
>  2 files changed, 21 insertions(+), 9 deletions(-)

Any specific reason you don't want this also backported to the stable
kernel branches that have the other retbleed fixes in them?

thanks,

greg k-h
