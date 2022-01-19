Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01472493FBE
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356686AbiASSUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356682AbiASSUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 13:20:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C480CC061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 991C7B81996
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61C44C340E5;
        Wed, 19 Jan 2022 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642616409;
        bh=90afS0ji901FetnLym7zKpx9MUu9gakX/QbbJMfUsTY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OoYD+u4mrJ8ri9Fc5MrNYx16eBJDxYv59BpHxD0VRUUEGrPKbOkAIBXL/H1xtSmwB
         U/NUj0LoQdfSgpr+X4mtVVE3PhX9Yp6zIDer4p83+TC4qWDt7SkUrBTq1lEFyVcb+Z
         gd+1KYxmZzcR8doID91ijdJhAaJSV80ZGnWAhrqs59D6NF7q3H2Aue7ZjUA2G34STM
         027Zx3WsK2meXATcZZaL4pp0vM97j96+4GEzWmOXKOYpcyhM8XnhDadJQ+6Mhq5eTN
         V/mb25tTMRSqW0ehZ2mj5WCtTO0zxxncWEe9dmZgsmdNpK0dutlvEsSrHv2/isLJ4F
         X/9sfD0ugrn6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D3A0F6079B;
        Wed, 19 Jan 2022 18:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: adding support for BTF program names
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164261640924.4351.4787225192188055485.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jan 2022 18:20:09 +0000
References: <20220119100255.1068997-1-ramasha@fb.com>
In-Reply-To: <20220119100255.1068997-1-ramasha@fb.com>
To:     Raman Shukhau <ramasha@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Jan 2022 02:02:55 -0800 you wrote:
> `bpftool prog list` and other bpftool subcommands that show
> BPF program names currently get them from bpf_prog_info.name.
> That field is limited to 16 (BPF_OBJ_NAME_LEN) chars which leads
> to truncated names since many progs have much longer names.
> 
> The idea of this change is to improve all bpftool commands that
> output prog name so that bpftool uses info from BTF to print
> program names if available.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: adding support for BTF program names
    https://git.kernel.org/bpf/bpf-next/c/b662000aff84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


