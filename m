Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7593EEF05
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 17:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhHQPUj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 11:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhHQPUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 11:20:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6128260FC3;
        Tue, 17 Aug 2021 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629213605;
        bh=LKheDKKKN7aU8/P++S4JpWLfPyMW9UI4gjKHVpN9ifo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KffSS1hv2J4CmrtJsEH+051ZqGfrz2bKqPclDu0ywue17zg4E+Zr2cSjooWWpAUmK
         dT5FeRDPSdbdsWnGMsk7XZCzgUCOM3FX2PZUxnZwcbpLHVQMtoY4ayBpHn7k0M1cvA
         DBXkpBkTkUfERAhRdQrmbD4E1UMGfH6hVFvgk2DV7x0W8ZzATvv9D+Hd2draMt7MCf
         yjYfzyFlfRL971yK4I9HBANI8zWluFbBpldSJSUnTBdVCFPyWdfzYwKXiChbkDRdSn
         Nt5vH9XEBnpAarE7ZfKS1M46PiSvJP7iWJrXGTey675G/FgIVSFSkq+BQmDT97UFdR
         5zyUFNDTwyFVw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5581960A25;
        Tue, 17 Aug 2021 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] selftests/bpf: Add exponential backoff to
 map_delete_retriable in test_maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162921360534.31680.4489138432474945294.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Aug 2021 15:20:05 +0000
References: <20210817045713.3307985-1-fallentree@fb.com>
In-Reply-To: <20210817045713.3307985-1-fallentree@fb.com>
To:     Yucong Sun <fallentree@fb.com>
Cc:     andrii@kernel.org, sunyucong@gmail.com, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 16 Aug 2021 21:57:13 -0700 you wrote:
> Using a fixed delay of 1 microsecond has proven flaky in slow CPU environment,
> e.g. Github Actions CI system. This patch adds exponential backoff with a cap
> of 50ms to reduce the flakiness of the test. Initial delay is chosen at random
> in the range [0ms, 5ms).
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] selftests/bpf: Add exponential backoff to map_delete_retriable in test_maps
    https://git.kernel.org/bpf/bpf-next/c/857f75ea8457

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


