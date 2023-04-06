Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED96D8E69
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 06:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjDFEkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 00:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjDFEkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 00:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23A86B0;
        Wed,  5 Apr 2023 21:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80E8F642AB;
        Thu,  6 Apr 2023 04:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5387C4339B;
        Thu,  6 Apr 2023 04:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680756018;
        bh=KovWrG/4iyTPO4xu7Gs3LeZHG6KgCCbmr54VIlegrUQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gY90QfEHoJe40H32tpkysWMTk6vHwdEd7/oZs6++hzpmKJDdDFH9ZGilq7D+obqle
         FNgoO8LH0EqwntzS/7mFzLWybCBHlcGTaHyC1jx/CWG93jBtnDd04mYj2Br30cAuFj
         LyHgXlNxxMVZ7gqS5tV+nUirLLy9J+R+dTdUHtxpVildrKvzVsETyZ64aKXzdWqVkN
         /kDe7Ci4b//na0+xMmoAM2nIGUd+qapAj/rCavMEv8TGl0rLM94enmTl8JmYIvRuEE
         gQ7esdvpz2DNdGmi792RuAV4l0/+XB+FRIaFhmc5ataztDRKENmbzIyQ20epE4CQLX
         gPZlTdIrkMALg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A448FE29F4E;
        Thu,  6 Apr 2023 04:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] kallsyms: move module-related functions under
 correct configs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168075601866.17428.2889245679074422058.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 04:40:18 +0000
References: <20230330102001.2183693-1-vmalik@redhat.com>
In-Reply-To: <20230330102001.2183693-1-vmalik@redhat.com>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, mcgrof@kernel.org, daniel@iogearbox.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, lkp@intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 30 Mar 2023 12:20:01 +0200 you wrote:
> Functions for searching module kallsyms should have non-empty
> definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
> only CONFIG_MODULES check was used for many of these, which may have
> caused complilation errors on some configs.
> 
> This patch moves all relevant functions under the correct configs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] kallsyms: move module-related functions under correct configs
    https://git.kernel.org/bpf/bpf-next/c/34bf93472f8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


