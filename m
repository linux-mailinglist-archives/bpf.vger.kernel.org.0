Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF23649566A
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378097AbiATWkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378095AbiATWkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 17:40:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2558C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:40:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784A96191A
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 22:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D095EC340E0;
        Thu, 20 Jan 2022 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642718409;
        bh=6KV2x5UAyYgG1/bLRxZJjFEhVtMmVtZ5C3rnT4L9eAw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vP6aSqwnjRG0chEzHR+R9pOTBi6WhjCRScbLBhVggGbKC8OFpRIwWXXs6uJSqczgd
         CC0dCujSJj3FiyjMj8JRE18nMxzvFBoQdPQpmnWGZgsbjqSP4985yKpLeigQKa5De7
         phddBCCWQ2TuKY1OGC0VDueKrg1lHPDH2G9RaydcCYFdhGubgCV8dtM5N7YMqz8IWv
         wtga9Go4OhQME6uAzdUm7oULQ5kCy9j1FI7c0LOAhpGsKZ8bmRbbGxzBcmarXAEPTm
         koQPGdtRJLPvrw2OUQ2mZFjIgmEG+6sYUlwroagSocQ0GYpywMVF5VDNWrmkdjZFje
         orlijiSZVv5mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC00BF60796;
        Thu, 20 Jan 2022 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] rely on ASSERT marcos in
 xdp_bpf2bpf.c/xdp_adjust_tail.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164271840976.1166.16657329299123541689.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jan 2022 22:40:09 +0000
References: <cover.1642679130.git.lorenzo@kernel.org>
In-Reply-To: <cover.1642679130.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii.nakryiko@gmail.com,
        lorenzo.bianconi@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 20 Jan 2022 12:50:25 +0100 you wrote:
> Rely on ASSERT* macros and get rid of deprecated CHECK ones in xdp_bpf2bpf and
> xdp_adjust_tail bpf selftests.
> This is a preliminary series for XDP multi-frags support.
> 
> Changes since v1:
> - run each ASSERT test separately
> - drop unnecessary return statements
> - drop unnecessary if condition in test_xdp_bpf2bpf()
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: selftests: get rid of CHECK macro in xdp_adjust_tail.c
    https://git.kernel.org/bpf/bpf-next/c/791cad025051
  - [v2,bpf-next,2/2] bpf: selftests: get rid of CHECK macro in xdp_bpf2bpf.c
    https://git.kernel.org/bpf/bpf-next/c/fa6fde350b16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


