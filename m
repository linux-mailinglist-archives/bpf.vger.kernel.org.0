Return-Path: <bpf+bounces-71963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4975C03052
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCDD9567E1C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283D26E71B;
	Thu, 23 Oct 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf6/1x6M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519E29408
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244232; cv=none; b=aX1nWuJ6Dqrhi2l7yxptGjE0ijIzjOY7/ebSj7OLiIAh+g+nRNdJ7TEFO61/Ki/3XYdudfboUxmxolbFLCaZuquWLf33oex2pkX4hp9NXq549ARxMIvzBsUuR6JASLviT0hzvz6DNXlsJf6MXVyl7CCSULJrhYzc/NxThSXimB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244232; c=relaxed/simple;
	bh=qVT2cHheyYCRZKDG9x8WDTGNLQBDe+aap/cTJ8W5B3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/LevjqhUfLrH69VWSOBTPyo0wOrYbMeNlMjAdDjDkuV0hEzc2G2GfDFGzXGHbIdzdCcpPS50rqPECqE06R2488MzwGWfu/f2QU8oQspme83KXJQkbVaSf+9eM4zg/xo1GyaZVYhGUqyIsbEPWEpKnnjfrmM22oVtPuv9CKt4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf6/1x6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606A0C4CEE7;
	Thu, 23 Oct 2025 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244232;
	bh=qVT2cHheyYCRZKDG9x8WDTGNLQBDe+aap/cTJ8W5B3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wf6/1x6Mzyo1Oz8tuUGTqlu5TPkIquoMMDpWVIklkFRyYgxPmYVLs+B+ZuKdrJ6eD
	 4szv49SN+jNj4O7F8fSdUw7W7Y6gavdAnhPO5CLVKa/qB9HhnMwr4mXeT1TCcdmBPz
	 GWgtWM/Vdmv8pe1NDKsODoNEJug43N/Nei0TA5MDdtIAKV+GR9kCpDTP9YSVSRTcYK
	 vWagcAhPVbkTQY6J1wzxHzcR7NSBya1zkCr0JpQ/JejuePWz5SszvRM/bigAABVsB4
	 2PU2Q5jlsHEc19P+cpBxof8WoOKGWiMcLdLnmrrHppy+20uQUGJuOpFIDNBzJmi/fu
	 eH4wIB323MB9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEED380A956;
	Thu, 23 Oct 2025 18:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix powerpc's stack register definition
 in
 bpf_tracing.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176124421252.3200573.3750075512025000623.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 18:30:12 +0000
References: <20251020203643.989467-1-andrii@kernel.org>
In-Reply-To: <20251020203643.989467-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, naveen@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Oct 2025 13:36:43 -0700 you wrote:
> retsnoop's build on powerpc (ppc64le) architecture ([0]) failed due to
> wrong definition of PT_REGS_SP() macro. Looking at powerpc's
> implementation of stack unwinding in perf_callchain_user_64() clearly
> shows that stack pointer register is gpr[1].
> 
> Fix libbpf's definition of __PT_SP_REG for powerpc to fix all this.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix powerpc's stack register definition in bpf_tracing.h
    https://git.kernel.org/bpf/bpf/c/7221b9caf84b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



