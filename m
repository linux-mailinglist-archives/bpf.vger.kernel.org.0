Return-Path: <bpf+bounces-77648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F655CEC9A5
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 136183007906
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FF30DEC0;
	Wed, 31 Dec 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5Hnyens"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFA2BD00C;
	Wed, 31 Dec 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767217404; cv=none; b=hFXvVg+CvuuMbQboYx0OH57cPB+Jtsx4f99U1j5j5Nt7Sf9Z/ejkyROlFhPb0+yUNBsgOqerAFDLB/QxLG11WPhzQoYpzmUUv0uIZREdU1vzEIBkmJJF/XBINWcXuiU3RQrxsBUOs3WbTJyZAxpNIg+TIRaIgUYx2OwmO/4vBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767217404; c=relaxed/simple;
	bh=zjkiUOFtQUg3utE7N9prdVTdxXopfiRzdJkp4QRnPYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ppI9AxZkktrGPcFiQD1iLLPXoJTsRIOOwHmc/g3jbiCj1azHoD9npTyZYc9uP+HS3h3+ocZ5FHFwrHAKepizdGNN57mKRzy6NEb2OVF1FnkjUpDCcDeIrwEOUHMgoJbG6gnpIe/W1dyj1y33kjEQ/IAAgMhEwbLlDtAW1B6Z2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5Hnyens; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B018C113D0;
	Wed, 31 Dec 2025 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767217404;
	bh=zjkiUOFtQUg3utE7N9prdVTdxXopfiRzdJkp4QRnPYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V5Hnyens2D5Gh2Ja/s3JK/HQRiGKJbXl8wAoZLZ/ZBZXdlpapftHL8mjbb6i2qDkI
	 WSL1r+91c0W2EAQKNHG1tirjOBm0U8xRsSkWB0ugomh0LbbFZbOr5oPFM7scRz9+Ap
	 xc3qv72IqwYj9ZY39vyJyIPFyLElTPuKWD/6Ad24xb5ROiX1sx+14I5tjMhT370MWE
	 4sA0qk6pGRNou5o/rl99wsgu5lDRS3VyVfLiJC3bbpPZcSRpqmIv65nu75tDup9Qo2
	 K0yp4sKGinid+ENZoNtJU1xS5vqYIKVyEZnFXYICYiq0yNcWM9StIQ2H/DvxogdT16
	 rtQ8uwD0BT26Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2BF13809A83;
	Wed, 31 Dec 2025 21:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] scripts/gen-btf.sh: Reduce log verbosity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176721720579.3606175.10334632447565675369.git-patchwork-notify@kernel.org>
Date: Wed, 31 Dec 2025 21:40:05 +0000
References: <20251231183929.65668-1-ihor.solodrai@linux.dev>
In-Reply-To: <20251231183929.65668-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 nathan@kernel.org, nsc@kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 31 Dec 2025 10:39:29 -0800 you wrote:
> Remove info messages from gen-btf.sh, as they are unnecessarily
> detailed and sometimes inaccurate [1].  Verbose log can be produced by
> passing V=1 to make, which will set -x for the shell.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQ+biTSDaNtoL=ct9XtBJiXYMUqGYLqu604C3D8N+8YH9A@mail.gmail.com/
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] scripts/gen-btf.sh: Reduce log verbosity
    https://git.kernel.org/bpf/bpf-next/c/453dece55bb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



