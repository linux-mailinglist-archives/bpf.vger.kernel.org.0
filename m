Return-Path: <bpf+bounces-19795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24981831222
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 05:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59B3B23BF4
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253AC2F32;
	Thu, 18 Jan 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WabH4oPw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E12A41
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705552228; cv=none; b=UGTdJmHpX0FfQMjzMAQxOl/WBKA/GRBQActPbW0v5JXXk3bUf47+5Cdn6AXTXWtWHfUhn6f0yPG62xPtOvk/iG79DCVpMG3dd/VeRaaeKVI6QjCT9ax+Q7nnyAsAxrrn8f9YJ7Cgh33S1wiHzGaVhZiO4JQr0ASn9C9hAh2lbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705552228; c=relaxed/simple;
	bh=r0eE3XKsuw3UPyQnDjSQ9A49UZxxD79iIUG6xvoX3/Y=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eDh92jkJIg8a8bakUlONbfICBt2SZWm/n0hvBRse8TO28ZVrenL+gvp/2am0Vf/TIyLCwzd/mZy1jLFpSKzXDi8B7wN5Kk9iEaUR/Izcu3248lF6W/VJzifhLgglChw4kIZScNIn4lhYcvGmZ9Ydlhxf7vQUVaZzAEVHzL/VrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WabH4oPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA4FC43390;
	Thu, 18 Jan 2024 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705552228;
	bh=r0eE3XKsuw3UPyQnDjSQ9A49UZxxD79iIUG6xvoX3/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WabH4oPw4H7bWuzNEZr0mLGIgrw4BHENuTNS4gZ4OoTQbCvS8jL4cV1635G+wQtut
	 s8m9E23FiACEsUp+beyIpvtnfY9lnTkUfQBOirkm/vnizZXIvvrshvKEEXjxVA90fn
	 i0RWAT1MgR95agsBOG2/7VfYwgrrLY4eNHWsxFF1aoZN0OGQJ4Xu8TCZ5rgu5RAQ/g
	 XvthjHf/N7Odh+eDvKm7PipwhaQDDDkJ7eG5oyYHuGgbWnBAWOu2Ve0bgYdXfb/T2G
	 buML9alrHerZKV2F/EDt7Nn40kKrBA/B4VxMfWUHOwCWnY9HDWboZSjxG3/IuGo8iQ
	 PBVPv3mYQyTvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7581D8C970;
	Thu, 18 Jan 2024 04:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf 0/5] Tighten up arg:ctx type enforcement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170555222794.4195.3268031757006579635.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 04:30:27 +0000
References: <20240118033143.3384355-1-andrii@kernel.org>
In-Reply-To: <20240118033143.3384355-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 Jan 2024 19:31:38 -0800 you wrote:
> Follow up fixes for kernel-side and libbpf-side logic around handling arg:ctx
> (__arg_ctx) tagged arguments of BPF global subprogs.
> 
> Patch #1 adds libbpf feature detection of kernel-side __arg_ctx support to
> avoid unnecessary rewriting BTF types. With stricter kernel-side type
> enforcement this is now mandatory to avoid problems with using `struct
> bpf_user_pt_regs_t` instead of actual typedef. For __arg_ctx tagged arguments
> verifier is now supporting either `bpf_user_pt_regs_t` typedef or resolves it
> down to the actual struct (pt_regs/user_pt_regs/user_regs_struct), depending
> on architecture), but for old kernels without __arg_ctx support it's more
> backwards compatible for libbpf to use `struct bpf_user_pt_regs_t` rewrite
> which will work on wider range of kernels. So feature detection prevent libbpf
> accidentally breaking global subprogs on new kernels.
> 
> [...]

Here is the summary with links:
  - [v3,bpf,1/5] libbpf: feature-detect arg:ctx tag support in kernel
    https://git.kernel.org/bpf/bpf/c/01b55f4f0cd6
  - [v3,bpf,2/5] bpf: extract bpf_ctx_convert_map logic and make it more reusable
    https://git.kernel.org/bpf/bpf/c/66967a32d3b1
  - [v3,bpf,3/5] bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
    https://git.kernel.org/bpf/bpf/c/0ba971511d16
  - [v3,bpf,4/5] selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
    https://git.kernel.org/bpf/bpf/c/989410cde819
  - [v3,bpf,5/5] libbpf: warn on unexpected __arg_ctx type when rewriting BTF
    https://git.kernel.org/bpf/bpf/c/76ec90a996e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



