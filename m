Return-Path: <bpf+bounces-20602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDD8409F5
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D381C2280D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70569153BD8;
	Mon, 29 Jan 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW6nCuMD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E9153BC7
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542227; cv=none; b=kNSP7J4RSfRh0MYdF50Fv0Ukp76epycbu0/RfOp178Vfp3OCcBFbFX5/BKLnu4HqVFSOq6oC+GMMkp2Gah2WtDlBufR3w7BIH5EGq69WkaC+fA6FZ0p7sv7SC3O0GtcHcxfTFw6M5WHXtOEUNPBft4ExS+GysiBnTfcJpOE/1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542227; c=relaxed/simple;
	bh=G+5Ugc81RCrOXJrmU84xR5P0Bljc51NusWKNXs/u+dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLL/5GYVIcKISZ3zgWXwB9lPsLXOY3dftmf7Qe3mWmajY6rPNN1FvNiKGLgU40eR66FZH+eqEMvmZoYij8ZKjt+ZeMe9LFpJDGS9y5qet/72XH+YahyDtDmNMAWJXNE1pw729r4TfkfqEuLqd8x6KhfmovxcheEwUEdDdvy4FHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW6nCuMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95025C43390;
	Mon, 29 Jan 2024 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542226;
	bh=G+5Ugc81RCrOXJrmU84xR5P0Bljc51NusWKNXs/u+dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NW6nCuMDaztzxgrMMQbFgSIhZIvc9XABNDIhd7WXJ5sqdJPHsfRX3kNXSWWVxNY9Z
	 mDjr4WoAZCU+Cgs4CaD0edL3dtesRZqQkOq6gtl0gYsXMp93vVLBvAEP2EBfEzbpYh
	 bir1tgq8y2v0M7IgVo5cQXFGoTKNPIBrf11DsSwxbmiKoxu1nEKtAJkI8OEeY2IysG
	 fOcWL/a5wrIdvOR8y0sbxyfKh9BHZjsGkwDJGMhegO200njMdjr5K6NZSfoPkppXSn
	 VM6wYixbKm4/+hdw9Gxelv7OzN3l+pSFCoPbZSmdqW77e5NweN0obvXMjhopc80Bib
	 qwakEN92RGqvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71D25C43153;
	Mon, 29 Jan 2024 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix faccessat() usage on Android
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170654222646.3521.16557016099018166666.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 15:30:26 +0000
References: <20240126220944.2497665-1-andrii@kernel.org>
In-Reply-To: <20240126220944.2497665-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 26 Jan 2024 14:09:44 -0800 you wrote:
> Android implementation of libc errors out with -EINVAL in faccessat() if
> passed AT_EACCESS ([0]), this leads to ridiculous issue with libbpf
> refusing to load /sys/kernel/btf/vmlinux on Androids ([1]). Fix by
> detecting Android and redefining AT_EACCESS to 0, it's equivalent on
> Android.
> 
>   [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
>   [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix faccessat() usage on Android
    https://git.kernel.org/bpf/bpf-next/c/ad5765405380

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



