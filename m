Return-Path: <bpf+bounces-39373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A47972581
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17DD284CC1
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906318DF8F;
	Mon,  9 Sep 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnyL6Da+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3C18DF7C
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922829; cv=none; b=e28fB6s5qr4LXpoR3ujBOfrm2uof4W7pHSPvZNJIYsgUL9RHaMR0g9rfOrPMngCHbi19S1nljF0+FsfsOMq58qKyQnUamjTur30Zo3hcU82mCHH0hHzZ7uKPoRY72pKYee5khU0igwwuFZFoDk6L/r7SfsY+KMUzlV+UwQ7GPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922829; c=relaxed/simple;
	bh=OjVvjOGY6Zm2+fsVp+MLQ3xLmqrpeYvT90dytDbS7Rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d0MHKw8L0Pk9v4nbwCxr1uCGlNNykLd6lPMkPZn9Fg/4MRzBLiiMdRYTlhYiysHDpxRMWxTgtTVC3P8yhvJqHm4vkhy/yayBcckbfZoZKlbngr5dE6cZ3uAsxeHvRHUlyZxn4sVygzLmYAwq+vLgt+T86Jc5i4wEmMTlzwvQipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnyL6Da+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF74C4CECA;
	Mon,  9 Sep 2024 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922828;
	bh=OjVvjOGY6Zm2+fsVp+MLQ3xLmqrpeYvT90dytDbS7Rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PnyL6Da+lFSUHDnRIOmhe2HAss24EoJlrqTullr+G0d3R/KM89k7D8wA8AAztqf9a
	 1rWxqmccP4A5M6DQmD+/JqoNhIhwFjfA/qo5NDM5Gs3Av9pTO6KQYYr80o4y46lluk
	 Z/mVqhr9wO1n32yuGg8OnwcRTtL9gh/CgvgGOJXucNjQcGPPtppoZb/mIJd2DwytkS
	 QTIytuxV4KuncAQ7xzg75Zx41uBl2xIMLxUg04iUlJJjoxCCixlspKNoEWgs128whW
	 xBISJhJN3xfHdFi6i5YXTok7w41mNuFX/SULPlAeaS5Ik5WspYYUb93KSyPp0WnEP5
	 5Fd6PyO+VX56A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00E3806654;
	Mon,  9 Sep 2024 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fixed getting wrong return address on arm64
 architecture
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592282951.3949024.4673736502035872750.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 23:00:29 +0000
References: <1725787433-77262-1-git-send-email-chengshuyi@linux.alibaba.com>
In-Reply-To: <1725787433-77262-1-git-send-email-chengshuyi@linux.alibaba.com>
To: Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  8 Sep 2024 17:23:53 +0800 you wrote:
> ARM64 has a separate lr register to store the return address, so here
> you only need to read the lr register to get the return address, no need
> to dereference it again.
> 
> Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: Fixed getting wrong return address on arm64 architecture
    https://git.kernel.org/bpf/bpf-next/c/12707b9159e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



