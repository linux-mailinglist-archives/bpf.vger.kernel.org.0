Return-Path: <bpf+bounces-28960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D568BEED0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D50C1F25E84
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5573539;
	Tue,  7 May 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKmhmOzp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1618732F;
	Tue,  7 May 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116828; cv=none; b=pzn02elvjUP8W/ylxrpHOy6gMRt1pFauANj3WDXANHn38P1AissZtg6vIuB/qoHh7mGOT/VvkGaPu9n60FqeiJPsjchZBw4u/par+s1L7fDJviqJUnFyrNM7rpRN/5QwyiPCbCmiayAf390Se8NzHm3HgUwSiVU/JaT8IweytdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116828; c=relaxed/simple;
	bh=K+FJYEXMeHdROpG7zkTa6XKHYJnqij7TQnzvgTOY+tA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mTUvvQz8wTWuM8uQ88FE+sgwBffRuPnL2D+sdlxsjTXJts0VEa3Q4oGGtjn2yL3nC2XpHn0gpTP/9z0B1+oXvm+KNZp/A0/ExavVnUu107oG/C8FoYKdJD8I8Pa0dhvEFjSsLW+dVxKnDWlPLIVrLlxEee54PLHs5OqbQWXf348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKmhmOzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD06C4AF17;
	Tue,  7 May 2024 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715116827;
	bh=K+FJYEXMeHdROpG7zkTa6XKHYJnqij7TQnzvgTOY+tA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sKmhmOzpvIqJ70Wb4blyQs7YTwIwb0LxaPORICgVpnZCLSR/g6ejikw2FviGr5EZe
	 id/x5ke2rx8v5ZrZTcn5gZO5P0t8e0uG5ZaBNxELQgvza3bkpD+T8Yfmneq+tnR/ff
	 5Mec0qjtMlfjOA5ziNjgXkiUnzp+F4eFm/GcyVMPRoO3Sen98pV1KogIdUYrcyb+nB
	 /cZaAgViQs4MP+Vrc5Qu8QKduZesP9ix3acX9TrjBNvZqdYFOHe+q3Q4ROT1L11ZsK
	 3ucRRA1r7EvIuBPsLp6oyL4wC6zJVqlPOKouzhSHLiPRqZ+KKCBdmwuH64vqwCGJDJ
	 ezy7iTV+npZKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9973FC43614;
	Tue,  7 May 2024 21:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf,arena: Remove redundant page mask of
 vmf->address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171511682762.6179.3486534275221293442.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 21:20:27 +0000
References: <20240507063358.8048-1-haiyue.wang@intel.com>
In-Reply-To: <20240507063358.8048-1-haiyue.wang@intel.com>
To: Haiyue Wang <haiyue.wang@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 May 2024 14:33:39 +0800 you wrote:
> As the comment described in "struct vm_fault":
> 	".address"      : 'Faulting virtual address - masked'
> 	".real_address" : 'Faulting virtual address - unmasked'
> 
> The link [1] said: "Whatever the routes, all architectures end up to the
> invocation of handle_mm_fault() which, in turn, (likely) ends up calling
> __handle_mm_fault() to carry out the actual work of allocating the page
> tables."
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf,arena: Remove redundant page mask of vmf->address
    https://git.kernel.org/bpf/bpf-next/c/75b0fbf15d84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



