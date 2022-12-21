Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6504F6536F4
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 20:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiLUTUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 14:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiLUTUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 14:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC3252A4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 647C5B81C14
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 19:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F680C433F2;
        Wed, 21 Dec 2022 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671650416;
        bh=NaZcK/Dl5Bjy8qBYN4dEySqd5kO07627p+FfgTg2C2k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PZUaUaGfI4QgKX4yBn7S1q7H8MZ/UjieyEi1ozmVQc2O/AsofSV40E8UVxsmIKvEi
         +g3c3Ct9uWZVGHZ+S1L/0BeZkWgqPJI8PGr6r/tneXqQUuPXjQXW3dAXRqLr96WNHk
         R9c0tNUw8PCbdhRqlK9msJ8VQMKHS6Alkb8NTNbmExVxLpqNx2Dklu1yjRUEkS66PR
         zBINjKUDhhAcjzzEHn7ryjyb7wflbs/6fS5orUIwZzL/9aGviQaVwwIpyHcqcHIdby
         RiB9TzXSQwnvIsIJyT/ZvJHFu1jKILaxmBMQasVQp0FHon04LW8UgLnj+1KhOcijJh
         Duiqp5r36lVbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07C67C41622;
        Wed, 21 Dec 2022 19:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: start v1.2 development cycle
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167165041602.13230.13160241349703633187.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Dec 2022 19:20:16 +0000
References: <20221221180049.853365-1-andrii@kernel.org>
In-Reply-To: <20221221180049.853365-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 21 Dec 2022 10:00:49 -0800 you wrote:
> Bump current version for new development cycle to v1.2.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.map       | 3 +++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: start v1.2 development cycle
    https://git.kernel.org/bpf/bpf-next/c/4ec38eda85b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


