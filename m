Return-Path: <bpf+bounces-16255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F197FEDAC
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF569281DF5
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED033C462;
	Thu, 30 Nov 2023 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELtgMres"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE818E01
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 11:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A053C433C9;
	Thu, 30 Nov 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701343225;
	bh=/k59YdZdJ2hdOuoQu4L/tQFt5BKzGrYlSi+Wg+rmzCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ELtgMrespBXfJU9ocDIohT95Wq02wdfbHTFE+XaC5B0hUSXbHDf399p/NWFoC4yUA
	 lI4lFZs+1CZhf122vh8fvO4tr+xFjVjB4s2K6ZU04Cxv9OHEXPkuF3Am96hgArlhhO
	 R225iNKVIEKpvYgmuYkgOXRHsxR7NJmU07sd3ldGWCUSrpx7y7SWLJopOG03PPMurv
	 ZcuBCIhW5NqZF93OKr87VsQ34O3KwmgXSkbqGWD3z1nmszL5Y91+FzuSRSdS38Tqag
	 7ZpqzcGlG/Ib7DTUW4N6NN0irvgcue3NQxHcM2kXvh3t8OuAf3a2WPrySJ2eAOj9k1
	 gSLK5gYVMutUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBD0C64459;
	Thu, 30 Nov 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/tests: Remove duplicate JSGT tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170134322544.30094.8628031237009156633.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 11:20:25 +0000
References: <20231130034018.2144963-1-yujie.liu@intel.com>
In-Reply-To: <20231130034018.2144963-1-yujie.liu@intel.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, johan.almbladh@anyfinetworks.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 30 Nov 2023 11:40:18 +0800 you wrote:
> It seems unnecessary that JSGT is tested twice (one before JSGE and one
> after JSGE) since others are tested only once. Remove the duplicate JSGT
> tests.
> 
> Fixes: 0bbaa02b4816 ("bpf/tests: Add tests to check source register zero-extension")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> 
> [...]

Here is the summary with links:
  - bpf/tests: Remove duplicate JSGT tests
    https://git.kernel.org/bpf/bpf-next/c/f690ff9122d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



