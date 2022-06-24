Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D181559D06
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiFXPK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiFXPKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 11:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874C4CD74
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 08:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2DD9B8293B
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 15:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78CC9C341C0;
        Fri, 24 Jun 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656083413;
        bh=ItdlVkzei8qd7g0fN93HPHMMtZSUrxdcRa8wzCUFF78=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R3PygstUEqUw8wIOUzLXdZY8+uX/Zeb02TTfnv0kE6yBxubYPjBmUuBiZM66RZ9Uq
         4+Kg0wQoKlHlCT4DNU33yXeYxZUtBitZsZBZtbxebymkgkKBf6mLQgaimwcJrcq+AU
         qUqqA7GEwz2RL28gOqbWFF3PBPB5yi3bolF6sMhN6VIrof8UVYS6oRNdWU+Yoekdww
         5PtdLFfVcO2hhZrojzNB8jbQ7ueM94+tFg+kNOWVHwMSmBBMvuXemsEKJCRqM45yWK
         RyhA9VT1P9SOIOW2FbRvJNCdyZMzzi1C8oeK+63e5I0ot8BMuzbvRkK251F5McZMKp
         jUE10Yj8zuwcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5ED44E85B87;
        Fri, 24 Jun 2022 15:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: fix for use after free bug in
 inline_bpf_loop
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165608341338.10216.7762863388278881390.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Jun 2022 15:10:13 +0000
References: <20220624020613.548108-1-eddyz87@gmail.com>
In-Reply-To: <20220624020613.548108-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, dan.carpenter@oracle.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 24 Jun 2022 05:06:11 +0300 you wrote:
> These two patches fix the use after free bug in inline_bpf_loop()
> reported by Dan Carpenter. The fix for verifier.c and the test case in
> test_verifier.c are split into separate commits.
> 
> While the first patch is necessary, I'm not sure about the second. The
> test case is somewhat fragile because of the following line:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: fix for use after free bug in inline_bpf_loop
    https://git.kernel.org/bpf/bpf-next/c/fb4e3b33e3e7
  - [bpf-next,2/2] selftest/bpf: test for use after free bug fix in inline_bpf_loop
    https://git.kernel.org/bpf/bpf-next/c/41188e9e9def

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


