Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1034A9172
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 01:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiBDAKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 19:10:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37214 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiBDAKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 19:10:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8556761904
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 00:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEF4BC340EF;
        Fri,  4 Feb 2022 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643933408;
        bh=vuEV/P6tvgumjLzfeFFjtX1Gt2rtJPygf3U4y2g7whk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m4EvFGtqkIk5NIhs2hPAYza4UsSLY637+6oFOLd8yGgPjxF7AOGABjxC6xVWseVMO
         iDVv3Lklu9aRU6rAK8pvpqos0tV18VASRs0XfFYjEACqGcrg7RMcowy+6NVNqJlhcc
         +uqqMdkkRooYJbosZcd1pKltREJ3fTWZFPXmQcuw9XW9LZab3XivcAAGDeAu0WUzGu
         alXvGz5HFxriqo18ygSq7TIP6I3Qvyw4PwLBrF35xyXl8K4J0fE91+ZYC43tcgN+b8
         eGJiUFfT8M5VHY/xC1F/dDvZbXguZq6KugkGGZYanP/np/Nmq0G7OfJpr0QhvBV21h
         2i9aixDpytGcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1695E5869F;
        Fri,  4 Feb 2022 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: deprecate forgotten btf__get_map_kv_tids()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164393340878.16754.9720661905246478710.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Feb 2022 00:10:08 +0000
References: <20220203225017.1795946-1-andrii@kernel.org>
In-Reply-To: <20220203225017.1795946-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, davemarchevsky@fb.com, yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 3 Feb 2022 14:50:17 -0800 you wrote:
> btf__get_map_kv_tids() is in the same group of APIs as
> btf_ext__reloc_func_info()/btf_ext__reloc_line_info() which were only
> used by BCC. It was missed to be marked as deprecated in [0]. Fixing
> that to complete [1].
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20220201014610.3522985-1-davemarchevsky@fb.com/
>   [1] Closes: https://github.com/libbpf/libbpf/issues/277
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: deprecate forgotten btf__get_map_kv_tids()
    https://git.kernel.org/bpf/bpf-next/c/227a0713b319

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


