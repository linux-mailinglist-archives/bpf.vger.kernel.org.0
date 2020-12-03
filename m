Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41132CDFA7
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 21:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLCUUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 15:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgLCUUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 15:20:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607026806;
        bh=SHlVsajNhEkKDWKAV9w8dMCGebDseuFgbWqCTWpWQj4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I7I3k4jc20+OxTSCd3uph3Ymb5NumBU5p0VR6kkKXwGm+sVnAnwLvUnacNnuyrj4f
         oZWZGsY7E/0zlO93lWntQ3BkXPc4hcaL2x1xc2VqvY0BQc3mu4HXHRM2OPnR9RqMKg
         tC3zO8mA5bm1tv67e3vMpoA9MBiL7mj4Ok0u+qXRUYIoQiCr7FZPOctjejAwOVQnaG
         IjBN+hv9OkDui1Y0Po/fH6z2JX0wJOa2Qq39KE1BXAXfq+n25MDSt7Tl1IsYnHzmMY
         qlR8hh3+QCuYna6eGwYji8Ou2l4pa9ST+2ROKtfB9qx0CkvOCjFc4r/O0b2fymNhuE
         B/OcdLhN7EWlQ==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix cold build of test_progs-no_alu32
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160702680637.7769.14897046184537989999.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Dec 2020 20:20:06 +0000
References: <20201203120850.859170-1-jackmanb@google.com>
In-Reply-To: <20201203120850.859170-1-jackmanb@google.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@chromium.org, revest@chromium.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, andriin@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  3 Dec 2020 12:08:50 +0000 you wrote:
> This object lives inside the trunner output dir,
> i.e. tools/testing/selftests/bpf/no_alu32/btf_data.o
> 
> At some point it gets copied into the parent directory during another
> part of the build, but that doesn't happen when building
> test_progs-no_alu32 from clean.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix cold build of test_progs-no_alu32
    https://git.kernel.org/bpf/bpf-next/c/58c185b85d0c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


