Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447B049566B
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378095AbiATWkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:40:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41172 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiATWkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 17:40:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7522061913
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 22:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC059C340E5;
        Thu, 20 Jan 2022 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642718409;
        bh=W4gVaNk5fR8MRoiR/tm1ZNMv0FwOVv53CYC4S84p2lM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YJdzZHH7noE5C81NQjz61rqW+MyKapq/RsqVAPgkK2IRZUwQ6zIc4GQb7hBloAOQY
         pf+S8O0HzkfWkGafGPYe96HMgHtG53S8n+kjzfXlshhdRMGPlDKy/IMdHU9eN8CnLp
         vLh8PgqpYY70zfD7Pm3qL1iZyuMY/Af1M5G6iScx3SJ5FM5lHdkkbqusH10sheUxHy
         Yphip2Ni/hiaErKlNvA9bylSaB6MhIHOy8OPhD5uB/ChDAyhW6hHfovtdQ3jaczv/S
         1Gotb36EcS2elbpMpgBIHAdPezpQp4GS9/6Tuw0ORmIkKVqvjCK7GtuZVUPWF70EZe
         +CwQAWlac+fAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3213F6079D;
        Thu, 20 Jan 2022 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests: bpf: Fix bind on used port
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164271840972.1166.16358307258129760252.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jan 2022 22:40:09 +0000
References: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
In-Reply-To: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, kafai@fb.com, ast@kernel.org,
        jakub@cloudflare.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 18 Jan 2022 16:11:56 +0100 you wrote:
> The bind_perm BPF selftest failed when port 111/tcp was already in use
> during the test. To fix this, the test now runs in its own network name
> space.
> 
> To use unshare, it is necessary to reorder the includes. The style of
> the includes is adapted to be consistent with the other prog_tests.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests: bpf: Fix bind on used port
    https://git.kernel.org/bpf/bpf-next/c/8c0be0631d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


