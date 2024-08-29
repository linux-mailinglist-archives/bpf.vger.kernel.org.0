Return-Path: <bpf+bounces-38450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF0B964EAA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4951F238C2
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E61B8E92;
	Thu, 29 Aug 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1OkAi7I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D41B81A6
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959227; cv=none; b=bqmvqg3rP9fvXinNrEjeP+8LeuCNMPfFMDi+EU+vicZOtQ4CFPqDbLTuB8ZSAbaENzUY9N10R3TeGrpmfIPOWVFF1TzjIvl2CQUBcIqLREP3Q4aN6v/FVKrZcwZe8g4STny1F7O80Nbt1/1RPiNcvODZQbFcZEKwqr0aDk/W7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959227; c=relaxed/simple;
	bh=9WbVapS7iBvGg1dfRZkc9AE9jOGBy26QtjljBgsqCD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nWBpklfg+aX9ApQeFPvYxm1kWUK0bgW0n02kZmBTDpWkLrvO0tX943Uy7FiH547peVFX4e7/niL8vhEr3YJiZHoVmeF30IAzm2YNMrOfxHysOpYPj46DaZA9SPmILjjT2SsKLMSkrRkLfEhlSadpCUbQIrvwxK3nPcGamZ+2e60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1OkAi7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFDEC4CEC2;
	Thu, 29 Aug 2024 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959226;
	bh=9WbVapS7iBvGg1dfRZkc9AE9jOGBy26QtjljBgsqCD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t1OkAi7IUm4Ph416TFj/ZK1n3p36T693WH2+nsDDRKPcEOlr33Pn7JTp4C3yhClQe
	 SXJT4gY63DW2xCRUUUe7QSFMIT0IQzckaX+ACJUeIUD0/phFGj5w35ZElabF6qa9nh
	 nAB5hIYgoNcOT6gRm1BAU3nTMHgtu0h53tOVC/12Y9KrkDxTN4jvD+huz4oNAZY7p2
	 nO47Di9rgxloW0gOf4JFupZE60CAzKF06EwbxLIqWXe2HnkJQQsAMcyZMinPOwq2md
	 XnaDSqrR6iCtfPHGejdK8em8NGZ9Cq0fbe/7p8BHVRqjBqH/8Iew2nbKJgKY0dh6ps
	 I+uD6yHhE8ziw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 016363822D6A;
	Thu, 29 Aug 2024 19:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs/bpf: Fix a typo in verifier.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495922799.2057934.3853223539115464115.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:20:27 +0000
References: <20240829031712.198489-1-kxiang@umich.edu>
In-Reply-To: <20240829031712.198489-1-kxiang@umich.edu>
To: linsyking <xiangyiming2002@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, kxiang@umich.edu

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Aug 2024 23:17:12 -0400 you wrote:
> From: Yiming Xiang <kxiang@umich.edu>
> 
> In verifier.rst, there is a typo in section 'Register parentage chains'.
> Caller saved registers are r0-r5, callee saved registers are r6-r9.
> 
> Here by context it means callee saved registers rather than caller saved
> registers. This may confuse users.
> 
> [...]

Here is the summary with links:
  - docs/bpf: Fix a typo in verifier.rst
    https://git.kernel.org/bpf/bpf-next/c/89dd9bb25597

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



