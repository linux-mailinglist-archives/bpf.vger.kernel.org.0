Return-Path: <bpf+bounces-48267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72264A06391
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71479162B31
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55F20010B;
	Wed,  8 Jan 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N21TPvcf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1D19B586
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358012; cv=none; b=U9SDxjse4UmBFXE9YQZLYwQUAcjVS6VEgvrliL+9Gu5TX5i6cGcYSsxQLOOb/ewm/RhrDBwxajI5fP1YOan8TM+sQ3pdjWG0NCG36HxcRmqEFr76OQYjnhvttrEXC+IUDqwIu0sQtgGrSPlm7ELyLk1PyJdZx6Ig+XXBzlYMEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358012; c=relaxed/simple;
	bh=vbm2srfkln32i+VOsLCcz5HEdVXyOJ2/jbeogcgtya8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m+oqaVFeh2N0IkNOlenl1XbYDaKkm8lAetuyaoWs3LOp7WcJU6mvhrESfNjrFqlIj6inEVFksoyXjLVl8+z7S9D/ItkWXEiV2MkYl8T3hIwJuZQ543FEtiyVsQnmAPdznjmJJuimyFSblHC9NCz+s4Co4V7Qj+yV5cSftF2Uau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N21TPvcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB5C4CED3;
	Wed,  8 Jan 2025 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358012;
	bh=vbm2srfkln32i+VOsLCcz5HEdVXyOJ2/jbeogcgtya8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N21TPvcfVzcpqUjCghGaz2aYOapIQl9jrtYa3Fpkx2mSnfaQHstWmJWALRqBqo0Tk
	 keyAP89r5uGvIIDDIOPNlT0S5RRKkWb3GsrzgMw1XNTJoQVDhTNSOSSlndYtRpYpPm
	 7vrZYzDZpvrtO6MQQ0QcNrLEebvI9aiPMOplTqxX8t1/nLDlqnjAAkHFsZJXBAUNsx
	 hHjPr66KCQKh63s2jNvhEv0K8YUdSwUPgfDhuJ5v6gr376E+2/+0vv7uI0U2wflLul
	 aX4YZngEgzUTNpmF5LiZAcNijrluFqokV2h88Wt6oPZ35d0e34d3qPvxWyDvEGjeau
	 SsejSPX1woPXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7149D380A965;
	Wed,  8 Jan 2025 17:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173635803426.725872.2212081616637030699.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 17:40:34 +0000
References: <20250107235813.2964472-1-ihor.solodrai@pm.me>
In-Reply-To: <20250107235813.2964472-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 jose.marchesi@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 07 Jan 2025 23:58:18 +0000 you wrote:
> Latest versions of GCC BPF use C23 standard by default. This causes
> compilation errors in vmlinux.h due to bool types declarations.
> 
> Add -std=gnu11 to BPF_CFLAGS and CFLAGS. This aligns with the version
> of the standard used when building the kernel currently [1].
> 
> For more details see the discussions at [2] and [3].
> 
> [...]

Here is the summary with links:
  - selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS
    https://git.kernel.org/bpf/bpf-next/c/bab18c7db44d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



