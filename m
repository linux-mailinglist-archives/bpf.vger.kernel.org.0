Return-Path: <bpf+bounces-57135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A994FAA626F
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 19:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB281467432
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C668218E96;
	Thu,  1 May 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ+Qd8Gx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F02DC799;
	Thu,  1 May 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121190; cv=none; b=V+EfLH0LxOX5pG5PK/TfZ5tHxe5h1IoM/lTcLy7mdHZWIUxQnvVljDkFeRLFsXFKAyMW6K4mrpVOTWpkQT137qhLFISdnITsrtxZzwwgU957OTvf9dQOavJGpVq1oEPfrDDtRl+WE5k01jGdc8Bmcyh6ogyYly9p0zXSXvBeV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121190; c=relaxed/simple;
	bh=gUabOZNCoxnhBsGFUC7eUgc2+woyKqEf9pb93kB0e2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uigwjNpB9xGk/YUet3BwuOEEscxbd6Hkwt/JB98/2YT+oiPnYuiBVY4i1tc4mzZZ1tP21pzPx7Prx2nEYX4wl6++IxqXfldRivuT9o3CAZDJeLU2s5PA1vHPQ34k1PKIgaH0oLIjHRo8IM3/U3mHi7zAoMdz3PWn7BkrXy9QCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ+Qd8Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE36C4CEE3;
	Thu,  1 May 2025 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746121189;
	bh=gUabOZNCoxnhBsGFUC7eUgc2+woyKqEf9pb93kB0e2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mZ+Qd8Gx95g8Bzel8ErukaGTahaHipq/wpz48uBOz8ATClHxn9PNiowFlWirrAk7I
	 OT2skGJzgrz2zFRuLuNBcYjji8en4B1Ox3axL9Wh/QFaa8C6QFQkovbt8QCrqCKPR7
	 hhfRya7Gys0LHZYO8vRrDgId6c/WjNT0XE89ro3+RTuNx20XCJO1/9WM5bd41al63k
	 lRa9OsgjOWffssWhW/Dr8YELAUUooD67U5scMfZ2EDKSRuhKKyrnoj2X1QYdAkpx7t
	 DcxS4OwzLU9TyX8WCeelwMxIDRSYKLOvw6ek7BeGadbDjsBVWFYZhK9kGCz+YfmI24
	 0w+CNO6WGcVZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2323822D59;
	Thu,  1 May 2025 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Replace offsetof() with struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174612122851.3034920.4000294220028113213.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 17:40:28 +0000
References: <20250428210638.30219-2-thorsten.blum@linux.dev>
In-Reply-To: <20250428210638.30219-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 28 Apr 2025 23:06:39 +0200 you wrote:
> Compared to offsetof(), struct_size() provides additional compile-time
> checks for structs with flexible arrays (e.g., __must_be_array()).
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Replace offsetof() with struct_size()
    https://git.kernel.org/bpf/bpf-next/c/7b05f43155cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



