Return-Path: <bpf+bounces-46677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FF9ED9D5
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 23:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF23F166558
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64A1F867E;
	Wed, 11 Dec 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjfwijMb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6791F4E57;
	Wed, 11 Dec 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956345; cv=none; b=HOA+kLRATcm6rdnFeUUu44fRHPtKRlg0lfjD0MUu0BfHuLBuM8PBQFoTpUUEzVujmwycPFTazTZPNCJRg8WaAfEluIKUC8bGjsLSakAFYGfe170sbzneRBfeNl2juosA5qf72i37fi86M8WPaQJkor6TFBMQalaqjUGX6o1MyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956345; c=relaxed/simple;
	bh=NGdHSLNI0l4aBJ0f/wN2z7bSGQikMSaNjVw2lkQNoSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DHbudQZ1J5ne/WjFWu34AlpgeC1loquMnY///N7cr1WseQnFp24sjtcIi8pHZfNT37BzM2w2cg6Ym5C6RwPkftQZteG4wORQlXXR3ldrtIn7g26mCoHx0wKWIstRDIGmOVhx6QsQXZoJSrrNTm8HFwzxhVgfbF8t/sMrMmJPXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjfwijMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C33C4CED3;
	Wed, 11 Dec 2024 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956344;
	bh=NGdHSLNI0l4aBJ0f/wN2z7bSGQikMSaNjVw2lkQNoSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BjfwijMbLAHcxokg+pJC2/UdLPu8w5NNJmdVSAOq2BH6ThTgopYBX0+fTtZ0X5Kuy
	 NfKs4ecBx8K7owJiX4gaHbZBZVEBE69mG9OnadEwoaVEg/YlWV4VJLxNr+lfzV/GM4
	 iA1E8xJfJ2sY3w+RU6+3M4tkCTnE8gjvlGNhbmRMLplxytpDE2GUi7CltDLER9CJyH
	 af7l45Q1lRTiP73iaTZ93p0r8Fdwq1sRnbHHxXRYZbnkmrZjFr7m4xdrLOhsG8VX23
	 P33IqFJvqHyO4uQPBwp0R1LbM7vOM2Cv0K1r4G6XH+u5VBDgJKVnd2C0jB45rqkTCf
	 vX12KmEy4LCbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8A380A965;
	Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] Optimize bpf_csum_diff() and homogenize for
 all archs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395636024.1729195.5884060368915845974.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:40 +0000
References: <20241026125339.26459-1-puranjay@kernel.org>
In-Reply-To: <20241026125339.26459-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu, ast@kernel.org,
 akpm@linux-foundation.org, andrii@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, haoluo@google.com, deller@gmx.de, kuba@kernel.org,
 James.Bottomley@HansenPartnership.com, jolsa@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com,
 netdev@vger.kernel.org, palmer@dabbelt.com, pabeni@redhat.com,
 paul.walmsley@sifive.com, puranjay12@gmail.com, shuah@kernel.org,
 song@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 26 Oct 2024 12:53:35 +0000 you wrote:
> Changes in v3:
> v2: https://lore.kernel.org/all/20241023153922.86909-1-puranjay@kernel.org/
> - Fix sparse warning in patch 2
> 
> Changes in v2:
> v1: https://lore.kernel.org/all/20241021122112.101513-1-puranjay@kernel.org/
> - Remove the patch that adds the benchmark as it is not useful enough to be
>   added to the tree.
> - Fixed a sparse warning in patch 1.
> - Add reviewed-by and acked-by tags.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] net: checksum: move from32to16() to generic header
    https://git.kernel.org/riscv/c/db71aae70e3e
  - [bpf-next,v3,2/4] bpf: bpf_csum_diff: optimize and homogenize for all archs
    https://git.kernel.org/riscv/c/6a4794d5a3e2
  - [bpf-next,v3,3/4] selftests/bpf: don't mask result of bpf_csum_diff() in test_verifier
    https://git.kernel.org/riscv/c/b87f584024e1
  - [bpf-next,v3,4/4] selftests/bpf: Add a selftest for bpf_csum_diff()
    https://git.kernel.org/riscv/c/00c1f3dc66a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



