Return-Path: <bpf+bounces-67460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F033B44259
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D1B178BCC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AD308F1E;
	Thu,  4 Sep 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkyvsP1T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB312F39AC
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002216; cv=none; b=KwUrYjmedpJy57kDHc9+hzxJU7wt1oX+J0xqnqGNDKjSoqIzTNRKP9fHXRZGF9J85cPiyvvd2ZebxzOzVIXmV/nWoH4g/SA9pgptRbveryIIpgC5MdH/kt/FcI1bv+QUYuGCk0t+MZqtyFWgZbVZHFDAQ0Um4Q9bk67pBoq7wVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002216; c=relaxed/simple;
	bh=PzJf2eFa7XlRq3jnc0qsRIT1FskvmfH515OKy6ak/hA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dxorn3L/zQ6E3ghHVtl3N1XnPABiuHN5YxzZTFANSzuB3mnVXBHRc0wQpGLV3JvVqz1lroNupDxqwN4Scx21Dtu4AL+rYboA+2oaJRXM6LRzbqmdw4nxwrMnA6ktvuSZlrtjJgnsc8NKEWTE0/UUO3T6MxfxwOuhHm7dYDOikXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkyvsP1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5591CC4CEF6;
	Thu,  4 Sep 2025 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002214;
	bh=PzJf2eFa7XlRq3jnc0qsRIT1FskvmfH515OKy6ak/hA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QkyvsP1ThN3CFuSVYUZvkQY0ujldyuZYpKXQ8fHsAp9TqnLDIQ+AWmuse7yxTz58L
	 zI5jwNXN0TDfy/1M3IBz9erIOt5Yy6tC1ZVfZakSWHgs4ZD5511/lvpKV0JrmgzaI4
	 xRp1N654PiRk0gYCcC9+3XL4xOWBnkCOuUrZGDRcYJ5X9uVq85omwGDi8NXDW45O7A
	 RubmQuXlu+4MvoBs7Aadou0P4eXyv8kZEIsziHmdYyh0iWHVITwyZ/EjrtqZRTbnAn
	 4bk/nvmSge2GjhlT7oSThgMbEPzUMPlJVHF4kwgOHaHQRu7V+etzit+E7Jt3NOm7nb
	 87YSL5if3yGgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71633383BF69;
	Thu,  4 Sep 2025 16:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, arm64: Remove duplicated bpf_flush_icache()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175700221901.1866840.15658662229710428210.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:10:19 +0000
References: <20250904075703.49404-1-hengqi.chen@gmail.com>
In-Reply-To: <20250904075703.49404-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, puranjay@kernel.org, xukuohai@huaweicloud.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Sep 2025 07:57:03 +0000 you wrote:
> The bpf_flush_icache() is done by bpf_arch_text_copy() already.
> Remove the duplicated one in arch_prepare_bpf_trampoline().
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, arm64: Remove duplicated bpf_flush_icache()
    https://git.kernel.org/bpf/bpf-next/c/929adf8838f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



