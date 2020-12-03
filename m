Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC98A2CDF3F
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 21:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLCUAq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 15:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgLCUAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 15:00:46 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607025606;
        bh=u2avPBs2wcV6gNPGB4NiNw7lv0Nkjyx9BafWVAygCvs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jJNpU9ilhqfZlRtwQN3wA3DSj5bJbjzxbLr29aVfz9FT7g10YymZtwte12YztqDBK
         3w7TMC4JKq4Ip7d9zPObfnsR7/9RHwlIyUvhlYIjG51+aSWhGXjOg9NIuibUQObQXm
         YGRuKePbFRBil9eMGF82R/9tXnCSrKklOShDIl7st2RkyhLCT4E9YVdOoFe6amKh6y
         M3FXRpue75A+du95EVzsguzePApgWyjlK4A3yKWJen+VC98FpfU50enN4dseHysPkN
         8qEINASIFEipDUwzQGDOJZPVOpyWmRoHixFwq2/X9F5Y8ErSzCamQy2IIf3fQU4Rc8
         z0WrlzA9iempg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: fail early when loading programs with
 unspecified type
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160702560588.30230.4432583746640187390.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Dec 2020 20:00:05 +0000
References: <20201203043410.59699-1-andreimatei1@gmail.com>
In-Reply-To: <20201203043410.59699-1-andreimatei1@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed,  2 Dec 2020 23:34:10 -0500 you wrote:
> Before this patch, a program with unspecified type
> (BPF_PROG_TYPE_UNSPEC) would be passed to the BPF syscall, only to have
> the kernel reject it with an opaque invalid argument error. This patch
> makes libbpf reject such programs with a nicer error message - in
> particular libbpf now tries to diagnose bad ELF section names at both
> open time and load time.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: fail early when loading programs with unspecified type
    https://git.kernel.org/bpf/bpf-next/c/80b2b5c3a701

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


