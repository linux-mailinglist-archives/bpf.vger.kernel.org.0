Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1029E2D701D
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 07:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392681AbgLKGVG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 01:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392014AbgLKGUv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 01:20:51 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607667610;
        bh=SgIBIB8iOaGhgAj79G3MqZXSLGznL6eAZi8o9kCM3eg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tQRNBkKJHQLbg4fgtgUXpJOAEwPrqRv9KESKRBe0BZp6yRGgbqNhvpjUyo/pWolvh
         9r6+yqferZnzvChsMW9m5Qt4jeZV6EeONf5TLCELtRCVBYGcSdLaHZiHJtq240UlMj
         qskbvVnYxRhgxN/VZxcMu66tbLYRzagh9kiDsJ5beyXwTDLrWQZCDXbtllCSTWzh1j
         k1TCJdsHJG9dGirvjjMsaiUn0blDySt8yavBUZEDjNMrjF35nUc80UrqvDq3GIwupQ
         evL/vDv46lkKZK5Q5kyvUM5aKiC5Fo/KHSbcVQluTybqdlXLG+WCK5hPmcogAUA6jS
         0tj2LyTKAgHhw==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Silence ima_setup.sh when not
 running in verbose mode.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160766761069.15480.6756712628902910100.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Dec 2020 06:20:10 +0000
References: <20201211010711.3716917-1-kpsingh@kernel.org>
In-Reply-To: <20201211010711.3716917-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 11 Dec 2020 01:07:11 +0000 you wrote:
> Currently, ima_setup.sh spews outputs from commands like mkfs and dd
> on the terminal without taking into account the verbosity level of
> the test framework. Update test_progs to set the environment variable
> SELFTESTS_VERBOSE=1 when a verbose output is requested. This
> environment variable is then used by ima_setup.sh (and can be used by
> other similar scripts) to obey the verbosity level of the test harness
> without needing to re-implement command line options for verbosity.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Silence ima_setup.sh when not running in verbose mode.
    https://git.kernel.org/bpf/bpf-next/c/b4fe9fec51ef

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


