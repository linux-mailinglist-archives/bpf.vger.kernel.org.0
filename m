Return-Path: <bpf+bounces-61697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99DAEA4D4
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AC317B571
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB262ED178;
	Thu, 26 Jun 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiSctyWo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669052E427A
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960784; cv=none; b=C1OaV7aNnRflwE5R0rScCuEfyBvb+icUB2WsK0EogmTlEt0jvWzNK9TbYdtWb6QeG6HT4ZSy3C2rfymKcGk2dYMiBXJp+LOtWP3q7oQINALoDxrNIsAWe7jGG1l+gJnJYSoQMqFFYmkKQ8iD/V2X93lv+6NELY/nvPkHUbuz32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960784; c=relaxed/simple;
	bh=qYz8rvsdFyu63qGBEouH9RxEuMTXA5J/m+CoXml4xUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kmR8Ng7Ws3E6ar4jTYoUhPbwbzuZnmdlOuE1/RW1Vp8PfnbMaJ06U0Ca0X9bGoVd5b9DPR3jqw8XyFPv3RAsdHNDDwqk1XdRc1QY4comzrMN5OJyWQVkQqQOEKzHNyh1Wu2H7fsHu6eFfjBAjQ+E32z5w2tooS4UCmv0q/hFuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiSctyWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97DC4CEEB;
	Thu, 26 Jun 2025 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750960784;
	bh=qYz8rvsdFyu63qGBEouH9RxEuMTXA5J/m+CoXml4xUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MiSctyWo+S4f7/5TRKv31FnfvvIWBtlB0EahbZicedH6Coho0rAb3KHR1bFPE8s7/
	 lw8q2txCO0y+mF5BWbPb2usJMuouf3EdTgzkckv95XBzduyB+/yndYQQ9NcwbeMLJo
	 To/2U/B3XY6xwbEShQJCHfYwKJbGKElFL+WhCoNdI5Z56k+cGPTDJ473UWfs+hSRoK
	 FipcjE9bgEv1yd3PlURxHJ1F0IEgAGmdF6BSRlT7Hk9UOpnnRoX9KyeuJxdFmDo0n1
	 5weE+niyg6QnqU2Yz74MBdJASaB8+c1OfDO1E6dbaY69Zt0y8vP7mKm5mM/TCWKv2p
	 205ddzFgkx2JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFB63A40FCB;
	Thu, 26 Jun 2025 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] Support array presets in veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175096081050.1287156.17968557175673828237.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 18:00:10 +0000
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 25 Jun 2025 17:59:01 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> This patch series implements support for array variable presets in
> veristat. Currently users can set values to global variables before
> loading BPF program, but not for arrays. With this change array
> elements are supported as well, for example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "arr[0] = 1"
> ```
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: separate var preset parsing in veristat
    https://git.kernel.org/bpf/bpf-next/c/be898cb5cbf4
  - [bpf-next,v5,2/3] selftests/bpf: support array presets in veristat
    https://git.kernel.org/bpf/bpf-next/c/edc99d0b021c
  - [bpf-next,v5,3/3] selftests/bpf: test array presets in veristat
    https://git.kernel.org/bpf/bpf-next/c/583588594b24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



