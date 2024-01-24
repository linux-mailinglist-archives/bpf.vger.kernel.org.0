Return-Path: <bpf+bounces-20152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE70839D79
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978DD1F24EE9
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCB16419;
	Wed, 24 Jan 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uug/KwRH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DCED8
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054426; cv=none; b=LTFG1BZr+la4LKgk+rMri/F7I1vlgzJ9QjgoveQPc1wr9d+KTV20q9icVG3FvGovGCJjL6XFG+AKVMroSSUgMEyx4zxMIQ2xTk91vPyaMTkxb5lI0eoBBPDhYfYTBNPMUJ22GpPOGLWIQQeNN7s13GGWT198cUwE6FibBTwDoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054426; c=relaxed/simple;
	bh=C0IZqdTGUgvF1F5EuCVFMemrmu88cczHhR171RplgYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CA6tqjb2x1sGIG5ggz7YFuNb1TVuYaqR0btn3oMhA6CUHtY+GLHfSwJ+mQWGy9TuQALkfi7XVuQWhhj/I6RCJ+C9Qyz9/uS0/xxz0UfvAiQnzMNKyiE/SzWJt4dikpBEFVD2A+oXTThbuCOKrtHZwkjK31av9MbvkfOTMU3/muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uug/KwRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D11EC433A6;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706054426;
	bh=C0IZqdTGUgvF1F5EuCVFMemrmu88cczHhR171RplgYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uug/KwRHrDgYRXxeGLCUhFD4nz4yufl+P7arcz/PIn372FgC0MJH5VcD3AHX3c5bu
	 BU3Mxkw3jLmgeD7Mc9TVqxBEK6MEf6Tk+BJeiss9Zvoep7Wh2gjimlhnD9p6WHF+Ly
	 NfnnUi9SoOjOZAHvcFAJEl1ENsIgaXIBhFJnLJndQntVK4ZU35RVbdoffUZO6sudyF
	 FGcjM8HEn41FURpS5aDdfslvTpZFzoxX8oG4se+qvWYItkIvSTO4WTYnSDOrGNsGMU
	 Qr0VKROfPPU87pOwJB7AlGK7YcFx2eFdsqPzUJpm9gc8BzjCWBX7MftKpzlCs605FF
	 7049TrnM+nIig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 143C3DFF767;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: avoid VLAs in progs/test_xdp_dynptr.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605442607.2408.8094664709925991530.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 00:00:26 +0000
References: <20240123201729.16173-1-jose.marchesi@oracle.com>
In-Reply-To: <20240123201729.16173-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yhs@meta.com, eddyz87@gmail.com,
 david.faust@oracle.com, cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jan 2024 21:17:29 +0100 you wrote:
> VLAs are not supported by either the BPF port of clang nor GCC.  The
> selftest test_xdp_dynptr.c contains the following code:
> 
>   const size_t tcphdr_sz = sizeof(struct tcphdr);
>   const size_t udphdr_sz = sizeof(struct udphdr);
>   const size_t ethhdr_sz = sizeof(struct ethhdr);
>   const size_t iphdr_sz = sizeof(struct iphdr);
>   const size_t ipv6hdr_sz = sizeof(struct ipv6hdr);
> 
> [...]

Here is the summary with links:
  - bpf: avoid VLAs in progs/test_xdp_dynptr.c
    https://git.kernel.org/bpf/bpf-next/c/edb799035dd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



