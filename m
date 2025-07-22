Return-Path: <bpf+bounces-63972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B391BB0CECC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A32189ED2C
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E60487BF;
	Tue, 22 Jul 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa4cvVGz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28A1754B
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144789; cv=none; b=tVH7a8Q4jh/e91a3CRg9gzAvTlvL/0qGBq48yvDFjoZ0Sjeih1GlkDY4wsARaTRJiQoeNs629sX8MfBW2beP3ypMgYgwduAoYZoLVanocgCF5wk57HbS8TzlGa7RsSBzAO0yQO5pbu8PSeY/qEL+n1sVFJnE+rjSIH+uHwgQRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144789; c=relaxed/simple;
	bh=gBKj5gCCTDP6lOsq7BXZtQWF34xjBazIvHplSKMBSvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mf2S681yI4PnUwU3XyVVkXIzic6/E4eF5z1J51Nx7X8zN0JuGXzdX3+81x3yX5y918eATFI0FaSEhVg19j2kBgZa7uq6JNTOOubM6VcoNFwghJdhsmBNFUsvVhbpxor9fx0tEXxuNyS/rZMXLk/SFPleBJrtBQDGWYwaUfFNdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa4cvVGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A871C4CEED;
	Tue, 22 Jul 2025 00:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753144788;
	bh=gBKj5gCCTDP6lOsq7BXZtQWF34xjBazIvHplSKMBSvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oa4cvVGzQTnsntY1bxVBtHWNdQkqluLodIL1ZWVzVBeEEDFnfzpRgbBnwMRToXPW9
	 +3r4EhtvFjj5PbCa/uqQ6zEn7OZuP/Y/XXNlEZFhY3qxdpdgOguZTH+DxN8Hk50VdV
	 AoUIqWf/zhO/0XDImcT3d1cshHaTkRurAlHJ8NSF7Mex3Rsr+Km12YSq1coWMJUbPs
	 2PrXQ7/WAvRHbFtvhtArTi42hso3pBG3AKJyZx83fEM/e4iPylhG2QDmeYP50smAuD
	 lYIhLf3hGNv5PRtUnB0GIfJJ5lu8aHsSQsplqB6grZ89rMbCXpaB+o1oA63z/Y+XbM
	 eE/r0LWtKyDDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AEE383B267;
	Tue, 22 Jul 2025 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Use ERR_CAST instead of
 ERR_PTR(PTR_ERR(...))
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314480726.245816.293068238583127562.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:40:07 +0000
References: <20250720164754.3999140-1-yonghong.song@linux.dev>
In-Reply-To: <20250720164754.3999140-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun, 20 Jul 2025 09:47:54 -0700 you wrote:
> Intel linux test robot reported a warning that ERR_CAST can be used
> for error pointer casting instead of more-complicated/rarely-used
> ERR_PTR(PTR_ERR(...)) style.
> 
> There is no functionality change, but still let us replace two such
> instances as it improves consistency and readability.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
    https://git.kernel.org/bpf/bpf-next/c/95993dc3039e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



