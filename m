Return-Path: <bpf+bounces-2455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6662172D44E
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DE1C20BD8
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350B2343D;
	Mon, 12 Jun 2023 22:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FB18AE0
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF2AC4339B;
	Mon, 12 Jun 2023 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686608421;
	bh=p2gWIkHcY8hxhzpTuUiF+umz0kKF8zoxaa9l8hZ5ye4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TJa1ii9EMwpnkgXg6CLnBqWgZwyx5GI/sDeBIoycsc54LEUaSvBi0CD4LLuD+Da8l
	 wAdjhkl5Rj0nME87oPWmju6Lv69AwV8ts/vco8SgtHSmLaQQk2r5lLdCM7hVAa8hzl
	 MNEctZEhVlo0CYiBZw4cvZJ/H7e2G6yGAvREQGNqHtrTLPQcDTTM38gxjfEifgk2BN
	 hDGzyMsau/jM4B4oNb/G8Xp8E8oaF436TV1lZS0Or01D2VSC8Vcl9jumJ35ju/L5fy
	 k5hxyCuC00MO/GVEti54DuCjTY/JVi1eAUSsmoXafCqCNy5z7y/rZjK4J/mZJW/ari
	 WF2Rs46oZndMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC502E21EC5;
	Mon, 12 Jun 2023 22:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bpf_cpumask_first_and() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168660842083.26905.7112478847600800130.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jun 2023 22:20:20 +0000
References: <20230610035053.117605-1-void@manifault.com>
In-Reply-To: <20230610035053.117605-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Jun 2023 22:50:49 -0500 you wrote:
> We currently provide bpf_cpumask_first(), bpf_cpumask_any(), and
> bpf_cpumask_any_and() kfuncs. bpf_cpumask_any() and
> bpf_cpumask_any_and() are confusing misnomers in that they actually just
> call cpumask_first() and cpumask_first_and() respectively.
> 
> We'll replace them with bpf_cpumask_any_distribute() and
> bpf_cpumask_any_distribute_and() kfuncs in a subsequent patch, so let's
> ensure feature parity by adding a bpf_cpumask_first_and() kfunc to
> account for bpf_cpumask_any_and() being removed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] bpf: Add bpf_cpumask_first_and() kfunc
    https://git.kernel.org/bpf/bpf-next/c/5ba3a7a851e3
  - [bpf-next,2/5] selftests/bpf: Add test for new bpf_cpumask_first_and() kfunc
    https://git.kernel.org/bpf/bpf-next/c/58476d8a24bd
  - [bpf-next,3/5] bpf: Replace bpf_cpumask_any* with bpf_cpumask_any_distribute*
    https://git.kernel.org/bpf/bpf-next/c/f983be917332
  - [bpf-next,4/5] selftests/bpf: Update bpf_cpumask_any* tests to use bpf_cpumask_any_distribute*
    https://git.kernel.org/bpf/bpf-next/c/5a73efc7d1b4
  - [bpf-next,5/5] bpf/docs: Update documentation for new cpumask kfuncs
    https://git.kernel.org/bpf/bpf-next/c/25085b4e9251

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



