Return-Path: <bpf+bounces-54003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2FA60355
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A1189344D
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFC1F471D;
	Thu, 13 Mar 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cof0uc0c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61084747F
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900805; cv=none; b=asoJvXuEZw4hRa7YIhY1yWu4294PH6RJStm+IfRetxw9lAN3sVFbHhcPE8gUy39GlCu+hxmtgZHXyurQVkpy/NQ9Km9Dd3sBUPeU1iTzKjoEFMCZzuLJEaU9NiZIQrAACrCETR/fyPwupKrsCaPOdWQbJiX6RymW1Lq04cOll/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900805; c=relaxed/simple;
	bh=3PijNp+fIniicuORrEodXRcQwNsIYjgVTxzYp2xhNkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SuTnmGHA6BQAqVZ5ZyxTXyNP+1DEy/WtXrirHV1AmWPrFut1xRY733m/yV+AFa5MMRYShSLbgpld9RWLGTAnUbI5tI3uyfUvM/g5JQAcMiLOQkGdLSqyX6MXuvRhT7Q12Tai7UaNakYPGdoRrhDPt98w5pi/EdNoMAfvxccwGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cof0uc0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB77C4CEDD;
	Thu, 13 Mar 2025 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741900804;
	bh=3PijNp+fIniicuORrEodXRcQwNsIYjgVTxzYp2xhNkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cof0uc0cDjz2z6xjC8zb8IWICMWGUbTfx7ER4BoMAQ1CPG1VSJbBvFiEa260GDfkm
	 WGiE/WuropBe3rCdbFY4VlfA7HP6BcKcUyaez7c+yLaV22X0dPgXm4OtFzbyD9l2yj
	 +3fmd/y9VmwMns8dtp8eDVU/08iiNu/Q253Of8z0wt6ygzOUaTR/YJ6u62orx5svzP
	 7onHZPhR7qhI0Wd2XFNsUlc89PBhvKmxG0f2DQloXdGVQregccBplQ2Q2pth3bipo0
	 W+vJW6QPlFkmy4oyYKrD3dLFVi6sEXXzAUZCx1xrDvn+YsegLryTWNorCFDHABEcGA
	 gyvDg6gYm+WWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7763806651;
	Thu, 13 Mar 2025 21:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix string read in strncmp
 benchmark
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174190083952.1666043.609968556188949252.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 21:20:39 +0000
References: <20250313122852.1365202-1-vmalik@redhat.com>
In-Reply-To: <20250313122852.1365202-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Mar 2025 13:28:52 +0100 you wrote:
> The strncmp benchmark uses the bpf_strncmp helper and a hand-written
> loop to compare two strings. The values of the strings are filled from
> userspace. One of the strings is non-const (in .bss) while the other is
> const (in .rodata) since that is the requirement of bpf_strncmp.
> 
> The problem is that in the hand-written loop, Clang optimizes the reads
> from the const string to always return 0 which breaks the benchmark.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix string read in strncmp benchmark
    https://git.kernel.org/bpf/bpf-next/c/956e816deb34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



