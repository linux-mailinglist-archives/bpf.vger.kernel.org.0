Return-Path: <bpf+bounces-29136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F78C0735
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62710281510
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED0132C37;
	Wed,  8 May 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk9ViNoo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00021373
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206230; cv=none; b=NZir3rdNaqVRYnFEm8D4mq5FiDSm9ZMfIAYIWq9fO3Ca/atwadFwem3mVhd7nxfluYb5wxVmqvL/XGtklSCiDQ25ZuX2g2XeAOygr5iyA8JWAJiBbq2b8ECpXdYhCbwaVcBwj0H4Y70F4WHK3Z2vVGi6TsUXmpYWT5qeKxFZuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206230; c=relaxed/simple;
	bh=Qnd9Nafpcy5kigH6dScu1p/UUtXRETHNBuiuhYc5qc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a1JRB//mNPyazdoND8cyhowxxNqGW+AafvKrZBwBq7MRsalWfae1tdRSfTZ+FU9qD8eL5TE+69/QZwjmyzzcAECjqvjgWQFjW5SzazccsDZdyzW9wnXpzerBPegUPue56LxmiQsZlA5mTn93rtI1ysewQk2Zy0WCRxMVAm0DVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk9ViNoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A31E2C2BD11;
	Wed,  8 May 2024 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715206229;
	bh=Qnd9Nafpcy5kigH6dScu1p/UUtXRETHNBuiuhYc5qc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pk9ViNooKP3MaicZJex5rIdgfTF+xIJvnN3gtW0SxRKE8PqEhBkorqzZ0kba/whMx
	 GP6ovZKWSbPG1QFC83MwBpUFYI34SqI1X4JStR+kcWcKEHoN1HuJdfhREnGOZeGZP/
	 vyBIIeJQ6XyQEW5M+3uUkoLLjtcN9VR863zlF+PolAEgyGVElViCOXxUH8q5BPKCaY
	 fJKbtCdu6WDxhb5eVlybPk1YofkyrsOHp9aQJSU9gR7JafxqsC9VOOeIM+ogvqT8Aj
	 OPhRNz0VV27Wrch0ySDL79Qb33uudfGN+XgB39ktCTpAJDs+tIy7wd4XTMAf2fcXFC
	 3pPSZb0hlVFPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E0D3C43332;
	Wed,  8 May 2024 22:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf: avoid uninitialized value in
 BPF_CORE_READ_BITFIELD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171520622957.7593.2662904887895439011.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 22:10:29 +0000
References: <20240508101313.16662-1-jose.marchesi@oracle.com>
In-Reply-To: <20240508101313.16662-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 eddyz87@gmail.com, yonghong.song@linux.dev, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  8 May 2024 12:13:13 +0200 you wrote:
> [Changes from V1:
>  - Use a default branch in the switch statement to initialize `val'.]
> 
> GCC warns that `val' may be used uninitialized in the
> BPF_CRE_READ_BITFIELD macro, defined in bpf_core_read.h as:
> 
> 	[...]
> 	unsigned long long val;						      \
> 	[...]								      \
> 	switch (__CORE_RELO(s, field, BYTE_SIZE)) {			      \
> 	case 1: val = *(const unsigned char *)p; break;			      \
> 	case 2: val = *(const unsigned short *)p; break;		      \
> 	case 4: val = *(const unsigned int *)p; break;			      \
> 	case 8: val = *(const unsigned long long *)p; break;		      \
>         }       							      \
> 	[...]
> 	val;								      \
> 	}								      \
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf: avoid uninitialized value in BPF_CORE_READ_BITFIELD
    https://git.kernel.org/bpf/bpf-next/c/009367099eb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



