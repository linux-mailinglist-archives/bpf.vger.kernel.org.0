Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26035A860C
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiHaSuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiHaSuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 14:50:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1F8D3C2;
        Wed, 31 Aug 2022 11:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB92B8226F;
        Wed, 31 Aug 2022 18:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF695C433C1;
        Wed, 31 Aug 2022 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661971818;
        bh=XBDExukn3W/ryamnBQ+uoJ5iuzvy0qtEDpLmWP8pXoI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RHI0D/WzgelOz02OFO0wQyyhVhGeCwgrk9oIbQHrYq7/aYKWfOaeYwCX//JgeA+du
         FmyMpg8gPRFp5RINnSydK/vrgvveOU/CA7hIRqi3qtKgDe1b9GKAhxb71lvJ4imkZZ
         tb/isdokrhfQIyEWPduBnVKNxVa/8JWaxrnyX+2XTecc+oDQztDLdWUWOGCTOzd1At
         xQIQuGXhHUq+sv8loZn4nPQfhO4PQG0aazJZCvE0seVncJBJ7PGhb7nJBm6Hz0NSs2
         Zvnl2RKzfDgfAZ1wIKJ0YiIx65UGdUqPP8OhenkV4Esb99zep99L0j86Xv7eXfU8sb
         nPVzCGOIv8obw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FE16E924DB;
        Wed, 31 Aug 2022 18:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/tnum.h to BPF CORE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166197181865.21305.12137078236632378559.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 18:50:18 +0000
References: <20220831034039.17998-1-shung-hsi.yu@suse.com>
In-Reply-To: <20220831034039.17998-1-shung-hsi.yu@suse.com>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 31 Aug 2022 11:40:39 +0800 you wrote:
> Maintainers of the kerne/bpf/tnum.c are also the maintainers of the
> corresponding header file include/linux/tnum.h.
> 
> Add the file entry for include/linux/tnum.h to the appropriate section
> in MAINTAINERS.
> 
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Add include/linux/tnum.h to BPF CORE
    https://git.kernel.org/bpf/bpf/c/c829dba79736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


