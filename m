Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99DC6BDA9B
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPVKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCPVKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 17:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4316302;
        Thu, 16 Mar 2023 14:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E639062040;
        Thu, 16 Mar 2023 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4309CC4339B;
        Thu, 16 Mar 2023 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679001018;
        bh=a0L+li0aacAmUhFaKDDXBVRHvZSExCxiZaFv90QSFMY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vfm4Pgvo1N9W3nq80zDUlaZvsetn9iiCVaVPTnWE9fP5zkPhwIz1dGknk0dppyE98
         A0MLIptmlJKtO1wLCiR6lIXp+Wk9sLf2y1BRTbXAldNHagrH9TJz7M5mVZybbK1Y5l
         hFzUptwPoB4WY/U5Kz+ywrTh3Y4R0NypfFf7ZufNk7kjttwNnVGgUJrAkWXUhr1W2K
         SzsM9q2uRgCFoI7TvbQi4qbLLktJ/41WpKyAV1H/wGbg5PCL7DJH0KZ25y7hdys/rs
         AhkK5NtbcjpHG/Ic6GuX+M06x8qw4I1uY82onhEhE38I2ULiKPOQv6eDuEXkrAO9U7
         cTB6/sZKRGsMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A004E447D3;
        Thu, 16 Mar 2023 21:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: remove misleading spec_v1 check on var-offset stack read
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167900101816.1695.823827696670320072.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Mar 2023 21:10:18 +0000
References: <20230315165358.23701-1-gerhorst@cs.fau.de>
In-Reply-To: <20230315165358.23701-1-gerhorst@cs.fau.de>
To:     Luis Gerhorst <gerhorst@cs.fau.de>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, andreimatei1@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 15 Mar 2023 17:54:00 +0100 you wrote:
> For every BPF_ADD/SUB involving a pointer, adjust_ptr_min_max_vals()
> ensures that the resulting pointer has a constant offset if
> bypass_spec_v1 is false. This is ensured by calling
> sanitize_check_bounds() which in turn calls
> check_stack_access_for_ptr_arithmetic(). There, -EACCESS is returned if
> the register's offset is not constant, thereby rejecting the program.
> 
> [...]

Here is the summary with links:
  - bpf: remove misleading spec_v1 check on var-offset stack read
    https://git.kernel.org/bpf/bpf-next/c/082cdc69a465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


