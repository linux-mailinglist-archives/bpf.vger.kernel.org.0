Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D945719D
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhKSPdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 10:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhKSPdL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 10:33:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F68261B27;
        Fri, 19 Nov 2021 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637335809;
        bh=XIvfsmpMmoSj4+F6lfXKn3KsvPuSAmi3rbS8cANcq3E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=np1tu0ULkXdS88Ifuo5dMqovMEQ1EvkqJ7o1F512YF1WXjhQp6sK1oxbndp53Pw7K
         /KP58UermQ1m//NAkYTUOzZOi0Hjf4DsmvCQXO0N+RRcV/AYFF4+EigURS0V5t9fxG
         BQoJ+ov5Sx2BfC6LpvEcRN2Z+RiAXzio7P3Exkgn4Ehai8td2hEWCeHFP1OIRgRZF6
         /1azQO0sUwRUsirXpm+45D5M6kEpXmwzigwcrZc/vyOMSq6cAJq+nKjF3zY6BYGLdG
         3mR2mQ8PpAvSrfWGotdMaoLDy2Z3Mn5UzI5gGtPNXLQ9IXvXKQRPWFpuc2uJol4rfh
         FcQ+jjz4H+Dcg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 246E9604EB;
        Fri, 19 Nov 2021 15:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: add runtime APIs to query libbpf version
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163733580914.14687.10562422329373013535.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Nov 2021 15:30:09 +0000
References: <20211118174054.2699477-1-andrii@kernel.org>
In-Reply-To: <20211118174054.2699477-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, john.fastabend@gmail.com, toke@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 18 Nov 2021 09:40:54 -0800 you wrote:
> Libbpf provided LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macros to
> check libbpf version at compilation time. This doesn't cover all the
> needs, though, because version of libbpf that application is compiled
> against doesn't necessarily match the version of libbpf at runtime,
> especially if libbpf is used as a shared library.
> 
> Add libbpf_major_version() and libbpf_minor_version() returning major
> and minor versions, respectively, as integers. Also add a convenience
> libbpf_version_string() for various tooling using libbpf to print out
> libbpf version in a human-readable form. Currently it will return
> "v0.6", but in the future it can contains some extra information, so the
> format itself is not part of a stable API and shouldn't be relied upon.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: add runtime APIs to query libbpf version
    https://git.kernel.org/bpf/bpf-next/c/7615209f42a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


