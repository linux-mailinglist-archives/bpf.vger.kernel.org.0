Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5675B3043B8
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 17:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392844AbhAZQXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 11:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404348AbhAZQUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 11:20:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4DFE02074A;
        Tue, 26 Jan 2021 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611678010;
        bh=RnpgxvnAcnVE/Rm5Z3B2m9Dj3qyfImrkMIs90xCITRM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bk86UcK9+VgTLQlmqFuIAYf6dwuXlEeCYuNpQpX/fc77VCDDtKnYouZuenyDAsanp
         03hFSy6f95E4tFz9CkjBM4rfIDFnG1NMG8BXMuszla5XVKgJTizBfRfy+vhOalHe3r
         JPW98Xb9gXkulKF0Wo9yrOIKAfmKuv9zMHmQj7ySGqxno26wm/aukSlAo2enHlgBDA
         qpTUevUsI8x2r1u3BK9fHddqZYTsB1lwZO9zREhUuqKxm69ACDxgRI509HnyOZP7xn
         6/r+CjmTJ5Gs1D0mc+O/LR2e+JTOuK0jmsomwIUZ5Ms+QPStMPZxnSXQM4KZLfliuq
         q1ZckhFCQNAXA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 45F0661E3F;
        Tue, 26 Jan 2021 16:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Drop disabled LSM hooks from the sleepable set
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161167801027.27230.2221763931153263483.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Jan 2021 16:20:10 +0000
References: <20210125063936.89365-1-mikko.ylinen@linux.intel.com>
In-Reply-To: <20210125063936.89365-1-mikko.ylinen@linux.intel.com>
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     kpsingh@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kpsingh@google.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 25 Jan 2021 08:39:36 +0200 you wrote:
> Some networking and keys LSM hooks are conditionally enabled
> and when building the new sleepable BPF LSM hooks with those
> LSM hooks disabled, the following build error occurs:
> 
> BTFIDS  vmlinux
> FAILED unresolved symbol bpf_lsm_socket_socketpair
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Drop disabled LSM hooks from the sleepable set
    https://git.kernel.org/bpf/bpf/c/78031381ae9c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


