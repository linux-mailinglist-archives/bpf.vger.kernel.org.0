Return-Path: <bpf+bounces-11980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C357C61E6
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5536C1C20BCC
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34591654;
	Thu, 12 Oct 2023 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLaY1QcI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06F62A;
	Thu, 12 Oct 2023 00:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19AB7C433C8;
	Thu, 12 Oct 2023 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697071227;
	bh=eTY0ERKmxkock4XhJFgZPIV0F4b1kmzrpjA/qhFbPkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QLaY1QcIZNN3qfif7QI6TanwEyRjc7m69m0hoTetiSTTPaA8QvwXvjtpapENc36WY
	 bRESY1RHw9HGTvJc9Va8+TPSkhvjJnqIiWtJV758MKEjsZgXIaY92WSpRMfiAHkSAT
	 JWlCxyQU3TZx4gN55apsJWifsM87z/6TGt5CNJkBikIAG7cOBPy3DJMGI5yrB2TI0/
	 BvboGu7ousC74y46YnRZod54VeBQvSFfqSXdxr2hkeeYUG6A3loOZ8rdai/2vm1hpa
	 ckp0XqZ/xvA3WkrzTlTxqQoMFIPjXglcwgE4QptFX69glfFK7dayUJaxAUt1huptLm
	 j/JG5nihvRJlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1C74C595C4;
	Thu, 12 Oct 2023 00:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 0/9] Add cgroup sockaddr hooks for unix sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707122698.23011.1563941211051179589.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:40:26 +0000
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 11 Oct 2023 20:51:02 +0200 you wrote:
> Changes since v10:
> 
> * Removed extra check from bpf_sock_addr_set_sun_path() again in favor of
>   calling unix_validate_addr() everywhere in af_unix.c before calling the hooks.
> 
> Changes since v9:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
    https://git.kernel.org/bpf/bpf-next/c/feba7b634ef0
  - [bpf-next,v11,2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
    https://git.kernel.org/bpf/bpf-next/c/fefba7d1ae19
  - [bpf-next,v11,3/9] bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
    https://git.kernel.org/bpf/bpf-next/c/53e380d21441
  - [bpf-next,v11,4/9] bpf: Implement cgroup sockaddr hooks for unix sockets
    https://git.kernel.org/bpf/bpf-next/c/859051dd165e
  - [bpf-next,v11,5/9] libbpf: Add support for cgroup unix socket address hooks
    https://git.kernel.org/bpf/bpf-next/c/bf90438c78df
  - [bpf-next,v11,6/9] bpftool: Add support for cgroup unix socket address hooks
    https://git.kernel.org/bpf/bpf-next/c/8b3cba987e6d
  - [bpf-next,v11,7/9] documentation/bpf: Document cgroup unix socket address hooks
    https://git.kernel.org/bpf/bpf-next/c/3243fef6a4c0
  - [bpf-next,v11,8/9] selftests/bpf: Make sure mount directory exists
    https://git.kernel.org/bpf/bpf-next/c/af2752ed450e
  - [bpf-next,v11,9/9] selftests/bpf: Add tests for cgroup unix socket address hooks
    https://git.kernel.org/bpf/bpf-next/c/82ab6b505e81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



