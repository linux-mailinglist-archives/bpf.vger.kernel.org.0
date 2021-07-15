Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB493CA4F8
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhGOSM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 14:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhGOSM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 14:12:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 18ABD6120A;
        Thu, 15 Jul 2021 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626372606;
        bh=LqJGm9CbWWXXNQ2Wprx1D6OdfrxrMuB/AotMRjvb7wk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c1tJRJPBrw/w9jzQDUrRvL+KDtZcW5acs0SAE1V4docFO3V8t91mP/CruWUCU5EIw
         DWOYm84vDNkYr30MqXxcbmJiIRs6Ygm3XtYnoqQHLZyE2eR8CiZbfyWo/WOMGkG2Ug
         eQKD0Sb5fYur0cLjS5EZ4aqWzkhhatLVEHfhIZyJvT4Mow5mftDITqUJlqvo/3U1cX
         bbEe/xi1Fh+yItmyjkAzsOvdIX4gKTwl6KcOpeWVsP29C4CgFCLZgCS02Sy1WlSsIM
         tIIf4UiAxwcDn+5hSGuMxmsiP/p/3zskLm1Xj3dTrmdy1Q3bYyCwXOJnghvxDxYj94
         DI19upWmrhEFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0B8C4609EF;
        Thu, 15 Jul 2021 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Check malloc return value in
 mount_bpffs_for_pin
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162637260604.877.6736448029956053245.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jul 2021 18:10:06 +0000
References: <20210715110609.29364-1-tklauser@distanz.ch>
In-Reply-To: <20210715110609.29364-1-tklauser@distanz.ch>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, guro@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu, 15 Jul 2021 13:06:09 +0200 you wrote:
> Fixes: 49a086c201a9 ("bpftool: implement prog load command")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/common.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [bpf-next] bpftool: Check malloc return value in mount_bpffs_for_pin
    https://git.kernel.org/bpf/bpf/c/d444b06e4085

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


