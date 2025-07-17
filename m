Return-Path: <bpf+bounces-63535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33FB08283
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF4D1A64A82
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E9C1E0B9C;
	Thu, 17 Jul 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h13PkQuo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF911DC9B5
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716389; cv=none; b=ggF1VKHZD3AjtnVb7hjMrFC25u6FMOI2jQJqTDlP864gT1JxJwpZ4iSnTd7ZjV3gF1GL4g6Ljhaz92Ppw6v8xH14OM6oJCPPGbB4YMivAl96gdl8rnBJZW747M8Sm4QWuL5Fj6603qFw49nxxXdaf5qyvdbGVvDXjc0pX3uTawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716389; c=relaxed/simple;
	bh=wr4zAjphmBygZHgxmdsYKlEyzW1ZGvxE2QnVgd854F8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJA2otGkzU8PWWpMjkOeNVwyJJkIg7VynFXrrrfQjBGG5BLwauRcAfYWjSCFDxYp+QtACNuKuUqocfVBhPX0/KIRpIjvYCgxjE6wqYNhi38IiDHPrNOSmeYt5eXTO3swLO/x40wskIzADVpD0L/fnOnpOinUGvy9P0xw8dIUq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h13PkQuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D2BC4CEE7;
	Thu, 17 Jul 2025 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716389;
	bh=wr4zAjphmBygZHgxmdsYKlEyzW1ZGvxE2QnVgd854F8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h13PkQuoPEZJ8920hBcct/EcT5lmA15HyaCMtHviGmhMs6eiaUFQHoLpX3MzH5ZTP
	 L2a/D/S+3RZiGu162pmFXzq1vUv7LeqRHK4ji+W4sCO+8YJq2Qlil2sOOvuxKbR66Z
	 YioorSA+SRDl+qx/qBYdJXsDMRPrE8Bf7J4RjG000vn+4yua45UNa1WJIlSoM8rsW4
	 CZlRXtxaT2zcxs2x35YYg1RjnoGdmIjxUoORoaCukvadyGb9IK5IbuUeEhwScaJlje
	 QBtuTnwm2gZR1iqXcaFo6grBuy0LGJKaZcuEHt38k9z2s9GNhDMGJG8gFbo3aliCu+
	 4m2E9ZAIz8AJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB26383BA38;
	Thu, 17 Jul 2025 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] s390/bpf: Fix bpf_arch_text_poke() with new_addr ==
 NULL
 again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271640953.1391969.13089681287539444894.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:40:09 +0000
References: <20250716194524.48109-1-iii@linux.ibm.com>
In-Reply-To: <20250716194524.48109-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Jul 2025 21:35:05 +0200 you wrote:
> Hi,
> 
> This series fixes a regression causing perf on s390 to trigger a kernel
> panic.
> 
> Patch 1 fixes the issue, patch 2 adds a test to make sure this doesn't
> happen again.
> 
> [...]

Here is the summary with links:
  - [1/2] s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again
    https://git.kernel.org/bpf/bpf/c/6a5abf8cf182
  - [2/2] selftests/bpf: Stress test attaching a BPF prog to another BPF prog
    https://git.kernel.org/bpf/bpf/c/d459dbbbfa32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



