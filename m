Return-Path: <bpf+bounces-37863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F1395B657
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095081F279EE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E761CB319;
	Thu, 22 Aug 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgCsmfHu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AC1CB15D;
	Thu, 22 Aug 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332831; cv=none; b=mtvokaHOYCN35bOn3kDFIIFiYPvSN0OBnrfrlw++iMVrSlkpXu5O25+q+ltY5OTjhZNu4KUIug0ETX92AynnnNzK3T4KYwPTFnojn5SWIjO+b9aMMJhZPuEl2gwLl1OvMMlDxTV+ItGT1biBvGa+JKxOpTqoVXzpuT5IpLa1jwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332831; c=relaxed/simple;
	bh=vMGDKyKgTABlktGrPfHcQEmrwb//c3+aabEAxJlJ2hc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCccaH3h9uI22a7uw9aNMv8D5flFSFqe6w4F1W/74QyR66ps5Wcu9x/HrtKKWRNH855SbgHRsviC29yHr9HkadpXhF5M/Wkc0R9Ii+1PSr4tEm4EjWZ6Cm3+/uLoSkBLBbADBuzTCk6ANTpsmX7gHEfimzm0v1lNhUIGgIMTc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgCsmfHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E465C32782;
	Thu, 22 Aug 2024 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724332831;
	bh=vMGDKyKgTABlktGrPfHcQEmrwb//c3+aabEAxJlJ2hc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lgCsmfHuhajVtMUi8wgh16/WWNEh1I9H6ZDiNUWOkIf2tAV9hhqd7RLv9V7+fu5WA
	 jVm+jd9P8XSwmXwbPhBo6no7wpWJULUw33bpZ/q6Nlw7CO7/2r2GbTTqDF5G14Ii2z
	 oLcKczifK5th6WF7zTlxmDnDI84RZEN2Wa1m241sLcA5YvhjLfxnUy2GaGf32k+gAs
	 RqtsCbf+2qDLJqIiUSzcpANYOp5/FeEUZiEXO1TcrJ/8VeqUVb6AwUZQsEsczHnMv3
	 ucODypVboZe30Mywfpojgfrl7iGs8BFzuf5dyuBoKm+rfoo/8y8RA3jBiro0r97XoU
	 KZAn2TujLUvAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D693809A80;
	Thu, 22 Aug 2024 13:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] nfp: bpf: Use kmemdup_array instead of kmemdup for
 multiple allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172433283102.2321073.9798465617228049100.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 13:20:31 +0000
References: <20240821081447.12430-1-yujiaoliang@vivo.com>
In-Reply-To: <20240821081447.12430-1-yujiaoliang@vivo.com>
To: =?utf-8?b?5LqO5L286ImvIDx5dWppYW9saWFuZ0B2aXZvLmNvbT4=?=@codeaurora.org
Cc: kuba@kernel.org, louis.peens@corigine.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Aug 2024 16:14:45 +0800 you wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  drivers/net/ethernet/netronome/nfp/bpf/jit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v1] nfp: bpf: Use kmemdup_array instead of kmemdup for multiple allocation
    https://git.kernel.org/netdev/net-next/c/d6f75d86aa78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



