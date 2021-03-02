Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0A32B31D
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbhCCDou (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349587AbhCBKkz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 05:40:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5437F64F0D;
        Tue,  2 Mar 2021 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614681609;
        bh=JspeI+qEObb9+R0y7wiFH25+3V3R+SpMp98YuaJCgS8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=psPbba89g2launHL712OHIc0+MFB9p04/5Rezh4Kd7I+pfE9rIC9mtpM1ivLD1D0c
         sfxq0xnShH9TUez/L3HpbA6UU8LM43ouqY5pC9Nea0HBWo3XoSTmFJzZiTm4E2tDHb
         fmLw8XTds2PaT48o3LQEqHpNEHRlCC0U/JVaS/7DKNzDBHHlP7+iR3ceXJmtOMB04D
         yCNHgqygGQu4OGP3EH0+iUv6sUIoa0HSkCr6qluBWCTAIGKmABE0rb5n8Kx/mc0Qiq
         ZDAeqqhpJ2HKmlJ3WLnTPqtvpPTIp7+5B94HuPRXfJDjQC/li/VXZDpAhS3OeE/uqx
         17qBSjcmCdKrg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3FF0760192;
        Tue,  2 Mar 2021 10:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: Use the last page in
 test_snprintf_btf on s390
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161468160925.21557.3549250924796518274.git-patchwork-notify@kernel.org>
Date:   Tue, 02 Mar 2021 10:40:09 +0000
References: <20210227051726.121256-1-iii@linux.ibm.com>
In-Reply-To: <20210227051726.121256-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        heiko.carstens@de.ibm.com, bpf@vger.kernel.org, gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sat, 27 Feb 2021 06:17:26 +0100 you wrote:
> test_snprintf_btf fails on s390, because NULL points to a readable
> struct lowcore there. Fix by using the last page instead.
> 
> Error message example:
> 
>     printing fffffffffffff000 should generate error, got (361)
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] selftests/bpf: Use the last page in test_snprintf_btf on s390
    https://git.kernel.org/bpf/bpf/c/42a382a466a9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


