Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0D694E90
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjBMSAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjBMSA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 13:00:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA71F93A
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCAE61214
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 18:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 037DDC4339B;
        Mon, 13 Feb 2023 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676311217;
        bh=G5N6dwvzcIJg8NalT+mCmpPn5E2JKHGlg9os/15pEy0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F3mR8WouPN8v2Ew42rIP6HIPDxYFxGMVfLnM6uaoOwICOKcOd2KFQ+g1rtuNI+G0x
         EmXaCbiEkRlnb63FQNVFs0Q7bXIuQH3i4Bl7sD7vGd7HF+fZiCtXKPycOkgTwFndi5
         t4Ounou+ZucXCCaKTsKetjAdnhwHUDtBbFsa/5Y60Qnu/OagpY+rnaOktDBNyLfeFZ
         0Cfjh9SLzFu3jAods4quW367xedlgFCPi8W/HgwEzmLv5pkPmwg8vYkuRDWm5bjk+E
         b5eIBVIkqbsGn9D+RElvgofoZzuo3P/pL7A/Gc/9ncWteWcPWUIDlcxewIuDtKh/cH
         hChhlBMG96IAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC8BFE68D2E;
        Mon, 13 Feb 2023 18:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix out-of-srctree build
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167631121689.23748.6047290825984829267.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Feb 2023 18:00:16 +0000
References: <20230208231211.283606-1-iii@linux.ibm.com>
In-Reply-To: <20230208231211.283606-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
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

On Thu,  9 Feb 2023 00:12:11 +0100 you wrote:
> Building eBPF selftests out of srctree fails with:
> 
>     make: *** No rule to make target '/linux-build//ima_setup.sh', needed by 'ima_setup.sh'.  Stop.
> 
> The culprit is the rule that defines convenient shorthands like
> "make test_progs", which builds $(OUTPUT)/test_progs. These shorthands
> make sense only for binaries that are built though; scripts that live
> in the source tree do not end up in $(OUTPUT).
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix out-of-srctree build
    https://git.kernel.org/bpf/bpf-next/c/0b0757244754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


