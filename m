Return-Path: <bpf+bounces-65585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0858B2574F
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05E95A7DC2
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9632FB998;
	Wed, 13 Aug 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nePHpeRO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4642F5322
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126595; cv=none; b=KPI5dSbf7DP3QlllnAkkt89W5/r4mFuFkJhbwYfqlwaXkJP5iW+MwIue3zVZnryRMLHe47RVYGsKLP4o0Buv2jhH4/YAtJ1O6U1NNCwYVRezwPTD6GdIZqnGizCB2ICD7yaA23jWUbI4cO/JqU1lHel+LQ1/Ge5RPtjCQBTwvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126595; c=relaxed/simple;
	bh=i3VfC3EixeuSVJ4SdDGG3lEhA0CCeR99sP3iD1fD4Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DyqLVrZRT1ZCYWQqxhuzBD+/dtB37fr+hppnb3kQiqzb141VLhysVmDQ7d/wXiPldkuq+wzOLEnOxLp5Y8A+UXjgfJyFoFieL7yfzkWEjisTVovqtnl3tEMYVo4cPL98plyeOyP+nH2yCfVqkZruphkCLGFhYoDBIPSdiJcZ0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nePHpeRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B72AC4CEEB;
	Wed, 13 Aug 2025 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755126594;
	bh=i3VfC3EixeuSVJ4SdDGG3lEhA0CCeR99sP3iD1fD4Jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nePHpeROpd6R8W02IMeGkrc8QzzH8I3rtNGjij8QADyYskxVeLF5ZihXYJ3Fml8ek
	 PEYHHRbBCLYkRwaXaIjAAn4UNizbrZBENBXlzUsczpJUzWRfplIyKhAC+H7gEMgWxq
	 gQZtPjrHj/l5OvxAS/CgN+D7PBrmvIG43EdA+vJtVyTIfTlqexP+DZXzYLx/DfEmtL
	 8oW+U46Lavl7fxLro06uGF13UenZeWhKTxY5kFEv0U5nhVJbEkneg5mdKgyYuT97hM
	 B6jBt+fjizpJx0ZAhYo0f8vApaNZKYn3WJHFMTA5lLW5n0jaNcCNFhjPoDHtiKLJ6A
	 tejmialCIVE0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9939D0C37;
	Wed, 13 Aug 2025 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/1] selftests/bpf: Copy test_kmods when
 installing selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175512660610.3810269.2938068331915732327.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 23:10:06 +0000
References: <20250812175039.2323570-1-ameryhung@gmail.com>
In-Reply-To: <20250812175039.2323570-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, mykyta.yatsenko5@gmail.com, toke@redhat.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Aug 2025 10:50:39 -0700 you wrote:
> Commit d6212d82bf26 ("selftests/bpf: Consolidate kernel modules into
> common directory") consolidated the Makefile of test_kmods. However,
> since it removed test_kmods from TEST_GEN_PROGS_EXTENDED, the kernel
> modules required by bpf selftests are now missing from kselftest_install
> when "make install". Fix it by adding test_kmod to TEST_GEN_FILES.
> 
> Fixes: d6212d82bf26 ("selftests/bpf: Consolidate kernel modules into common directory")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/1] selftests/bpf: Copy test_kmods when installing selftest
    https://git.kernel.org/bpf/bpf-next/c/07866544e410

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



