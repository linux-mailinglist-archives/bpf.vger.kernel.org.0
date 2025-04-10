Return-Path: <bpf+bounces-55621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C074A8370E
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165091B655C9
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB91EF39F;
	Thu, 10 Apr 2025 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6l8orUO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F521EF382
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254602; cv=none; b=fSCp6iyv8v6e1MhltBTqV3+pbEK2YgE+YP9+xuVEFEvpwTmsUyTX5BOaWEKK43YeuT5Flm6/pfrZt+OfWomG3sMR3y+tKwDq6LIlhLe14+OUyGzRFE30SPVHYd7o5T+8mEgIDaYf3c3VcfPTz5qokhnXEZM/tFfwSTXCyD/tJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254602; c=relaxed/simple;
	bh=ziK3GjMY+H6kixgmVl7nA+H61ZUoURZcP2dqYtT9VEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f8SjNNok7LhFezPSLZ+ynwfIe8TB3Y5C7QRVC36BZYBZea+6WDgqKkAniMEP0BK94cOePYXeXognvyvqcr6I6Zq6IB9pQv+2yrRb1J4C68gGXSrc2JgKIubGs/dQmU1JbUGiQW8Xr6H+ka/4fl0pQaHk3FPPVtT1zEo5rzx9520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6l8orUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82FCC4CEE7;
	Thu, 10 Apr 2025 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744254601;
	bh=ziK3GjMY+H6kixgmVl7nA+H61ZUoURZcP2dqYtT9VEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6l8orUORv7SFNsRrPEyYrS++JUyhug8Cp8GPMd1PFlNyYUQ7CfNSbZcS0SpGTNLW
	 ecif3K7xrJp5PWRr7syzW9WDYJDN6UubzCNb1hYPclDHs5KluwUrtbqdDsqiIKf3V5
	 +xinW3btcelWkDRRwt2kbXcVXQSAJwmt+VV5TERgPUnEz4K8L8KFa2XffKtZnqDcVE
	 ezEA/JXoPMA3GbVSfO1/dDmZoWLiH/sJDr6LK6qz1PYfvHHv0EL1I6YjN+lW2Oe0CC
	 MDtybxYNR4IkXQzXVt4YHM8TV/HiMnf1BBcPlXx/n4OGhgnAWoOfIFgCl6EYyRprXO
	 rRv7ul0Am14ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5F144380CEF9;
	Thu, 10 Apr 2025 03:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Clarify role of BPF_F_RECOMPUTE_CSUM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425463922.3131897.5068814594178596418.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 03:10:39 +0000
References: <ff6895d42936f03dbb82334d8bcfd50e00c79086.1744102490.git.paul.chaignon@gmail.com>
In-Reply-To: <ff6895d42936f03dbb82334d8bcfd50e00c79086.1744102490.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 8 Apr 2025 11:00:04 +0200 you wrote:
> BPF_F_RECOMPUTE_CSUM doesn't update the actual L3 and L4 checksums in
> the packet, but simply updates skb->csum (according to skb->ip_summed).
> This patch clarifies that to avoid confusions.
> 
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 14 +++++++++-----
>  tools/include/uapi/linux/bpf.h | 14 +++++++++-----
>  2 files changed, 18 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [bpf-next,1/2] bpf: Clarify role of BPF_F_RECOMPUTE_CSUM
    https://git.kernel.org/bpf/bpf-next/c/b412fd6bcc4c
  - [bpf-next,2/2] bpf: Clarify the meaning of BPF_F_PSEUDO_HDR
    https://git.kernel.org/bpf/bpf-next/c/5a15a050df71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



