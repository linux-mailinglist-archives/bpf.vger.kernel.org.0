Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F262622F
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiKKTkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE87C8F7;
        Fri, 11 Nov 2022 11:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA2E3B82796;
        Fri, 11 Nov 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A1C8C43470;
        Fri, 11 Nov 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195616;
        bh=FUIVSUE9JgMaiKo3srXQLhxGnj9uHH3tx+khRQncnmo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gJtia0YvlGB2OWFlpX7/EsyKU4OIt6xuVqbrm+jmX6Yq1gmLOJRRkrF11Sx+cDY37
         Gvbpmcbrn5ffCUCT7nfmCebi3gmbkj6AAesi0IokDriU3PGFQ0PQzNMzQvZctjrQ0b
         +c99YB0HM8TFYmcmaXmEVlFGjOV4WdFsKYgLQ2PqsZtVDJzj2+ROZcScj8kURA3kag
         8e8Lp74uFHyovCm4JGqgkmCTIc6buD5o3dhp5VkC4/C065VbIBgdkPUAs3O43dPHdr
         rQz6gtf/VnvJCKhFAClfqZy6cBrjrjjaEBkN62NZTw4mldpKJS24pL/yY/r/hBgF7Y
         5A9ZVSkowuiXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 427E5E50D93;
        Fri, 11 Nov 2022 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/1] Document BPF_MAP_TYPE_ARRAY
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819561626.2662.1576356651622652024.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 19:40:16 +0000
References: <20221109174604.31673-1-donald.hunter@gmail.com>
In-Reply-To: <20221109174604.31673-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net
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

On Wed,  9 Nov 2022 17:46:03 +0000 you wrote:
> Add documentation for BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
> variant, including kernel version introduced, usage and examples.
> 
> v9->v10:
> - Add missing Reviewed-by tag
> 
> v8->v9:
> - Add "Kernel BPF" heading suggested by Jesper Brouer
> - Tidy up wording to clarify BPF vs userspace APIs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
    https://git.kernel.org/bpf/bpf-next/c/1cfa97b30c5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


