Return-Path: <bpf+bounces-56008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FEDA8AB4C
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262237A92C6
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E92296D15;
	Tue, 15 Apr 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzsMEXBR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F8161310
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756242; cv=none; b=WJ8IHkVVvWjeBDGr+QpVWcCLylsuoA39VqqSZzbWqLx9kwBUlNX+Iyi5kp/iH9rk8f10g0AiWzICRIidS83mP2nqNALdc3XzFCbuGWzUVSvozUuhr9vdiw3H0QJC9ogyLWrCmhNmMDp80ER7fyN0TV+R3mO0knBExdmUXxlJK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756242; c=relaxed/simple;
	bh=J5MK0Y/yLRTpNGEskkgYsDFg2smieDIAyiGDjGkYe7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VVZDjhrUBBR2LDra6sHWv+covtzgikOTc/cSsJZWZpo/bUn7iU3Xp0Wa1X5JmvhqsInfVwuX0tVX7vLhhyx3yTyKDz7Ckt4TUheYONWwii2U2HEMe+NTPtrTd3KbN9QnYghDm0+QWt7YuWxK4Xc0uu65UnHWP390Fjn0GWDHnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzsMEXBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A272C4CEE7;
	Tue, 15 Apr 2025 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744756242;
	bh=J5MK0Y/yLRTpNGEskkgYsDFg2smieDIAyiGDjGkYe7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzsMEXBRVDGqShzTq+CWk/Scb8Fh2mgcd95z4+mFWj9II7I3xIcN8ZegGpeSdXgS4
	 we22Ymop941K539VYTgc6DeAis1efX4UOMMnulY7nkNR5WvUxkJSVqS5eMJ9Wd/Sny
	 0iQ+6DGPcGfA8r7/nE5yZVAf4iryvxmrY6GhF+lfYXO20r5b+Fdw52T2wudY38WYY0
	 fLU7m484USpMmuSdnEEXAgr8LzthfrC1cma7XW+EMvUGOdLKSBIQ1AMdBTS2wRvUvR
	 KEcItF4iUD0+qwUlry3YOfrOaAEhaaUjYCa0wuHaKhMlc7TmWNGB4iO/1AdWOKmJJ4
	 V328Fjy1YFy5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F5F3822D55;
	Tue, 15 Apr 2025 22:31:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] libbpf: Fix buffer overflow in bpf_object__init_prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174475628010.2800528.9512365182028464539.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 22:31:20 +0000
References: <20250415155014.397603-1-vmalik@redhat.com>
In-Reply-To: <20250415155014.397603-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 2524158037@qq.com,
 shung-hsi.yu@suse.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Apr 2025 17:50:14 +0200 you wrote:
> As shown in [1], it is possible to corrupt a BPF ELF file such that
> arbitrary BPF instructions are loaded by libbpf. This can be done by
> setting a symbol (BPF program) section offset to a large (unsigned)
> number such that <section start + symbol offset> overflows and points
> before the section data in the memory.
> 
> Consider the situation below where:
> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
> - prog_end   = prog_start + prog_size
> 
> [...]

Here is the summary with links:
  - [bpf,v3] libbpf: Fix buffer overflow in bpf_object__init_prog
    https://git.kernel.org/bpf/bpf-next/c/ee684de5c1b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



