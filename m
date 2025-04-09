Return-Path: <bpf+bounces-55603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE76A834AE
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9F78A6FD9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADB21CFFA;
	Wed,  9 Apr 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHt7xLdr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7D19ADA4
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242011; cv=none; b=sta/vRYsDR/NlSLAvcC39jKxbag4nXbbXo/LxNlFT2sMJNJolz2yexX05Pdp46HNHSOD0+jhXzztSrwjaCdjhlBnMpzx30Fb4SpHZidkZ4mj3IU6cH3im71pjXqiht2vhG+ucI26OS4OATLOPsJpKAjeGWy49hdUp9zntvJa/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242011; c=relaxed/simple;
	bh=8EQl7ZE3nWDXmZULWCAS1IE1uK1pcUxLGkTkDmbPakk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UWvw1xPoEudGhzV6cqyJlG4tMkpU/gohUDOBnVKDbO0tH6IzZm24MnCgGfTWQsy7TdpFOFurhC02qh/swriNsk4lxVI8vZb0rCGlt04nfO3/4vr9c8UP6AL0xLzG9KcxIUDpAhtUZa3kNTO89252rC2iIyuEZ97YcD8xQyPQhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHt7xLdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F55C4CEE2;
	Wed,  9 Apr 2025 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242011;
	bh=8EQl7ZE3nWDXmZULWCAS1IE1uK1pcUxLGkTkDmbPakk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tHt7xLdrXaTWXqkUMa5I7tzPnwZTA7PBoyi7D8qRSUhZM4Fi9wZA/Cqs2qXC6rNB3
	 taKMf2H56k0Jy5M/HScw5W32HxFqcGMvn90Z5CsB0ueEL3V3fPJ0ULz+32ohU1tJO4
	 ZUw7yTGRpoeKGxR4x7L3WJzNf2CvrBx6ZqYAoriLQfUssuHrcxDcf3E1iZaI11aPTo
	 j7rNU353hx0wUPPElDHnj1BQw4t2JrH/LgF8FE0xcryDG/oa4cRrK1oe/TLRoltX+g
	 pCwdYcCWh//CdCnAIwys41hDaS2At5tott3EJ8RFeaUoaht46zFc2GU7ZHEsQPom2l
	 OAnjZl43LFKtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE80C38111DC;
	Wed,  9 Apr 2025 23:40:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: support struct/union presets in
 veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424204833.3077267.5549128178308798234.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 23:40:48 +0000
References: <20250408104544.140317-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250408104544.140317-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  8 Apr 2025 11:45:44 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Extend commit e3c9abd0d14b ("selftests/bpf: Implement setting global
> variables in veristat") to support applying presets to members of
> the global structs or unions in veristat.
> For example:
> ```
> ./veristat set_global_vars.bpf.o  -G "union1.struct3.var_u8_h = 0xBB"
> ```
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: support struct/union presets in veristat
    https://git.kernel.org/bpf/bpf-next/c/37b1b3ed20c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



