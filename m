Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610972B733D
	for <lists+bpf@lfdr.de>; Wed, 18 Nov 2020 01:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgKRAkH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 19:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgKRAkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 19:40:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605660006;
        bh=go9oetv/NnAHIMcevcbrihVwJOjTRqpZY5jHueeHVSU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KgIbWTW7EjSKTjeBcWPeGnZJExVqyn1eLakhTA62HnHfS15L8tfxcWrfyqSM60f/v
         qesjHEEsZimaDsO7L1KOiT8ASMhdI3PZwGLIfF5VCp7wSPqSFlIWPy+jX7gQaEEVNS
         zyrb9ic3+ftVwe1bou4JWUI3gEm6Q/p7RIvjy6/A=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add bpf_bprm_opts_set helper
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160566000595.20766.10496873955506140440.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Nov 2020 00:40:05 +0000
References: <20201117232929.2156341-1-kpsingh@chromium.org>
In-Reply-To: <20201117232929.2156341-1-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com,
        ast@kernel.org, daniel@iogearbox.net, revest@chromium.org,
        jackmanb@chromium.org, middelin@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 17 Nov 2020 23:29:28 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The helper allows modification of certain bits on the linux_binprm
> struct starting with the secureexec bit which can be updated using the
> BPF_F_BPRM_SECUREEXEC flag.
> 
> secureexec can be set by the LSM for privilege gaining executions to set
> the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> use of certain environment variables (like LD_PRELOAD).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Add bpf_bprm_opts_set helper
    https://git.kernel.org/bpf/bpf-next/c/3f6719c7b62f
  - [bpf-next,v4,2/2] bpf: Add tests for bpf_bprm_opts_set helper
    https://git.kernel.org/bpf/bpf-next/c/ea87ae85c9b3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


