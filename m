Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B844FB241
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 05:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiDKDWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Apr 2022 23:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiDKDW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Apr 2022 23:22:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2A1A053
        for <bpf@vger.kernel.org>; Sun, 10 Apr 2022 20:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE0DBB80E9D
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 03:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7654C385A8;
        Mon, 11 Apr 2022 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649647212;
        bh=aNzJk0hqdUah/8QBKj6FvwHM4+RYptjd/4yaSZ9mfkA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SZM993/bEJKtuHIZgC2qc+0d4icaTzM9AkmjcBh9KYXyxQuTDubVoQmQ34QQWWs23
         lYSxNl66G0T5PCslYODN7jhFjnCIFmyDlW6QPaeZnWqCQqTO/PItd7XF79c64rY6VB
         Pz+wvJacOaA3KSoI6vq9Hg3hKo1+YgESWisB3TAZMdzZ2hMFJrLIoHpKzb+5Zs3z1k
         CsF/bf22lo6zfpz/cIJcoFzUU1HYP+/jzVognjbZPSqBGBwbPMQ39AlmMcByBifK30
         Kb9GWw5F1uMaLK9LRH+iroigHGCGoHvsak540boI8qn4SXKBhNO3XgtCGA2Zae5DgC
         w5ceikLfMGgRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 835B4E7399B;
        Mon, 11 Apr 2022 03:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] libbpf: Fix a bug that checking bpf_probe_read_kernel API
 fails in old kernels
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164964721253.11578.7623906648168365938.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 03:20:12 +0000
References: <20220409144928.27499-1-rainkin1993@gmail.com>
In-Reply-To: <20220409144928.27499-1-rainkin1993@gmail.com>
To:     Runqing Yang <rainkin1993@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  9 Apr 2022 22:49:28 +0800 you wrote:
> Background:
> Libbpf automatically replaces calls to BPF bpf_probe_read_{kernel,user}
> [_str]() helpers with bpf_probe_read[_str](), if libbpf detects that
> kernel doesn't support new APIs. Specifically, libbpf invokes the
> probe_kern_probe_read_kernel function to load a small eBPF program into
> the kernel in which bpf_probe_read_kernel API is invoked and lets the
> kernel checks whether the new API is valid. If the loading fails, libbpf
> considers the new API invalid and replaces it with the old API.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix a bug that checking bpf_probe_read_kernel API fails in old kernels
    https://git.kernel.org/bpf/bpf-next/c/d252a4a499a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


