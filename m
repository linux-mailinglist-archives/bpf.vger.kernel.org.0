Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1AC27DD2D
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 02:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgI3AAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 20:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI3AAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 20:00:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601424003;
        bh=A6JJfG8E9Ua0Z1MjKPxxF9c8+gw1X1snHHpD7iPUOGo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Of4p+zKZtP+TMKwrwuLEDDbbgrwYZlMk2iTQKrQKPn/o/TpYTky4kTx8KyyLLQMDN
         1ymZAFGyBkkrTHdyHg7ZuhrCz5v3+j+VZUtGb8gH9AUYPJaZJlm4/IzAmsad+tenUR
         osfBhJ4EyxuXIQ7PhFuHa9G1R1AvoGkkgTooAh80=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf, x64: optimize JIT's pro/epilogue
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160142400339.22881.13903800847155832950.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Sep 2020 00:00:03 +0000
References: <20200929204653.4325-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20200929204653.4325-1-maciej.fijalkowski@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 22:46:51 +0200 you wrote:
> Hi!
> 
> This small set can be considered as a followup after recent addition of
> support for tailcalls in bpf subprograms and is focused on optimizing
> x64 JIT prologue and epilogue sections.
> 
> Turns out the popping tail call counter is not needed anymore and %rsp
> handling when stack depth is 0 can be skipped.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, x64: drop "pop %rcx" instruction on BPF JIT epilogue
    https://git.kernel.org/bpf/bpf-next/c/d207929d97ea
  - [bpf-next,2/2] bpf: x64: do not emit sub/add 0, %rsp when !stack_depth
    https://git.kernel.org/bpf/bpf-next/c/4d0b8c0b46a5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


