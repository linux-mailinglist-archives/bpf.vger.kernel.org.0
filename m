Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0927227D823
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgI2UaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 16:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbgI2UaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411404;
        bh=nW+Hk0tKaZYDSl3lVZdl4YLL0D4cy0TFJh8tQWvp7J4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UR/D+05QLTLSZNsEhjCUUZL+fKX+V4X6XMA/PjLAhLsfvqzERBZg/L/oNGx8vXwY3
         mrqEU4DuLPJ9MvRBjoDhwLiJJtdeZ/3FEAaEKvDglxUBzmIo0a5HoMbEoHN2ytEzXi
         wE6jCLgjVlLtS6qqLGEKHXsjcV3dHPp886dP2ubw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next PATCH] bpf,
 selftests: fix warning in snprintf_btf where system() call unchecked
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160141140480.17638.2211015367858971528.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 20:30:04 +0000
References: <160141006897.25201.12095049414156293265.stgit@john-Precision-5820-Tower>
In-Reply-To: <160141006897.25201.12095049414156293265.stgit@john-Precision-5820-Tower>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 13:07:49 -0700 you wrote:
> On my systems system() calls are marked with warn_unused_result
> apparently. So without error checking we get this warning,
> 
> ./prog_tests/snprintf_btf.c:30:9: warning: ignoring return value
>    of ‘system’, declared with attribute warn_unused_result[-Wunused-result]
> 
> Also it seems like a good idea to check the return value anyways
> to ensure ping exists even if its seems unlikely.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, selftests: fix warning in snprintf_btf where system() call unchecked
    https://git.kernel.org/bpf/bpf-next/c/c810b31ecb03

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


