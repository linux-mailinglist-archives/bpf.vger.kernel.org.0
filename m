Return-Path: <bpf+bounces-32077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645149071D4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204BB283B41
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733F144D28;
	Thu, 13 Jun 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfLjHSEw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D854143C50;
	Thu, 13 Jun 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282432; cv=none; b=Q4VWRUjaec9LEqrY44BzpNUDkwQP/+38+aP3wiP7cLnAgx10SHETlgqWA1RBtl+qVDr/gw/2hGNCplH3iWeq33qHscbf4064to+uSzCbo9adZD8qzHifhxjviSHnW+Ll1fQIgZd0vlLjvRu96O1KW0Z0x+i625PIjaP2LlsbcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282432; c=relaxed/simple;
	bh=jpa7uXyQT9LKK7vRGulcO5ZphvoMO5zGFDVqTDzvICY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cswJMfdzne+ovvrE0mFzah6s6UOc2otNVuPTONCrXMZD6ts7l6HYuwnQMT/SLrR5Q0jfjoogyAhyhY8Ex6+FRnShkyEbdIdgzESW6bwQvaQzFS7oy7xrEGGKYlPeT4+ZvyGMcodOv7yPvTdZ4SjqBFZUVqlpJfRdp2saNB+qerE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfLjHSEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3958C4AF1C;
	Thu, 13 Jun 2024 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718282430;
	bh=jpa7uXyQT9LKK7vRGulcO5ZphvoMO5zGFDVqTDzvICY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GfLjHSEwZChWnkMflzEVRkROvHEN512rJvej2kONPJwCxTBME6gV9OaQVCGJoIdKP
	 16MNSGO/pM1hRANIB1elI1+WfCr9JUAH/DyWibk44pflYSELFqRTKzsJd75/aKZuuY
	 PkkAXL4KgUkiwf97qUZvtNcHBiD0zovD4gk/FldU0VEBqiyIu6ZO/FHLc4ZrQzFlbQ
	 q+iDrn15kKJTHr382PmjR/rEgOX9Q9WcrwPCLfhR4C0TS0wT0CIGoZ5bHbi6uEoXCR
	 P43pxmLhvNjP9sxExn6YPoP8fql41uNI0rZWlrCghovnyRov6fx02PbWgX5J490pg2
	 kMZAFbt7ImQ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4936C43616;
	Thu, 13 Jun 2024 12:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171828243073.30018.3001493447683443532.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 12:40:30 +0000
References: <20240606145851.229116-1-vadfed@meta.com>
In-Reply-To: <20240606145851.229116-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 ast@kernel.org, mykolal@fb.com, kuba@kernel.org, martin.lau@linux.dev,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 6 Jun 2024 07:58:50 -0700 you wrote:
> Add special flag to validate that TC BPF program properly updates
> checksum information in skb.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v3 -> v4:
>  - use network header offset as starting point for checksum
>  - use folded checksum values to compare results
> v2 -> v3:
>  - remove BIT() macro from uapi bpf.h
>  - change error code to EBADMSG
> v1 -> v2:
>  - clean unused variable
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
    https://git.kernel.org/bpf/bpf-next/c/a3cfe84cca28
  - [bpf-next,v4,2/2] selftests: bpf: validate CHECKSUM_COMPLETE option
    https://git.kernel.org/bpf/bpf-next/c/041c1dc988fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



