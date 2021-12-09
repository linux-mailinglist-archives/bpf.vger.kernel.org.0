Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5746E2F7
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhLIHNq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 02:13:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhLIHNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 02:13:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 161FFCE24E3
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 07:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EA82C004DD;
        Thu,  9 Dec 2021 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639033809;
        bh=BGr8DeMQ+XRK17TrAZgOPBMgYdn6UJOwGT9aYx+Aprw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hus0WEJGgmc5XXo0ujMtQt002ZY0+4k2XEOOIamw0UGJ4nfDzNN73+NRofWNW2FB+
         kjfswsQP8IS4XbATVskXGik2FqhPYjTETdB42HbN/sHVKWVCeBLIfdrd57wpKTC6JM
         GRqMt52WpemlB3a4OAIp6qmkjil//A78zDcZD80eD0U9XQz0iZWrluqipbHHxVLmgh
         s3IO/L6GWYmCkbgmz/U91ASTW4f62eiJ2uBr+bk/Xsx6FXXlhkG3rcATcpCjuBMbbM
         kLlCPAI+vFJC+XKNTdD2plM9vbpmNE7Q/5cD9grm6JlsvIH90hljCUn7YxKlumkgaW
         xgIQRJxFzMoWA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E952A60A4D;
        Thu,  9 Dec 2021 07:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a compilation warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163903380895.9212.6767669055885105398.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Dec 2021 07:10:08 +0000
References: <20211209050403.1770836-1-yhs@fb.com>
In-Reply-To: <20211209050403.1770836-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 8 Dec 2021 21:04:03 -0800 you wrote:
> The following warning is triggered when I used clang compiler
> to build the selftest.
> 
>   /.../prog_tests/btf_dedup_split.c:368:6: warning: variable 'btf2' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>         if (!ASSERT_OK(err, "btf_dedup"))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /.../prog_tests/btf_dedup_split.c:424:12: note: uninitialized use occurs here
>         btf__free(btf2);
>                   ^~~~
>   /.../prog_tests/btf_dedup_split.c:368:2: note: remove the 'if' if its condition is always false
>         if (!ASSERT_OK(err, "btf_dedup"))
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /.../prog_tests/btf_dedup_split.c:343:25: note: initialize the variable 'btf2' to silence this warning
>         struct btf *btf1, *btf2;
>                                ^
>                                 = NULL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix a compilation warning
    https://git.kernel.org/bpf/bpf-next/c/b540358e6c4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


