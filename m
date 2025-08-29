Return-Path: <bpf+bounces-67021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AABAB3C1BD
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7819F188EB38
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115BB341AB8;
	Fri, 29 Aug 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFV18k3B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CA2DAFC0
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488602; cv=none; b=TNpBp54g9EOS6HecI9oHoc3Qfz6x7VmlVozOJRJgg+cOy1U/Ow3i1CB55m+bGOAz57UgBudrKe3+Lrs/hhc4eVIkuuLieoqdxJkDd1RWR8BuS0LnLVEI3ld423UWRyi8MqJLwYCKDFlRurjkuUo9gAZ5wygfc0M0FOmHU4SIU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488602; c=relaxed/simple;
	bh=/IlNH2b65+xt9nddx8wrJmtWPgvjgHKNPxFPX8N2xVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uzOpJO/izUx9e5y3q7c/EO3/DMVyOedPT+L239/SaLLJG8efjWMid2UBio8Rwc/5S3TyFKjD1rrHXLt5/s1Xhdly6dKo0xc2qCSdnK2CS7wss8E6Q31MeBXd/r0r3cktgVhjB4mog8Dr9CYHHh9cvw28kzL22vGFwSQFWd3IAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFV18k3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22347C4CEF0;
	Fri, 29 Aug 2025 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756488601;
	bh=/IlNH2b65+xt9nddx8wrJmtWPgvjgHKNPxFPX8N2xVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFV18k3BG0ViI1qSA64JK4cE9RC59X1FMwYL5gsK5vq6qGDUqZT4PB1bVZMoDv8TP
	 rn2AbjssR0ijQpQnibZ+eaEsKDguxrBdcNIULgIkEzCd3sm0NuwzYY4t4xHrmOpzPp
	 CMj2yIgoyjqhcfkpvLCHGSgAzADopZmM/wwLKErvmEJjCUmBKZI/G7BfGBFTkFrqP6
	 fUHIosxEKEkbQrvPxBecNnHg9iYX8IuwtXB0vgNBJa810Bv4qRdCopY5nImFe6hbfi
	 XgCNZ6m+XbmVKquVSfFmMTziAt2Lrj2yr0Qg7z7NXv29xHVMcVj4tWq69XPihscSf6
	 6iG0IZW9MotKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13B383BF75;
	Fri, 29 Aug 2025 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix out-of-bounds dynptr write in
 bpf_crypto_crypt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175648860777.2290405.13980466851752354921.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 17:30:07 +0000
References: <20250829143657.318524-1-daniel@iogearbox.net>
In-Reply-To: <20250829143657.318524-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 disclosure@aisle.com, vadim.fedorenko@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 Aug 2025 16:36:56 +0200 you wrote:
> Stanislav reported that in bpf_crypto_crypt() the destination dynptr's
> size is not validated to be at least as large as the source dynptr's
> size before calling into the crypto backend with 'len = src_len'. This
> can result in an OOB write when the destination is smaller than the
> source.
> 
> Concretely, in mentioned function, psrc and pdst are both linear
> buffers fetched from each dynptr:
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt
    https://git.kernel.org/bpf/bpf/c/51ae4ca30f11
  - [bpf,2/2] selftests/bpf: Extend crypto_sanity selftest with invalid dst buffer
    https://git.kernel.org/bpf/bpf/c/5aa00f0e9589

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



