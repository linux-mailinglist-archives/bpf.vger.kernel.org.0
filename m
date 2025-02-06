Return-Path: <bpf+bounces-50664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F835A2A7EA
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42173A3CEA
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308822B8CD;
	Thu,  6 Feb 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibGnIqIf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F286214209
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842603; cv=none; b=QOYwdd/dHC2RXB673PJAcY0WfjJTHGbO6LtZIBTxmPWKJRe8qbkMj9aCwlcOeI/6ZeqlqQ0RNa7wcRxI2q5AUoZJ3bt+mxHrNbMdd8fL6urNvLuso+oasH+4O9Xbe755jDUaqZT/Y+/+LaheIa/31IAk0VXunqCt4R19rsQYxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842603; c=relaxed/simple;
	bh=EeI9jGgkEEZsw1Tyzxs9vy/9+vAB79PltlCgby1GPpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZgdVFGZHmdwyyWVPcx+xS4x6YgO7BzBMbnoO+DM0QnpBo+vVRAQSWz9eFbT/KTy7Pcc4FZu7Ryjaxkvl9tZbHgtbCkUwXSGoWvTxm+Te1xAtH1ZIOjve7yaN16ywfdmhNVpgYilAjVlqQYKX3M5ytWXC105iO4nknQQoAy2R7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibGnIqIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8CC4CEDD;
	Thu,  6 Feb 2025 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842602;
	bh=EeI9jGgkEEZsw1Tyzxs9vy/9+vAB79PltlCgby1GPpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ibGnIqIfqvjntglO5zDzXMiaqZM7DV6d/2fRM2eLCVe9FQ9zgV5cqUvOM6SNXMZiT
	 rKD+lAdmCbixsdHKFM/Ups8biwsFMCAmzRlsDyVjB0GI8z5/htCR2oUvaMnjKMVAVI
	 gtvotDbHwd86t9KaaclmGSKG/92sqMEMO1oN9XsPOATDE2flXvF5NNkJyN4WPzfmoS
	 AlvokWZAEeXiphAi9OU+Rjw6CSEcTwlDlnjUDikvZxhP+isf2aY9zKNjO1fLFliNnQ
	 GOujj4DETWflzzbgp/N1I8XgJkpafnpHb3pX1kuRRyhGucGWtFjBaCGYdxOeV6lgD9
	 qCva4n7HaVHCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7120E380AAD9;
	Thu,  6 Feb 2025 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] bpf/arena: fix softlockup in arena_map_free on 64k
 page kernel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173884263027.1450777.2550898579870196871.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 11:50:30 +0000
References: <20250205170059.427458-1-alan.maguire@oracle.com>
In-Reply-To: <20250205170059.427458-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 colm.harrington@oracle.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Feb 2025 17:00:59 +0000 you wrote:
> On an aarch64 kernel with CONFIG_PAGE_SIZE_64KB=y (64k pages),
> arena_htab tests cause a segmentation fault and soft lockup.
> 
> $ sudo ./test_progs -t arena_htab
> Caught signal #11!
> Stack trace:
> ./test_progs(crash_handler+0x1c)[0x7bd4d8]
> linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffffb34a0968]
> ./test_progs[0x420f74]
> ./test_progs(htab_lookup_elem+0x3c)[0x421090]
> ./test_progs[0x421320]
> ./test_progs[0x421bb8]
> ./test_progs(test_arena_htab+0x40)[0x421c14]
> ./test_progs[0x7bda84]
> ./test_progs(main+0x65c)[0x7bf670]
> /usr/lib64/libc.so.6(+0x2caa0)[0xffffb31ecaa0]
> /usr/lib64/libc.so.6(__libc_start_main+0x98)[0xffffb31ecb78]
> ./test_progs(_start+0x30)[0x41b4f0]
> 
> [...]

Here is the summary with links:
  - [v2,bpf] bpf/arena: fix softlockup in arena_map_free on 64k page kernel
    https://git.kernel.org/bpf/bpf/c/517e8a7835e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



