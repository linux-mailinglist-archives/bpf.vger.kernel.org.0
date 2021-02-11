Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608D9318EC3
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBKPdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 10:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhBKPav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 10:30:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B5CFE64EAC;
        Thu, 11 Feb 2021 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613057408;
        bh=L1f0bA3IKI3RlH/dkX4pY30ZhaEthxOu2f1TnjemYXg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FePJkLPfse2d8+PeI4fVORBLA3Hsm7rOC6A533pBiFMJ1napvoa+4esS2Gjq96OYn
         51RdXDJiJtxepJSVaOgyjGWU+abuVuhAZM5GFjE5Hvf9hGweAWz2GlNiv8HBwOfpxc
         zSrehsxcsbIJyRClQoAxDiiZIszhmDR9D8QLejQ6C1CEjI0h3e4wR1R21K8j0WFGjH
         f7UvNT8AlOw0JAqKwTmGxPjnZlYO6T4i1iEcCd+zsInk2st2mJt4ZT+I3nfc/HkNuz
         GU1clWOUtVZ/a04wp2MppqyoHBmkhGwmYvcwGjckDkWC4uOegtDE9N5feBbgNjEsOm
         Koa9BMVRWfL1A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AE99860A28;
        Thu, 11 Feb 2021 15:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/9] bpf: Misc improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161305740871.13437.8696596839743871764.git-patchwork-notify@kernel.org>
Date:   Thu, 11 Feb 2021 15:30:08 +0000
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, bpf@vger.kernel.org,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue,  9 Feb 2021 19:36:25 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v4:
> - split migrate_disable into separate patch
> 
> v3:
> - address review comments
> - improve recursion selftest
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/9] bpf: Optimize program stats
    https://git.kernel.org/bpf/bpf-next/c/700d4796ef59
  - [v4,bpf-next,2/9] bpf: Run sleepable programs with migration disabled
    https://git.kernel.org/bpf/bpf-next/c/031d6e02ddbb
  - [v4,bpf-next,3/9] bpf: Compute program stats for sleepable programs
    https://git.kernel.org/bpf/bpf-next/c/f2dd3b394674
  - [v4,bpf-next,4/9] bpf: Add per-program recursion prevention mechanism
    https://git.kernel.org/bpf/bpf-next/c/ca06f55b9002
  - [v4,bpf-next,5/9] selftest/bpf: Add a recursion test
    https://git.kernel.org/bpf/bpf-next/c/406c557edc5b
  - [v4,bpf-next,6/9] bpf: Count the number of times recursion was prevented
    https://git.kernel.org/bpf/bpf-next/c/9ed9e9ba2337
  - [v4,bpf-next,7/9] selftests/bpf: Improve recursion selftest
    https://git.kernel.org/bpf/bpf-next/c/dcf33b6f4de1
  - [v4,bpf-next,8/9] bpf: Allows per-cpu maps and map-in-map in sleepable programs
    https://git.kernel.org/bpf/bpf-next/c/638e4b825d52
  - [v4,bpf-next,9/9] selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable progs
    https://git.kernel.org/bpf/bpf-next/c/750e5d7649b1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


