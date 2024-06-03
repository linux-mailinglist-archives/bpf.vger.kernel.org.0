Return-Path: <bpf+bounces-31208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B78D85CB
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2738B238E5
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E7130A73;
	Mon,  3 Jun 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EACXZVwm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2212FF73;
	Mon,  3 Jun 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427429; cv=none; b=f+4A7kLKiEAx8fKDVLK527fHobiDq/0Vkr/QB95/XA/Ctq+s3jwcwC/5982pS5T4JU6MwLKF2jT2UuPEqTxdiuLucLbn3j3ZAl81QWCRJ4HxLUgNW4E9A642+23QwAW9+7NA0md0g8fSiYAsDyMDpi8QbjFv92hM5Q7ADjlAoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427429; c=relaxed/simple;
	bh=rNBDGAVUSqxZbk8Bj4sgiaMLerDh+0JJ9wWeRX3afuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gWNa9zZcNaP8vXpu9/ja9N9eb20B7geMjNNvRmzP18vsNnxA5ywnSl6cJyyEA5s4DwHO2ecpTUXwQTSfTUMg7k/4oc+5wgsgWG4U6Oxd5/5fg2XdXpqdCiLLG/E4K+PlsgRILS9SGth1FjDbKtyh5yKmECCFs+QSkcp2H01q3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EACXZVwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB2A2C4AF12;
	Mon,  3 Jun 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717427429;
	bh=rNBDGAVUSqxZbk8Bj4sgiaMLerDh+0JJ9wWeRX3afuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EACXZVwmhKooPq6AETvauDSxLa2IxFk2MFzuSMjLsANHLJJceMfW0ogqWmfgJk/nu
	 LoVS/5NSKLpXyVSkMklriWC58FEwDN64sKxAGN5XlCY81SescN7nDqLULs/ONfQumc
	 9taULNjKdb5MuNXFY/dynuyL0MgfCoFvdvdftNT9FOq2VWjrIaRrUmr/LC4rWxrWwW
	 2Ag5cppUalG2omP6wmu5loh19FQU/09xDzWYmwvVUc1oG80b0Tgj8O1ej0PkkVoWnP
	 baLKAP7psEbwV4HYdACakR9ybdxyaSkowciUIYt/zgkNqeYA7Gxbnw8Bb18yMRNKwy
	 GNyy0Vv4SDQDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0671C32766;
	Mon,  3 Jun 2024 15:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] test_bpf: add missing MODULE_DESCRIPTION()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171742742891.507.1892910666937536494.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 15:10:28 +0000
References: <20240531-md-lib-test_bpf-v1-1-868e4bd2f9ed@quicinc.com>
In-Reply-To: <20240531-md-lib-test_bpf-v1-1-868e4bd2f9ed@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 31 May 2024 09:28:43 -0700 you wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bpf.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - test_bpf: add missing MODULE_DESCRIPTION()
    https://git.kernel.org/bpf/bpf-next/c/ec1249d32781

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



