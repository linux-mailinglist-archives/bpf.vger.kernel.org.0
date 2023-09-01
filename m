Return-Path: <bpf+bounces-9099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1AB78F9E4
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4841C20B50
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438148F68;
	Fri,  1 Sep 2023 08:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBE8BEA;
	Fri,  1 Sep 2023 08:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D3EC433C8;
	Fri,  1 Sep 2023 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693556424;
	bh=ZAki2J3DFnvCqnO/0ecTpuZXnK93mx8u2neEFWdSBds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZXl5Oj/kYOrJxIxR3h/uYk8ikQRynnnwX2yuyPMfLFmmizejXeOYsk0NuivvlDXxi
	 rzanK/x3kN1I4DSMB6LIjM7uOVVF9vTeuzdqj3ImKxYaEYncJ7vnM5rOYDumuwPwsS
	 6zjy7ESZWUT0uTEMXuO9xCOKYviMxroP9JClFn03gfAnxmyYA78jA0SqkSYDWsRv2f
	 vXZn1Js8e6WCbF9zJuy40GFbUnZc2PETb6SzXQswXUgt7ZLCjgWOepijLb16P8cSly
	 NPmjGXXXbGrSlZaj5AB4MgWsoX7zJlQQVNdP6kfSrdirszo7NQyQooxLBX9ey+1V0A
	 MxLm4VX6sNYEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CDA8E29F3C;
	Fri,  1 Sep 2023 08:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix a CI failure caused by vsock
 write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169355642437.27368.3865294006849826443.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 08:20:24 +0000
References: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 bobby.eshleman@bytedance.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  1 Sep 2023 11:10:37 +0800 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> While commit 90f0074cd9f9 ("selftests/bpf: fix a CI failure caused by vsock sockmap test")
> fixes a receive failure of vsock sockmap test, there is still a write failure:
> 
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>   ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>   vsock_unix_redir_connectible:FAIL:1501
>   ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
>   vsock_unix_redir_connectible:FAIL:1501
>   ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>   vsock_unix_redir_connectible:FAIL:1501
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix a CI failure caused by vsock write
    https://git.kernel.org/bpf/bpf/c/b0193c731e43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



