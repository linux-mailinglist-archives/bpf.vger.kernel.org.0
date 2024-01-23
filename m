Return-Path: <bpf+bounces-20144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355F839D4D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC491C25660
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36055769;
	Tue, 23 Jan 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irOEgieE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EA53E19
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053250; cv=none; b=XB++yDfDwVZeOJrW+ikEQ1P7UMERmd2b5fsZMbptAafVhIoNtBullX4Hj1TBNG0m/2nBMdCCTxW2c5HgCSMZyMNHYzpXqJincUuZhGVc4Y97nZV8xlr/Wq0MMVuQH9biphNJQrRbC19lJd3QaR0e2ifYfEFqulziNAHGvVXqKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053250; c=relaxed/simple;
	bh=ktSZETThlnXiOndCxBUyJ3GnKz8XQIYKkLGBKxXgMHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iV1aIAOYrOJ9q3f2KG7qNmoycylLcgpshk8CiYYMJZyFf69M4nc9C9vTj+r35LyH9klyPliI6A3czBhOkvrVdMLZ0+zA/NL8K62Sx3+kv+uLoP2xiGPXrue/9Qa5cbb/j6/awawDCZiXgX0A/MyOk2WqacAqp1R4ZCMzUa8z03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irOEgieE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21760C433F1;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706053250;
	bh=ktSZETThlnXiOndCxBUyJ3GnKz8XQIYKkLGBKxXgMHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=irOEgieEPE6b8IZyrE+8T1LVzZcpMHcVPt6jQZJl4m3KFd2eTy7CtM5nt1piJUcav
	 HMnOJEJhNuqM/MNEY5AauM+AVcUccfAkBcFtHJFWQ2amvNliAhJqOw0ESGstpl7XNe
	 ybIqhKwzmqSLWT+4AQmhZgX+TucKLs0VfwLY+oQHKDIe0Md+nmr4NF0HkcQRxpyKxk
	 DqNtE/O37WCPJIllukd3AF5F1O04uMscSNCZK6L88xr7WjXg/mErPttOw0IhTZQRoy
	 0hIiZzRE2rF9VrX/g6VR76ymu7TD4k1dyeE7buJ7Hs1n6dENHsFLMVh5AzEBQAev8r
	 LjSGDrtex24YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0919BDFF768;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] bpf: Define struct bpf_tcp_req_attrs when
 CONFIG_SYN_COOKIES=n.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605325003.25186.16243676644043807611.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 23:40:50 +0000
References: <20240118211751.25790-1-kuniyu@amazon.com>
In-Reply-To: <20240118211751.25790-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: martin.lau@kernel.org, kuni1840@gmail.com, bpf@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jan 2024 13:17:51 -0800 you wrote:
> kernel test robot reported the warning below:
> 
>   >> net/core/filter.c:11842:13: warning: declaration of 'struct bpf_tcp_req_attrs' will not be visible outside of this function [-Wvisibility]
>       11842 |                                         struct bpf_tcp_req_attrs *attrs, int attrs__sz)
>             |                                                ^
>      1 warning generated.
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] bpf: Define struct bpf_tcp_req_attrs when CONFIG_SYN_COOKIES=n.
    https://git.kernel.org/bpf/bpf-next/c/b3f086a7a136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



