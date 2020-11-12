Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650772B0DC3
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 20:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKLTU2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 14:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKLTU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 14:20:28 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605208827;
        bh=EZnj4lFL4efndtJE9wwQyUiUietoNUis7cDXTWIqCdk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=wPGK5frRs8u1rY6AvwitG8yR35wWwPIdSK9Qt2EC33jrBwvZGpSvpYHuDPXwXst5F
         BI1uLgfVSC4dr67y+l/jMhP9YRYuBPZgDs+ApvAtvP5nlMUsdzKqEuIvAjvWzHCa6p
         +ajFCtUH7+ZljWGhZFmdkRc5eH0w1usBRvuqNdp4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] tools/bpf: Add bootstrap/ to .gitignore
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160520882784.10993.15549409637311773880.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Nov 2020 19:20:27 +0000
References: <20201112091049.3159055-1-jean-philippe@linaro.org>
In-Reply-To: <20201112091049.3159055-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 12 Nov 2020 10:10:50 +0100 you wrote:
> Commit 8859b0da5aac ("tools/bpftool: Fix cross-build") added a
> build-time bootstrap/ directory for bpftool, and removed
> bpftool-bootstrap. Update .gitignore accordingly.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] tools/bpf: Add bootstrap/ to .gitignore
    https://git.kernel.org/bpf/bpf-next/c/6a59edd832e2
  - [bpf-next,2/2] tools/bpf: Always run the *-clean recipes
    https://git.kernel.org/bpf/bpf-next/c/c36538798fc6

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


