Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E14E31F7
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 21:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348426AbiCUUlk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbiCUUlj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 16:41:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0804F44747
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 13:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 450FBCE1B74
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 20:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61A60C340ED;
        Mon, 21 Mar 2022 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647895210;
        bh=TOYKhHMHyN3F5R78Ive6XKQZxol/NX+JHmMCX+7pt0Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=twAx+Z6HopCgkTwgZmed6Kt25E0Qj5gNOPmcGBO1W7Kpos9dZzoRF/gNlO/scyGFx
         YA5ijJdT3c9E8jom1cW6DUL0d+XBg/k/EnXZq6OdMyo/pzPkaqxUbHmfzb+gUaSIVt
         OkSpGlK2G5K+jVPtXr76NN07x8dzvvhfKK55JM9ad3isLW7eoOWFUZG2javc7LUj/S
         FyCkwEVkgOJmL9V4dS4DfYxuNqT3a+6hMmEnm41OFwuQWx2+Zjf41vpogDha9/39js
         0GcGWthJ41thRaoy5yUTph5KVxdIAlfydXgYu6c4O3NuMNFPvQxlivq1kKDpGJnqxZ
         bLCPSz/q0koVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E2B5EAC081;
        Mon, 21 Mar 2022 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Fix warning for cast from restricted gfp_t
 in verifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164789521025.3088.14103262317824238657.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 20:40:10 +0000
References: <20220321185802.824223-1-joannekoong@fb.com>
In-Reply-To: <20220321185802.824223-1-joannekoong@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com, lkp@intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 21 Mar 2022 11:58:02 -0700 you wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
> 
> This fixes the sparse warning reported by the kernel test robot:
> 
> kernel/bpf/verifier.c:13499:47: sparse: warning: cast from restricted gfp_t
> kernel/bpf/verifier.c:13501:47: sparse: warning: cast from restricted gfp_t
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Fix warning for cast from restricted gfp_t in verifier
    https://git.kernel.org/bpf/bpf-next/c/d56c9fe6a068

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


