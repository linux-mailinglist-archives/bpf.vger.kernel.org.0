Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48D6A9128
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCCGkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 01:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCCGkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 01:40:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB21A94F;
        Thu,  2 Mar 2023 22:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4719B816AC;
        Fri,  3 Mar 2023 06:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FD3C4339B;
        Fri,  3 Mar 2023 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677825618;
        bh=SCT65/hEhJMVaOSLVrGjxCO1zJTq0Ndx9TI8a0xEkEU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OXvPaR5evAgcABaP29gQ1oD5m64LSQlPwzIiCF7xuB1Jpfp3QSNl3qjHdnD248BrF
         7AUvybeMzWSAXHCzE1QwxCKW9zY1k1q85IxfzxeX9JnVueIKZhza1bppIiAJ1ha3EJ
         /7ZgIypEcUn/1Cce+fvM4nyhJ1t7YH8qOET8It061HPx0fs7+rZ2X5FlDRvUgpJQhK
         Aw456CxgdhqBSXvp0y5Au3CHGeK7QegQ8IWmH2HdwUSH2dqS/En6aNVtydwAx4rup+
         lsnCExA+6Ki9WKBlvy1v0L16v6h0kB1iTdcyyKFAYX5klqTi9zM0dnph7Ksb5kJ9iL
         dWPCCJLmRYj3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64691E68D5F;
        Fri,  3 Mar 2023 06:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf, docs: Fix link to netdev-FAQ target
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167782561840.15961.16103747256620237171.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Mar 2023 06:40:18 +0000
References: <20230302183918.54190-1-void@manifault.com>
In-Reply-To: <20230302183918.54190-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Mar 2023 12:39:17 -0600 you wrote:
> The BPF devel Q&A documentation page makes frequent reference to the
> netdev-QA page via the netdev-FAQ rst link. This link is currently
> broken, as is evidenced by the build output when making BPF docs:
> 
> ./Documentation/bpf/bpf_devel_QA.rst:150: WARNING: undefined label: 'netdev-faq'
> ./Documentation/bpf/bpf_devel_QA.rst:206: WARNING: undefined label: 'netdev-faq'
> ./Documentation/bpf/bpf_devel_QA.rst:231: WARNING: undefined label: 'netdev-faq'
> ./Documentation/bpf/bpf_devel_QA.rst:396: WARNING: undefined label: 'netdev-faq'
> ./Documentation/bpf/bpf_devel_QA.rst:412: WARNING: undefined label: 'netdev-faq'
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, docs: Fix link to netdev-FAQ target
    https://git.kernel.org/bpf/bpf-next/c/d56b0c461d19
  - [bpf-next,2/2] bpf, docs: Fix final bpf docs build failure
    https://git.kernel.org/bpf/bpf-next/c/cacad346f67c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


