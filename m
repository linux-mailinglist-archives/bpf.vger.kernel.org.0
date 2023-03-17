Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350F46BF602
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCQXKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 19:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQXKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 19:10:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4C28D27
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7631B825BF
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 23:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 648EEC433D2;
        Fri, 17 Mar 2023 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679094618;
        bh=aa4wLArUQ+S4FaCqzJGHPJskiYjAR0+D8hR6umKx7l0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rMm3rxoPlhmNCWpMlL9+eM21pWMh7xe5ojFpU+6mmyGsq7UX6Z/58/ms8W26dzIgJ
         dUe1tNp7vrSHVB0y2NEmk551OnlwKqnbmtKiXoZFg1O/Hvae6M3OP/39n4kL3HZZVy
         KvCw7GZqbNh00oUx9MdrCO1XZXWu9IPekkvD7VKBukXi8c3JRxhZkQgU/Fi4mgV93e
         7RXZ515rqHuSEZLTvhcvzzqA4qtky2JH/2xyEthop+HSbMJyWCDlFU63xiob3hT8c5
         iwv4lIJJob1HdfWZN5boznX8k1NHM7VkUqZion/5/BOpTmcOcKfKtZOPDcxtln1Xuc
         osAnfBCKVr7TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A7D3E21EE9;
        Fri, 17 Mar 2023 23:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add --json-summary option to
 test_progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167909461830.10620.8456894802346986924.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Mar 2023 23:10:18 +0000
References: <20230317163256.3809328-1-chantr4@gmail.com>
In-Reply-To: <20230317163256.3809328-1-chantr4@gmail.com>
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
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

On Fri, 17 Mar 2023 09:32:56 -0700 you wrote:
> Currently, test_progs outputs all stdout/stderr as it runs, and when it
> is done, prints a summary.
> 
> It is non-trivial for tooling to parse that output and extract meaningful
> information from it.
> 
> This change adds a new option, `--json-summary`/`-J` that let the caller
> specify a file where `test_progs{,-no_alu32}` can write a summary of the
> run in a json format that can later be parsed by tooling.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: add --json-summary option to test_progs
    https://git.kernel.org/bpf/bpf-next/c/2be7aa76cc69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


