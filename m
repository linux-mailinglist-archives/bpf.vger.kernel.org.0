Return-Path: <bpf+bounces-41775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A071399AAFB
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6324D282FA9
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582931C9B87;
	Fri, 11 Oct 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcpyKBTK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029D193436
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671530; cv=none; b=idCswGjtqxbuVM7tDSs/2FZfm7NEv/pVcQ6un6H18OaRMIN4kFu2GPkPaAe21yrYKQF4kczB2MUq6hlQNL8aKPdWzMaRK3106FsF+jjblw6oL4KAfEgPmhkKDIEWPj9IwNI2Izh0GmE0AZEPvJIQ4ykvLssMjVyuAHQ1tes+f08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671530; c=relaxed/simple;
	bh=Oh6bCX1B/63fEgohpmsst2CnqYWPrC9TiC2z3S2LsDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WRh4iH0dtVuPH5AsWhsh5pNjF3UKKmzgKHkoNf8/cgRuTylzrH6s5pjd+Br+2RKkDe9HPTRGewkfEc8AI2oir1ixxH+66VFfx7qLn6lupbXqZpcmasCtJ787G8PkA+r3papuMGEWAMA9iYUXT/vkQS2hyyDY2GoWIGHYQs3GvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcpyKBTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1589C4CEC3;
	Fri, 11 Oct 2024 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728671530;
	bh=Oh6bCX1B/63fEgohpmsst2CnqYWPrC9TiC2z3S2LsDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcpyKBTKNRdLxRSSfihw78DvbH2bXaKGzCrDYoqVvAsZdSTyMYSa8u6iyUAmJPa3V
	 rtDGTsOdbOGllMpYxhZE/dlTFjunKT2hBo/+cyV/re5jo/MLaxkafxQx1pS/cv2kCT
	 mV19M6vwITLNPdm9A+MSm2eHkWSzS9aCFKC/Yojo1TU+/jFl+B6OHV0bad777DQI36
	 Rv2ixX2c9SzMsfNhun1uiZFeaDio5bXoAvahy/eon/MYXROk/Tgd9oiQ8ISKKGPfhw
	 ByZqyg721seUWiffSsQa2SM/NmIcTHhyGnxczjCoYuCusq3k+mJV4PgeOMVeywu6ll
	 73Zj5XbhIh4hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C47380DBC0;
	Fri, 11 Oct 2024 18:32:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: never interpret subprogs in .text as
 entry programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172867153526.2893426.6435315710115366653.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 18:32:15 +0000
References: <20241010211731.4121837-1-andrii@kernel.org>
In-Reply-To: <20241010211731.4121837-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Oct 2024 14:17:30 -0700 you wrote:
> Libbpf pre-1.0 had a legacy logic of allowing singular non-annotated
> (i.e., not having explicit SEC() annotation) function to be treated as
> sole entry BPF program (unless there were other explicit entry
> programs).
> 
> This behavior was dropped during libbpf 1.0 transition period (unless
> LIBBPF_STRICT_SEC_NAME flag was unset in libbpf_mode). When 1.0 was
> released and all the legacy behavior was removed, the bug slipped
> through leaving this legacy behavior around.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: never interpret subprogs in .text as entry programs
    https://git.kernel.org/bpf/bpf-next/c/db089c9158c1
  - [bpf-next,2/2] selftests/bpf: add subprog to BPF object file with no entry programs
    https://git.kernel.org/bpf/bpf-next/c/82370ed5ade5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



