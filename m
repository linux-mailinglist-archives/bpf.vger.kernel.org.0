Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03B6261ED
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKKTaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKKTaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:30:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0206DCFB;
        Fri, 11 Nov 2022 11:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4AA620C1;
        Fri, 11 Nov 2022 19:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C393C433D6;
        Fri, 11 Nov 2022 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195016;
        bh=8HSG2eZ3Z/xzTYeQI5spUFojsNkn5RISRbkUggGs6k4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HpnlqOn1dEvJidM0qwy9/qOH5q9VUwThX2RaKQb/5VaCBbq+heeSnIfQTENMWmrK4
         kDA/7JAT0k012xKtbVfLLqssS0QOhoy9sBSXGje/B9eSX1Rs36CcbBR7jqYu9vg3fY
         a6w4L/Ev9ZsWzOH3ZpL6fe14ahJh3KX98JAiBRVqMQS8NfRkmt4XwRAKVs9LK1D96i
         eaffwSYLzwnAR1JNX/LmOjVwIBKPTj8uheItqUxZaFrQbN8AMfvSVXpBJ1IU8yH3Zu
         7pKmQVszsaaqc18pvbu8CphxI54DG7oSsFY7/a2QUHEr6l5oEMcwos2Bdyg/GTjccM
         enVlqrfDH4ZmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07F38C395FE;
        Fri, 11 Nov 2022 19:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/1] docs: BPF_MAP_TYPE_CPUMAP
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819501601.28850.1844141482429874209.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 19:30:16 +0000
References: <20221107165207.2682075-1-mtahhan@redhat.com>
In-Reply-To: <20221107165207.2682075-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, lorenzo@kernel.org
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

On Mon,  7 Nov 2022 11:52:06 -0500 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/1] docs: BPF_MAP_TYPE_CPUMAP
    https://git.kernel.org/bpf/bpf-next/c/d9c982d25c47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


