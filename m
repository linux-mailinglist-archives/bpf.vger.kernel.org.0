Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE53AEC64
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFUPc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 11:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhFUPcY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 11:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 82C31610A3;
        Mon, 21 Jun 2021 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624289410;
        bh=waUayk7E9O05zgw1JEPUtUwq0ivvDK8ooVWDxBQrHG4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cSHud9uWc9ambxvD6TxEoyhUVhLNhmYAejcgXt9RNyPdctJSorwC9cC0i4x2pr/2U
         cqw2h5V9naXpLnNXBMiY1UOeam9Gy40gv9Ax97MKK63WAHYEGV/lM7DLS9OWcPWwgx
         KIlftQjmGAmC6pfTheT4g2iaY2pNPdBdWkHRqO9PanAHGjEY0Jab5KsV83Y0xqfv6P
         2+7kWz5jsk0XRA8dMKj29PG1+liwAlqNhksupjpnhaabn1BnMpYzFOOtO4cIALUhny
         5/GAcS9EcKz3pdOs8ag2z7rHNRP1x9tZSyoZ8+0DonOJDAB02p3UvboxaPVlCY6Eya
         gCiNdz/dZ1FWQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7A87D604EB;
        Mon, 21 Jun 2021 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: add extra BPF_PROG_TYPE check to
 bpf_object__probe_loading
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162428941049.14724.10215291624709324980.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Jun 2021 15:30:10 +0000
References: <20210619151007.GA6963@165gc.onmicrosoft.com>
In-Reply-To: <20210619151007.GA6963@165gc.onmicrosoft.com>
To:     Jonathan Edwards <jonathan.edwards@165gc.onmicrosoft.com>
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 19 Jun 2021 11:10:07 -0400 you wrote:
> eBPF has been backported for RHEL 7 w/ kernel 3.10-940+ [0]. However
> only the following program types are supported [1]
> 
> BPF_PROG_TYPE_KPROBE
> BPF_PROG_TYPE_TRACEPOINT
> BPF_PROG_TYPE_PERF_EVENT
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: add extra BPF_PROG_TYPE check to bpf_object__probe_loading
    https://git.kernel.org/bpf/bpf-next/c/5c10a3dbe922

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


