Return-Path: <bpf+bounces-43551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E49B662B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F02C1F21289
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C41F12E0;
	Wed, 30 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+qQ0ibR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8AB672;
	Wed, 30 Oct 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299224; cv=none; b=E/LKhaMyTWWWnNez73/hh34tKAgPuv9IFXzyZ51PDllBieifcrBgSxpm7SCYZArq7cYRCSLJximaRbmxFulrqYOT8xtDV6Ng7OBRvXL8H3MbO7vkbur/bsYBvEOENW1DVlFV6VzHD/z7VJ6V57c/vNNsiFg40QUQIui8JnHF9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299224; c=relaxed/simple;
	bh=vB3pvWOA7axGK3P12THCJTUlY17q7zuJreBzEmisMrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2nrSZTLKi4PNnMss4I7o9bwitrdkr3VFoxo8X+CMOJKXnyhVwcTnLQNSGl89wwreNdzB6H9RDcL9xQQM2Bcmx6JtLZedX4pbhraoKLp3obN6PuIq94pz6MdRrK++LdwaRGeVWlFXeiIQtYk+LK1IJMcO3N8gESezPhDermsMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+qQ0ibR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC33C4CECE;
	Wed, 30 Oct 2024 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730299223;
	bh=vB3pvWOA7axGK3P12THCJTUlY17q7zuJreBzEmisMrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+qQ0ibRuSgpkjSdXWVlurXrPNrevIoPI9+ZnWRSvtKm8Rw++dcE3rn7jrBK46ZvI
	 wqRY1cg12sMJqfI4CGeRUPQR0CmfZc4pb3ZjYQjkDA44j/WurH9LyJCuvLEaxM8sTu
	 iyW57V89pBj4cFmIGOW3NGa2rj0v2j9vAnyU4n6P++DckrkzkaRCoMQ9IH7zuF+OP4
	 hQ5DwFzOa3Ebiy9UPxy8RlftGZ+2cNRt2DKrPmQ/jlCMeAWVBbb0Zri66YX/KwtBkj
	 INuWWGA2UnAi7RVsS2Dqpnugg87fR6Fr7Bx550vO4OFm8LglVv8jWo8w+Mv7ej03x7
	 iJteFwZwvRWnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAF380AC22;
	Wed, 30 Oct 2024 14:40:32 +0000 (UTC)
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
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173029923127.1361326.16471187092779052308.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 14:40:31 +0000
References: <20241026125339.26459-1-puranjay@kernel.org>
In-Reply-To: <20241026125339.26459-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: aou@eecs.berkeley.edu, ast@kernel.org, akpm@linux-foundation.org,
 andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com,
 haoluo@google.com, deller@gmx.de, kuba@kernel.org,
 James.Bottomley@HansenPartnership.com, jolsa@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 martin.lau@linux.dev, mykolal@fb.com, netdev@vger.kernel.org,
 palmer@dabbelt.com, pabeni@redhat.com, paul.walmsley@sifive.com,
 puranjay12@gmail.com, shuah@kernel.org, song@kernel.org, sdf@fomichev.me,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (net)
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
    https://git.kernel.org/bpf/bpf-next/c/db71aae70e3e
  - [bpf-next,v3,2/4] bpf: bpf_csum_diff: optimize and homogenize for all archs
    https://git.kernel.org/bpf/bpf-next/c/6a4794d5a3e2
  - [bpf-next,v3,3/4] selftests/bpf: don't mask result of bpf_csum_diff() in test_verifier
    https://git.kernel.org/bpf/bpf-next/c/b87f584024e1
  - [bpf-next,v3,4/4] selftests/bpf: Add a selftest for bpf_csum_diff()
    https://git.kernel.org/bpf/bpf-next/c/00c1f3dc66a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



