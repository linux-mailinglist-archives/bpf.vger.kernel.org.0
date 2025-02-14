Return-Path: <bpf+bounces-51508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8326A35386
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6DE3AACD9
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA5F487BF;
	Fri, 14 Feb 2025 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3K6thTh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177983BBC9
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495411; cv=none; b=hsUjhTyZKC5aeFKMlizLK2a3NQeeWJ9iN0GNfOdBBp+0KnEBwEHgnchnE0fyHChUPyM+OlOZ5yNnc71OxQDsaSTvIpiopAzDHikrFeXG86NF5SNwDGDDqTt+OL5pjAkEbHBY6/eghe7RyRTh7xuC6o1Ad35y/88IxYIYZ9R4bzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495411; c=relaxed/simple;
	bh=VRdJnoYLeqAJ4r5DK3m0IJbK9zD7rVgHrERyrada5V8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e6Ch9KLY35fdFUjHZJqVUNEdYrY3HePppi2ZSsPZIdJDjROKy+qyegzE3fKu7vje/cqUYQEsGNOmhOEZo1zLA97EzGnX0wh7cDXGGM9JIt2+59yqxpNbOh7O6AEQ2d1rjjTLAfG0E7JPUMq86H2LMxza1kZvw262WJ/5Lp/8m7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3K6thTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B7C4CEE2;
	Fri, 14 Feb 2025 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739495410;
	bh=VRdJnoYLeqAJ4r5DK3m0IJbK9zD7rVgHrERyrada5V8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q3K6thThrrfzfpEC1rVCjXQpA+m9UlSi4SY0KXCB6muCGpU+0Kp2aQGVjO8l1nHXW
	 qarANoaKdnh38ZF7UHhp5MWo/R50SHPQGnLeyLm7cLo+Ucja5ur1yH2sdLhyKFoNrO
	 Hxy2QByWms0BxleiOrMWG0vP3rrmgfEtN9XgfnLWOvxSSqiWoESSOHMOPgeBg06WsW
	 cHUe99kHQuFBgIvo7QpW7XsCFgZlDmROgKZbW5nC/SUrlrruyn5Vqo7hdwRXdI1Uoq
	 wqds/tyeJZkDHPW0vWyrbifbwKIMz9cg9KzGDextSanQqiDdnNLdDg4mEjSClYs1tr
	 lhGI6bcwl5IJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC918380CEF4;
	Fri, 14 Feb 2025 01:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix stdout race condition in
 traffic monitor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173949543950.1451727.12072664468117854654.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 01:10:39 +0000
References: <20250213233217.553258-1-ameryhung@gmail.com>
In-Reply-To: <20250213233217.553258-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 13 Feb 2025 15:32:17 -0800 you wrote:
> Fix a race condition between the main test_progs thread and the traffic
> monitoring thread. The traffic monitor thread tries to print a line
> using multiple printf and use flockfile() to prevent the line from being
> torn apart. Meanwhile, the main thread doing io redirection can reassign
> or close stdout when going through tests. A deadlock as shown below can
> happen.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Fix stdout race condition in traffic monitor
    https://git.kernel.org/bpf/bpf-next/c/b99f27e90268

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



