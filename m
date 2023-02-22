Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E6B69FD85
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBVVKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVVKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C858149B8
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290596141D
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C6D8C433EF;
        Wed, 22 Feb 2023 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677100217;
        bh=LZsDwK9VnJsxk9KWx590nKqe+VSNm3U+f6aHMGSiauI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aG2fkk5PctQU/9e4PZejBnz8iwI2bkTjyIFFAlFZKQdNf4NbBQ8kfMjODxg8qq2fl
         gs+B4zC9Rd+2wZHJEwAYc6ZWf1AJEPwWS68Man75w3MNygaeb40xpHozwrK564j+8T
         AovyeL3RAx8qrgMQ/cp7tXH90+6gY3cjFuSHtrXlKyc385T2n9HUIJnGP0aR8Tff65
         cN0UXXiZ4scTDI4QcNJNXGUJUKklOQ8GNjGKvdSbMjFdKyk+n4+vEo5mYOORItM9fj
         icnxOZtdZ+uF3gbH9GXramr/k00//j7p47LZElFJVczqg/avp/zjM5er5bN4mP5r3r
         ecT/qflYOQ8zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7093AC43157;
        Wed, 22 Feb 2023 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Only allocate one bpf_mem_cache for
 bpf_cpumask_ma
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710021745.10496.10939138287246960835.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:10:17 +0000
References: <20230216024821.2202916-1-houtao@huaweicloud.com>
In-Reply-To: <20230216024821.2202916-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
        song@kernel.org, haoluo@google.com, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, void@manifault.com,
        houtao1@huawei.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Feb 2023 10:48:21 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The size of bpf_cpumask is fixed, so there is no need to allocate many
> bpf_mem_caches for bpf_cpumask_ma, just one bpf_mem_cache is enough.
> Also add comments for bpf_mem_alloc_init() in bpf_mem_alloc.h to prevent
> future miuse.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Only allocate one bpf_mem_cache for bpf_cpumask_ma
    https://git.kernel.org/bpf/bpf-next/c/5d5de3a431d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


