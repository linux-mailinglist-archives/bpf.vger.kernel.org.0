Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66E68F48D
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBHRa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjBHRaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:30:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3841BA;
        Wed,  8 Feb 2023 09:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52352B81F08;
        Wed,  8 Feb 2023 17:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEF0BC433EF;
        Wed,  8 Feb 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675877418;
        bh=EZINIVCMqvSUKPGqB56Yff7TFCb694mHXKW8jdBDJVI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gFTapzyjcOax/P0j5uIBPLYyZVbyh7vd191Q8FuL2RjJ6hKGgVUoDwBBCtSkUB4KX
         GXx+NCl1bf9/vQ5n9G4+Uh2pn3wv8IHMFzSgokKHb/ajNIG8/dni7qBPuKS46EFeZl
         Cm6oMZtHFHnnHt5oFGdlanGXH2m5jkq49NW3lC+6qlBii7Jl/mUR4xyaU69EFBhpN8
         n3A3tho9Bwt0MwssLk8uB1wG+yQMN70kSumU9pdPqejb6u0WthmN/A+5K8k5oZpB/Q
         +3H6dYwzL529UKTRswv2/Gk43HdInS+i8uIG8X0TP4qLGsAJntKCD56jSpCDIRLmqp
         /h+tGu93eX+7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C110CE55F06;
        Wed,  8 Feb 2023 17:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf/docs: Update design QA to be consistent with
 kfunc lifecycle docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167587741778.21324.9610371261971782580.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Feb 2023 17:30:17 +0000
References: <20230208164143.286392-1-toke@redhat.com>
In-Reply-To: <20230208164143.286392-1-toke@redhat.com>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, xiyou.wangcong@gmail.com,
        void@manifault.com, corbet@lwn.net, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Feb 2023 17:41:43 +0100 you wrote:
> Cong pointed out that there are some inconsistencies between the BPF design
> QA and the lifecycle expectations documentation we added for kfuncs. Let's
> update the QA file to be consistent with the kfunc docs, and add references
> where it makes sense. Also document that modules may export kfuncs now.
> 
> v3:
> - Grammar nit + ack from David
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf/docs: Update design QA to be consistent with kfunc lifecycle docs
    https://git.kernel.org/bpf/bpf-next/c/27b53b7364e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


