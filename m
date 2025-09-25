Return-Path: <bpf+bounces-69792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E80BA1EEF
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5CB1C25FBE
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B682ECE97;
	Thu, 25 Sep 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzk54N7w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7181B21BD
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841811; cv=none; b=Kpxn5Q8jmaxDZfH0FbYpR/JgtD3IdfRkbIf8wGN9bYEPP5OpHCBpDtZcGkIitVB8BNjnXz8FGeHAqky96hBETvy7/dfGom/FBnmL8++yugIm9aUCBBtilZIwExncdAqhadSIYBjk/+WFC4tkuXw+FllVHoNDtHvik8nKMl5YJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841811; c=relaxed/simple;
	bh=inMLMBQusDSABUvjEOUMnmDB39eejFm2HP8Kf7xBMGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ya/oFhOEIsuuXe4HIXxubPF4St2Ntpuvpl6mXaoHJXvJmVmuKbahxO1FqaA0gH4tYGV2lID2XfMiBANMLRa0bPgemD8cRyT3LDP8CDlz6ACj9LlUfIGDJl9c5LSMtxPXz7mIXphDWNhqd5xPJLdntNCHru9EG8WOd6xHfa0jEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzk54N7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E98C4CEF0;
	Thu, 25 Sep 2025 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758841811;
	bh=inMLMBQusDSABUvjEOUMnmDB39eejFm2HP8Kf7xBMGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzk54N7wTPf0UjOHTSwWESPkAEf1T+d10yBsaE9EW+wTnE4n2WwsAdfJELAY7w+PD
	 2IxNZeMySqgsSdslWwC5jkEiAPxKo+9aEXmzANX5s4oRGrJ7G9fRLb0Nj0D25m98yE
	 Ka8z1sZEvZoaRJ6FnWcqjxvk+KyvY2QeMRUy+pmDQxEJjmdJOjbIK5uEjTvuYEEiX2
	 XROQ2z0YNcWjrji5VamIHoFd2xo1EMPYAhP/qoPKQRrvbEyfaX0H2MdBCkev2vC8KQ
	 dmHZwqbAG91wSCgXIPe1HWxMox+2oWCQEP6XiBgVp6PAyKiUUkLECqPm9ZsYGIyjAb
	 sH2lGf2ZJfydA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1339D0CA0;
	Thu, 25 Sep 2025 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix flaky bpf_cookie selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175884180676.3552688.9361128567774914034.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 23:10:06 +0000
References: <20250925215230.265501-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250925215230.265501-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 25 Sep 2025 22:52:30 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf_cookie can fail on perf_event_open(), when it runs after the task_work
> selftest. The task_work test causes perf to lower
> sysctl_perf_event_sample_rate, and bpf_cookie uses sample_freq,
> which is validated against that sysctl. As a result,
> perf_event_open() rejects the attr if the (now tighter) limit is
> exceeded.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix flaky bpf_cookie selftest
    https://git.kernel.org/bpf/bpf-next/c/105eb5dc7410

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



