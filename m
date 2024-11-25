Return-Path: <bpf+bounces-45600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3459D8EA3
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E5F16948C
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D951CDA0B;
	Mon, 25 Nov 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in2Kdznx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A01CB31D;
	Mon, 25 Nov 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574419; cv=none; b=ZGQzK1+6uSbumMB5ooVZLlx3wv1mokGlBckXZSA7zlJwW1u06DmWWmQu8NvgrnSKKQBPU7JJO4gIz78m0MoAEvB0qyWycJuR9KoaHAy32tiMh7wN5awQ2fDSFDHit3WnrQK0rYPRe51KmCvEZrp3FLa4aUYDR5G9CqdDojS5bDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574419; c=relaxed/simple;
	bh=0W8JUcm1y/ERLrvqP4EByaRIr4XHlEH9thdJboWFXnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FuZIr1OmluC+5hoeBZ1voHhji9fGe2L2DLUtQznPAwL354cXuBjMG3bpbBIDN/GK5Vud0rFltBFZqLVcqc1kfTFq5YYbtuNK1SMG9/6HEuBsTJrRoiMIBo4B/MFK3oL13ArCamcGCNz/0CH6kiXkSMRHMoguRehBV5RcX1EvVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in2Kdznx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464EEC4CECE;
	Mon, 25 Nov 2024 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732574418;
	bh=0W8JUcm1y/ERLrvqP4EByaRIr4XHlEH9thdJboWFXnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=in2Kdznxf0ZPNUJEmEXXoQRFHai4v8YpCz1LL1oD6w7HL5ZGVJ99mhkSmsBdY/FVU
	 UWRgh6VCAxOEO0jYFsF58TvZhqajeDEqQXlbNBzkEl7MXuLICwipaJYmjr7gua8wpt
	 003UFEbmHgN90tYSOnYDxSRMuyGXBq1eDuudW4c259ZiHU/fRcAHl4IGTm7JDARF9r
	 wXpblhyx6JRkc66840koCN3QcdpT+/sI19Sp5ORm2Ibb72ifX6l/lp6u//PvH2EqhQ
	 l1klIjtDN1Ybe336nsaRkviPA+FqMLyO8aP4xzAQpadEs6VYYhYrzJM7sKeuEuVL50
	 tH1NMunPDXL+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7C3809A00;
	Mon, 25 Nov 2024 22:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: Remove unused variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257443102.4061252.12313181880297794372.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:40:31 +0000
References: <20241120032241.5657-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241120032241.5657-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: martin.lau@linux.dev, song@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Nov 2024 19:22:41 -0800 you wrote:
> The variable is never referenced in the code, just remove it
> that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  samples/bpf/xdp2skb_meta_kern.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - samples/bpf: Remove unused variable
    https://git.kernel.org/bpf/bpf-next/c/27802ca14cae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



