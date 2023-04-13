Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351F46E0DE1
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDMNAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMNAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 09:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613B49E5
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 06:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 074A563D54
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 13:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF6AC433D2;
        Thu, 13 Apr 2023 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681390818;
        bh=QHpwhWqeXegH8DSVyrYCQsjEkXlXYKwCPOgWisYVAEc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EV/VVXolRRIHxXCyVmwcbuteunLxscf9tMo7SosTOwwVoCFMijAgOPRw56ALQIy1a
         7PCoz0TjJpabyc2iccQLGBIwf5DsfQUDoeQJi/DNYpCruF8pXspHKzHsQJa3a2ozEG
         qkdOCXB/7fh0kAHpUiy0HuJdNLLSewAFRFrTRxkA8eiIFWfLOWO2BjbcoXKYSJoOrR
         Mk5CmDI9FNzlKPO/klTOfwogkSqHuDDxkA1fYNDoMj1GT0UHa4ICAyUa7pHv40dD8m
         zx24YNo+ash02UzENK6jrLNRq+tmTOK8SsLbuR3mxXZ+n8OdFpYwnYKFNDFeDCR2sS
         Asu78SKfr6Wyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4391FC395C5;
        Thu, 13 Apr 2023 13:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compiler warnings in bpf_testmod
 for kfuncs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168139081827.26604.14208479858222165341.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 13:00:18 +0000
References: <20230412034647.3968143-1-andrii@kernel.org>
In-Reply-To: <20230412034647.3968143-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com, lkp@intel.com
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

On Tue, 11 Apr 2023 20:46:47 -0700 you wrote:
> Add -Wmissing-prototypes ignore in bpf_testmod.c, similarly to what we
> do in kernel code proper.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304080951.l14IDv3n-lkp@intel.com/
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix compiler warnings in bpf_testmod for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/4099be372faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


