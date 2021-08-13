Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB763EBEE2
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhHMXud (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 19:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235727AbhHMXuc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 19:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 61C21610FC;
        Fri, 13 Aug 2021 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628898605;
        bh=vc2x4x9gtq8OXojxtFDwq8/ycuLwggQRQItU+eIu8yQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lBqKrQDIEAycH6a+GE67KbupwqBMmYWZtRhhdvcJYbeYbD5RfCZBLlZC2YcRnXyN9
         WVttwndpa9iDZDju2nYJBTdzU+v5t1fdKUb/Vkbkvh4ybHQgdPHB4k25TF+JKAYVwd
         tVgOTuBltcEBacDLuhd9rudwHLaHT45s2dhIK511RXngf2DTuAqhHuPMv+dHwnN0tw
         wFvCI/Iy0+j7YMs/00J4+aOv5Wviwq3OXzOC0PUGTc5uFE2GP87GtriNM1x5V+nTOM
         OTb/vXKW0n8SnDlu5pI9F06UQ/v6xIH6Xg/S0Y26lp7n8Uu0NPlXeSKdMClxfn6OYp
         puIAaldMTeDMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 53F6060A9C;
        Fri, 13 Aug 2021 23:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_core_autosize on big-endian
 machines
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162889860533.22125.9682341429405959219.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Aug 2021 23:50:05 +0000
References: <20210812224814.187460-1-iii@linux.ibm.com>
In-Reply-To: <20210812224814.187460-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        andrii.nakryiko@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 13 Aug 2021 00:48:14 +0200 you wrote:
> The "probed" part of test_core_autosize copies an integer using
> bpf_core_read() into an integer of a potentially different size.
> On big-endian machines a destination offset is required for this to
> produce a sensible result.
> 
> Fixes: 888d83b961f6 ("selftests/bpf: Validate libbpf's auto-sizing of LD/ST/STX instructions")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix test_core_autosize on big-endian machines
    https://git.kernel.org/bpf/bpf-next/c/d164dd9a5c08

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


