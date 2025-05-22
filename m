Return-Path: <bpf+bounces-58731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7AAC1045
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3629A26CF4
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80813299AA8;
	Thu, 22 May 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLMccfVt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA728A402
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928999; cv=none; b=M9Ru1I+xqYVdh6Ix7F6j3TrqXhw+GGS5xIKSPFMsMnfSOez9KA3pvGZhKVBfvHexI1zQ7/uP2EJEEpAzh+nenkltWm8hdeFWRpOzFVonkNMDPzBfQ7MFNSAB7Ak/8FB1s/kTIOHkIXhibaE21gZx0Bk4gzic6KGRpFGeKd4LgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928999; c=relaxed/simple;
	bh=pbdHkRnhGLEaN+f6Q/vHdNUhMCqPP76X63OR3l33ekI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vA379FiWHLT031ihxwjTujsZimEzhSwDnmMq2Ob9dKf+MqsV5nWaWGgDk3jGks/ISF++mPYJ2oIduQT3gRLRy9hayJ4Z3CZO5W0NXXWpAeH9CqFkFNpHMxTM1/kVgj8zkNCca4W0uztXnhDm7IaaTPl92LmPK3Sal1bsaL3gnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLMccfVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A355C4CEE4;
	Thu, 22 May 2025 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747928998;
	bh=pbdHkRnhGLEaN+f6Q/vHdNUhMCqPP76X63OR3l33ekI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLMccfVtsapn2XfQuC/asE/cUTB+0ZYJN7UdxRsr3olcliNLtSyraul5OnBPr2w92
	 I9G5Pr/HNv4ehGS/agaA/oDJqImZX9R4iEEP/RLfZQqIJOqBBwZP8P+Lm6aSSFD8gr
	 kaSJ0aG9q62cFqwhFzaqGa8U5tWUrIKW71izywVhgZkmgq7xlvRJLnlzrDHB979usp
	 0kOIy0s+LMwQctd4T52AZ5SmST4MoNA5HB73/4sZyWt/Yp4d35EpLmH6okBt0XwLub
	 MSDaf3reG3YYKjeWlULUn2SsSWF6EFQQQvBYvnLyJ6TcH5112UyunvnhQFLQl+jDuy
	 K1MgC5eU8LTTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA53805D89;
	Thu, 22 May 2025 15:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] s390/bpf: Use kernel's expoline thunks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174792903400.2925590.5659251830068951044.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 15:50:34 +0000
References: <20250519223646.66382-1-iii@linux.ibm.com>
In-Reply-To: <20250519223646.66382-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 May 2025 23:30:03 +0100 you wrote:
> Hi,
> 
> This series simplifies the s390 JIT by replacing the generation of
> expolines (Spectre mitigation) with using the ones from the kernel
> text. This is possible thanks to the V!=R s390 kernel rework.
> Patch 1 is a small prerequisite for arch/s390 that I would like to
> get in via the BPF tree. It has Heiko's Acked-by.
> Patches 2 and 3 are the implementation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] s390: always declare expoline thunks
    https://git.kernel.org/bpf/bpf-next/c/f7562001c8b8
  - [bpf-next,2/3] s390/bpf: Add macros for calling external functions
    https://git.kernel.org/bpf/bpf-next/c/9053ba042fc7
  - [bpf-next,3/3] s390/bpf: Use kernel's expoline thunks
    https://git.kernel.org/bpf/bpf-next/c/7f332f9fe9d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



