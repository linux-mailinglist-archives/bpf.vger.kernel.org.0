Return-Path: <bpf+bounces-71593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A0BF7C83
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0943A2C86
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948426B942;
	Tue, 21 Oct 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuo0WpGt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056E346E4D;
	Tue, 21 Oct 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065426; cv=none; b=tO49bQRywdhvbRyAUVSbGfMHWvLZMcbl6u9GW/jTpZ9WhMeJNUKvxqP5idAYrs79dHc5lToparTSWGvBRLuZQU6X81XzAVphz2POeRS54LSWhzOW1IRAVcs45b4SHB110aeqAg4HN/g445lhK5JuuNBFUSLRbSkQewWnr2O8gV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065426; c=relaxed/simple;
	bh=+BafhbXkJhAILjAhpBXovI19QdGmbkSLGtSV/MpF1/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ek8XbzJymVtXKoJ/8i5tihSwuCcp5CAYfvH2SZ185HPzWkMD/2UgC8mMuflba3HPWqbV/yyWYJegn3hPhwXJEgFN6oEe1QR3G4U9SjvTkm/XTCRZX86YHeMdOpgUmh1Y9TeBukCTUgYYHFT3HDsJ7D69VU1h92QHxdMdxNI1g5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuo0WpGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820E7C4CEF1;
	Tue, 21 Oct 2025 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065425;
	bh=+BafhbXkJhAILjAhpBXovI19QdGmbkSLGtSV/MpF1/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xuo0WpGtjFCj0kfY8zZ4/o11T1RpHCGHykEq+6yR+ACfC5fbanCu6bqLISg60bb6w
	 hWQsHnfpnyXOe/OjYPwF4APRywoi9aZqRQWOqnYOgc/7gjaGFEw92RymgBYgvRuQ/b
	 UohUVkaytxDhgoQc5s+dQzp6Wq4kwmAAsd9/pgvAMhr1a0xxU5eJdSFeTdfEFO72j8
	 e1D7O/33TOAyvV0vF3L6YYco8neucTbYHjWqAJl+YjnQogLUTDF2vxPvfVr8Lotk/P
	 4lre4PG0g2/YwWXaJpaNBBCvNfDvpSlioywzUmPxhPYHMaC2aevXLKeI9Xvw8AoO1a
	 iuqujV+a6/cZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D933A55F96;
	Tue, 21 Oct 2025 16:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf] bpf: liveness: clarify get_outer_instance()
 handling
 in propagate_to_outer_instance()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176106540703.1157367.9711062469755027347.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 16:50:07 +0000
References: <20251021080849.860072-1-shardulsb08@gmail.com>
In-Reply-To: <20251021080849.860072-1-shardulsb08@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 Oct 2025 13:38:46 +0530 you wrote:
> propagate_to_outer_instance() calls get_outer_instance() and uses the
> returned pointer to reset and commit stack write marks. Under normal
> conditions, update_instance() guarantees that an outer instance exists,
> so get_outer_instance() cannot return an ERR_PTR.
> 
> However, explicitly checking for IS_ERR(outer_instance) makes this code
> more robust and self-documenting. It reduces cognitive load when reading
> the control flow and silences potential false-positive reports from
> static analysis or automated tooling.
> 
> [...]

Here is the summary with links:
  - [v3,bpf] bpf: liveness: clarify get_outer_instance() handling in propagate_to_outer_instance()
    https://git.kernel.org/bpf/bpf-next/c/96d31dff3fa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



