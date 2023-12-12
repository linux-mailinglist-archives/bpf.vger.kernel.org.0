Return-Path: <bpf+bounces-17559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1480F518
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408C41F2180C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4684D7E769;
	Tue, 12 Dec 2023 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNnjgGnR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856467D8B9
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B6AAC433CA;
	Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404024;
	bh=SpCebh687Pyl6eMDOcw1Dmo4Z0AZLPicZLgLUQLeP5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNnjgGnRTdDboO8hZNZDRPa1LHQIuJBABmQT2au7l97o2wY/+Vc/sxFEtzYeKBCIC
	 D7OwOcJE8VcIimt4FnKiVt5PYKveKKnPpTV/vBWcSZsbl9QKIHKoyQ9vXfNHl5pcDd
	 Fnfycma/w2fpPiYm4kpavLFoo/9CxLuhfn/UggIHtF4pH4s1Q4yazB26k7COzAVw5m
	 bSxeWesOLAIcVxVJtA4j9kUArPLDcv0tPMsYp6dv+51fDC4tS4bvZHPU+ietYhEc6m
	 dINoxXKBW2GXkGvyTvxoSzkS+gH5dCfl776KNL7SjJ71I3aVGqu4dCMnuYZDkiAc7X
	 T3Jg6Fm2IuaEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 108BBDD4F01;
	Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] bpf: remove unused function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170240402406.18804.9321914425985610627.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 18:00:24 +0000
References: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, kpsingh@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Dec 2023 08:54:36 +0800 you wrote:
> The function are defined in the verifier.c file, but not called
> elsewhere, so delete the unused function.
> 
> kernel/bpf/verifier.c:3448:20: warning: unused function 'bt_set_slot'
> kernel/bpf/verifier.c:3453:20: warning: unused function 'bt_clear_slot'
> kernel/bpf/verifier.c:3488:20: warning: unused function 'bt_is_slot_set'
> 
> [...]

Here is the summary with links:
  - [-next] bpf: remove unused function
    https://git.kernel.org/bpf/bpf-next/c/56c26d5ad86d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



