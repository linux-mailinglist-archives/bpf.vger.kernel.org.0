Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D864528B
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 04:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLGDaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 22:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLGDaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 22:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F9554E8
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 19:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AB16B81CB3
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 03:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D752AC433D6;
        Wed,  7 Dec 2022 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670383816;
        bh=HIswNfj2QR3XOjDNtd6tAu0R+/NGTdyQoqq2TaQE1AU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CR8cnLsNBtFSdbvZErG7Sf4aFQV4D3nArA9VCapZb4GVIvqOYpTAUEnWLYfJMhXv9
         /sGOrMjPKUw7W+2OCNh98FJ7KggkGfTXwW/wrO7KPK+uVXvUMAuWrMpYsmgUpJD7e4
         IdTTa3ITfAAautIVjcJIFKQZshkp8tdpXtMTLZRzfU2lH3/Tue2zKMvuR2smWykreZ
         DkiZsNZnCDH8dD3S7VkKbNgS7ybd+DVrL9rtMo4YOR8dHz+Rg1+uiJV/tmfL45LCS7
         MaYzyTn7PaFAMXywZJK+SRVTnSzfe/nAyr76Obcid3G9biFZDgG86TrujFOdcgbGpI
         fXsT3hz2Qniaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0C59E49BBD;
        Wed,  7 Dec 2022 03:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Refactor verifier prune and jump point
 handling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167038381678.17201.15997949112538207031.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 03:30:16 +0000
References: <20221206233345.438540-1-andrii@kernel.org>
In-Reply-To: <20221206233345.438540-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 6 Dec 2022 15:33:42 -0800 you wrote:
> Disentangle prune and jump points in BPF verifier code. They are conceptually
> independent but currently coupled together. This small patch set refactors
> related code and make it possible to have some instruction marked as pruning
> or jump point independently.
> 
> Besides just conceptual cleanliness, this allows to remove unnecessary jump
> points (saving a tiny bit of performance and memory usage, potentially), and
> even more importantly it allows for clean extension of special pruning points,
> similarly to how it's done for BPF_FUNC_timer_set_callback. This will be used
> by future patches implementing open-coded BPF iterators.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: decouple prune and jump points
    https://git.kernel.org/bpf/bpf-next/c/bffdeaa8a5af
  - [v2,bpf-next,2/3] bpf: mostly decouple jump history management from is_state_visited()
    https://git.kernel.org/bpf/bpf-next/c/a095f421057e
  - [v2,bpf-next,3/3] bpf: remove unnecessary prune and jump points
    https://git.kernel.org/bpf/bpf-next/c/618945fbed50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


