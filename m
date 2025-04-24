Return-Path: <bpf+bounces-56609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15BA9B188
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85A77ACF9D
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F819D890;
	Thu, 24 Apr 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0lzSHoV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF4190664;
	Thu, 24 Apr 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506191; cv=none; b=Q+gONcztBxt7L4xmxApZXNAeMt7WvhiyYZHBrLQlRZA5PC+w90mMMPWEiFzoGkH2niYuEdao0/9InB/Dd/+hHqFQCPmmzdCak4sGtnwOTHy6Sa9ISxvJadm60JpPqLqN/OhBOkQUKGDvWlo3NSNRVAk6Cq1Hy9HrWrvrkCA8jio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506191; c=relaxed/simple;
	bh=k/4SzJ/S8zT753squp+17vR/XCXBVuMwAFfFZS9idHM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KQFqmu8pb2nvCBtxQEbuArXktCj+g7Yn7QVwglv9+6Jln5A/mv5XpCLZUvJYRkNNFxYCMeAzAQJTNqCGd0EgzO190+m0jkyWqxKKByvCuY3Tx6R+rHbgEazUF0PbgcmW3ptlbu+HXjpx/LBev29d/TgOfBXqcv7WgLXyLM3S3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0lzSHoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B440C4CEE3;
	Thu, 24 Apr 2025 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745506191;
	bh=k/4SzJ/S8zT753squp+17vR/XCXBVuMwAFfFZS9idHM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0lzSHoVNVxd4EGRVcX5nwX26NYmkyiO2BN90EkHe/fQwQ91qrvlAXFKQx8yPMoce
	 3aX74rEDRXEcPLjRXovr3zuBMyIz9WpbsSH2ADKOtwzqLlDTUQWrdx8gEKIiFIX/Fh
	 DbghI6orUhV0Vyn+LcHOUDp6uGvb7s2eBVvf5xGsz3xgknX3U9mM/3tb7WaRo3rYZb
	 9lp2zrf8ZJxrMC5uTPgdvqr/6X4smQVdhtjPpgF3ow2XpaOvE6REy1rztv448eJLQV
	 2eatpAcjq73Bn8BewNnyGIqH6khPTUhPcybg4R0gGjyarVZ9syzznbn4RJ4jptels6
	 Llbhff9R4QEmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A0380CFD9;
	Thu, 24 Apr 2025 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: iterator: Rectify non-standard line break
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174550622958.3379613.5622744579499628281.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 14:50:29 +0000
References: <DB66473733449DB0+20250423030632.17626-1-wangyuli@uniontech.com>
In-Reply-To: <DB66473733449DB0+20250423030632.17626-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 void@manifault.com, psreep@gmail.com, yhs@fb.com, zhanjun@uniontech.com,
 niecheng1@uniontech.com, guanwentao@uniontech.com, chenlinxuan@uniontech.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Apr 2025 11:06:32 +0800 you wrote:
> Even though the kernel's coding-style document does not explicitly
> state this, we generally put a newline after the semicolon of every
> C language statement to enhance code readability.
> 
> Adjust the placement of newlines to adhere to this convention.
> 
> Reported-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> 
> [...]

Here is the summary with links:
  - bpf, docs: iterator: Rectify non-standard line break
    https://git.kernel.org/bpf/bpf-next/c/4cc20482143c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



