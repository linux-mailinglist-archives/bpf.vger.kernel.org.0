Return-Path: <bpf+bounces-9719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0D79C6E9
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9581D2813FB
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4A171C1;
	Tue, 12 Sep 2023 06:30:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8380171BE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4837FC433C9;
	Tue, 12 Sep 2023 06:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694500228;
	bh=2OW6wmDN+76TIb9KhfGX17NgzlCETPc/C9J9Zzc1Nj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E8GlH9AxUSm4cxvgTMsQImFWXLYmeIjGj5+zmxT/QnKRSW2pLxAsBctHE4Z3N99tT
	 sh4zlpBIC/qlpKeF8mz3X53ixEWXcceAF1DHgdYUMOvEzBUYjQzmRAEw1cGus70w1m
	 xpef3Ji92fgbNAGZ8wn8PvGqQ/pA1PSaNgLaduzENU4gItupXpTMhucQzziPv3GZDh
	 GNHb/vO6qhrMCLbb8dwFH7dS4d4NbYlZgkoYC2UtdYsvlwVk01YQRPdEcrt42gfjkl
	 mUHYGMQBWRFicTUQRauwupI8OLRuIYPKNfIRuCCdWVU7NG55rX90ZexL124vJnSOJO
	 xUJIFjKwAvJCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D09AC04DD9;
	Tue, 12 Sep 2023 06:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Avoid dummy bpf_offload_netdev in
 __bpf_prog_dev_bound_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169450022818.23567.15817731968195253421.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 06:30:28 +0000
References: <20230912005539.2248244-1-eddyz87@gmail.com>
In-Reply-To: <20230912005539.2248244-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, sdf@google.com, kuba@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 12 Sep 2023 03:55:36 +0300 you wrote:
> For a device bound BPF program with flag BPF_F_XDP_DEV_BOUND_ONLY,
> in case if device does not support offload, __bpf_prog_dev_bound_init()
> creates a dummy bpf_offload_netdev struct with .offdev field set to NULL.
> 
> This dummy struct might be reused for programs without this flag
> bound to the same device. However, bpf_prog_offload_verifier_prep()
> that uses bpf_offload_netdev assumes that .offdev field cannot be NULL.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
    https://git.kernel.org/bpf/bpf/c/1a49f4195d34
  - [bpf-next,2/2] selftests/bpf: Offloaded prog after non-offloaded should not cause BUG
    https://git.kernel.org/bpf/bpf/c/e4c31164737e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



