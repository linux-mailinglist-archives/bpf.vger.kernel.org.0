Return-Path: <bpf+bounces-45685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00449DA1A2
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33AF168E59
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440C713CFAD;
	Wed, 27 Nov 2024 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4t9ZXHA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859F80054;
	Wed, 27 Nov 2024 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684216; cv=none; b=h7XSS23WO17sJJyLWGgsqea9N8g2u7YhJXa6NBCSqiMxwhq1W9ROCjo3WqxV0un2btKdkx1flic1H5F9tQG9wmGMA8s/dYny76wRTthTivGfAIx9j3ph15q2ibXh+RDpwLLpXTKq8nAmLqzUAzzoV9d88y68xDue+yn1n9+pLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684216; c=relaxed/simple;
	bh=J3mfvTqZIvmilrwwWts6S56pSp5+2LzijSa6Bjnzbqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qxhiq1a6UtVq+vxCgvdbsvxyNxUOZcsNTJZXzTZV8y9Gs37HmRAF7xeJw+OhfX+kDEfYwRxNJr6PDB295Om1ylRzEQvWFY56LAP9ObALnNTK/lbaJ8KSgYCsyATuSmfDxMbue/67LlVkIwCbK6lhhLED4gIdpO7opdbEuZYzZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4t9ZXHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D585C4CECC;
	Wed, 27 Nov 2024 05:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732684216;
	bh=J3mfvTqZIvmilrwwWts6S56pSp5+2LzijSa6Bjnzbqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z4t9ZXHAQbj5bvPcfjHitjXhl5efst6gehsYyUtMAXaQVQJAdZjmMXfjanK4t0mDz
	 7zLgdsVFXYUouUrJ2MEnLVjqylQx+HLOeKJvz/uojL6486xscxZiXZ5wU5mvA8yH/w
	 AosBFLI37ccLE3b+M0V6RFtntv0hMyqdKejO9jzpVPYCctx0zQUYrFt/p9NcbEpUGA
	 PKSAh9eMsxT+PceYflSjNe0I10QiVsEmXabFGhpxVFor45ej/MvysknIZ0W86FGspj
	 S+8cJuPc3MNEuPzUcMxmE9fR8pafdV8+EkJYfj5wrn0sAAZ5eEnPmBTammk7gshWTm
	 p2aCfiPVtCqLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9B3809A00;
	Wed, 27 Nov 2024 05:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] libbpf: Improve debug message when the base BTF cannot be
 found
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173268422926.953645.12366019016333248450.git-patchwork-notify@kernel.org>
Date: Wed, 27 Nov 2024 05:10:29 +0000
References: <Z0YqzQ5lNz7obQG7@bolson-desk>
In-Reply-To: <Z0YqzQ5lNz7obQG7@bolson-desk>
To: Olson@codeaurora.org, Matthew <matthew.olson@intel.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Nov 2024 14:08:45 -0600 you wrote:
> When running `bpftool` on a kernel module installed in `/lib/modules...`,
> this error is encountered if the user does not specify `--base-btf` to
> point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> However, looking at the debug output to determine the cause of the error
> simply says `Invalid BTF string section`, which does not point to the
> actual source of the error. This just improves that debug message to tell
> users what happened.
> 
> [...]

Here is the summary with links:
  - [v3] libbpf: Improve debug message when the base BTF cannot be found
    https://git.kernel.org/bpf/bpf-next/c/c8d02b547363

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



