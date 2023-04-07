Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90A66DB696
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjDGWkn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDGWkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 18:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C2BD53B
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 15:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44C7F653ED
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 22:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2183C4339B;
        Fri,  7 Apr 2023 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680907218;
        bh=Sd6UYj2CnllXy2TiY6fYpSSvSB9oRyv9W55lNXyekLA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P3TX5yitkK/Fipb3npOrWebY7iqW6+D2OXPv2SSpKzquawbq/CPy2z0fjyAYDzOGa
         rjIDUpi9aE8dFqXTutrRWyFuGO478KpPZhaZnWcRsJJt2h7WjP2SYvkmNwefad1F05
         hrtZP/qJyqTQIc9HOYsC7g6Wthj4vrLk1uwEDUf5W8s8q+ibxmYoH7imqaKrO1gemg
         vUjkyoFIypgl7itK3+rSU4zQiaVhr4H5OgSHv8AV0l3Tg1Ef34yXW39V1HJwwlxnro
         m31Ry9nLKtzzlEQVSsAOwNvoGMdp8SRuz4zj8zPBiQRbGtUbMpN2FvsDvei2r/u3ZB
         gskpfsRcI6eTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86D81C395C5;
        Fri,  7 Apr 2023 22:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Prevent infinite loop in veristat
 when base file is too short
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168090721854.5568.4906476351301381423.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Apr 2023 22:40:18 +0000
References: <20230407154125.896927-1-eddyz87@gmail.com>
In-Reply-To: <20230407154125.896927-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  7 Apr 2023 18:41:25 +0300 you wrote:
> The following example forces veristat to loop indefinitely:
> 
> $ cat two-ok
> file_name,prog_name,verdict,total_states
> file-a,a,success,12
> file-b,b,success,67
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Prevent infinite loop in veristat when base file is too short
    https://git.kernel.org/bpf/bpf-next/c/5855b0999de4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


