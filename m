Return-Path: <bpf+bounces-51999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9825A3CCE1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAEC18988A7
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12DA25E451;
	Wed, 19 Feb 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT+ft3iL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8E25D555;
	Wed, 19 Feb 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006001; cv=none; b=uKoopbG6EKJMMcyCLhzEwMFnsqjDtZ53Um/5zuZh+KLtHBvq+/Dh1AuL4TajzD1RUw8KNHkzBGaJP24pmqHMDBMT92JUNntKDnd9WzGEMIBheEjmAXN5yz4X19zBuzyL6twSfSLUhVFIpzf4sB7Lcet2jj91LjN8SqltOMB6k8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006001; c=relaxed/simple;
	bh=Avixi87/yUvx+vB5Nk9euMakPds3svx9rpHC3tSzvek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KRi/1SUrgJx6vVoj4KWXeOI2zmTGcAiy7kBMxH85hsndLZaxJUO6LoNJgFrsQ6T4PrLW2F1F1uS4dPZ0NIxRJZ1GXLjzjPtLjAF5G5Hw3KK1HpqLLpYC3G3golqcZM2pG4Dxseza6Ynx58Lpty50KcS8eHUpsIGF5aAMYtdzRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT+ft3iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8380C4CEE0;
	Wed, 19 Feb 2025 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006000;
	bh=Avixi87/yUvx+vB5Nk9euMakPds3svx9rpHC3tSzvek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gT+ft3iLRCKHnOxgb4+TqS+HaBofMO943Lft75JgqO9u1+LUmOBgsPeA/8qWOmGWR
	 g9G4tdUefzFzoaVDRk99mgJYGtl2DqskhhHaeHLV9F1nbhtUOv/Xvr+JB0bBbG59Ji
	 2HsKEroDQJPMb+lTVFtt4IcgkS9k8vP1XLjkoxIOuJJR2715GigH1ILMMkUAry8cG9
	 gWC7Lod3Uev5pOVvzsz70Qyx9YqKeKrC4UhauNBpEXlGxMMLlEHIcC3dz/7K0iS0ja
	 6MEWQr380RJT0cKyqr6n6L5u42n5Mxocnqc78YrZU84AatZKDhI50K9buRQ18lo7xn
	 mzvK9YKuuXk2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE374380AAEC;
	Wed, 19 Feb 2025 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Wrap libbpf API direct err with
 libbpf_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174000603155.775571.10326164542234873495.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 23:00:31 +0000
References: <20250219153711.29651-1-chen.dylane@linux.dev>
In-Reply-To: <20250219153711.29651-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chen.dylane@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Feb 2025 23:37:11 +0800 you wrote:
> From: Tao Chen <chen.dylane@gmail.com>
> 
> Just wrap the direct err with libbpf_err, keep consistency
> with other APIs.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Wrap libbpf API direct err with libbpf_err
    https://git.kernel.org/bpf/bpf-next/c/e8af068239ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



