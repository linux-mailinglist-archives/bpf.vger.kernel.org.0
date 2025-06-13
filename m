Return-Path: <bpf+bounces-60567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F133AD80E5
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A6C18911D8
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454A1F1909;
	Fri, 13 Jun 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SisH+KVV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560B1EFF8B;
	Fri, 13 Jun 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781205; cv=none; b=sR8PN/BtY7mLLS5Aan2IGRZW4XfC4X8UhQYndqh3OdsZk4Vy5ALiRGawEXgCnIBUQUK3Vg6RBb0hGl3z5/JDyzg43XjpAZv/zrCoUY1E2v9K5OzKiHPF2RVfmUm80ZeItax0RHyLhogh/Oz7NFjc6rptlWbqTpVAwIEIDuwz7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781205; c=relaxed/simple;
	bh=TLjcE0YICO3kvaYsCN72SwXHbWe98aZ1eqQahmYFW7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eV3Bj4Miz68zeMx5ihKQcnBZd1bw3WAV2WO0xI0mhqK8L1ymVCtU74VXcgzTsC+fnwK3bBd2p/BIk4lkCnlICG4BpUdfFnX5j/pfe1RXk1Ek/i0VvFMZpWZAqZVjMbOgsWU2QbqjSftfjYEFg3mGWqAQ/arOEMjfH4Ex86bcLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SisH+KVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330FC4CEF2;
	Fri, 13 Jun 2025 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749781204;
	bh=TLjcE0YICO3kvaYsCN72SwXHbWe98aZ1eqQahmYFW7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SisH+KVVC41sI+q1/5diUZeLLx8ecT33wZ8FPu7A5bUkXdM7IJk60qJLakNVgVEPM
	 WOHEHLk4DFdZbASXIn3zbPvLC/edmDfyy2T3LUGWhEJreqF0hHdbSQxcvLaOQmBeTd
	 FxMe5pQqtzeGCUz200Y9XnbGVEioy1jqiDQ9AAjzxWqXYrFxDZnYhf/tblOH/3hqdt
	 1afVUfxWTFNDxNJsERRwUOuA1EEyeGdX0L3W7EwMfSrIn61BSFfLkagfaEHX6tH54x
	 DKTCjCOyMr4SSdUwQsv6Fog+v5DrxT+/GwkRC1Cp+8KB0ReBo3RZ+Pux/dtr9sNN2G
	 VgYJAkYnUBgDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4539EFFD1;
	Fri, 13 Jun 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] potential negative index dereference fix in
 get_exec_path()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174978123449.192771.10901561494426019024.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 02:20:34 +0000
References: <20250612131816.1870-1-uncleruc2075@gmail.com>
In-Reply-To: <20250612131816.1870-1-uncleruc2075@gmail.com>
To: Ruslan Semchenko <uncleruc2075@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Jun 2025 16:18:16 +0300 you wrote:
> If readlink() fails, len will be -1, which can cause negative indexing
> and undefined behavior. This patch ensures that len is set to 0 on
> readlink failure, preventing such issues.
> 
> Signed-off-by: Ruslan Semchenko <uncleruc2075@gmail.com>
> ---
>  tools/bpf/bpf_jit_disasm.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - potential negative index dereference fix in get_exec_path()
    https://git.kernel.org/bpf/bpf-next/c/af91af33c168

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



