Return-Path: <bpf+bounces-66756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB5B38FB5
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6434F1B226B6
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3815667D;
	Thu, 28 Aug 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8raZpui"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C843398A
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340401; cv=none; b=Idl2H36e/vOsW2dqUjz4BJHGE94akmctVKiAlwne2uVSU4jrobcfrkBas7gh6ovc3pEbdNxOaMMo6rXSBQ4HgWZXx5doHBnsu+/ot19dPBB+I6R1ayc7qyY79ADfEuIptEPvKT6xrRTbZHrWPrVm2m70fzFVPQgHYppvx1KbWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340401; c=relaxed/simple;
	bh=Np2FlqluHdk/2TL8d5nz5USdMGuWi3N0uz/a6qLVyvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WyhkhYsmv4kH6l4Z9szrxnKg+ks8DhILadT1qBuCSIKhP+SpB/eqeYnFWAuxUVYTilQJpQK2qm1aICWVDJU+yNMUwS7jRp9IXWyO6V2EKFoyQjAgkyPZxktdr44e8J6iEV9X2TadfIvgI1kAGMbqI7MjVe2sEEu3fNhkla3CRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8raZpui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F025C4CEEB;
	Thu, 28 Aug 2025 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756340401;
	bh=Np2FlqluHdk/2TL8d5nz5USdMGuWi3N0uz/a6qLVyvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g8raZpuit7W8N2+VvAYToATPH8SdlFTL6gDBxHiHQdVBal81OCL+5Kz/1vjqReOL+
	 tTXOGcpZsEecYX81lyVUSwE061iWG7sgt8cT3h4xE6QB8M6nhvyZU8ug0pV8G7ct2j
	 S0D45EleQ3ru4AyyDcU741hcnaGKOgfIPVBrLCvc/sW6PztaMy9sG57ZoG/3lDfaLH
	 +83+67t8kli+QbG5su1wyLGVJhkwqDWHlxJHGtnYSE2eqH2nCLwSJimzKxvfN187i4
	 vLNr+9/RBO0LbFhcB+t2XUshbvo+SGtMTQRGjfnb2S/lJk9ybnM9XAIickWRtv+mzC
	 l6+HpEoSYA3Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDA383BF76;
	Thu, 28 Aug 2025 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf, arm64: support for timed may_goto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634040877.884225.1028273482140460675.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:20:08 +0000
References: <20250827113245.52629-1-puranjay@kernel.org>
In-Reply-To: <20250827113245.52629-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 mykolal@fb.com, memxor@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 27 Aug 2025 11:32:42 +0000 you wrote:
> Changes in v2->v3:
> v2: https://lore.kernel.org/all/20250809204833.44803-1-puranjay@kernel.org/
> - Rebased on bpf-next/master
> - Added Acked-by: tags from Xu and Kumar
> 
> Changes in v1->v2:
> v1: https://lore.kernel.org/bpf/20250724125443.26182-1-puranjay@kernel.org/
> - Added comment in arch_bpf_timed_may_goto() about BPF_REG_FP setup (Xu
>   Kuohai)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, arm64: Add JIT support for timed may_goto
    https://git.kernel.org/bpf/bpf-next/c/16175375da36
  - [bpf-next,v3,2/2] selftests/bpf: Enable timed may_goto tests for arm64
    https://git.kernel.org/bpf/bpf-next/c/22b22bf9ee48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



