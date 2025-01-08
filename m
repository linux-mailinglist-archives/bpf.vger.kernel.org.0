Return-Path: <bpf+bounces-48270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F720A063B4
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8A1635DB
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1CF1FFC77;
	Wed,  8 Jan 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+KR0QcB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18661957FC;
	Wed,  8 Jan 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358613; cv=none; b=kxEuT9YG4aWmSXtI7NZkod01VsK1u6pc0w/m51N1XgWDPtcQqvrE9TPGyFwRDL5HceK0u+yubv1fROrnHW3GGXsaqqNb+fp/KKGNK4kqigqPjgF63Se7s7Pie1n1fred06Wz9LVqYNcKDFzz5rDBGa18ankJHDAhQInj9H6gSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358613; c=relaxed/simple;
	bh=cJ4gsd2+xSu85gCs0M/1/TxPsXnhxVuiRvszKB4LNLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiFgxcDPOY/16PHN8TuGuCcNFsAP8ffZw3ORIqn/q3LQ78zp0DPr0DiP/JKAllW98NmuG94dH3E1eTvog+ioRUruUEFThZ+j1h4C99O2S5pLX+QwNCwLldTBv9VOoACI1d/GUUr1UezNXA/CN1awX73k7otRsSmp7zdDs1vxmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+KR0QcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33052C4CED3;
	Wed,  8 Jan 2025 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358613;
	bh=cJ4gsd2+xSu85gCs0M/1/TxPsXnhxVuiRvszKB4LNLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E+KR0QcBh5dTmrMmpCxPJXqzLWSBkpuQUdw21FczRgA14Kl+rSMtEWTQUVpnr3ai8
	 +59TkRf6vjrVIdEDIFindbZzEtk+hQHaeNhLZ7eVAZlPR5L/GS3YFRjiHe+uApyOLv
	 4Z1ETo+VSa5yFroOvZshmPalB6SXH5lyb15j8XKosyWpOxB3Qhc9reDk/IduKI4W/o
	 Zyblh5/14UwHtGqgDkSjwABgTyoVTivSbUYIefYnveA57v/C3ArVjgb6h/1SJ21UaT
	 YpRBVeN3aU0BX75UrNoRvg6zzf2Ym057W5pu032sqnz+9dn0+CbTacAg6HhHAbViLN
	 KFqq3UApQPpHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB316380A965;
	Wed,  8 Jan 2025 17:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Return error for missed kprobe multi bpf
 program execution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173635863460.728295.8358342066547800983.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 17:50:34 +0000
References: <20250106175048.1443905-1-jolsa@kernel.org>
In-Reply-To: <20250106175048.1443905-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com, mhiramat@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  6 Jan 2025 18:50:47 +0100 you wrote:
> When kprobe multi bpf program can't be executed due to recursion check,
> we currently return 0 (success) to fprobe layer where it's ignored for
> standard kprobe multi probes.
> 
> For kprobe session the success return value will make fprobe layer to
> install return probe and try to execute it as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Return error for missed kprobe multi bpf program execution
    https://git.kernel.org/bpf/bpf-next/c/2ebadb60cb36
  - [bpf-next,2/2] selftests/bpf: Add kprobe session recursion check test
    https://git.kernel.org/bpf/bpf-next/c/bfaac2a0b9e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



