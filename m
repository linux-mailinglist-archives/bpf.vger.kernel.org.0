Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8005FDCDC
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 17:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJMPKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMPKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 11:10:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49D4D836
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 08:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E9B9B81E22
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 15:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99C2CC433C1;
        Thu, 13 Oct 2022 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665673818;
        bh=x0FmB/d2xVPzLiv0TxUVMoPhEHphD429H59XeD6q8QI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B6ew3p1ObzNwYwXo9zs8YCokKK4ZyMjvFyShG4bc4wakmTD7xckkBWPqGqgLzp3AJ
         OD9OO/vxXcbUXH4okwZFndCZi/AyC7Hpoq5K9fXTXlqqW9JnN0CoxcfxK4tWtox7xb
         EXopgQmnzCHdAetuhDUj6CvrUhG2cDNP/Garqkef7T7ZfQqMTcHA/rj2VrXCDItUu0
         pqzYJTYI4n16A0kyAvEDe84S+m2as7JzTQA+W80iB0HfiI4i34AlY7Opvu/l9hiWWr
         3sVj6NwFcnka9lrJ3YsrTwasoqTzwtwHShU5pvgGc7ItL+c59QbM48RbH81QeeV7o4
         Gsd99ScnxWYLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 758F1E29F32;
        Thu, 13 Oct 2022 15:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: s/iptables/iptables-legacy/ in the
 bpf_nf and xdp_synproxy test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166567381847.6176.8913221014838832724.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Oct 2022 15:10:18 +0000
References: <20221012221235.3529719-1-martin.lau@linux.dev>
In-Reply-To: <20221012221235.3529719-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, chantra@meta.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 12 Oct 2022 15:12:35 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The recent vm image in CI has reported error in selftests that use
> the iptables command.  Manu Bretelle has pointed out the difference
> in the recent vm image that the iptables is sym-linked to the iptables-nft.
> With this knowledge,  I can also reproduce the CI error by manually running
> with the 'iptables-nft'.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: s/iptables/iptables-legacy/ in the bpf_nf and xdp_synproxy test
    https://git.kernel.org/bpf/bpf-next/c/de9c8d848d90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


