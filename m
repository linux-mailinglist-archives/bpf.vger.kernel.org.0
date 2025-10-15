Return-Path: <bpf+bounces-70981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA1BDE03C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7A4FEFE3
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986A31D74A;
	Wed, 15 Oct 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyBv1bJB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E6307AE1
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524289; cv=none; b=RI9l+Y8woc5LtdwN5a6Hd5McJSoi2R3+FdNd6SEns5gFz5EhJhDC/AgJJB3Ix9t5Y5/NJhpctohoi8sMSwS2SSRyzAh8puB+ewBoyaruW46on8fJVpiDWQkE3vNJwB4ffW0YDYJOoFFMz5EyXlpUf4/pJ3fuEfE9X37qnfH9EC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524289; c=relaxed/simple;
	bh=Aqk7Nfhpsw1f7aZwOwFj13tGEh3Eqw+P6Q8KBNyCvz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uq7g8x3LZqhY/24YpZuF/OFmjJaYNoHRVzFPRbcaBtR764L9Or9B/i6jVVGc9OFZS74Q1MTpDiW4UUwbUH4YE39gQARair560+3ay61FQCWUc1OxWKEF99RCL0ClzEDCzAuEECgzaqxEzgIaoMir6Lh7u6a9XoK55YUxOQqsvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyBv1bJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D07C4CEF8;
	Wed, 15 Oct 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760524289;
	bh=Aqk7Nfhpsw1f7aZwOwFj13tGEh3Eqw+P6Q8KBNyCvz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NyBv1bJBRzMaDO50WqkBa/RiX5Vip7/hNEyzeqXTu1i5x1r+VMqtbNrsoMeR4yHqA
	 EqhZICP0bljilL3I8jLiau+nlv8jVBuEnjlLE4srrWElo862HYt9K1ggH0QdgEgjEk
	 xhIKwN7m2Ux1Z5MgDogy/Hn/A6eMVGMiEm4PGYHMzFuPxpoesl+gOT0v0tXR5nOPq+
	 6TRev4IF12gPrK8vPNh8rOT1qJxcDIFW/Cfy98INc/77n9xQTkmouXXOEi6NDo+JGu
	 g3kP1yKKrU1pyAycDjm7kyEK+mqSJZ0ZsvXUtVHnoxOT3RMvUDGTvP0uWqbC1hF2Cs
	 5bPtW8DVgKa5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74343380CFDE;
	Wed, 15 Oct 2025 10:31:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: consistently use bpf_rcu_lock_held()
 everywhere
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176052427424.282100.8035714898138837243.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 10:31:14 +0000
References: <20251014201403.4104511-1-andrii@kernel.org>
In-Reply-To: <20251014201403.4104511-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 Oct 2025 13:14:03 -0700 you wrote:
> We have many places which open-code what's now is bpf_rcu_lock_held()
> macro, so replace all those places with a clean and short macro invocation.
> For that, move bpf_rcu_lock_held() macro into include/linux/bpf.h.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> v1->v2:
>   - move bpf_rcu_lock_held() outside of #ifdef CONFIG_BPF_SYSCALL area (kernel
>     test robot).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: consistently use bpf_rcu_lock_held() everywhere
    https://git.kernel.org/bpf/bpf-next/c/48a97ffc6c82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



