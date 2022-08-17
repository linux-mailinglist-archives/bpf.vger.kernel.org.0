Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0559747B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiHQQuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiHQQuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437828E0C5;
        Wed, 17 Aug 2022 09:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E34F8B81E5B;
        Wed, 17 Aug 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88960C433D7;
        Wed, 17 Aug 2022 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660755015;
        bh=QRwswQY3xmL0seLhxiYPPY22FDX+5j5mR8lU7Srjbhc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sN0Efzk/si3VFhiJrrcSgMWLULkwFx7oDyYXGNjb4LX9XlVW3pk2ZLH8ZoJLIndvd
         yjXiifG/hgnGrrtc3NnzUGvn+QEdRPZFMdUxBSneQPJG7Rkkzp+o6kJkSjyHtw4sQD
         n9LlNXtZi2n4aplBtXlSsXcQrGlo3/TuN4jgfEZXOoMbLd85seDSl84TPXOMrYiGx9
         yaiLZ2MB/YE9xpRMYa41FmBDRsAQ85kRDaCxp/t5jvX7tafEx+45HD4i2kxb8x5eC9
         EYCVJa0bNrba/8fjMMGJa7juYNibwraqbpDD+7rJ7MV8RaZkIQZns9jNrfl8QwDY1v
         AmVfFPg8AoyLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A03BE2A052;
        Wed, 17 Aug 2022 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Allows disabling auto attach
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166075501543.29308.8178577555614859134.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Aug 2022 16:50:15 +0000
References: <20220816234012.910255-1-haoluo@google.com>
In-Reply-To: <20220816234012.910255-1-haoluo@google.com>
To:     Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, jolsa@kernel.org, kpsingh@kernel.org,
        john.fastabend@gmail.com, sdf@google.com, yosryahmed@google.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 16 Aug 2022 16:40:11 -0700 you wrote:
> Adds libbpf APIs for disabling auto-attach for individual functions.
> This is motivated by the use case of cgroup iter [1]. Some iter
> types require their parameters to be non-zero, therefore applying
> auto-attach on them will fail. With these two new APIs, users who
> want to use auto-attach and these types of iters can disable
> auto-attach on the program and perform manual attach.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] libbpf: Allows disabling auto attach
    https://git.kernel.org/bpf/bpf-next/c/43cb8cbadffa
  - [bpf-next,v2,2/2] selftests/bpf: Tests libbpf autoattach APIs
    https://git.kernel.org/bpf/bpf-next/c/738a2f2f9130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


