Return-Path: <bpf+bounces-31360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B68FBAE9
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63319288400
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDB149C4D;
	Tue,  4 Jun 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+Pjl1G1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123A18635
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523429; cv=none; b=ryjWJjkQ3vfiYp2cZbqKaPtZkLSU1unTTJtQxWePmCYsd/FzEhOgWKX95usSNlgk+wvJmnG9O5JChYbuEfGQsb/NK7NWT2vioIybIam4G8MSAK06kqciZ5qVdvxNUKQvQR/PGSFYDsuo11HKyYGsqe+0PbZGrkTcgTdZKnGbktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523429; c=relaxed/simple;
	bh=yfrKwhuF2jCYAoibO48DdDB5IXgm3Uvvjgp9lDygfZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldnEdiYQASrfEvQJF8U4pXnXPUDS04okjcgqkvou1AYefAYT0vUdJqH6n0S1qrJA1JdO4b+pgNXRmdi0laEvsEN+WvyPTSXFjU2EnBLJ6e32pnkyQZQhSeSqN2pHXx2iJRp8hkQaiYhzymJgvVymZTwndN940O1u8HJDveB4G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+Pjl1G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FB56C4AF08;
	Tue,  4 Jun 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523428;
	bh=yfrKwhuF2jCYAoibO48DdDB5IXgm3Uvvjgp9lDygfZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E+Pjl1G1ifYl5VIj3+WZ0nu5al921SChISSCPLwbLqWq+ix+ErqhzR7Xlk/nPzRo4
	 AJPahF0k7AAjBVOac1cyNCEvkrZIeVhO2HRVVQSa/unYULgU1WNDH6eLBSTmo6GZGG
	 BnuEEJOFdZvIgpOYQ8v2Bw6287L8VBC8gwQMd8F7SeYWRidBsnsiZLpCGljPLV8JLw
	 hfiZqOZmh11P1t+i1QNL3rGPW97AdOhwBmBGz9F7ddL2UzX5SCguJud6WBQe65SwDN
	 wObsexODBwRzvAtZaLU5Xop4vkog1tMDt0X1r+EpCqJMArKY+XAbjnpHlfX6ZclO4P
	 QbJAYUo7RqgiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ADFBC43617;
	Tue,  4 Jun 2024 17:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf] bpf: Set run context for rawtp test_run callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171752342849.2569.1402307140231281372.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 17:50:28 +0000
References: <20240604150024.359247-1-jolsa@kernel.org>
In-Reply-To: <20240604150024.359247-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 kafai@fb.com, songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@google.com, haoluo@google.com, mhiramat@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  4 Jun 2024 17:00:24 +0200 you wrote:
> syzbot reported crash when rawtp program executed through the
> test_run interface calls bpf_get_attach_cookie helper or any
> other helper that touches task->bpf_ctx pointer.
> 
> Setting the run context (task->bpf_ctx pointer) for test_run
> callback.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf] bpf: Set run context for rawtp test_run callback
    https://git.kernel.org/bpf/bpf/c/f472e923bf4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



