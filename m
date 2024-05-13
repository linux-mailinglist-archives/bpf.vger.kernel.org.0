Return-Path: <bpf+bounces-29607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD28C397A
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F82281391
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C7E5914C;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG8pl/OO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09A101CA
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715558430; cv=none; b=QqLLpWx9crd3Lu+VV8JmQl4/qWDbiC6xkpo0+X5H5NSFZHXoIrtffKD8KLlGIpeRmki5cSUGLd3h1gH8rgSc9n0lda9u7EEVFJtqZeDasm7Fj4MS5/YOZYIdGOQpnHkcEg32qptiu5jKNOgveQPrvuytzzNPwYX5hLbK6lQP1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715558430; c=relaxed/simple;
	bh=Ac7deBypVTjZbqSL/noIFbQe1zlip1Qlx3oo2hzHumQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qn+kR+dC//tLbHO3h9r4X+iL4Y0CszyZOlwGhklvGdMEloQlUbgY8+EhF1Lf4aLW7/g03NmyJ7SGAp2owwt2Kc5Q+bxH1ESoKvVEugBLPCjyFIZfdmC6y9x4VGARt6033Nypufvpev7M8NIsKKx37hMvy42uCnPXH5+4kQ2lcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG8pl/OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1A32C32783;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715558429;
	bh=Ac7deBypVTjZbqSL/noIFbQe1zlip1Qlx3oo2hzHumQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jG8pl/OOo4Zq3316iaMvewYn9kigB5PXabuBwe8F6f3v9I++6uJiVnLLDIAKDRcBU
	 guQHCjk/+kQc5IbQ6kFE9vHlz5sR0tVCvaHMMgRLP8SJizm/DZ/WU3d/5Qzg4GFEbU
	 VMkdC8r+OdBcpKx+XI0V/PgyPV9XR7Jk245pa/nnczL24o6j7gqxgRydycsYOd+zr0
	 rMkBj0DlqCTuVnNwp6NZcQmu6mfgChYTN6vlvV+gzkSmiP9SxpqKiwxmfktnR6lnxh
	 Aa/KWN/Ybcpc3E5vWqUjA2S9xFdEy/yoRfWrKHjjJftGdDZ2RCpyaag2A8nrC+9ppZ
	 97pDK5Kfuusvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD5E7C4333D;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] ARC: Add eBPF JIT support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555842983.18024.4891712787415544525.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:00:29 +0000
References: <20240430145604.38592-1-list+bpf@vahedi.org>
In-Reply-To: <20240430145604.38592-1-list+bpf@vahedi.org>
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: bpf@vger.kernel.org, shahab@synopsys.com, vgupta@kernel.org,
 bjorn@kernel.org, linux-snps-arc@lists.infradead.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 30 Apr 2024 16:56:04 +0200 you wrote:
> From: Shahab Vahedi <shahab@synopsys.com>
> 
> This will add eBPF JIT support to the 32-bit ARCv2 processors. The
> implementation is qualified by running the BPF tests on a Synopsys HSDK
> board with "ARC HS38 v2.1c at 500 MHz" as the 4-core CPU.
> 
> The test_bpf.ko reports 2-10 fold improvements in execution time of its
> tests. For instance:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] ARC: Add eBPF JIT support
    https://git.kernel.org/bpf/bpf-next/c/f122668ddcce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



