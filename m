Return-Path: <bpf+bounces-72640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F3C172DA
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2F71C601C8
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206712E764E;
	Tue, 28 Oct 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ/BfxQ+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869819CCFD;
	Tue, 28 Oct 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690028; cv=none; b=IPb/hNFSeGfLGrx31IiG0+6HbN1nsyz5ok4MxxlCGqspVyX31Ts15jzaT+eXg74ryqESSeJJbkFI1t0n19qvkXxkbZH0j0t7/0F+H6Kvtv1otee0vjzlrNfykGa47yC0ihP6yvj/crz9ZTei9PqVdwNFvUQNIfsk+t6z8f9Utow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690028; c=relaxed/simple;
	bh=nJ/arLn0DYuoELcn6fstFFsLiExrR3TMz2WTRoCZad4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/2SjDfMKoG97mrBAvmn0JDlwlLO6r7IrkPu3eh/i9tcPSdLgN9z1evC+H+uRfw+FiYaeip9kuwM02Y1Rjdv5D0cLD/rEdambwQYUDRBl8Sz52VGcLawoGFKfNbwxRvogxXeVfkPzOOua+oaGoSol38gHMjP8ZVBZ/LjtPkZU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ/BfxQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279AAC4CEE7;
	Tue, 28 Oct 2025 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761690028;
	bh=nJ/arLn0DYuoELcn6fstFFsLiExrR3TMz2WTRoCZad4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DZ/BfxQ+YbxuQlQ3gMqqnl2aHlIdXegUjXCA58OOTpeaH70nUwfe2iop1CoIZDm0E
	 rsC2n017dZpwW01MO9GqIAEJCXqs1snRPBhkP3vSxU2AFWQ8KJBr+YZ0EwzIvQuatv
	 hDpD9RhhTymxpjNXVCnnDnxqfCMcD3sd7SIK4UvvESy/sUL8kCqtdxzRmWuUGtnoIr
	 /u0xIWA/4JPw5XhB+Xa6UVuBsiig04vDlzo75BzaXgTI7feGSX2y2PkC+jGCeZpPmV
	 hVrpsXJEdhdnw6ofX5Vr/ctuxitGh9GIHSKqvdfwrXNKalAmii6AOMcCGsx9Bqm2m8
	 wk++z9JR2zCrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAE39EFBBB;
	Tue, 28 Oct 2025 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Reject negative head_room in
 __bpf_skb_change_head
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176169000576.2404988.18143767699290680049.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 22:20:05 +0000
References: <20251023125532.182262-1-daniel@iogearbox.net>
In-Reply-To: <20251023125532.182262-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dddddd@hust.edu.cn, M202472210@hust.edu.cn, dzm91@hust.edu.cn

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 23 Oct 2025 14:55:32 +0200 you wrote:
> Yinhao et al. recently reported:
> 
>   Our fuzzing tool was able to create a BPF program which triggered
>   the below BUG condition inside pskb_expand_head.
> 
>   [   23.016047][T10006] kernel BUG at net/core/skbuff.c:2232!
>   [...]
>   [   23.017301][T10006] RIP: 0010:pskb_expand_head+0x1519/0x1530
>   [...]
>   [   23.021249][T10006] Call Trace:
>   [   23.021387][T10006]  <TASK>
>   [   23.021507][T10006]  ? __pfx_pskb_expand_head+0x10/0x10
>   [   23.021725][T10006]  __bpf_skb_change_head+0x22a/0x520
>   [   23.021939][T10006]  bpf_skb_change_head+0x34/0x1b0
>   [   23.022143][T10006]  ___bpf_prog_run+0xf70/0xb670
>   [   23.022342][T10006]  __bpf_prog_run32+0xed/0x140
>   [...]
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Reject negative head_room in __bpf_skb_change_head
    https://git.kernel.org/bpf/bpf/c/2cbb259ec4f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



