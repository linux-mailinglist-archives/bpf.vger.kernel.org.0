Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441A03E2DC9
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbhHFPaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Aug 2021 11:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244675AbhHFPaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 11:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 96F8F61179;
        Fri,  6 Aug 2021 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628263805;
        bh=8Jdbqr8SQtb4lL2oqOcHvBblUQb+FTIupDAtcPZ7EB4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L5yC2aT7+SqLi0Za1bzKzicvb4DfcgdjgLrxNuJG4c8AW2vKANcsDz/B8Zj18MHam
         2hopFznxWLWSX1TSJOBu0XqbA8S8H7YNe5AS0w2D7WJPkKMt7TjzWvnK5ZU4sW0pM6
         pXKUvCGDKFkqzNB2YlgfNz30WhOCCySpMlYT0yzSrDDC4/sm/vYyAjntHxByZvtqgb
         qJsXYnyoFvrhWOJ2F/ihvn1H9OefqOzc8bqpHBNAmnhagzDwyP8fqDcaKQZLsuq3zW
         gLsija9T1OxDqQosaIqQnxOsFXa5GNW/nFM+9PaEPxwuITL7TazlE43mu8JaPAdGEN
         d2AmdWOpkU1uQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8BD2260A7C;
        Fri,  6 Aug 2021 15:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: rename reference_tracking BPF
 programs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162826380556.27843.6888227098570168634.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Aug 2021 15:30:05 +0000
References: <20210805230734.437914-1-andrii@kernel.org>
In-Reply-To: <20210805230734.437914-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 5 Aug 2021 16:07:34 -0700 you wrote:
> BPF programs for reference_tracking selftest use "fail_" prefix to notify that
> they are expected to fail. This is really confusing and inconvenient when
> trying to grep through test_progs output to find *actually* failed tests. So
> rename the prefix from "fail_" to "err_".
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: rename reference_tracking BPF programs
    https://git.kernel.org/bpf/bpf-next/c/579345e7f219

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


