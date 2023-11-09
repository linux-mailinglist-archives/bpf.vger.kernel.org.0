Return-Path: <bpf+bounces-14620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F37E7189
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5441F212BA
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9720B14;
	Thu,  9 Nov 2023 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKplG1P4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2636B05
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4558C433C8;
	Thu,  9 Nov 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699554624;
	bh=oBOSdaIc9FwI+yfH2lZYSqfxPvBLs5hoLhYfdWzpS/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKplG1P45Mtym7gVZJvl9wQo6GQcXSD59si55OpNRN8iw0gryzrzPsg7XyzkvOhrT
	 Te4qkQ0bwCHVkjH/6v0rrGxCne3YzHkzrjK9u3HE9M2ierWbxz/enHEVkyAncYbp79
	 LMdYDy2ay0AvcZOx7yA5JlsT+pISLUpB+qyJyFcbV73C0rFQEA5MP4jbc7+6g2DJIL
	 HjZ4qMPbaHfeAvFqyE1zyu5zg8lWvqEGElQYjL/Ou5gEAlKlHdPG4fuEgzamIB8pZL
	 4xA43k/Sgc30ka++i94bf2XAUpfTiYQ8go7ITNsjGQGf+E0mixa5lN8wHLgB+bvEKs
	 EfLp6e0LdI2zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD61DC561EE;
	Thu,  9 Nov 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: replace register_is_const() with is_reg_const()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169955462477.11926.14918758803007867967.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 18:30:24 +0000
References: <20231108140043.12282-1-shung-hsi.yu@suse.com>
In-Reply-To: <20231108140043.12282-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Nov 2023 22:00:41 +0800 you wrote:
> The addition of is_reg_const() in commit 171de12646d2 ("bpf: generalize
> is_branch_taken to handle all conditional jumps in one place") has made the
> register_is_const() redundent. Give the former has more feature, plus the
> fact the latter is only used in one place, replace register_is_const() with
> is_reg_const(), and remove the definition of register_is_const.
> 
> This requires moving the definition of is_reg_const() further up. And since
> the comment of reg_const_value() reference is_reg_const(), move it up as
> well.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: replace register_is_const() with is_reg_const()
    https://git.kernel.org/bpf/bpf-next/c/3815f89592d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



