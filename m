Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3B2C4B55
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 00:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgKYXKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 18:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:32920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgKYXKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 18:10:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606345806;
        bh=HmVmboHLRT2akidt/sMRFZU4ZFKJPHRy8BwngDIlhaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TXZCC+XbFncZEn9e3rtlcupVHAocud+59jV7KtujgInwazrWkpMy9WDosMSkGoZBr
         DpWGtPPr6UXZaMQ3uCKs5QBTsqAo8wkSEdOavP9b32gavQlG+XSuNV8C5pFShybl84
         LKFOkpmo1MshZnSI+ATwQgyWqZllP6KOys/6ycBw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Implement bpf_ima_inode_hash
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160634580589.11847.11072899001096362522.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Nov 2020 23:10:05 +0000
References: <20201124151210.1081188-1-kpsingh@chromium.org>
In-Reply-To: <20201124151210.1081188-1-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, revest@chromium.org,
        jackmanb@chromium.org, zohar@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 24 Nov 2020 15:12:07 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v2 -> v3
> 
> - Fixed an issue pointed out by Alexei, the helper should only be
>   exposed to sleepable hooks.
> - Update the selftests to constrain the IMA policy udpate to a loopback
>   filesystem specifically created for the test. Also, split this out
>   from the LSM test. I dropped the Ack from this last patch since this
>   is a re-write.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] ima: Implement ima_inode_hash
    https://git.kernel.org/bpf/bpf-next/c/403319be5de5
  - [bpf-next,v3,2/3] bpf: Add a BPF helper for getting the IMA hash of an inode
    https://git.kernel.org/bpf/bpf-next/c/27672f0d280a
  - [bpf-next,v3,3/3] bpf: Add a selftest for bpf_ima_inode_hash
    https://git.kernel.org/bpf/bpf-next/c/898eeb122e8a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


