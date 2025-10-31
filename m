Return-Path: <bpf+bounces-73182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF46C268B8
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 19:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A62E3504EE
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99A351FA8;
	Fri, 31 Oct 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbJZkbg0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51982F2600
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934833; cv=none; b=dnLqBt6V7kOCuRD/BJwF8IhgW4YLiTGoP1QNh4T1oROWjGQ/x59lkPeB2nFxjDwuFG9e3OVstsJrfp5JvmeB69fjHcvZ0vjwrxpDOWiH8QPr1DJ+5bgM+ba54uafOlfz/HXyTlefwnTZiCRTtNxWj4kx77qHRhPBkNU/HgazFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934833; c=relaxed/simple;
	bh=vXQI2/nCPI/9CtdSm/4vANq4vbuyf3XKSfsk2UiUQ+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nElMcSI+NMUZtxnpplH18jqtCRqNkTYH8PotQabU4RJ8SK1zH6QRTJs8Jfty0kk+LQzK0cG62Xz2u8dfTARPXQoLrhUfxwFCSPLp8O2g82h/CvUEwYwVLHduXXPTgIZip2uu1JTvIUZBlYv9AJeWZowL356q1NJTwC1xSMPbqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbJZkbg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C3FC4CEE7;
	Fri, 31 Oct 2025 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761934832;
	bh=vXQI2/nCPI/9CtdSm/4vANq4vbuyf3XKSfsk2UiUQ+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kbJZkbg0mRQiPdP129ryiMjsuHMGiHqlAvQ/KrJXpGDRL+D92ErNdpnEg3CTf186q
	 ug8nTga3xC5LupytfgUiLmNnjYNdX7/VQ8iCr0WAoGDmPQNV4cqoFnE1mLeBKpPx7V
	 2URpYfxlyzhGFZM53UTmDJgBXZHJ0V/pVAnx9B/UYfZPVaKBoXIbjMJNZegX5M8YSJ
	 THa6xBYFznIVv/Ie10M7x8YIDEibctc43jyJ2j68trtl6CSdVnUtarHwpJGsbjchm8
	 1HVTWJA1zKAauatjkiPqGPesxbOxIkhOhc7Nt2+6AooUeF8riNPiDOQP5mv/PVgOCq
	 eEG27LL6c2pcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0443809A00;
	Fri, 31 Oct 2025 18:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Make migrate_{disable,enable} always inline if
 in
 header file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176193480824.596218.10895400219102454363.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 18:20:08 +0000
References: <20251029183646.3811774-1-yonghong.song@linux.dev>
In-Reply-To: <20251029183646.3811774-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 menglong8.dong@gmail.com, ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 29 Oct 2025 11:36:46 -0700 you wrote:
> With latest bpf/bpf-next tree and latest pahole master, I got the following
> build failure:
> 
>   $ make LLVM=1 -j
>     ...
>     LD      vmlinux.o
>     GEN     .vmlinux.objs
>     ...
>     BTF     .tmp_vmlinux1.btf.o
>     ...
>     AS      .tmp_vmlinux2.kallsyms.o
>     LD      vmlinux.unstripped
>     BTFIDS  vmlinux.unstripped
>   WARN: resolve_btfids: unresolved symbol migrate_enable
>   WARN: resolve_btfids: unresolved symbol migrate_disable
>   make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>   make[2]: *** Deleting file 'vmlinux.unstripped'
>   make[1]: *** [/home/yhs/work/bpf-next/Makefile:1242: vmlinux] Error 2
>   make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Error 2
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Make migrate_{disable,enable} always inline if in header file
    https://git.kernel.org/bpf/bpf/c/14a7f2392f42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



