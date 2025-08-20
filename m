Return-Path: <bpf+bounces-66087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBFFB2DD5C
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400E07BB36D
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0831AF25;
	Wed, 20 Aug 2025 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8IZLliP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413E242D9E
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695397; cv=none; b=YCYwoVvRFnW6MAx3BKchCyDA0IEiuBVhHZPyFSpf/5nioHyZlZkkznITYv3UHD66KhrYgLY5upr9H8dKwJ3WBgSg6pcxLlKmB35yVfuEVrNBOThWMZf68/5m+61RlE09VVC3HQwrJ3M72oS8wO84Uae7F8KCrlsDypezELkvfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695397; c=relaxed/simple;
	bh=pgYVT+usj7afLqSXiRRncQqVtAW6r6s/9qQ5sFpEqVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=loBTlLQnzukKuHRlXGUhKtj7q7X+9YfXkuSNM19PP/XQ+yBRjmTVU1CbPFKtKCqRHjlFnasOZOqgx6ljrhB0XAyuj9ABwKXqD7PGhd0Wl+ax78NuiXPSEeOg3OB/zuu+7bEdYRdKHVx8rbFGg/mGNjQDZL/zSBAycT95LPfMnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8IZLliP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1A5C4CEEB;
	Wed, 20 Aug 2025 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755695396;
	bh=pgYVT+usj7afLqSXiRRncQqVtAW6r6s/9qQ5sFpEqVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o8IZLliPVGDfJksPQhbO/9VvcwSra7IJWyKvZ6gxzog0jRWsIlQyK+N6286ZnDatK
	 Mgy0kX4dCXGqdCBvpMz3CMm4kkYzlKr+SGglI3fyffpOCvNB2G2Tcu7iUHv6TH/nBJ
	 G3a5IqxOG5JA31wAZDpaRgeK2Q3YDnH7VHZbpgACJuzt4M/oZp/NnTAvxhnsXXKxwq
	 E8RvZYzbs79vDmdwsLtQxwRzpbbw36fCNMI8Y5hRpEJi67Jhb5EZULqQ8BnsGD6hiZ
	 xiqw9OKrpmfy/8A1NMgPFy2KP1InM6QLWEZBPPpIPXp3zgoE4qq0ViAQxacOEDxFbV
	 31IqsfI1ZI6/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71AA9383BF4E;
	Wed, 20 Aug 2025 13:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: export bpf_object__prepare symbol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175569540626.229552.2531878236327571333.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 13:10:06 +0000
References: <20250819215119.37795-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250819215119.37795-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 19 Aug 2025 22:51:19 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Add missing LIBBPF_API macro for bpf_object__prepare function to enable
> its export.
> 
> Fixes: 1315c28ed809 ("libbpf: Split bpf object load into prepare/load")
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: export bpf_object__prepare symbol
    https://git.kernel.org/bpf/bpf-next/c/2693227c1150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



