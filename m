Return-Path: <bpf+bounces-21875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C75853AC2
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C39F1C22915
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F871F618;
	Tue, 13 Feb 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru8gEQxC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58A5FDA1
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852027; cv=none; b=CmPFYoajwqsNy5caJNrhKSS8yOyuMddaQ945QDJVphSSDL11rmuA78RS3JMK8ayzfef7dvYEUKrZ5HyKs2RBNt7OqqCE3aMUBty4ndtreDacQsK1e50YW8yf5jxsyarZA3973dQGUJWxtzTSToZ9GcfLLAVh9DWv9Ztp/59P6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852027; c=relaxed/simple;
	bh=0FMQcDohmKkaNi5LvPAdORM6pFtH2/wafXhKQ6RbqeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bBjtq7d1m7obDa2GrYQ2yepSnrVdOP7qJPYZLHueZVJkp23g3DWhrmJsF9Xn21Q1cOsdvD0gYu5BqqB57AOtIRGWTiD9WyMFTlo0+c6Z98Ef4tPpXJQ9hqW73R1kGHenWNp71GaEt8HI548nqdz/PbggScIWrGDCocQ3BTHTUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru8gEQxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B45E6C433C7;
	Tue, 13 Feb 2024 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852026;
	bh=0FMQcDohmKkaNi5LvPAdORM6pFtH2/wafXhKQ6RbqeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ru8gEQxCSbHytgRHeA5iVOnanPdMxK7yC2W4gMSWykWpA95xZj9LHtWRI1u8+mEcN
	 OBJCN8b5QXpBO5qIP8ZczDym0GPwdtkx9Mz1z8FVfK1jmMyfGeUM8RQb6fwc2ldkZ0
	 fXoSqxI3SpOII4oAuuJuCDO5Ib/HKFswjn6oB2YLSj7A4ZcAd3ScBeWHx6zH6jC2si
	 FzHHxxVaOGa0zA7JZS9BLN5Yww5heROYo97AXf8Zr0NPk/Ilc9MZMLJL2rsm7tPMgH
	 7eLR6FTsdiBv0f1ABI3nO4rFgVXN7n6xAyqPNyI7XCEK4x/24Cg/x2q9anKLqUZEgH
	 erI3GnCulwWrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 998C4D84BCD;
	Tue, 13 Feb 2024 19:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix warning for bpf_cpumask in verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170785202662.2905.2398429930172128232.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 19:20:26 +0000
References: <20240208100115.602172-1-hbathini@linux.ibm.com>
In-Reply-To: <20240208100115.602172-1-hbathini@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, void@manifault.com, ast@kernel.org,
 daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  8 Feb 2024 15:31:15 +0530 you wrote:
> Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
> warning:
> 
>   "WARN: resolve_btfids: unresolved symbol bpf_cpumask"
> 
> Fix it by adding the appropriate #ifdef.
> 
> [...]

Here is the summary with links:
  - bpf: fix warning for bpf_cpumask in verifier
    https://git.kernel.org/bpf/bpf/c/11f522256e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



