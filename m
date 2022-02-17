Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7FD4B953F
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 02:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiBQBKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 20:10:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBQBKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 20:10:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C131D2AB538
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 17:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A91A61C9C
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 01:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76FDC340EC;
        Thu, 17 Feb 2022 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645060209;
        bh=29Y5TKFoB2rBORc1oh0yqIbC+tZoT5TR3mKHrTTFPF4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Iyuk/cowvaWNe/p7FyxgVdG+xO95HsnUCJZKLkGTTqNTpmo4W8QwxEZjBCI6o6sU5
         43qnMLFytKNLIRJcxXSc6A0jWMZOtgj/9P4Tr6e8GBHX1lFsZUcHXlrabO8/KMWrVe
         5VPuOUm0I8vhpsPFn6hLSgiBlOTWWVXY4IsfZBdbCZFEbPr9EJIEJ7tUZGO6od9Y88
         0mPjJF0iJjRJdkwE1WpnO9MWDQWD6nMFVp7Y9OJSoMi+g/YTK6+Z1/5FmwuGoc9gy6
         QRy9dSQz4REEXY7v/O4w2E/R8OOOCdCTwzkozdZLM/uAt6KY4PLkjvXb3h65LJaIlU
         CfZ0JdkIAStpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A17B2E6D4D5;
        Thu, 17 Feb 2022 01:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: fix C++ additions to skeleton
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164506020965.24047.4442618073418612648.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 01:10:09 +0000
References: <20220216233540.216642-1-andrii@kernel.org>
In-Reply-To: <20220216233540.216642-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 16 Feb 2022 15:35:40 -0800 you wrote:
> Mark C++-specific T::open() and other methods as static inline to avoid
> symbol redefinition when multiple files use the same skeleton header in
> an application.
> 
> Fixes: bb8ffe61ea45 ("bpftool: Add C++-specific open/load/etc skeleton wrappers")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: fix C++ additions to skeleton
    https://git.kernel.org/bpf/bpf-next/c/9b6eb0478dfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


