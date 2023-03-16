Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7A6BD71C
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 18:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCPRau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCPRas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 13:30:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1356C8898
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 10:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 691CFB822B3
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 242BBC4339B;
        Thu, 16 Mar 2023 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678987819;
        bh=QWYEG8d2xhj7242b2yfyil6aWIb6hfl1z6OTAb+iYU8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J0LsINhSzskXUztm22mQHPWVL6YKS4hdk1ClKr3BpgcRY+8eWQHiWiPGFxr3e4VbH
         ZPlb9bXwkHeZ6Or7uWcuZtg/X0lhmby7AhKH7glJv5LjXN7wNE3KWss6DwRSEtn3hE
         6sV97rCqPoIZpftv9prpFC2IT1UCpZwb/U7hXR4HXlc2qYyfp5cTylCQNNlGZDsw1k
         4Xe40eboMHve3e9mBavCcSD8m22qABXTsk9+ZNhAMn5dYSUzc+9gOvr/jLqK40KPdW
         eEiBkHpXEZXjqg8Smzj6IY8+ik0/y/n8Q5bIzCQTNFZXpoRYprr+BielPe2YqObNF+
         2XXw5ve5wCsUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06E98E66CBF;
        Thu, 16 Mar 2023 17:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Ignore warnings about "inefficient
 alignment"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167898781901.22462.18055879853345667541.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Mar 2023 17:30:19 +0000
References: <20230315171550.1551603-1-deso@posteo.net>
In-Reply-To: <20230315171550.1551603-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
        lkft@linaro.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 15 Mar 2023 17:15:50 +0000 you wrote:
> Some consumers of libbpf compile the code base with different warnings
> enabled. In a report for perf, for example, -Wpacked was set which
> caused warnings about "inefficient alignment" to be emitted on a subset
> of supported architectures.
> With this change we silence specifically those warnings, as we
> intentionally worked with packed structs.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Ignore warnings about "inefficient alignment"
    https://git.kernel.org/bpf/bpf-next/c/6cb9430be147

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


