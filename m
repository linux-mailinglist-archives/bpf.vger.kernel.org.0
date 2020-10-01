Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1E280440
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgJAQuD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 12:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgJAQuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 12:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601571003;
        bh=eEpa1cYybbkrIRk0PfbQwX7cxfc4/VuZj6ScjrtGtVU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ciMhVPZTLT+ywxIqRbcneD6tBDbJUkpg26CFzCnf4ZzNN7tmq4noTphGrsyjQ6CrQ
         iENoxWpwPVUOnHuZGgkPG2SeBShYWqPjTTSfb/ChPQETaVWRO/PhjH4BieiysFglga
         V/H/g/Id7dqE1P96hsVbWo5dtAg7UNKnBrc5xiys=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf: fix "unresolved symbol" build error with
 resolve_btfids
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160157100291.17212.7509730280458834178.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Oct 2020 16:50:02 +0000
References: <20201001051339.2549085-1-yhs@fb.com>
In-Reply-To: <20201001051339.2549085-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 30 Sep 2020 22:13:39 -0700 you wrote:
> Michal reported a build failure likes below:
>    BTFIDS  vmlinux
>    FAILED unresolved symbol tcp_timewait_sock
>    make[1]: *** [/.../linux-5.9-rc7/Makefile:1176: vmlinux] Error 255
> 
> This error can be triggered when config has CONFIG_NET enabled
> but CONFIG_INET disabled. In this case, there is no user of
> structs inet_timewait_sock and tcp_timewait_sock and hence vmlinux BTF
> types are not generated for these two structures.
> 
> [...]

Here is the summary with links:
  - [v3] bpf: fix "unresolved symbol" build error with resolve_btfids
    https://git.kernel.org/bpf/bpf/c/d82a532a6115

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


