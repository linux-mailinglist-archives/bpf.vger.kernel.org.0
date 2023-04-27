Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8B6F05CF
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbjD0Maa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbjD0Ma1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69E19AC;
        Thu, 27 Apr 2023 05:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19BB63D22;
        Thu, 27 Apr 2023 12:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 572E2C4339B;
        Thu, 27 Apr 2023 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682598620;
        bh=FsV3skstZVSxKed6nmKiXT/ugMxSTsOB/CYQgOgJWTo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DCBHRg76C3UoRotiVyQkyfNT0ZcHtSNijT7moRVrdKSZPC+X9sqs22VPASQf1uWtV
         xqpxo6Vc5zQWGgJxjci4MvS60sTGwInBkTf6j25DT5JM7a5PWCdllksqrD9MP1F76z
         BVV70mqjDlYAE4Ql2q/C3JEsuTEmkdPJhsINWdnNvGLBlcUe2rhloD/3wxvAmqawFT
         zF0cGpdFAJOg4yUnVsz+0t+rd1BHvXvjgDwCqg7/Wgf6Bxo6MtRmz0+Vg3XBsVFa3M
         8nAIN4B3PeBM+4UexBeO9Bz/A8yokGkGvt0vuoQc1sH+zOBcVRnk0o4HGqLCjdQ5Ks
         qI0VjeeeHZdLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DCEAC43158;
        Thu, 27 Apr 2023 12:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/2] docs/bpf: Add table to describe LRU
 properties
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168259862024.23031.10502966266346106910.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Apr 2023 12:30:20 +0000
References: <20230422172054.3355436-1-joe@isovalent.com>
In-Reply-To: <20230422172054.3355436-1-joe@isovalent.com>
To:     Joe Stringer <joe@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, bagasdotme@gmail.com, maxtram95@gmail.com,
        john.fastabend@gmail.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 22 Apr 2023 10:20:53 -0700 you wrote:
> Depending on the map type and flags for LRU, different properties are
> global or percpu. Add a table to describe these.
> 
> Signed-off-by: Joe Stringer <joe@isovalent.com>
> ---
> v5: Use bold rather than verbatim for column header
> v4: Initial posting
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] docs/bpf: Add table to describe LRU properties
    https://git.kernel.org/bpf/bpf-next/c/af0335d2926e
  - [bpf-next,v5,2/2] docs/bpf: Add LRU internals description and graph
    https://git.kernel.org/bpf/bpf-next/c/1a986518b8a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


