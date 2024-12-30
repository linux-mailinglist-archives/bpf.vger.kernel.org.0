Return-Path: <bpf+bounces-47716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E409FEB8D
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D899C3A27A1
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F31AAE33;
	Mon, 30 Dec 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRZpkix6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15ED19E99A;
	Mon, 30 Dec 2024 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735599617; cv=none; b=fVLGYxurPgTe2M2lRGGtEBfN1XcfRgoBHWpMwTgGlpxgwI6ZgzoP2Sce6MODCq1QYHBVlQMg3GXncXZyMNXB754nENnARGkmmbkHz41xMPLaYfKKOSCW6ntIKTJgsKqiK9z0XDNE3wTv/OCxXiZ3QoWE4ZXi2kVAsZrYeaEBTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735599617; c=relaxed/simple;
	bh=f6EGxIhfFEszlQ3igzqXNyS7VM7zdpPzD6wc0MePv3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u9+k257sFR77HuJ576mowOGi71enlj1QdU2ko7hItmP53L0wjUYnYoa8auuPTheSz+abmnOdb9T7m0zFiC4ZCQ+dvrkCalx+3P8/aS4UsKHjxRGnACxylMcEM2UWTFH6kEcz3qu0UUmKQ40h5E/lgknjQk1cVUcQ5W6gTHB/Go4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRZpkix6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30537C4CED0;
	Mon, 30 Dec 2024 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735599617;
	bh=f6EGxIhfFEszlQ3igzqXNyS7VM7zdpPzD6wc0MePv3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lRZpkix6b9swoimdD5SdOVMjrqEbHhGm01e8ZG8Lfbwwah8XPZBZSKOpgO9iJ2YO/
	 67B/VinJ61AQOpxkIahnZjWD6NZF+n2gJZUAPrDzIRt7jmdBgKN/r5QMb/hkhqKq8h
	 ljSwZTtoBvjyzWrhSZWhZ9sfSo54iK2ieCGI/chNZMvSiIpF0ystYKcE4Wq9r3VCqB
	 4RyovJyWdYIhh59rezguVJKP256fU+ViYJV0BjGriO2DTHjJDBvFj/UxIkI/cw1EqR
	 BbieGlk7T94U22WGx0OnHeM75P4CGAq0YfAcdXc0Fsn3wa2ccqZj0UiDXMRsPqwXPi
	 BpK7fgD0XJSUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1C380A964;
	Mon, 30 Dec 2024 23:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Set MFD_NOEXEC_SEAL when creating memfd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173559963675.1460841.7357730511716480117.git-patchwork-notify@kernel.org>
Date: Mon, 30 Dec 2024 23:00:36 +0000
References: <6e62c2421ad7eb1da49cbf16da95aaaa7f94d394.1735594195.git.dxu@dxuuu.xyz>
In-Reply-To: <6e62c2421ad7eb1da49cbf16da95aaaa7f94d394.1735594195.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 30 Dec 2024 14:31:22 -0700 you wrote:
> Starting from 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and
> MFD_EXEC") and until 1717449b4417 ("memfd: drop warning for missing
> exec-related flags"), the kernel would print a warning if neither
> MFD_NOEXEC_SEAL nor MFD_EXEC is set in memfd_create().
> 
> If libbpf runs on on a kernel between these two commits (eg. on an
> improperly backported system), it'll trigger this warning.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Set MFD_NOEXEC_SEAL when creating memfd
    https://git.kernel.org/bpf/bpf-next/c/1846dd8e3a3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



