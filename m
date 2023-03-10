Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50146B4D5E
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCJQnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 11:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCJQmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 11:42:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B911997F
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:40:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75148B82352
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 173D0C4339B;
        Fri, 10 Mar 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678466419;
        bh=ZmrXNJLiZwYSV/ecZ25zJaUBRkStmyd+NvPyq/imGxY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FMc/yN725NqxPjklP2Yq32yklu8tmKtdhZdTX8h7uP3A9P/DYXW8RRWk0TnF/XJmq
         3HBF9Ni1u4WOEC9mVhDqPXHQpFD5S+Z80lSDBtkE8MSD/fFR4W7dRDkNQsiy5e4ava
         9JqstvaC9q1MO35gzSlOW1hl4iigrGFpWJzNGn2rXNkoZ1a0QxqA7Ew+XMgRckl5cV
         REMWZLM0hVmdm33RitDaWw9KeONxXc4+k2mxzydnjifMG3voILuG8epgFBKrTBqrfH
         CptkpTt30WoNiBz7kKbnaiRHhkwx1xNPm4MaTb9Ey+S4CeZ4OUX50PGjmnG2EK7EMW
         R7zwgEi0ChmKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF032E21EEB;
        Fri, 10 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: ensure state checkpointing at iter_next() call
 sites
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167846641897.10287.2969904343162506781.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 16:40:18 +0000
References: <20230310060149.625887-1-andrii@kernel.org>
In-Reply-To: <20230310060149.625887-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@meta.com
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

On Thu, 9 Mar 2023 22:01:49 -0800 you wrote:
> State equivalence check and checkpointing performed in is_state_visited()
> employs certain heuristics to try to save memory by avoiding state checkpoints
> if not enough jumps and instructions happened since last checkpoint. This leads
> to unpredictability of whether a particular instruction will be checkpointed
> and how regularly. While normally this is not causing much problems (except
> inconveniences for predictable verifier tests, which we overcome with
> BPF_F_TEST_STATE_FREQ flag), turns out it's not the case for open-coded
> iterators.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: ensure state checkpointing at iter_next() call sites
    https://git.kernel.org/bpf/bpf-next/c/4b5ce570dbef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


