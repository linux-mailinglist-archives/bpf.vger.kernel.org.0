Return-Path: <bpf+bounces-41179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA37993D86
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4666F2831B1
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B3137772;
	Tue,  8 Oct 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+f44Dlv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D77E0E8;
	Tue,  8 Oct 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358232; cv=none; b=dPC+TxtRjJOs81ay53tbVQzR58N247LGIl9bpHwj5ejfJCVWN6DcjkJVSJ6KBS6QEWk2pS3vcjYJgzKcTWBtVj21SaOvcyJ6jydde3kD1J1ztzIJcKHY1/KlIQpQ6YcEDZzo2KkZcGx22MWZDqMKhEi4ks0GJP6e+OaJE5lZoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358232; c=relaxed/simple;
	bh=t4WHWLLYzEObBAy/O2ZTHtC04EG74x13mGAys4rk6yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mzSEBOu2+Q6b+bQxdFMy+1V04Qz8gui5shobu9M5/7z5EeyQusVpwPxm9x2aaOlsEYmNk54mR4bKkauG4paSUscX3aMiKQL2XQzKRUTK8jmZn//dZer+m1ODzpeTcgZxmliXgGT9EFMOMLTBai0x3TO7CLUm6g0SsHv4AIl9NVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+f44Dlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2977C4CEC6;
	Tue,  8 Oct 2024 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358231;
	bh=t4WHWLLYzEObBAy/O2ZTHtC04EG74x13mGAys4rk6yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l+f44DlvlYXYXsFYw7uNh2MNdw/bpvqR/Suhsuevd/bQzKJZ0YNVZ/PS5ZjTiFO5s
	 tk3WgsbNNhUw0l0bArAiUCdtaGWutvJUVcmjRk3u8GsxtcbbvHsylHpF7w+PM7fpMg
	 CvWl02nk0+ZL1xpIUlUJHvrpIuMlIw0pJxUAEleWatVZdr+fxSkkpufayJst327ryp
	 iQzsN03EkOzraAeT22DRDye0Alb+3zgLUvfCg4t0EdhwfZwtxyM3u275Z8N6XqUDMM
	 TfmyCDv7FySMaFvQcXd5LEwJbF5wYLWgYXOf9kmopL5fhqnxQ9QDzosHWnF8XyJzjM
	 GAHrgumYv3yOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3D3803262;
	Tue,  8 Oct 2024 03:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2] bpf: fix the xdp_adjust_tail sample prog issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835823598.66789.3944630078344989491.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:30:35 +0000
References: <20240930024115.52841-1-chenyuan_fl@163.com>
In-Reply-To: <20240930024115.52841-1-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: ast@kernel.org, andrii@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 30 Sep 2024 10:41:15 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> During the xdp_adjust_tail test, probabilistic failure occurs and SKB package
> is discarded by the kernel. After checking the issues by tracking SKB package,
> it is identified that they were caused by checksum errors. Refer to checksum
> of the arch/arm64/include/asm/checksum.h for fixing.
> 
> [...]

Here is the summary with links:
  - [v2] bpf: fix the xdp_adjust_tail sample prog issue
    https://git.kernel.org/bpf/bpf-next/c/4236f114a3ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



