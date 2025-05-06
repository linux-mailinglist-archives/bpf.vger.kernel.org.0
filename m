Return-Path: <bpf+bounces-57458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21EAAAB7F7
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38537B74A1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E81F153C;
	Tue,  6 May 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+K6xgDw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818A72601;
	Tue,  6 May 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489654; cv=none; b=YEUJyX3A5C9KGoTIyG8+L7AMcgwvvf7QSH2eHp/rA2lx8gOkUkG0W5LP8jlvJ3G28nHNVQSU46naffg7nD3CUgCqxzVtCpkj6zsIx+VVOYj92zIVsfpBbjDZ4jfbm7kFllvFc4Q8PlOohE8nNVhtqxxWW7znmdhHwcBEJ3Xl2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489654; c=relaxed/simple;
	bh=luPpqaQ/VMqL8Yhyov8v6dcXJkvh50HfPTJn9vftpx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYpvgz+GfqGXPNKHSyjYRGWi6a/U2+guAyCp2XXHQDozuaRNrgxuUU8ZJAYaSiSTMnd9bBYfPDAFh6Fu/Ef8JuBFJOUFERq4enr3RpUJV91Sl6Xh/SwrsHyz+iYvqD620YkoGuJuWry4HO2nt4fyUCi13/LsJR2MjbTyRzMgk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+K6xgDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD76DC4CEE4;
	Tue,  6 May 2025 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489653;
	bh=luPpqaQ/VMqL8Yhyov8v6dcXJkvh50HfPTJn9vftpx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+K6xgDwdZKBnvVEB0YkXoKKIsDAYu6TAQYG7EVqL+VUx2tOkzIPPzkDa0F6G9r16
	 AV8aHzArNVCAVIseveNDPjHXHvQKduEM6qXzJywxJWavFTHFI6KaJ+VU9wHz0ioVUw
	 U3qWc0UySfcGNvNgC4FDqUFccxc28/HWwKLd5PE8b8fEANzQ+oeQGzxliq1hzqrzph
	 QDD/dKOlgoUczagbkSewoRqZrJQyhNozbrVKZu5ndF6HqzQzze4icMWAk7ou+vgyOB
	 Y9rf7W3sXCypVaeFjEOUPMYtfeAzFaBZvDn+r5SAdLg5cClhj8xoULYWlfCTptAktt
	 FmDji0AZyC6/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AB7380CFD9;
	Tue,  6 May 2025 00:01:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-05-02
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648969281.970984.802430710077286674.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 00:01:32 +0000
References: <20250503010755.4030524-1-martin.lau@linux.dev>
In-Reply-To: <20250503010755.4030524-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 May 2025 18:07:55 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 14 non-merge commits during the last 10 day(s) which contain
> a total of 13 files changed, 740 insertions(+), 121 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-05-02
    https://git.kernel.org/netdev/net-next/c/b4cd2ee54ca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



