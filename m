Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C632F27CA98
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgI2MUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 08:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732467AbgI2MUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382008;
        bh=HYxGlk6NQY71ojUKwTQeds4Me6ucmHaf8NpcyRLpkN8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZlfWno5wZeUobHPmALGG2z/GOPfdcb4BiT4th2IFIexyso+CfOWSAaCb7YDmBxr7x
         tIIgYOnILTWEhJlhtLvGrgTFoU4kb7zp9wQSa7PMXNyejnYMr31F+M5bCgpEcsApkd
         m56OXanmiqE6/aDaNGBInknMh5UcpAyWTk7Y3qPo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next PATCH] bpf,
 selftests: Fix cast to smaller integer type 'int' warning in raw_tp
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160138200850.26741.8249592517695495561.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 12:20:08 +0000
References: <160134424745.11199.13841922833336698133.stgit@john-Precision-5820-Tower>
In-Reply-To: <160134424745.11199.13841922833336698133.stgit@john-Precision-5820-Tower>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 18:50:47 -0700 you wrote:
> Fix warning in bpf selftests,
> 
> progs/test_raw_tp_test_run.c:18:10: warning: cast to smaller integer type 'int' from 'struct task_struct *' [-Wpointer-to-int-cast]
> 
> Change int type cast to long to fix. Discovered with gcc-9 and llvm-11+
> where llvm was recent main branch.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, selftests: Fix cast to smaller integer type 'int' warning in raw_tp
    https://git.kernel.org/bpf/bpf-next/c/00e8c44a147a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


