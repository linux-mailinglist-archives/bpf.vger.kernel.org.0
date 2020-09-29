Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1C27CA95
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgI2MUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 08:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbgI2MUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382008;
        bh=T1w5XrXa2H9LIp7yp9/7COaL1m0xbyEKuPiJJf5RpYc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vh7zhpPh7tSvLJTje2Oihassq0ugHsS57Vrfut2z5MNvr+N7SvSkm+W3xA6A2IrkF
         GYqO010rGceL8p/aZG4gGcqqsnj2jq1N4AhhWpCYTthpfdAgaprYJSQ13SYLRYZGMg
         ADaqofguvRwgbtBdRek3ZhKcHdmgPt5qYGFLA+KA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: cpumap: remove rcpu pointer from
 cpu_map_build_skb signature
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160138200860.26741.2323768930219509515.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 12:20:08 +0000
References: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
In-Reply-To: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 13:24:57 +0200 you wrote:
> Get rid of bpf_cpu_map_entry pointer in cpu_map_build_skb routine
> signature since it is no longer needed
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  kernel/bpf/cpumap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: cpumap: remove rcpu pointer from cpu_map_build_skb signature
    https://git.kernel.org/bpf/bpf-next/c/efa90b50934c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


