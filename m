Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8486445E2E7
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 23:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhKYWPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 17:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhKYWNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 17:13:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3C6EF61130;
        Thu, 25 Nov 2021 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637878209;
        bh=+en/9tmOqieISr9M4HJvQFEFMhPX9/hOGDnh13d0kBw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nDTfbCDofMVMtB2TxNk0c1r2vKLj8aJUxy/2sREaStajD9VKgv23g24ub1PXGYgB+
         aR8yEprtPC+XMjPqCFkUN2/foAzqhknR1ZUc6H1ecyZSY5cF29XncpMuww0bIi0bCe
         esb0hpYfOmzI3/upEVaJXCUSoOJm1EL7mpieGE6l+LrqQCMvB62WaRDnnNDUeIACXF
         X2Rn0MdNBLI9w2jLWHnCoZLpinWt7ecvbPwNIm+iRAksByIIcKZ8vGalsgCzTQ13fG
         MsHrF9Ft4Yu1M7CQ/dEOWibl/2QQM2tkrL3iDIADuf9yyWGAgv4nowQfJU5tHttHfy
         jtWq0O/8rambg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2CD8E60A4E;
        Thu, 25 Nov 2021 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: load global data maps lazily on
 legacy kernels
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163787820917.6965.4029647479959151077.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Nov 2021 22:10:09 +0000
References: <20211123200105.387855-1-andrii@kernel.org>
In-Reply-To: <20211123200105.387855-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, songliubraving@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 23 Nov 2021 12:01:04 -0800 you wrote:
> Load global data maps lazily, if kernel is too old to support global
> data. Make sure that programs are still correct by detecting if any of
> the to-be-loaded programs have relocation against any of such maps.
> 
> This allows to solve the issue ([0]) with bpf_printk() and Clang
> generating unnecessary and unreferenced .rodata.strX.Y sections, but it
> also goes further along the CO-RE lines, allowing to have a BPF object
> in which some code can work on very old kernels and relies only on BPF
> maps explicitly, while other BPF programs might enjoy global variable
> support. If such programs are correctly set to not load at runtime on
> old kernels, bpf_object will load and function correctly now.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] libbpf: load global data maps lazily on legacy kernels
    https://git.kernel.org/bpf/bpf-next/c/16e0c35c6f7a
  - [v2,bpf-next,2/2] selftests/bpf: mix legacy (maps) and modern (vars) BPF in one test
    https://git.kernel.org/bpf/bpf-next/c/e4f7ac90c2b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


