Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403036A9136
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 07:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjCCGu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 01:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCCGu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 01:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E11026A
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 22:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F156FB816AC
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 06:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80E3CC4339B;
        Fri,  3 Mar 2023 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677826217;
        bh=u+vRel2EM5Xr2QiefbRzd1PW6q7RaJexvETF943WWRc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Jo6jQ3PP+doQm8QsNRNSi7tqL840gc+4Ds5ADknSm5XxjYvSVb8lUnuwWIUe3/KAy
         1wwkodP+KL3WngWww+LhoikmpLiSnadxD8iAbz1O+FRTdTQbP+ABHRLQJkYOqU12in
         KHFY4qhcKk7iUX4o0rS3Yse4Pc12ccAkq9N3mHqShmvkMCHwAx5tW4Cw1Lzy4oUejT
         pjmjADe2FqF0kEUigo+TXuhlv2ZBwI/5GWOLrTrsXS2jHrIXQSWks54/Y5i3cbUI3w
         EFgO0uOknGX18RgzR79vC7QezB457wNQoWkdm2oLDcXkwaP8jz5G4wo9yTmd3yyHjL
         SiwXATOrweqfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62B5FC41679;
        Fri,  3 Mar 2023 06:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167782621739.20201.14730726321835500258.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Mar 2023 06:50:17 +0000
References: <20230303005500.1614874-1-davemarchevsky@fb.com>
In-Reply-To: <20230303005500.1614874-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
        void@manifault.com, tj@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 2 Mar 2023 16:55:00 -0800 you wrote:
> Per C99 standard [0], Section 6.7.8, Paragraph 10:
> 
>   If an object that has automatic storage duration is not initialized
>   explicitly, its value is indeterminate.
> 
> And in the same document, in appendix "J.2 Undefined behavior":
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf prog flags
    https://git.kernel.org/bpf/bpf-next/c/ec97a76f113e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


