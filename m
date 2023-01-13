Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3966A5B8
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjAMWKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjAMWKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33020149F1;
        Fri, 13 Jan 2023 14:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C4B62340;
        Fri, 13 Jan 2023 22:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14731C433D2;
        Fri, 13 Jan 2023 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673647817;
        bh=GimIwLx6mttHFjghxeqnl83ETbobzYr9VMgVcRT06ZQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dN4zhqFikSt0t7yyWzdOL8Q0iOIokhNlY+XGyEViz0Zewdoj4m2rmWPjbxahYCWlj
         lA/Hykv2mcoHdyK5GzAemwxBNsOKZOLrJG1RP4fTsrDX0u2NOeUEW0kj0CTGrF1hGe
         U+p4fu0Pk/5bJ+lGN8tzk0ekOGfT1MMpZz2zf67d1/uokUG5iZW2TB5XyXlB6p37nw
         vbivT+PlhowUnFhiT6L+Sh2lmK7qyQGhSnNjwFoIK/YI3XdI1BRPcOhvR70eNtb4j4
         5cyo7w28MRpbndyXaT0/pPv14lqvn11K46n/xW3cXw3t3k9hj/0nfo7jjaTGkELPk9
         AUuEcc9dEgl3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5F9BC395C7;
        Fri, 13 Jan 2023 22:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167364781693.13894.2909658070241455730.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Jan 2023 22:10:16 +0000
References: <20230113093427.1666466-1-imagedong@tencent.com>
In-Reply-To: <20230113093427.1666466-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, imagedong@tencent.com
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

On Fri, 13 Jan 2023 17:34:27 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> '.' is not allowed in the event name of kprobe. Therefore, we will get a
> EINVAL if the kernel function name has a '.' in legacy kprobe attach
> case, such as 'icmp_reply.constprop.0'.
> 
> In order to adapt this case, we need to replace the '.' with other char
> in gen_kprobe_legacy_event_name(). And I use '_' for this propose.
> 
> [...]

Here is the summary with links:
  - libbpf: replace '.' with '_' in legacy kprobe event name
    https://git.kernel.org/bpf/bpf-next/c/2fa074536590

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


