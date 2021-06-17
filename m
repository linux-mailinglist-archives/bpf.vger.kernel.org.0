Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3602D3AA9D9
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 06:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhFQEWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 00:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhFQEWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 00:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D28AA613CE;
        Thu, 17 Jun 2021 04:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623903603;
        bh=9pAC13zSyUale0AW2dVXWJ4wQJJfwltO3XUY0oGmE4Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DlYf+YG2frhvdtFAbc9/krduP4wj8biCejkryWCfcGsqdj8whPBz11NW8elftUa0z
         uzhh1NBLeh5fuFTh2U+o87oKJmiDUmkmrzBHgKnaBxvYJgPtbZ481MhibmeuDECRoj
         pZwd7S8egclshCPF4s0ULPTNDB4ywe1Fd6YlCBcJt6T8HyetSyD6hypgqAMa+FfBDK
         Syc1V4uUSCGQOG/Ta+gFBbOz6uZoqBwq1zvUNpGTP7X87rNImN6kN7mq8m+j9B+X7C
         z98g66o3ryOSBCQQu6zJIhZLzhYPeJNQqOEPdR1s2w269SdF+yxG5RFJwLkni5vvkj
         wMbj6COm4zeZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C610B60CD0;
        Thu, 17 Jun 2021 04:20:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/1] lib: bpf: tracing: fail compilation if target arch
 is missing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162390360380.962.14577274135893714325.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Jun 2021 04:20:03 +0000
References: <20210616083635.11434-1-lmb@cloudflare.com>
In-Reply-To: <20210616083635.11434-1-lmb@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 16 Jun 2021 09:36:35 +0100 you wrote:
> bpf2go is the Go equivalent of libbpf skeleton. The convention is that
> the compiled BPF is checked into the repository to facilitate distributing
> BPF as part of Go packages. To make this portable, bpf2go by default
> generates both bpfel and bpfeb variants of the C.
> 
> Using bpf_tracing.h is inherently non-portable since the fields of
> struct pt_regs differ between platforms, so CO-RE can't help us here.
> The only way of working around this is to compile for each target
> platform independently. bpf2go can't do this by default since there
> are too many platforms.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/1] lib: bpf: tracing: fail compilation if target arch is missing
    https://git.kernel.org/bpf/bpf-next/c/4a638d581a7a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


