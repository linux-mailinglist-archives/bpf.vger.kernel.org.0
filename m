Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789DC49ACCD
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 07:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbiAYG6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 01:58:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46164 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3423436AbiAYEK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 23:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6562B8122F
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 04:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EE1BC340E6;
        Tue, 25 Jan 2022 04:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643083810;
        bh=cqNWi2ZW7SAJM3xyjUTZ6MZAl2VGzxpEHzmTdkwL62A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rf1p8i0UhC7ruYbRYKuP/m2chys3rY9UylK1QsIQwFMor7lxMnvivF4TdhatUj9bX
         EGRe8y7iRz9Cvl842HrswGbmSA0mPbqCug5dN2FbKpzmfrIXcbzzukxstR7JcwyzV7
         GFviaWJsq27vsWVE4v21jM9MV41Zwo7WN6lVHSEGtkrSa7JIUz7ocubohWxvnMNblW
         kyTMRUVWSHxyoCMaxg+4X/nnZXJVWQ+2HwPLg0ihVZTq7eiqh7ld2Q2PrjDRLl1HKM
         mHAdHGlD6ezr5t7Zhq9Xu45cb5QUIyiwnJ+xEJwdPWTQmijmS6pJDwQtFtpASBOBRO
         wnSCRSi3AmPOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56C4CF607B4;
        Tue, 25 Jan 2022 04:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 0/4] Add bpf_copy_from_user_task helper and
 sleepable bpf iterator programs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164308381034.4179.1054700872398715511.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jan 2022 04:10:10 +0000
References: <20220124185403.468466-1-kennyyu@fb.com>
In-Reply-To: <20220124185403.468466-1-kennyyu@fb.com>
To:     Kenny Yu <kennyyu@fb.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, yhs@fb.com, alexei.starovoitov@gmail.com,
        andrii.nakryiko@gmail.com, phoenix1987@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Jan 2022 10:53:59 -0800 you wrote:
> This patch series makes the following changes:
> * Adds a new bpf helper `bpf_copy_from_user_task` to read user space
>   memory from a different task.
> * Adds the ability to create sleepable bpf iterator programs.
> 
> As an example of how this will be used, at Meta we are using bpf task
> iterator programs and this new bpf helper to read C++ async stack traces of
> a running process for debugging C++ binaries in production.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,1/4] bpf: Add support for bpf iterator programs to use sleepable helpers
    https://git.kernel.org/bpf/bpf-next/c/b77fb25dcb34
  - [v7,bpf-next,2/4] bpf: Add bpf_copy_from_user_task() helper
    https://git.kernel.org/bpf/bpf-next/c/376040e47334
  - [v7,bpf-next,3/4] libbpf: Add "iter.s" section for sleepable bpf iterator programs
    https://git.kernel.org/bpf/bpf-next/c/a8b77f7463a5
  - [v7,bpf-next,4/4] selftests/bpf: Add test for sleepable bpf iterator programs
    https://git.kernel.org/bpf/bpf-next/c/45105c2eb751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


