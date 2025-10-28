Return-Path: <bpf+bounces-72470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11639C1278C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92EC58211C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779B23D2B1;
	Tue, 28 Oct 2025 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzgdYC84"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9113AD1C;
	Tue, 28 Oct 2025 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612701; cv=none; b=HiN6QqZ3wgY8d14eSBo/rscVDFgMIkvbj834mm+ySb2lz8AumSAJ4eAvLgjIily3T0eDnBBsoqmoMKT6WUjENOczh73yJU/3l2bhKwTKX28X+/p6rzUQa0cdVYitDMX/zRPh/awZnieg2XeB2PgBMui9awDWdB1wz+y/8fLYzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612701; c=relaxed/simple;
	bh=B3wQzMLbOhQRfaLAzldS6M7Qq4VdvWa8daZ/dTvVZww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hFSyRcgHRx+SedeMbj+0T4aCT1qhyfAISKEgwhwHaye7IYn/YIRBdKzbG9znhAxPjh/g0PGQYReOR9+S2WC3UiYmFiNkg/bjgFlw7lSZ5cgJhrNDhB50KeeKc25x98OZSyiz6GLFeRaU8AAiH/i8UjbtRtVKEi/ffB3AAwUPQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzgdYC84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36248C4CEF1;
	Tue, 28 Oct 2025 00:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761612701;
	bh=B3wQzMLbOhQRfaLAzldS6M7Qq4VdvWa8daZ/dTvVZww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BzgdYC84a6TWOsj1DTaLwaIkUE8gRYDjfUFbC+iMX9kGeZ9BLihTowzVTdIZbGN0C
	 ujp3Rt+NvmqNpUpHcgaJLK6tFVg5p2i2cTPJJPKFJ1KBs4ZfNdQHRnUJjCUuj8WVcI
	 Ot887XDYhmMjkbV9G2xLJqzSu5jWxf6GrTmzDP+Hjl7jBPJrc20c/NGFMDpuqQfPBQ
	 lFwMq8666c6aQ7ux1s43ckyLoCbQIGWV2+15NUkdgOJH7+7tj+kT2pIfoQUveZkmw1
	 xQsRWf6s3SetPnqtA9RExaZ1i+5fFiw4pp6FmLjdssDzRbN1Uq4Vj/NOpcgHHYtY3N
	 VanS64g6u51EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CAF39D60BB;
	Tue, 28 Oct 2025 00:51:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix memory leak in module_frob_arch_sections()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176161267924.1638595.1882870898016863299.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 00:51:19 +0000
References: <20251026091912.39727-1-linmq006@gmail.com>
In-Reply-To: <20251026091912.39727-1-linmq006@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, samuel.holland@sifive.com,
 ajones@ventanamicro.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Sun, 26 Oct 2025 17:19:08 +0800 you wrote:
> The current code directly overwrites the scratch pointer with the
> return value of kvrealloc(). If kvrealloc() fails and returns NULL,
> the original buffer becomes unreachable, causing a memory leak.
> 
> Fix this by using a temporary variable to store kvrealloc()'s return
> value and only update the scratch pointer on success.
> 
> [...]

Here is the summary with links:
  - riscv: Fix memory leak in module_frob_arch_sections()
    https://git.kernel.org/riscv/c/c42458fcf54b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



