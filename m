Return-Path: <bpf+bounces-28175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C08B6497
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF73B209AF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25122184117;
	Mon, 29 Apr 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwkuspYG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAED184111
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426231; cv=none; b=hgOVXRicp3U9B1uybzWdbqyty93L0LqsnKMCA/xwVMlE9PftMPWCEWYCCLNbgIephAj5idq9wwdAL5NnSyjsf5vA1aYI6csU1ykq/tOE00Lj0jDTh/NZytxnE3Ji2lFBSrxQHbiJwhWfKcXUde0gb+iC5nx7RahCUsNY4f9R5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426231; c=relaxed/simple;
	bh=fT3eBOYsbKUZDm3yY8elfrDfGr6/NA8ZHYcRdzIFWig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J+UhJ5HIs8GJ0TE35e9WcC6V05zkRxRh9vQc9YP//mejdiGtretfuCoUaFtXEMbdVUIoJDAm31ROb3ayc/r1VcfvBqghL8GJG1A4OdBqMUCxMMSUJWzjjJQWvzFJzM7oFsFvqShZq/zlUE+2WPFUQTH5PNJJjRsxrJoBGGrA4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwkuspYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 639F2C113CD;
	Mon, 29 Apr 2024 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714426230;
	bh=fT3eBOYsbKUZDm3yY8elfrDfGr6/NA8ZHYcRdzIFWig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XwkuspYGFdpqW4n6kNK5zcmM+8Td4KJy8FYyxwKUXL/vQRa4kH5w/aRJ+aKkdfqZe
	 3zdgM7dV1MWm14TbCZK5XV5gH2hCoBSf7nGllKCeH65SbMdG8jLRMaoRlx+6ZSx3Xf
	 7O20LPNAqadAUtBLJqK+3FLHZ3WGUCjuNg8v4E25pF9rzAqQLz+RluB99ShPU4ddDq
	 cS9va0cZf/dzBeVMubLdKbreuHbU/mUn4+upaadKg0k8l3Ain67YR9ogj8fDiB5IBF
	 qF1p17OSU4qUTNKg4g0oli0A7WXN4y00wO9X8rxXXo39p4l1Bt2vsEUFi/eh5R8SCi
	 f/c78i7LSrCHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5201EC54BA4;
	Mon, 29 Apr 2024 21:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Fix verifier assumptions about socket->sk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171442623033.6230.12112644479266922233.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 21:30:30 +0000
References: <20240427002544.68803-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240427002544.68803-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 liamwisehart@meta.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 26 Apr 2024 17:25:44 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The verifier assumes that 'sk' field in 'struct socket' is valid
> and non-NULL when 'socket' pointer itself is trusted and non-NULL.
> That may not be the case when socket was just created and
> passed to LSM socket_accept hook.
> Fix this verifier assumption and adjust tests.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Fix verifier assumptions about socket->sk
    https://git.kernel.org/bpf/bpf-next/c/0db63c0b86e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



