Return-Path: <bpf+bounces-34579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850192EC32
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FAC1F21B91
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6841662FD;
	Thu, 11 Jul 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc1YuhhP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F1179AF;
	Thu, 11 Jul 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713631; cv=none; b=Coa/RhGMvyoebRTIcJ+MUdVK8giQ4Aiq2DaL/AeFjzt63RyySS8AqttngtAIOg5cWN4ahyb2YIgZq6ZfU9go47mjGSnZFDedsFOh5yVauOxzdejUjdGnbzpQJ9VPbVR2IHea5Qy+vz8JRoPhOJ7nSQQ588W6S7uHkA6gx9PD9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713631; c=relaxed/simple;
	bh=BHYCtrKDFbTriWSnWuFES4/RKdf0Hj7f+PdyDv5PYEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U8EQ1auYlKsgWJpdeopg/m+iJyg7suovPJFkeA83dNd4HvsnRdWQhX4MG9VAaL6Q0GQmrb2WuL7laSuomc3TtEDWiUVBNp86oDPnVt9xSXB1n0jdcCU37/Mxvhob3kuFK6pdHt8bYhuoE8MEZO9/b5r9tJu2JApPkuJqPZvAPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc1YuhhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51839C4AF07;
	Thu, 11 Jul 2024 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720713631;
	bh=BHYCtrKDFbTriWSnWuFES4/RKdf0Hj7f+PdyDv5PYEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hc1YuhhPUQSN3XJii8SEGASoc2W7yqf+j/4hs2xIoTF5ef8nTt2L+Xr77TSxfs9rn
	 3AXQRdZt8wrkUo04WOclw0AY9lxb4P7F+ZImLnBeLNKDMTUpgeB1And7uZaUgF+sqy
	 Z2kCxumlmMLQix0WKRNJSXSo/uzzHXUwhwWBiUrm4YKOH0moQUGMXdU2Z6mJU3POBT
	 OtdXpUUFMWxC1+0Ooi5PCjiRPl/6c0bjygJZyKPietZxhK+TsgRGHqwMsqKDpBpuJ5
	 aL5wNslJSMmcePjQSUjcPgSqBKHInUkxZDHDWS4TnMEQPLOq3CUhyk5iAoZg9wJ+ui
	 dp3VXhATJt2bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 378D6C43468;
	Thu, 11 Jul 2024 16:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, arm64: fix trampoline for BPF_TRAMP_F_CALL_ORIG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172071363122.25248.13927897511832402439.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 16:00:31 +0000
References: <20240711151838.43469-1-puranjay@kernel.org>
In-Reply-To: <20240711151838.43469-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay12@gmail.com,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 jean-philippe@linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 Jul 2024 15:18:38 +0000 you wrote:
> When BPF_TRAMP_F_CALL_ORIG is set, the trampoline calls
> __bpf_tramp_enter() and __bpf_tramp_exit() functions, passing them the
> struct bpf_tramp_image *im pointer as an argument in R0.
> 
> The trampoline generation code uses emit_addr_mov_i64() to emit
> instructions for moving the bpf_tramp_image address into R0, but
> emit_addr_mov_i64() assumes the address to be in the vmalloc() space and
> uses only 48 bits. Because bpf_tramp_image is allocated using kzalloc(),
> its address can use more than 48-bits, in this case the trampoline
> will pass an invalid address to __bpf_tramp_enter/exit() causing a
> kernel crash.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, arm64: fix trampoline for BPF_TRAMP_F_CALL_ORIG
    https://git.kernel.org/bpf/bpf-next/c/19d3c179a377

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



