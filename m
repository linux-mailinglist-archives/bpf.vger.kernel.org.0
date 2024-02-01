Return-Path: <bpf+bounces-20937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264B8455A3
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBBE2824AA
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AABB15B961;
	Thu,  1 Feb 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue+SoNsP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC0185E;
	Thu,  1 Feb 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784027; cv=none; b=eyENHMNdrKdPazrlPrI1k8bLmximwdtsGBFMU3P2eQ4EAiExH7wxgWk8NG560JB3ljh2Zo++84DHsDM5jTQyHxPqS7eiMw5NKS+TDYGSdlya561+PurIMXGZ+Hbc/QJEln7K3yU5ECpQO+ILs3sykjDlUMhCE0zz0db0s8giLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784027; c=relaxed/simple;
	bh=XaG0HTa5bdiZUGiMcDQ0KA5J9y1Mt48AeFOL+u1Drd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OSv7MfRMyYYyrK9nhbtlg5fL4peSFLgyf1p0E94rk4ZqRXhyGRQRfmJkdj7AGEiBMcTPEarxCrDi3R0bnTGyKNpH+yL2DrOgqrU/AtrmoFgi6gcxEM5sgAN9r+ixyc4erZS4TeGppbTuiksjzLOglZsnYIpbC/rd60OumWhezYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue+SoNsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42FCBC43399;
	Thu,  1 Feb 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784027;
	bh=XaG0HTa5bdiZUGiMcDQ0KA5J9y1Mt48AeFOL+u1Drd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ue+SoNsPgTZAimqUVy5rIYex/14lNlZMmPq+EV8Qua2OfHWthNQ2wQQjer3Jo/mK7
	 RKdKkIUaar3lHB45M9WYYfITZwnwBGU3NSWzvVz3PBWSP8yOUBh9oTL1MneiMvtgVq
	 kK5LbaGZ86DA6xBNYxuhUoNrgp4r7kNE6/9oCdV3E7fX3hRuNzHBX5YHTNq8BOqjhW
	 6NhU9iIyUttXlY4zOLuhcQ9RNghUwttSFTYqG1kyJvwAd7hBlBwmnsjc89SJGoizWH
	 JAQUHqZwMS1JOCYQt0yO3pLmwheTsqU592r9bE/bc+nK8OT+y74P7/tzrS5XYaN0SZ
	 AuEyFhr2P/FFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E98DC1614E;
	Thu,  1 Feb 2024 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Enable inline bpf_kptr_xchg() for RV64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170678402718.13930.11085578984728371793.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 10:40:27 +0000
References: <20240130124659.670321-1-pulehui@huaweicloud.com>
In-Reply-To: <20240130124659.670321-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, bjorn@kernel.org, houtao1@huawei.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 palmer@dabbelt.com, luke.r.nels@gmail.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jan 2024 12:46:57 +0000 you wrote:
> This patch is the RV64 implementation of inline bpf_kptr_xchg()[0]. RV64
> JIT supports 64-bit BPF_XCHG atomic instructions. At the same time, the
> underlying implementation of xchg() and atomic64_xchg() in RV64 both are
> raw_xchg() that supported 64-bit. Therefore inline bpf_kptr_xchg() will
> have equivalent semantics. Let's inline it for better performance.
> 
> link: https://lore.kernel.org/bpf/20240105104819.3916743-1-houtao@huaweicloud.com [0]
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] riscv, bpf: Enable inline bpf_kptr_xchg() for RV64
    https://git.kernel.org/bpf/bpf-next/c/69065aa11ca6
  - [bpf-next,2/2] selftests/bpf: Enable inline bpf_kptr_xchg() test for RV64
    https://git.kernel.org/bpf/bpf-next/c/994ff2f79739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



