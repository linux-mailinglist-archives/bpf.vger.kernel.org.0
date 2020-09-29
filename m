Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24227D5AE
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgI2SUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 14:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgI2SUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 14:20:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601403603;
        bh=a7cR4SNaXHCFV8AEUX3j/aCTeAkLQDqXqp6bIaKI0p0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nKsNWK2Hdmr72vO73MzAzUwNBqj63AIkHCvaxk6Qb5tyWtRZdDGH6MF5vz2ENfK63
         HP5o1OTnSJL9mmHnd29ldHTZmQeuR9ND1rHSKgsyThJ3ltrJdEhe4fzkUATpuyKvZC
         Rh8lTkH1m/1+QNIl2yK8wFsA8iGCSD4RHg3AJAVc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf/preload: make sure Makefile cleans up after
 itself, and add .gitignore
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140360307.18925.15245013041666309587.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 18:20:03 +0000
References: <20200927193005.8459-1-toke@redhat.com>
In-Reply-To: <20200927193005.8459-1-toke@redhat.com>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 27 Sep 2020 21:30:05 +0200 you wrote:
> The Makefile in bpf/preload builds a local copy of libbpf, but does not
> properly clean up after itself. This can lead to subsequent compilation
> failures, since the feature detection cache is kept around which can lead
> subsequent detection to fail.
> 
> Fix this by properly setting clean-files, and while we're at it, also add a
> .gitignore for the directory to ignore the build artifacts.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf/preload: make sure Makefile cleans up after itself, and add .gitignore
    https://git.kernel.org/bpf/bpf-next/c/9d9aae53b96d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


