Return-Path: <bpf+bounces-70919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B2BDB0A5
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 21:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FA3D4F621F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB22BEFF9;
	Tue, 14 Oct 2025 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgA+Zi48"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14439246BDE;
	Tue, 14 Oct 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469623; cv=none; b=oKcjIJKmoKuxZDaR+lgwDRGzR3bYhDyYZ2n3eu0SYsmZ61tQ8Gu+lIJvnjZf242UrPOC80Yvm2lC/9KnVOXAGxqo/d1qTBhbzf6JroMZHK5xlvO8Sff1mPVdZEd1aS09j6CSUQPpdw7+C4OuR2Gt6nllz9vfDWl0M4Y6YVAr7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469623; c=relaxed/simple;
	bh=Hj0CfW/gyUFp3WT623hdxlLNz9i7j18daeSMezlD0WE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ekIGG5/yoOq+plArmuWxTbtLUDX6oNdY6aM2T5I9Jsdw3QMZYc02p/+7U74KhkUilvwA7GpVECtAN9a1HoOSBj0hPBRxYcqU57QUfHKFYGCd8lCzIPh7AZjVLejwAo8xFUnCveVjQJO8FDS1ZDTTe1SN3uqqM2RWWM88m2zkF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgA+Zi48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C7C4CEE7;
	Tue, 14 Oct 2025 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760469621;
	bh=Hj0CfW/gyUFp3WT623hdxlLNz9i7j18daeSMezlD0WE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MgA+Zi48eTguL8DX3dctA0pnnB5PGDh1U0flQqmUPcgk6ZZ1CeTNTpULxOnO+3efs
	 KmBtCpskVBV8XTGWjoLljXDsSYoBpppuzqJnaB9iGxOeBdISdDlXOxsBpqW9IlQyS2
	 k07aU21lUCcsiMscOobkDdMsRWXdoaLc888qCpic+Lc/wT491x4HLkG8rFc6Jo6akt
	 FNhMi5rFJhfKOfKjGxw35Ttim+X5Gzfix31JM7ZPJodhYT1bIzRMfqrUoM+kjKsh6c
	 GRNSbaSCuYOzuoKim7FiHdqe6ype8O4dzCfyiqjdTx/e5OEEBR+uloLS1WPRNBNXFl
	 E915ybOyjZzEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB299380AAF0;
	Tue, 14 Oct 2025 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/1] bpf: test_run: fix ctx leak in
 bpf_prog_test_run_xdp
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176046960676.63650.4776306407784411161.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 19:20:06 +0000
References: <20251014120037.1981316-1-shardulsb08@gmail.com>
In-Reply-To: <20251014120037.1981316-1-shardulsb08@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 14 Oct 2025 17:30:37 +0530 you wrote:
> Fix a memory leak in bpf_prog_test_run_xdp() where the context buffer
> allocated by bpf_ctx_init() is not freed when the function returns early
> due to a data size check.
> 
> On the failing path:
>   ctx = bpf_ctx_init(...);
>   if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
>       return -EINVAL;
> 
> [...]

Here is the summary with links:
  - [bpf,1/1] bpf: test_run: fix ctx leak in bpf_prog_test_run_xdp error path
    https://git.kernel.org/bpf/bpf/c/7f9ee5fc97e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



