Return-Path: <bpf+bounces-64430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02EB12878
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEECB585DED
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3D1C4A0A;
	Sat, 26 Jul 2025 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4sq54ke"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877FFEAF9
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493992; cv=none; b=miqYCe8nu2D382mcEbsg97r1ZzUc5yd1HjN5abq5JETnGYtN8myABa+TsP++nJLJ/FD9FaAxdBE4ZqKOYiaByxszBNI/Is7tJXoSFO3VpUOEAkOr+fV8TH7bD8j9q9+Xw3UgNEJ20RXV7qIpYf+IoPZ5IGHSlmiI6wVEs8zMPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493992; c=relaxed/simple;
	bh=n0NByDLZ2yBkvO4P7+HWKEHeoonycXxTpUUky7/nHso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQ1RhgElij8c71+S/BcJ0+RZuGMQvFdcbJP4JPNfPhBdLa0ggJmB2NJvkzxwqtgk5vN9T+6WOKaWxxjHwzjpYUis5h392vaU1nVsk6EuA/oz62iUjz7YQCnBibpjecrWOT3tH4C/M9jlyPexM2xsK0bYjzpsctrkPqvl02Zam20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4sq54ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1180BC4CEE7;
	Sat, 26 Jul 2025 01:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753493992;
	bh=n0NByDLZ2yBkvO4P7+HWKEHeoonycXxTpUUky7/nHso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r4sq54keYsrpegN7DbRS9RaTDVCglAf6eXzP/JKQ9q/CrnlSJ9UuAUH1u2V9juqjG
	 aU/qCCI9vz8FUrN5h2am9wp4/0iS6+jlnj/Sp9lCWDA52CK9l7CUUAL8uIek0ApScM
	 8RZXPI2/N7OXzM/xMpw7se/47LeDH///leBV/lhpsqAVazWpLfeOAvWmpGrbfsbD0V
	 65OJO/jZxHwvMMHrEtpYSmKUhdQLyh3t60F7ZFuefybpw6KSxSxgyGsLtmu1IusDCW
	 hs9ZjfCt3DyowrY33CtWp4dnPdvDjZA7xEdrTXbnLG7nDhMR9b6qOAHzOx00tt591y
	 PUPp8Ia2iRZ4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC80383BF4E;
	Sat, 26 Jul 2025 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: Fix a few dynptr test
 failures
 with 64K page size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175349400950.3474098.15587274643797887717.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 01:40:09 +0000
References: <20250725043425.208128-1-yonghong.song@linux.dev>
In-Reply-To: <20250725043425.208128-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 24 Jul 2025 21:34:25 -0700 you wrote:
> There are a few dynptr test failures with arm64 64K page size.
> They are fixed in this patch set and please see individual patches
> for details.
> 
> Yonghong Song (3):
>   selftests/bpf: Increase xdp data size for arm64 64K page size
>   selftests/bpf: Fix test dynptr/test_dynptr_copy_xdp failure
>   selftests/bpf: Fix test dynptr/test_dynptr_memset_xdp_chunks failure
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Increase xdp data size for arm64 64K page size
    https://git.kernel.org/bpf/bpf-next/c/4c82768e4134
  - [bpf-next,2/3] selftests/bpf: Fix test dynptr/test_dynptr_copy_xdp failure
    https://git.kernel.org/bpf/bpf-next/c/90f791a975af
  - [bpf-next,3/3] selftests/bpf: Fix test dynptr/test_dynptr_memset_xdp_chunks failure
    https://git.kernel.org/bpf/bpf-next/c/4a5dcb337395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



