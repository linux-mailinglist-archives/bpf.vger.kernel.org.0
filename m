Return-Path: <bpf+bounces-70756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB97BCE0A9
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D311A6605A
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA28212550;
	Fri, 10 Oct 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5uqWnVt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58842049;
	Fri, 10 Oct 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116219; cv=none; b=MY7pgXs6lXgjUciayNsqxPKKqWEEDkuTr1cQwlZV6ymnbM1mPxVPZJ13u8yU/5d3N0UhuGmwgcK6texwEe04rrb3Xy8eNS3k2a3TuKwF0fzokQ/vOsB4bXUCpf+I3lK3bdt8ccSQkCsiZFnuzheromSS8BxJOR4rNzr1bs/+uNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116219; c=relaxed/simple;
	bh=7N5j4MPGCNhqbzofGJ6iM7pLlyWv4XqbzW+i8bDy0VQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i8jPQog1WkRLuJszdVcQBjS0tDW/0BXQTtnZRun6/2AfSbrN46qvyR/ZAMrpRvdQP2S08/+JJwR59PLssT/oNw5Wqi+S33umbJQyJqDtj67OddGuACAq+v01zKJVpvnOrPzHZs8d/WTQAiSfTAhmMql2iGM2QRQg2/HSSvPnfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5uqWnVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE3C4CEF1;
	Fri, 10 Oct 2025 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760116219;
	bh=7N5j4MPGCNhqbzofGJ6iM7pLlyWv4XqbzW+i8bDy0VQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P5uqWnVt2YhV8yR6U0oE6I66EmWmGnEXLDTvOWY0j5tCcUkTkDfu7mG2rqsZ122kF
	 3Jx226etWzqawljDd+vzOKRd1EeGR2ADlKDMPq79+pFkNY1XYBcsK3O3956fMfTKVk
	 OVufiCAtHpwzx4kzV3kKN5RDfgFr2bXEsUAwNmPWgKGr7mg75Eeqc9mDs6AAvZbV25
	 rlQIv7SoG7FZymaien3CIl/W6GtUHH8pyOuAD6EPG5DO78bMTiBDB4wiuTJUFCCDea
	 uDnu3f2dWpIK2GNFhIFj7RzHFhEgEa03rOY85lR//GR/IsNJ2gqLAWkW7Uw1fxb+47
	 5Vrpsx/Heijvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1543809A00;
	Fri, 10 Oct 2025 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176011620657.1050631.4250868223272428117.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 17:10:06 +0000
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
In-Reply-To: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Oct 2025 18:56:59 +0200 you wrote:
> Turned out certain clearly invalid values passed in &xdp_desc from
> userspace can pass xp_{,un}aligned_validate_desc() and then lead
> to UBs or just invalid frames to be queued for xmit.
> 
> desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
> can cause positive integer overflow and wraparound, the same way low
> enough desc->addr with a non-zero pool->tx_metadata_len can cause
> negative integer overflow. Both scenarios can then pass the
> validation successfully.
> This doesn't happen with valid XSk applications, but can be used
> to perform attacks.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: harden userspace-supplied &xdp_desc validation
    https://git.kernel.org/bpf/bpf/c/07ca98f906a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



