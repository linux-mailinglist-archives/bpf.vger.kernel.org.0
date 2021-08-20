Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6575E3F2C77
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhHTMwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 08:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237828AbhHTMwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 08:52:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3FB986101A;
        Fri, 20 Aug 2021 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629463929;
        bh=vAGcUhTQ0aWl1paGMLUBG6IoKyVBel965iPj8zNRdI4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dsuE42PMw8bkiZq+Sj5X4o0Euzdvko1WDS1LJG0X2RbHtrXmy2qisdr9XFzENLTKi
         aUj3qtViEyEqxmdu0SC7+Hqd25K8TWsyg+xvx8rIUmZNYIv5w5AjZ2GqIEoM0/Eegv
         Bxn2AocHBSJKuFApBVkatKEtwNI4hysMvS0aRuvZAXtVzdZyQL5vpAFQ8J6b+Ld5xL
         ElRZ2HRSDKr10tJbUpbj4TIoCG/JEVZa2y8885GBazdrITpxyA9pqJMSwJQdMqs1tj
         ZgBqXrVW3q+Z5TifaQJWZY94Z2/wdaMQGDvQSqXB+8iPWZGEK302b8GhVJKqn+jOfx
         ohnwXis1A3YNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 36ED960A21;
        Fri, 20 Aug 2021 12:52:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] Add support for bpf_setsockopt and
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162946392922.27725.16535081843524240254.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Aug 2021 12:52:09 +0000
References: <20210817224221.3257826-1-prankgup@fb.com>
In-Reply-To: <20210817224221.3257826-1-prankgup@fb.com>
To:     Prankur gupta <prankgup@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, prankur.07@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 17 Aug 2021 15:42:19 -0700 you wrote:
> v2: Added details about the test in commit log
> 
> This patch contains support to set and get socket options from
> setsockopt
> bpf program.
> This enables us to set multiple socket option when the user changes a
> particular socket option.
> Example use case, when the user sets the IPV6_TCLASS socket option we
> would also like to change the tcp-cc for that socket. We don't have any
> use case for calling bpf_setsockopt from supposedly read-only
> sys_getsockopt, so it is made available to BPF_CGROUP_SETSOCKOPT only.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Add support for {set|get} socket options from setsockopt BPF
    https://git.kernel.org/bpf/bpf-next/c/2c531639deb5
  - [bpf-next,2/2] selftests/bpf: Add test for {set|get} socket option from setsockopt BPF program
    https://git.kernel.org/bpf/bpf-next/c/f2a6ee924d26

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


