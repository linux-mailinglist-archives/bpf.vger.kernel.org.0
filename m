Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5851B2CDEFC
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgLCTar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgLCTar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:30:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607023806;
        bh=dT2HzCtMq+sI/LqFf79XJGh9+BkxaJoiZpJnWrAnIi4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gs0SGs4p62bRTsdVtgHoO5bQyJMKfXQRcINRH4pMLR9f/ln7bWdLKJ90h1Y7RFlk6
         t3IIFStTC8PCt98uuCNmoOzd0BMnd7YWz2hA6mD4HqMvT82JV+k8BsvCD9uQVqX+uC
         dpAT+Suq/J//5E6GwQmdTaYb9KO08yQddKX32c2bbrGAkcx8DenLMmJm/U39D2erT5
         JIFBVt9H0bffdNQ1B5tzEyKG8q8geaRdmP+L7AZxcmmWtJGhjH/HH/X6pjlysGDEAJ
         R8tNOr3kSgNv10Q7NfFh/6S35mBS766pnda4Hz1SvnJ/y4y4P1T6vIFo3WnulYD8ck
         QOKiYE1jT5zhg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] Fixes for ima selftest
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160702380669.17238.10473020024774391324.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Dec 2020 19:30:06 +0000
References: <20201203191437.666737-1-kpsingh@chromium.org>
In-Reply-To: <20201203191437.666737-1-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  3 Dec 2020 19:14:33 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v3 -> v4
> 
> * Fix typos.
> * Update commit message for the indentation patch.
> * Added Andrii's acks.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] selftests/bpf: Update ima_setup.sh for busybox
    https://git.kernel.org/bpf/bpf-next/c/3db980449bc3
  - [bpf-next,v4,2/4] selftests/bpf: Ensure securityfs mount before writing ima policy
    https://git.kernel.org/bpf/bpf-next/c/1ee076719d4e
  - [bpf-next,v4,3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
    https://git.kernel.org/bpf/bpf-next/c/d932e043b9d6
  - [bpf-next,v4,4/4] selftests/bpf: Indent ima_setup.sh with tabs.
    https://git.kernel.org/bpf/bpf-next/c/ffebecd9d495

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


