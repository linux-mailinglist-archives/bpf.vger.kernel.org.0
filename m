Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962457CB0F
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiGUNA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGUNAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 09:00:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038C26AD0;
        Thu, 21 Jul 2022 06:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F17DB824D1;
        Thu, 21 Jul 2022 13:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08EC5C341D2;
        Thu, 21 Jul 2022 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658408414;
        bh=SSIOkiVATINKESblwFrP/lP8zlxGhJckPLUFuO2J4mg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JKpQ9/F95mRS0hxT2DvPSmhETio99mSVlAmv9GokIqIZig20s7PP1oqKHqBK2HjL/
         /h1djsiOHr1UiOe7yZbQwoFraJjPgLjENBjqDD3xMZ/ReWC8uwbhYu7SPxd/bL81T3
         rDwV0V6cecz6FxlF5ooFiPFrnoPDKD5cBKrFFHL7Pdkcv4yKY8R+1C/i+GqrIP6SBd
         QAkN7E3QLEdmjuzIEXgJM6Umey44tY0jfvwv8gzTIKJelHAGv6WivFJqzBhcGGWfII
         XyMzGyt1g+uS2PFmhE5lYyYbdF2abhPuoM42ls8NYGPFa+l+9kULTb22+A2oGmyGEs
         /tg2dXEh9Gtsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1BE6E451B9;
        Thu, 21 Jul 2022 13:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165840841392.13235.13594925502325927326.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 13:00:13 +0000
References: <YtZ+/dAA195d99ak@kili>
In-Reply-To: <YtZ+/dAA195d99ak@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ast@kernel.org, alan.maguire@oracle.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 19 Jul 2022 12:53:01 +0300 you wrote:
> The return from strcmp() is inverted so the it returns true instead
> of false and vise versa.
> 
> Fixes: a1c9d61b19cb ("libbpf: Improve library identification for uprobe binary path resolution")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Spotted during review.  *cmp() functions should always have a comparison
> to zero.
> 	if (strcmp(a, b) < 0) {  <-- means a < b
> 	if (strcmp(a, b) >= 0) { <-- means a >= b
> 	if (strcmp(a, b) != 0) { <-- means a != b
> etc.
> 
> [...]

Here is the summary with links:
  - libbpf: fix str_has_sfx()
    https://git.kernel.org/bpf/bpf-next/c/14229b8153a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


