Return-Path: <bpf+bounces-38454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0E964EF1
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B6C1C21524
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B01B86F2;
	Thu, 29 Aug 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP4+ZW7H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C947A76
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959827; cv=none; b=OAnKmc7Zmm3XCHMo0bhyv7lLqdpWfw/o/MV0956q46vteRlY9uj4finPpu5Ihqf99TddcVGWlroln1zTAFn6K9cVd5RpEZ3nBQJArnWfQVZZQrCYOVeFjWdLCzhJEshU5T2ToiQacoFPfgwoWG4DfP6rKiZTDOMPHB3dhqCEIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959827; c=relaxed/simple;
	bh=deYGVDbsLfRN8UhqqNS48phgkNv2fJwNEfgF6ka2w7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k/g2i4fewW8g9BGP9K5o6Cw7QVbNCRRziep6zRwNKHxqHwilKO//E4FUJ3bxQYLy1JqcjgB5vm/S0WRnr53vWdgDTIoYPnGMWF6F2Uc3/NCvQCOeFlOeEw0eghLk2In2PtSTu/K0SKyYVqBlIuHdItirPOWPFVKtAi64qKvG2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP4+ZW7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61657C4CEC5;
	Thu, 29 Aug 2024 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959827;
	bh=deYGVDbsLfRN8UhqqNS48phgkNv2fJwNEfgF6ka2w7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DP4+ZW7Hd+06nkgBs/8VnXLdtqLXI+y1bpZUfWH+3RnnNt3PbVpceVIoswTSivDp1
	 3Ey5FrAfsPbb1BZDOPaBT4dwfkRjp6cbchVgmcmzefy19vlXVFHaqZA3Srn91dqVfV
	 QlIpdYCWSbADvDXPQ/RCga6uf03ZkyhFlu6XRjFVJJ+U0SuDaaob+JT+5nQSaHGve5
	 nshjmi2tPVK8UHum6uucZPKFzKAR6jj2gqVtQ8s5JJQTxJxVOcnr9wta7MlM+QPrZn
	 jnrRGhsDyC2Mc0l8AGA3DrstBO222qviYvXosebEmpmHNxMljKhEOmJnUh3/skuMIh
	 7eWgW+o5eJc/w==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DAE463822D6A;
	Thu, 29 Aug 2024 19:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf/btf: Use kvmemdup to simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495982889.2060481.1689682920399837326.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:30:28 +0000
References: <20240828062128.1223417-1-lihongbo22@huawei.com>
In-Reply-To: <20240828062128.1223417-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Aug 2024 14:21:28 +0800 you wrote:
> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the
> code.
> 
> No functional change intended.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf/btf: Use kvmemdup to simplify the code
    https://git.kernel.org/bpf/bpf-next/c/c6d9dafb5955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



