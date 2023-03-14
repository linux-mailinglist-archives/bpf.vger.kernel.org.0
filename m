Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23516B8A36
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 06:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCNFUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 01:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCNFUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 01:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FC5506D
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBBEA615C9
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 05:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AB78C4339B;
        Tue, 14 Mar 2023 05:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678771217;
        bh=42JLK61NwXkd7VUuG81ooQFxgiMWzdDe13ath731SbU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SFrSH+O2VsF5FsKiQeWLP2ER+pKwt046v78y404vE3DFIhOL2pnAOr1dKTUwytSLE
         bKvpf9M79IthIw0g0Jyg0VLkmx3IN5KcXRbmV3IPqr6DR0HmGn3/aHarUq11Urhc1a
         YqNnP5+B1DBtjvUZVZvDJ1M8RZM0urcK459sP/aUO92NzmZ629B2FnTwFok7Q4ilik
         CKymNh6VQDI2MmnDBOCape8M0A4pz4FXF/884r4cyRsLRAJL+6bNIqZneHOim7mQZq
         wtnHVmhZr0w2xsmcVTEwYTwQ0JAYVqBIgqjazzWWmKm7UzVW2jpsyXCrrYB1toZ98D
         13tabd4Kk9t2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF392E66CBD;
        Tue, 14 Mar 2023 05:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Add signed comparison example
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167877121697.23051.15228438821591357830.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 05:20:16 +0000
References: <20230310233814.4641-1-dthaler1968@googlemail.com>
In-Reply-To: <20230310233814.4641-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com
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

On Fri, 10 Mar 2023 23:38:14 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Improve clarity by adding an example of a signed comparison instruction
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: Add signed comparison example
    https://git.kernel.org/bpf/bpf-next/c/b9fe8e8d03d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


