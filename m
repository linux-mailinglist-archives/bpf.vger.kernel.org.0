Return-Path: <bpf+bounces-46939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89069F19A8
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C88188750F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F01B395E;
	Fri, 13 Dec 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqmzqF51"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F61B0F0A;
	Fri, 13 Dec 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131419; cv=none; b=gBx7tMkOI3cyDaI72OBhtT1KfXXwZDCuHFj783428ELQlt3FW6bEAVxSuLjLYQ5/q9QMK6BZY4WD0g7AENY9TziXdS5NXlZTer8mSOyfI0gxoSZtpAStdZcsnkjvfYOOA9s7SZsg4TgustiGKbVBwhQPoP5y21/BVVHivIh0/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131419; c=relaxed/simple;
	bh=Kr8sC2qFWfrbxPnSY7o0fTv5e0gyuclbb8jSGIyZEk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m0K51h7nfYt13Lescfe8paVLdVj2HZ4WME2Fz01+Yj+TjNNgkkXBSLFgDnGzTHJgr3dvKlN1X8eLc3RUIuTtchMYcHArKZHsosS2LCx4dTkobgR6KrnSWq4dCJlLTsA7ivp3gU9K/n4KrYHkbKCfUwwYbNzVwP6mbDLp+FGhr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqmzqF51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8038DC4CED0;
	Fri, 13 Dec 2024 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734131417;
	bh=Kr8sC2qFWfrbxPnSY7o0fTv5e0gyuclbb8jSGIyZEk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EqmzqF51T3RnLm1+40Ru9uHEFu75rNQ+wLJ6y36sKkcdChBCVqAzsHab7JbZ3SD6G
	 UjMVnGXZzk9VPQpv/czh76qGwX+CbcVTOm0mSTjgVsPKd6IiMSWwNRd93V2zR1A2Ku
	 ETAJ4NU1fc4wy+wSNcrCXP/jQmv3JkZtrBj3RU/Q5hPRpXHgaGmgOtaSUEQIIi+0Cy
	 p9GzsVXEaXxxEuJyGW2KxoChoMhoItW98tlyz08s0hhOJk+817ZXkncvl+krU4JpU8
	 fz29CtAtiaFtXsigCZE1a9h8Jfda1BcIn0p30BvXTNEMDnMhLOjxbLl+hwGmCgEx1o
	 k5ggTioVMLLkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E54380A959;
	Fri, 13 Dec 2024 23:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix configuration-dependent BTF function
 references
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173413143374.3187520.16720861618216480481.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 23:10:33 +0000
References: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
In-Reply-To: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Dec 2024 00:00:30 +0100 you wrote:
> These BTF functions are not available unconditionally,
> only reference them when they are available.
> 
> Avoid the following build warnings:
> 
>   BTF     .tmp_vmlinux1.btf.o
> btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' in BTF
> btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
>   NM      .tmp_vmlinux1.syms
>   KSYMS   .tmp_vmlinux1.kallsyms.S
>   AS      .tmp_vmlinux1.kallsyms.o
>   LD      .tmp_vmlinux2
>   NM      .tmp_vmlinux2.syms
>   KSYMS   .tmp_vmlinux2.kallsyms.S
>   AS      .tmp_vmlinux2.kallsyms.o
>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
> WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
> WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
> WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix configuration-dependent BTF function references
    https://git.kernel.org/bpf/bpf-next/c/00a5acdbf398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



