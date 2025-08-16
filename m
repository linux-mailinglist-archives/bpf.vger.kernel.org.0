Return-Path: <bpf+bounces-65796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D7B288F8
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A031189F69E
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2F2D12E6;
	Fri, 15 Aug 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXWtuSPF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72C2528FD;
	Fri, 15 Aug 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302398; cv=none; b=sdOIewqOCEpmrBte/TxxmVlR2Vp2rG5cdtAdihmI/FGlfKh1T6PEWKKUjeC1KZo5OVK9Hps9t3sjEs9EyGzJZanxBJgkUitmJ9xP7gt2ent8U9MSga00hfWeCCTmTSVaJpxsCjqiVWHWbrOD6uWlHbpQyvONr1wR3ymYzfpqBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302398; c=relaxed/simple;
	bh=Lc1hJma3r3b9ar9hI4gItvYQrUzDP9+Zq78s6ctRWtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IqtRX87YAbpUjUM+iDSAckR1S+m3NO7/DXtfNiViQde9oinXHAZhGpj02uduZk1EiemxGVsbpH4Z0+HOBzadOKUDX9rQOKRTqYl/74pogR4cUN55hFtsULeqzx9hEElu/SQy0kF5FdIjMHHoXgloYMGMk52NfXPOP/C804Mb+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXWtuSPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2BDC4CEEB;
	Fri, 15 Aug 2025 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302397;
	bh=Lc1hJma3r3b9ar9hI4gItvYQrUzDP9+Zq78s6ctRWtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nXWtuSPFgAb6SBSjjb+bj8x4UCr3w/gVncl7BSHcVd+tHYdG48yuvXsyhrmEnzGGR
	 ArgQnQ42K3qZ1Eva4pvmkxghdfaWArFiI+ENr/SOwV8jZxIo7DacWKQ18wOtB5SYlq
	 A4ssb4dNlEYLvt+TZEmY1TkPoqD5kO0+Y63xGH/yjh67sh1MdR28YvxjgH06TRars6
	 mN/JK4kqOU8PJMCpeDlfBQSy8gycHRnodA0mtOQVaggEtEFYaA3kVyXXbJ3E/Nt+tt
	 AuZYki9KSiXBRZ21928UV8Wxuf3m5UrTlh2GiG7LJeqJNf6hJNxp+1ff4n03o2B4uv
	 9BSKB9/cU75gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E910A39D0C3D;
	Sat, 16 Aug 2025 00:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] libbpf: fix reuse of DEVMAP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175530240875.1313451.2325010561135648743.git-patchwork-notify@kernel.org>
Date: Sat, 16 Aug 2025 00:00:08 +0000
References: <20250814180113.1245565-2-yuka@yuka.dev>
In-Reply-To: <20250814180113.1245565-2-yuka@yuka.dev>
To: Yureka Lilian <yuka@yuka.dev>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Aug 2025 20:01:11 +0200 you wrote:
> changes in v3:
> 
> - instead of setting BPF_F_RDONLY_PROG on both sides, just
>   clear BPF_F_RDONLY_PROG in map_info.map_flags as suggested
>   by Andrii Nakryiko
> 
> - in the test, use ASSERT_* instead of CHECK
> - shorten the test by using open_and_load from the skel
> - in the test, drop NULL check before unloading/destroying bpf objs
> 
> [...]

Here is the summary with links:
  - [v3,1/2] libbpf: fix reuse of DEVMAP
    (no matching commit)
  - [v3,2/2] selftests/bpf: add test for DEVMAP reuse
    https://git.kernel.org/bpf/bpf-next/c/7f8fa9d370c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



