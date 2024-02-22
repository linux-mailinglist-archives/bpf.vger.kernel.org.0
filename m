Return-Path: <bpf+bounces-22527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225208603F8
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D51B242D0
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4986E602;
	Thu, 22 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMSzJY2c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE914B82E
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635029; cv=none; b=ml/JqBrKV9AwbDJjwQnXYB3ELmHBYeL3ISL6NFr+W1tlIY3eERpCqzGWFEnHyksS49SPKlZpvT7QEBsKTrBhxSDGNdvKfsqWWeA4E1dynt8fMCy+fXZ9/YgxLPn0z/WVSEm7ue9NdC0iO82Wf9Ro47UAdct3Oe1e/kyW9l9FcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635029; c=relaxed/simple;
	bh=+XaRpLnHCxGPylhhGDs9oO1gBFoUrn6qD56XwAQRZKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YyulsQq5r8EyTz413H4G/Z6zoAumokv88kqUG4/BFKPyGhegyyIMFVRTwPUD7HZsBWnATHbLzzj69U96zqinBuCqCeahbrfjjg3WmI2pVmTh4VDCakjHoXw6HT/OLnExHbQYg2o92U7W/3ePpjFty1da5NO3nlVBR1tGjkYjt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMSzJY2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98C01C433C7;
	Thu, 22 Feb 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708635028;
	bh=+XaRpLnHCxGPylhhGDs9oO1gBFoUrn6qD56XwAQRZKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BMSzJY2cBXssk9GMkDLrAYDm0lDPfVHct4bWiNFfKXx5uqVHSxA73j5tRvzLqIZ+o
	 wDKK2+Dp6hxbk2yTuDH7INfByGpqZivDY2lCvx7KW3ESNEivcd/h+vXYowUpdGntRk
	 F539TdLT+2PVbQpR6WD+vGveKDexEL2HwCh6tJj6uhs1CCWvtO2BdlQztVopqZgoKV
	 ZTtkAYm6A+1ddDbZRCUTC3ziPLryT/zznde+h1tlnDxI+Lz/RTMFKZ3c1W8MIoThcy
	 jAiOnINAgDZIHO17pZ5fDqBggxc8MiN9Xv9Q/mn+cXAMgtWtE4zs6zMxLkB5KSwuEO
	 JdI/JntwS6ZmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82156D84BBB;
	Thu, 22 Feb 2024 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] Check cfi_stubs before registering a
 struct_ops type.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170863502852.11350.11162055811716334709.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 20:50:28 +0000
References: <20240222021105.1180475-1-thinker.li@gmail.com>
In-Reply-To: <20240222021105.1180475-1-thinker.li@gmail.com>
To: Thinker Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 21 Feb 2024 18:11:03 -0800 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Recently, cfi_stubs were introduced. However, existing struct_ops
> types that are not in the upstream may not be aware of this, resulting
> in kernel crashes. By rejecting struct_ops types that do not provide
> cfi_stubs properly during registration, these crashes can be avoided.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Check cfi_stubs before registering a struct_ops type.
    https://git.kernel.org/bpf/bpf-next/c/3e0008336ae3
  - [bpf-next,v5,2/2] selftests/bpf: Test case for lacking CFI stub functions.
    https://git.kernel.org/bpf/bpf-next/c/e9bbda13a7b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



