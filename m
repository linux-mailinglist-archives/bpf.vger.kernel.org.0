Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45CC2AF9DF
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKKUkH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgKKUkH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 15:40:07 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605127206;
        bh=MkvWH6k+wyGwy9eJK8AegUcYtD99Xk2lFGue+FbDdRA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=2TMwqbU9q85kDndZMImQqLC7KwR2Uo/srCsAMt7Oj0RjANWemgjNN9tn3V2AvPWFE
         dqrjfJv5pC3U9wHyaXDqk9qUCfMdvPLzn0RUDVv1MnWSNTkrjSyCsCaz8eGRoocZo1
         nDk7YCZjNgyp9yoK6XS3SiwNMPcCp7Tei1spAYh0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] tools/bpftool: Some build fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160512720643.1646.2354763888884596617.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Nov 2020 20:40:06 +0000
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 10 Nov 2020 17:43:04 +0100 you wrote:
> A few fixes for cross and out-of-tree build of bpftool and runqslower.
> These changes allow to build for different target architectures, using
> the same source tree.
> 
> Since [v2], I addressed Andrii's comments on patches 3 and 5, and added
> patch 7 which fixes a build slowdown.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
    https://git.kernel.org/bpf/bpf-next/c/c8a950d0d3b9
  - [bpf-next,v3,2/7] tools/bpftool: Force clean of out-of-tree build
    https://git.kernel.org/bpf/bpf-next/c/9e8929fdbb9c
  - [bpf-next,v3,3/7] tools/bpftool: Fix cross-build
    https://git.kernel.org/bpf/bpf-next/c/8859b0da5aac
  - [bpf-next,v3,4/7] tools/runqslower: Use Makefile.include
    https://git.kernel.org/bpf/bpf-next/c/3290996e7133
  - [bpf-next,v3,5/7] tools/runqslower: Enable out-of-tree build
    https://git.kernel.org/bpf/bpf-next/c/85e59344d079
  - [bpf-next,v3,6/7] tools/runqslower: Build bpftool using HOSTCC
    https://git.kernel.org/bpf/bpf-next/c/2d9393fefb50
  - [bpf-next,v3,7/7] tools/bpftool: Fix build slowdown
    https://git.kernel.org/bpf/bpf-next/c/0639e5e97ad9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


