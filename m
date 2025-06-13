Return-Path: <bpf+bounces-60624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401BAD93F2
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1787F1E1BDD
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F9226D0D;
	Fri, 13 Jun 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfkZ4s9E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA0211A23
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837002; cv=none; b=jbCjce6Ei8tkQyC5UHCqa2SjIz5/NXt+vyhgmv8QfFIgKA+yBdkzTSNz7Tc+n80oFPzliyRa6SvOPTZeiMUs5A00pE3nJ6tCKBawHHSGDetRKqgAehIT7G4SLLejFWNdy2Dula5RpGJB4K1CQQlqyH7QVBr5hprUXol4J4jLHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837002; c=relaxed/simple;
	bh=UmHVoBSDHYbdPxI70AzjVcbOZUQI61uP6+8L9fz+z9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXOUz3IXwUbeWFpRV+kntzXIvYH0I4GzIjvHD4gKNX4rpS9aBDPnPUHiiCd2aZv2rXzAaL065Kp9Lc/axxs9W1Fx6zT2Oba7GodXDbeir0Otyl57LGLI7kSyWg/k4TXB5s01WqXSQo6f6+0TKo4vSogarRXK/obQh3P7rzeVNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfkZ4s9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB7C4CEEB;
	Fri, 13 Jun 2025 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749837001;
	bh=UmHVoBSDHYbdPxI70AzjVcbOZUQI61uP6+8L9fz+z9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PfkZ4s9E4ZmYtQKxXNpmDnIuda+xXlnJIz7teqVznLy14JpYoUvXJIxuBMUyXmiJ5
	 EDZVqGy5OFZ2swCuvioEj+RuoFrdZuSRNl9X1+hhygCJBGcq1BjcafQn/lrnzSf1kT
	 VB/FOWmIs9Z0pUp7JOZNg0RNJQCBBXkLt0Z0be26sSDVTGcDbuTGotXI7qa0lA0I4O
	 jBvPKfLPMirsKjm3ecuJeT25U0rqCuC+7eLxeFXweSqZ1+/YXoZ/X4vbQ6gwBogXEb
	 0Ua5p/F4pR4OAiUoFgdmg6FcVwxk17RB45EXk4ef/1zB8GinCKe9bZsocqsIdf+A3Y
	 Ehz0vIbD5sLEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD84380AAD0;
	Fri, 13 Jun 2025 17:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] veristat: memory accounting for bpf
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174983703150.829843.11674630533535507815.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 17:50:31 +0000
References: <20250613072147.3938139-1-eddyz87@gmail.com>
In-Reply-To: <20250613072147.3938139-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Jun 2025 00:21:45 -0700 you wrote:
> When working on the verifier, it is sometimes interesting to know how a
> particular change affects memory consumption. This patch-set modifies
> veristat to provide such information. As a collateral, kernel needs an
> update to make allocations reachable from BPF program load accountable
> in memcg statistics.
> 
> Here is a sample output:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: include verifier memory allocations in memcg statistics
    https://git.kernel.org/bpf/bpf-next/c/43736ec3e027
  - [bpf-next,v3,2/2] veristat: memory accounting for bpf programs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



