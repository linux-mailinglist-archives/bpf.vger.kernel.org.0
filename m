Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E923D81EF
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 23:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhG0VkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 17:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhG0VkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 17:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2247660F91;
        Tue, 27 Jul 2021 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627422005;
        bh=oHHcu284snEhMrUauSiUWe9F9GKSLtu5QaNMEnGuNkU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mNWC2AehGcMmj+s2HBbMlIZ1aAcMBO95ymwPeHmRzD0lV74oZJNcBcx9Bd3zTnHD+
         93s+V/vf6ogTWNg3GDWASMScdYGvw3lMcxo0apOyp/sQwN5cN6to9zdRruGkBVkSNE
         kahiy2Lpn5cgQchF+m9viAOuzyHQ4TSrsnpWBD8VFMHJeBtLAmZP3/35vWZVKua5SA
         eZE3q0N6U3WKJ0y4g60cd5gZhUoii0Q0yDONnORX7wfSZ18e34FM3V+iVhOABhon4m
         toubd8lEKEWSl3ggCPnFjIfO+ksNN/2ZAtHvFjBKaD3xwZKjSdOkmQtJKefaDuZRQP
         2qkh9NA9shbZg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 17A91609CC;
        Tue, 27 Jul 2021 21:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] libbpf: fix race when pinning maps in parallel
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162742200509.32671.7545782010122853515.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jul 2021 21:40:05 +0000
References: <20210726152001.34845-1-m@lambda.lt>
In-Reply-To: <20210726152001.34845-1-m@lambda.lt>
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, joe@wand.net.nz
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 26 Jul 2021 17:20:01 +0200 you wrote:
> When loading in parallel multiple programs which use the same to-be
> pinned map, it is possible that two instances of the loader will call
> bpf_object__create_maps() at the same time. If the map doesn't exist
> when both instances call bpf_object__reuse_map(), then one of the
> instances will fail with EEXIST when calling bpf_map__pin().
> 
> Fix the race by retrying reusing a map if bpf_map__pin() returns
> EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
> Fix race condition with map pinning").
> 
> [...]

Here is the summary with links:
  - [v2,bpf] libbpf: fix race when pinning maps in parallel
    https://git.kernel.org/bpf/bpf-next/c/043c5bb3c4f4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


