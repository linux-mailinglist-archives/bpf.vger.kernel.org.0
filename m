Return-Path: <bpf+bounces-73183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD49C2690F
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 19:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91294424958
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50673261B8A;
	Fri, 31 Oct 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G53+JbBN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00691DF269
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935430; cv=none; b=UtbsM+zBO4CGIjAtfc/aXTOuuNbiejRadMLCLqT+inJb18Q6DUIwCxqJMjC+3Tte1oKJenaJQMlP0vHJ7QojvVELG5g2b9IFiZS6iZ94OvocMgRmD1JTSSIk5N2g8zXTRd/U+HFhGPdM/BI8bjoVf9pRZdn1FCuTBcGMAKsWdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935430; c=relaxed/simple;
	bh=S6ReYu2UchfiFNeCCH2HdJ8bcBBTNhM8zdgw1XyXVRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/VbX6sj3z/Y7dcqPJstkxNnZzhkZIJbwNU0AfOkTH72XZD/wTVs1vqjjZF84v8j/tHgeqztlZrITvfAFfrt8XKRM28byybcAS5AnvtR+EnhyUWieWe132T492sY1WmEhefQCKnP+bAJ1bYJS0njoqbrWElgWso6pkLWSNH3xiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G53+JbBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607CFC4CEE7;
	Fri, 31 Oct 2025 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935430;
	bh=S6ReYu2UchfiFNeCCH2HdJ8bcBBTNhM8zdgw1XyXVRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G53+JbBNsXkzL39iXkyv4jH3EaOrUCt/m6TaeHMCm5i3y+YFFhQ0M9R+ZjMsEeINM
	 dNNQ00U4xus2fVeQHJwkmCCC1pl/W2W8KbmOUXuxt0mLv9C9BXrz6+EvFeDu5S3SRR
	 2n86snzJrhF/dhz4qnYEXY6OBAPYiO4lzu9UTGdS+d66ucsu5aG2DLrgBnYJbBAMXo
	 YN45Ft7ZysDIXh084Z7pLfiK9iizCI+9ZG6ehQTAmzJygShd9XFt/I3dR6SiMSuOeE
	 qQh4rLUyseyPvp4+ganV7/LPKwyEI6XWcKmocq/fGNbbW1lkHv1fvLmnsWKhTDNa6G
	 uAH9soBvpjPpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1D63809A00;
	Fri, 31 Oct 2025 18:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: arm64: fix BPF_ST into arena memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176193540651.598404.1378163892417115487.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 18:30:06 +0000
References: <20251030121715.55214-1-puranjay@kernel.org>
In-Reply-To: <20251030121715.55214-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, xukuohai@huaweicloud.com, catalin.marinas@arm.com,
 will@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 30 Oct 2025 12:17:14 +0000 you wrote:
> The arm64 JIT supports BPF_ST with BPF_PROBE_MEM32 (arena) by using the
> tmp2 register to hold the dst + arena_vm_base value and using tmp2 as the
> new dst register. But this is broken because in case is_lsi_offset()
> returns false the tmp2 will be clobbered by emit_a64_mov_i(1, tmp2, off,
> ctx); and hence the emitted store instruction will be of the form:
> 
> 	strb    w10, [x11, x11]
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: arm64: fix BPF_ST into arena memory
    https://git.kernel.org/bpf/bpf/c/be708ed300e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



