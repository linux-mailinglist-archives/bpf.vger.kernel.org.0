Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0D35317E
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 01:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDBXaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 19:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBXaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 19:30:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7A65461178;
        Fri,  2 Apr 2021 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617406212;
        bh=ZMqsFUmJeRo9vSoC4+G35eEJQdRtW/VJaPaxMVzCEZk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ubo6uVnTOxhE1RNVmobDdQ+3/4G9OQSvO96gsPYBJa/VsD+cNFPc+zmrKc6ongfSX
         4U3Dkj8cb30OAMhHiQFCU8DYOe8lKsLY8WOCCoWJ7U9Sr1lK/yUncNF/Hhhq9tlFZ1
         +r+Vlm19hSYVXNB5yxA2POPNgAeIOos3iAfgf+AI0Pb+QnDXIL3o63/mc63iIjIJ4P
         6L0pmmpxGJp5/MLgk8GygARbSmyAQzk+6Bd8MRCaapEHeBDrXHtFW4zNua76yaQRVh
         pWRQhX3HhiFSCl3Rt5Mb5yIT4I+SHVF8qA7jMDXAiixjJSNgjmX7eLFuurEIj0+jHm
         EtS6c50YQFLRA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6B4ED609D3;
        Fri,  2 Apr 2021 23:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 selftests: test_maps generating unrecognized data section
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161740621243.19170.12135006939919119432.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Apr 2021 23:30:12 +0000
References: <161731595664.74613.1603087410166945302.stgit@john-XPS-13-9370>
In-Reply-To: <161731595664.74613.1603087410166945302.stgit@john-XPS-13-9370>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@fb.com, andrii.nakryiko@gmail.com, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 01 Apr 2021 15:25:56 -0700 you wrote:
> With a relatively recent clang master branch test_map skips a section,
> 
>  libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> 
> the cause is some pointless strings from bpf_printks in the BPF program
> loaded during testing. After just removing the prints to fix above
> error Daniel points out the program is a bit pointless and could
> be simply the empty program returning SK_PASS.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, selftests: test_maps generating unrecognized data section
    https://git.kernel.org/bpf/bpf-next/c/007bdc12d4b4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


