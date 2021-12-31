Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD348249F
	for <lists+bpf@lfdr.de>; Fri, 31 Dec 2021 16:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhLaPlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Dec 2021 10:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLaPlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Dec 2021 10:41:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD90C061574
        for <bpf@vger.kernel.org>; Fri, 31 Dec 2021 07:41:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FCC6B81DA1
        for <bpf@vger.kernel.org>; Fri, 31 Dec 2021 15:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC1DDC36AEC;
        Fri, 31 Dec 2021 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640965302;
        bh=y1Ihz9hf8G/Lqdjgmnbyq0HI1htj6e9Dlv8WD623+rY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uF3G3hBSAyzuc6Zxpr0m0fN/6IHR/MMmGTygrn6FlAldu59nm8MsFZnvWxcXvV4Ao
         ClYJeTqup5WBgt9qMQBvpJGzDUesh4D5eRvQfbWrtG24UNH/ctbBzPg0WbYnWgu1xd
         JaGqsaFeihBT8G0v4OzxP/PUSfFwlykqiQauIeAU7tz3nROFjYjaVJN2gij8RROfur
         /4qIDtBhM0jbNyisjiLAnLA63fBVmzk361cSivt9JIW0/mk1+dQeyEY/Cd/LaE+n1d
         nDNljcTACZOxqyyrQiTsgf7rMkmTdwbX6uswOWgWqT5cmTkrGHS3PxaaBAoidm5cEd
         C6h4lGb4Lc/eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF34FC395E5;
        Fri, 31 Dec 2021 15:41:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2021-12-30
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164096530184.26923.7980058528734264949.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Dec 2021 15:41:41 +0000
References: <20211231024727.68955-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211231024727.68955-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, kuba@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Dec 2021 18:47:27 -0800 you wrote:
> Hi David, hi Jakub,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 72 non-merge commits during the last 20 day(s) which contain
> a total of 223 files changed, 3510 insertions(+), 1591 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2021-12-30
    https://git.kernel.org/bpf/bpf-next/c/0c3e24746055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


