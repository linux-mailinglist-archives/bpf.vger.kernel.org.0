Return-Path: <bpf+bounces-70632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482ABC7106
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 03:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3F854EEBED
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 01:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347101C3027;
	Thu,  9 Oct 2025 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8qUEJcO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6661AF4D5
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972031; cv=none; b=fJ/lf7PrVpZa1v9UH8fkOsKel3xv9FEeTwznF551N5npy1wG3lKxxokRzyj/1VQZARobkJxOsczEaJd6DJJh5ogenlEtWM/j0rfDnI2BsmKxC80Pgpfs1N3+vlugWJI5jQXzQfpjozepchKLRme11yodxZcPwz3KQEh2PP0RHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972031; c=relaxed/simple;
	bh=gUKpBW4KllJ8CoUkDtY+/1hxh/FTHD8ZfTIsKaPto2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5lrfByC2uP2qfgs8FDg2RS1NyNV/mLSRE/fMftbp4qWoSudQFtUQOJFCm9seauKxDYmNgKDkOpQOZkzHfHP1DJTb4YGaWWERP6v9PiIl2+fRBxDPauLd0GriuTwrN7EdzvXlQt7mZ6Jq4p+VBW9tFRlSJ5l+7VzIIqNsQeDtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8qUEJcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE13C4CEE7;
	Thu,  9 Oct 2025 01:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972031;
	bh=gUKpBW4KllJ8CoUkDtY+/1hxh/FTHD8ZfTIsKaPto2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8qUEJcO3jnEk4AEiYY28zdkpGDHV2VM+kWqnOwRmihbEk2CYz5+e5Gj6nxa0V1Wj
	 +6A3gj010/mMOlreXhP8GxlsFMxpVKEVQ0p3rHmtpC3g6+KpJerMpVJ5atk3851f70
	 y8vgKiNpAH6aj8xqCZJ7s3fRcuioMBsh1BE0I5zxo2xTjp2G65rhAROGRSxX9SHPuc
	 B4aR9UUmuxVKZ0klrFsM8By0HwnJqa/pA1saKNT4NMKb14RHQcsCdpJsPFWOFnpMS7
	 OzxzB42kdW7kqCrEFuyJaQWDQOHRIhb7ME6vA6yu4efvIXfq5c3b2cd4Rf+KT4SLkB
	 cKuDtu4wGX3jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1F3A41017;
	Thu,  9 Oct 2025 01:07:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv, bpf: Remove duplicated bpf_flush_icache()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997201975.3661959.14473142112064760286.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:06:59 +0000
References: <20250904105119.21861-1-hengqi.chen@gmail.com>
In-Reply-To: <20250904105119.21861-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: linux-riscv@lists.infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Sep 2025 10:51:18 +0000 you wrote:
> The bpf_flush_icache() is done by bpf_arch_text_copy() already.
> Remove the duplicated one in arch_prepare_bpf_trampoline().
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] riscv, bpf: Remove duplicated bpf_flush_icache()
    https://git.kernel.org/riscv/c/6798668ab195

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



