Return-Path: <bpf+bounces-58490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650AABC4C6
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 18:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BC63ABD3A
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993A286D64;
	Mon, 19 May 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws7VX6i3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470428642D
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672796; cv=none; b=YLaIxNb1ZfEuiZODj6VM9FX9dE4NEWkbKzEOtWJoXH5mdZfnD7gzfMgCqiW36tHX8IKqVIvvZyHG9qcTAiTkhjzWX1VGCGXfnhF2PPNSLV+Hv7MtgV/aRv6eqVGpI/kbhkszhPdZ+y3kJ8jIw1/FZHs/q4/bMT1v6g88HEENJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672796; c=relaxed/simple;
	bh=TgSI7Ij7V7KPFdsW2tqukAJBt0+tsuji6hEmOfBPN/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=trhFruZIIDFHWALfWBDI4ixc1q2ZO4WMvpeamPVH2UCOmSUD/WwVCdQyA1mANHF1CSgHZLNx42g1uiwR2HJfUQh66L+jcG/Ok2/hpBlMxO872srbhvViCIAL3v1dwhTdSsViSuIwpff/uX154vbVJ1SmzVHCR5y7Xsgu88NMk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws7VX6i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13601C4CEE4;
	Mon, 19 May 2025 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747672796;
	bh=TgSI7Ij7V7KPFdsW2tqukAJBt0+tsuji6hEmOfBPN/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ws7VX6i3i9P+TMHmvJ7+cZwj5lWXCN1G3tJ5ff8sHfjjpcoek1PqzV1ypB/l+goOA
	 Q9DXYlDKJUZYcKXp0wHJBYk+qpwDPAIafCemUCgvq0fGf8oCblLoiahwApCiACv84b
	 +8QI0DYZYX6xBAnHufvtLdmep/Q8m/hGEx6LhhSwH6Z7tV4Rw0RmqzLd+ib30ARc+L
	 FxbW9nku2VU/JA1/isJkc5e9+2iTFCDmQh9q6egWGw/NTBAOD6WoiDC7yCCL+hMdf3
	 rsY7qaO3OvYh0NmY1NHCVmZ9DMvg1kEh+sP20IKTOOaVjg4VbpC35GWcPXDcIm7klT
	 GsWFKVPmJbiPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105E380AA70;
	Mon, 19 May 2025 16:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove unnecessary link dependencies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174767283226.994362.9833413093762861399.git-patchwork-notify@kernel.org>
Date: Mon, 19 May 2025 16:40:32 +0000
References: <20250516195522.311769-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250516195522.311769-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 16 May 2025 20:55:22 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Remove llvm dependencies from binaries that do not use llvm libraries.
> Filter out libxml2 from llvm dependencies, as it seems that
> it is not actually used. This patch reduced link dependencies
> for BPF selftests.
> The next line was adding llvm dependencies to every target in the
> makefile, while the only targets that require those are test
> runnners (test_progs, test_progs-no_alu32,...):
> ```
> $(OUTPUT)/$(TRUNNER_BINARY): LDLIBS += $$(LLVM_LDLIBS)
> ```
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove unnecessary link dependencies
    https://git.kernel.org/bpf/bpf-next/c/b615ce5fbefb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



