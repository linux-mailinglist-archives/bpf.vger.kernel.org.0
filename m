Return-Path: <bpf+bounces-10658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C697ABB38
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 23:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E2BAF28215F
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DD47C63;
	Fri, 22 Sep 2023 21:50:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6645F67
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 21:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09C6BC433C7;
	Fri, 22 Sep 2023 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695419424;
	bh=RZkcQxyT8G1eM/kUR2hI8php6v8yomrTdHuy65WBOCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jjry1+/xS/naoA7Ygmj7DLHNMT5m8Qr9PoH1EVmtk9ul8top9t0jjxmmgi7RGVOyp
	 1EFZ0QaHgT4Fk49/QPtKkQ4dG4JhkO5lfsTbW3u4kS3kUqlR92yRuDphNJ4nZukvte
	 eTty38kqUgC+iV58sq5IdciDb0uGJf8ZhX4wD2oAJgjxXgzM1V9C4Xm84ErzBMD2Wo
	 T62LxMJ7SN+XCyZLIhYbd94sK4gppLSXu69DO+I9FfK69502cRiqgNoZkIwH9f/SuL
	 CIhEJ8Adtox325ftxsuRSu2U4TpoDT+MPsaIgp+tZEPvvpkKJZuU1pzod39Gj8SACD
	 fQy2BZOdAJqbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE5F3C04DD9;
	Fri, 22 Sep 2023 21:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] libbpf: Support symbol versioning for uprobe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169541942390.21526.2065770587891852128.git-patchwork-notify@kernel.org>
Date: Fri, 22 Sep 2023 21:50:23 +0000
References: <20230918024813.237475-1-hengqi.chen@gmail.com>
In-Reply-To: <20230918024813.237475-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 18 Sep 2023 02:48:10 +0000 you wrote:
> Dynamic symbols in shared library may have the same name, for example:
> 
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: Resolve symbol conflicts at the same offset for uprobe
    https://git.kernel.org/bpf/bpf-next/c/7257cee65269
  - [bpf-next,v4,2/3] libbpf: Support symbol versioning for uprobe
    https://git.kernel.org/bpf/bpf-next/c/bb7fa09399b9
  - [bpf-next,v4,3/3] selftests/bpf: Add tests for symbol versioning for uprobe
    https://git.kernel.org/bpf/bpf-next/c/7089f85a9eb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



