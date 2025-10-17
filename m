Return-Path: <bpf+bounces-71244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02ABEB409
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D9B4EA3D7
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99398330312;
	Fri, 17 Oct 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHPD+xvc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17F22129F;
	Fri, 17 Oct 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726424; cv=none; b=qC6biNImCQ8nX6z0KVcm+K2HW6DqfXM1IeIwMVfQ/chjF88bVjzFCS3tyjfVfduPzlW/osqL3Af4gjtPj4n+siXY79dqzFKGtt1F+37PPg4PlH431+UyBy6ec+RljWz98KVDwjGUaLWBtEZH686RCL/F8E0wE3wuzFkGoyEb7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726424; c=relaxed/simple;
	bh=tZRXDU5mwSuT0nl5NaKCPlMvEP+7B6upV+W5HDp1mD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eMpdmEFMCCwlW6yQxNG+WVM4mkHR4kInv1IpihrjH4BbvI3Q4lyV3S/kqR+cCo6ayjvf8P0Td3AYdzGFQ3r1ckeSAUyPEDFXTQ24naRSHld42SA1+dmNWgt/Dz6rZ9um6/GKHWcw7dUuPFiMXA4S644hM8fL010NcnutViq3Jr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHPD+xvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF97C4CEE7;
	Fri, 17 Oct 2025 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760726423;
	bh=tZRXDU5mwSuT0nl5NaKCPlMvEP+7B6upV+W5HDp1mD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VHPD+xvcxqNtkvdK/FckD5hIWSDjboEYH8rRjkiQJikzr+RaExunYkmw/g7UmUgjb
	 IDnjrhuB5PxjFjX+ohcUqCKVctd4clGJ6UssgdAvoVO9JVcYldik36A8ALQWDtnXwn
	 EI0Aj4P//YZ4Buykgq4vKQ5dDjrC6UIT8fh64RSghzGOQRORDaF7hpFwa8ryCRLSOK
	 QYYtkQ9hBE6qs0KdxQgCCyBn4Uolz5TB9QaQBmFltJguZ12wmRC+Vqt+jPavIioDV0
	 y7VLySPqY6zl/w+z2t3gVj9xFwREeyQ7a6KjhF5/czGrxkMA+krNSqzAkzOpW+Qei1
	 bQ27R2C051Qhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C1039EFA57;
	Fri, 17 Oct 2025 18:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix redefinition of 'off' as
 different
 kind of symbol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176072640725.2744744.3047311242527040471.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 18:40:07 +0000
References: <20251017171551.53142-1-listout@listout.xyz>
In-Reply-To: <20251017171551.53142-1-listout@listout.xyz>
To: Brahmajit Das <listout@listout.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yonghong.song@linux.dev, andrii@kernel.org, eddyz87@gmail.com,
 yangtiezhu@loongson.cn, ast@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Oct 2025 22:45:51 +0530 you wrote:
> This fixes the following build error
> 
>    CLNG-BPF [test_progs] verifier_global_ptr_args.bpf.o
> progs/verifier_global_ptr_args.c:228:5: error: redefinition of 'off' as
> different kind of symbol
>    228 | u32 off;
>        |     ^
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Fix redefinition of 'off' as different kind of symbol
    https://git.kernel.org/bpf/bpf/c/a1e83d4c0361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



