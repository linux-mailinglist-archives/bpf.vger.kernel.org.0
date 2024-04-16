Return-Path: <bpf+bounces-26988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD38A6FD3
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7D71F221F2
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4ED131183;
	Tue, 16 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2Czmfah"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703E130AE5;
	Tue, 16 Apr 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281428; cv=none; b=MC3qGs6N9kfcJcAvUcFFH6JGi7DuFbweWPANW06AI7iAkKlCqkwc6mHrf2S7T05OVZU6k7dkqTBR//PEkrRBbENiZ2XG5ff9oOsZR+gS60cLqM8oZQa2NTovu2/dh7gjGwq6yPrmx2lkzwxWqKXibTIZ+8W4WaJSGUNnn/vBFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281428; c=relaxed/simple;
	bh=q6m/LIMrLHCKJDbNvF0ZB8D7x6ZQqpBZz/TZIQtFFL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ppp0Qd2XyGx3Wx2hC7k7kLVtpC3nV9lenWKdV0YcC/SUb2VMvlGDVUbEBujE11AZIPBaMngU/nXA7rLL1c5UR7wqx7oKy4nraCfc9VE1jSblPzRxFy7F9PZvEwZe1Gr07aT75mUalF+HuXf5kFfgmItciQEaKXRbyLT1TdvNlUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2Czmfah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C730C4AF0B;
	Tue, 16 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281428;
	bh=q6m/LIMrLHCKJDbNvF0ZB8D7x6ZQqpBZz/TZIQtFFL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t2Czmfahyw8yoOBIsrn6+kdHA8B/Gwg4pMuTx4L9b5sTm1ML3XNSyOI5LZUiYXUCg
	 tMEGjLYhdEMSkB7D361G58qRCe+kLLPkkluXw4OHqkW4PD+IYyWfWjenGbWV/TIa/z
	 J6fGHMEAaELJse0aEjfr5/nmuAIQYKvFo143SWD/3xj4bo7rljAUj6kGKCiC90W+kv
	 96XCNLXXN9+ISpG9jC0WoONACBpfOu6UbtoZ0fSxujdmwjXnRlpym3kshi8dixfxyu
	 7vApEa+TXiBkUpYFPNtlRYS1UNoq8ffjtLsHqdICch7q+8ztjONmaCdKx9sgz9/UEX
	 VrJVPu6qMPSlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8066ED4F15D;
	Tue, 16 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/tests: Fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171328142852.29407.8993138598400948839.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:30:28 +0000
References: <20240415081928.17440-1-cp0613@linux.alibaba.com>
In-Reply-To: <20240415081928.17440-1-cp0613@linux.alibaba.com>
To: None <cp0613@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Apr 2024 16:19:28 +0800 you wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> Currently, there are two comments with same name
> "64-bit ATOMIC magnitudes", the second one should
> be "32-bit ATOMIC magnitudes" based on the context.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - bpf/tests: Fix typos in comments
    https://git.kernel.org/bpf/bpf-next/c/dac045fc9fa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



