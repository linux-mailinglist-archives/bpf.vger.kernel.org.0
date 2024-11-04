Return-Path: <bpf+bounces-43862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C19BAA0F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 02:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF001F21467
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E814E2F5;
	Mon,  4 Nov 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWYlMFN6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E46FD5
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730682028; cv=none; b=IjZkeK4IFJ2D5P10U1qPkwprqD6mfHFarSjOj0Zrj2idXSovr6B0N7qY7NgYSdfSmooqDJJjyjFuNCIAtN81j9IeU/eIa8CMnl4rkCXDpNC5JfpcHVdObFcQJXlaOK3NolrU+CdeNO0tPLsEaoezFfXjidD5dqbhOb8cri5KvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730682028; c=relaxed/simple;
	bh=TMPTlCNxyBkzxRzAQeLv52lTualZ4aabwi72QJkKUbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=py6iSjsPfpPfNGrhkDR0Rp0CTYAm/uTYYbyRLSL5xwB5a8i35DhoL+FFJihUwSOtx2iVQ7aRuJr5f1ktzVKjqF6bo2yYlrZwzFNwIqfHTK4CmMrHEaFg5k10dIXkxx6bTquOoJ06D23aul5Rd10NkITfPlhTPDzYiAkEFCvrPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWYlMFN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED242C4CECD;
	Mon,  4 Nov 2024 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730682026;
	bh=TMPTlCNxyBkzxRzAQeLv52lTualZ4aabwi72QJkKUbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oWYlMFN67DPhn9fUn3ab8zZ1Qe4AV6FUrjcgKaiCw3hdCsyC/c8/KJgVhrwTeeiMd
	 qJLvuq49Hw/VrVLhdlwWWZFSq3kcsUhEMFnxN8qHGQtN+iGDqzFcBqbBagnMX9SGqS
	 kjzrWQ1lJlurOut0AEUVlHcvlidWgdeOUcVe3O0MQ2QwuoVcZLPZ+VuqGGE9X1pGQl
	 OrKWwdO6EGrepP/UYfVBtGsCo6DQIuCaCZDEibmrguIDq2PNzWq5oDjyd1dayFMucu
	 sUBmEd12b/VWtrau9V3tnqqyUqaJDsenhpxYUdZ06PCeKXz0l2DL9KDdFWx03Eo0MN
	 YwamGAWyKWDfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9E3809A8A;
	Mon,  4 Nov 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] Fix resource leak checks for tail calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173068203449.3594539.9649006550556738522.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 01:00:34 +0000
References: <20241103225940.1408302-1-memxor@gmail.com>
In-Reply-To: <20241103225940.1408302-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  3 Nov 2024 14:59:37 -0800 you wrote:
> This set contains a fix for detecting unreleased RCU read locks or
> unfinished preempt_disable sections when performing a tail call. Spin
> locks are prevented by accident since they don't allow any function
> calls, including tail calls (modelled as call instruction to a helper),
> so we ensure they are checked as well, in preparation for relaxing
> function call restricton for critical sections in the future.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] bpf: Tighten tail call checks for lingering locks, RCU, preempt_disable
    https://git.kernel.org/bpf/bpf-next/c/46f7ed32f7a8
  - [bpf-next,v1,2/3] bpf: Unify resource leak checks
    https://git.kernel.org/bpf/bpf-next/c/d402755ced2e
  - [bpf-next,v1,3/3] selftests/bpf: Add tests for tail calls with locks and refs
    https://git.kernel.org/bpf/bpf-next/c/711df091dea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



