Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDCA5BB3B8
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 23:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIPVA1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 17:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIPVAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 17:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F924491E8;
        Fri, 16 Sep 2022 14:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E106A62AF8;
        Fri, 16 Sep 2022 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45E31C433C1;
        Fri, 16 Sep 2022 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663362017;
        bh=hXMhOpy6gtT7q650gUlX5KucIY6LH/WFsflLx7c4YlY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ua6wzUJoC6TQbDCEd5wJ6a/9k78cqEfycuaxL216vxGQSbmZJWT1mYr6oZZf9M+P4
         j5pIG3H7h5uPhMqMv00qSJsHq7hz/t6GbY5/8GnG/qPVAV/vYlOSb0+xRwy3N5bEbu
         F9XJehjV1pXBWj7w0R/lbDXR32OC1mwQ/kHNpMGV6dJACiOncfhETeL6HxwpLv4adb
         FLd57KprsifYkAKQi9M/OEYl1o7NMd9cfeMW8SQJed8oh4w0CrNPIVvB7rR5ByevaG
         FGfBmTqqIPPyAOcJSkXeuNGJalRy+i+qi1fSacGw1lzASk2HcKDNZEApGBvpYeSmSs
         w94YweA/eWmRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BFB1C73FFD;
        Fri, 16 Sep 2022 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] libbpf: Clean up legacy bpf maps declaration in
 bpf_helpers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166336201710.13694.6117441685793027381.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Sep 2022 21:00:17 +0000
References: <20220913073643.19960-1-liuxin350@huawei.com>
In-Reply-To: <20220913073643.19960-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 13 Sep 2022 15:36:43 +0800 you wrote:
> Legacy bpf maps declaration were no longer supported in Libbpf 1.0.
> So it was time to remove the definition of bpf_map_def in bpf_helpers.h.
> Supported in Libbpf 1.0 ([0])
> 
>   [0]:https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v3] libbpf: Clean up legacy bpf maps declaration in bpf_helpers
    https://git.kernel.org/bpf/bpf-next/c/dc567045f159

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


