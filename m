Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C858C99C
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiHHNkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbiHHNkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 09:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C73A0
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 06:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B151B80E96
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 13:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 123E2C433D6;
        Mon,  8 Aug 2022 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659966013;
        bh=/7vcwjv0SrfzOMMyaajfbY1nJvfmWLUZ2pYxQdDMfpg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o6smz1WblYRZAXM9wLedWOpXOD63JBIlSALkjuxHFOdQpMETP39sMdi9NVeefCnrm
         oLaYnmpwiqnxFXQM+agwkHxA0GeP1fLrDhu//HcKdjaDWwiDXkw2XiABxrbaptD7qx
         3pSjBwgV/aajBLbObuCoUHaGgXSFdhd1MJ2Iw1GsbCb0ot9y2OgtLjSmbhLNwEmSyt
         UFuYtcY6arj7PFUBSYbO8TilUP13rG38M4cxgDhlVhb0tzs45FpdNHYpvEd+kMkMg0
         YStArayUfJx4bAj6hVxIu0kRGp2Bb1mYHo841R3DKZmh6Nr3su7nV+N9p3yZS4JyoA
         mOAT6oQ1+1+jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9160C43140;
        Mon,  8 Aug 2022 13:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] mptcp: Add struct mptcp_sock definition when
 CONFIG_MPTCP is disabled
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165996601295.18075.8680123178653821684.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 13:40:12 +0000
References: <20220802163324.1873044-1-jolsa@kernel.org>
In-Reply-To: <20220802163324.1873044-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        kafai@fb.com, bpf@vger.kernel.org, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com, mptcp@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Aug 2022 18:33:24 +0200 you wrote:
> The btf_sock_ids array needs struct mptcp_sock BTF ID for
> the bpf_skc_to_mptcp_sock helper.
> 
> When CONFIG_MPTCP is disabled, the 'struct mptcp_sock' is not
> defined and resolve_btfids will complain with:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol mptcp_sock
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] mptcp: Add struct mptcp_sock definition when CONFIG_MPTCP is disabled
    https://git.kernel.org/bpf/bpf/c/f1d41f7720c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


