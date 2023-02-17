Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE369B163
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBQQvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBQQvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 11:51:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03606F3CE
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 08:50:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ED85B82D04
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 440FBC433EF;
        Fri, 17 Feb 2023 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676652618;
        bh=l4VH8oUUVAj2k1rP6HnvN/ocVcW5u3Qd96dWC727kew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qUh4Hoslh60K/iZn0C2lzOxQxqmXHhysYX1/66zNFaoerybFALpI7GvwwJldyyPzD
         lmKUWm42n7Gvlv84/9QvLBrdOAXxkglBZ0EJ4o8VRQxlNAcWfmKjZSSTRfZl99yDDL
         idoHxBU5omXG9cgE/penVs2TQTgl/ocb+uVjLPjJEvGKTdQhm+9L4aX1PTh3I9O/8k
         vMdIB9wF4yWT5+Mv9SgQ8gFtP9694HNgg1fDqUcDNFFqLc8GCV+zqia/p9z0CduQDO
         JROxFm6NgS9oFOvL+BPAn+056P6FhsHrQwC1eeCVT03JkthZVBa+aBJNVnTy7UrU7/
         dQoHW69MxMwGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A6B2C1614B;
        Fri, 17 Feb 2023 16:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] LoongArch: BPF: Use 4 instructions for function address in
 JIT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167665261816.376.14712223051383027532.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Feb 2023 16:50:18 +0000
References: <20230214152633.2265699-1-hengqi.chen@gmail.com>
In-Reply-To: <20230214152633.2265699-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 Feb 2023 15:26:33 +0000 you wrote:
> This patch fixes the following issue of function calls in JIT, like:
> 
>   [   29.346981] multi-func JIT bug 105 != 103
> 
> The issus can be reproduced by running the "inline simple bpf_loop call"
> verifier test.
> 
> [...]

Here is the summary with links:
  - [v2] LoongArch: BPF: Use 4 instructions for function address in JIT
    https://git.kernel.org/bpf/bpf-next/c/64f50f657572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


