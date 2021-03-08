Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C03312B5
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHQAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 11:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCHQAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 11:00:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0090965210;
        Mon,  8 Mar 2021 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219207;
        bh=Q9gplszw9fWmkGjR5sEgBLnv/ckoUnqWmlK/iz0M9e4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QUWrg2yfO8VLiKd/gwAaEJL+R9sihgDEepocWlbXiTnoRqRDTbKnSMB0Majil3ldH
         uIQebP8/IfujApEKhOGUhloqIia3j/nu3LjZJiV5b1+EJwe6fGmoWGuubJWfP+fyfl
         aXsbudj5U8bS/uyeC2qzRHE76LKgqcYSZNVB4sEiKvAzougxjF6SHMUDiYcHAx2gPk
         7jWiCDzky5AomcvI4WwePN7J9HwHbs2CXAmF7T2eUDSLyH5Tz+305hW/CE+y64k7g/
         sHfXRF2GGQiFPL6knB2ZS4bEzEIJ8T5q3Q18BDGI6vnIofpWsmHkOTWoP+q20eqTVU
         cjXyRrGC9madg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E054F609DB;
        Mon,  8 Mar 2021 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Change inode_storage's lookup_elem return
 value from NULL to -EBADF.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161521920691.8334.9768614935730579351.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Mar 2021 16:00:06 +0000
References: <20210307120948.61414-1-tallossos@gmail.com>
In-Reply-To: <20210307120948.61414-1-tallossos@gmail.com>
To:     Tal Lossos <tallossos@gmail.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, kpsingh@kernel.org,
        gilad.reti@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sun,  7 Mar 2021 14:09:48 +0200 you wrote:
> bpf_fd_inode_storage_lookup_elem returned NULL when getting a bad FD,
> which caused -ENOENT in bpf_map_copy_value.
> EBADF is better than ENOENT for a bad FD behaviour.
> 
> The patch was partially contributed by CyberArk Software, Inc.
> 
> Signed-off-by: Tal Lossos <tallossos@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Change inode_storage's lookup_elem return value from NULL to -EBADF.
    https://git.kernel.org/bpf/bpf/c/769c18b254ca

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


