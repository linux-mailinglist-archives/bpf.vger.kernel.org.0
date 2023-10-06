Return-Path: <bpf+bounces-11560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98357BBED2
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F5C1C2087B
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16430FB2;
	Fri,  6 Oct 2023 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho1T3NtH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CC266D8
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48DA8C433C7;
	Fri,  6 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696617630;
	bh=HYapKJMwFkDh55pZuS5u3momjlscFEB+q9C3waeD1so=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ho1T3NtHL5pABzFyPdjJEIlYRfLF2Rh/englAlVj0hCMGxfZfhzPb40V+Swtu9N8j
	 u/hCaTj8i5/NOdKJnRLDLvAf8LO9TjWJlbppv0P/xYjYzTb59zJDsI9QikChWuUIeE
	 c+rKh75IpJItewgijvy9LaFwY5TMUzY6YWfze/IlxklnYKrpdpEM7zWGwlVNxFZx/6
	 IRpyZXfwWF2yujfnC1Ebps67EyqgsTX7mtRg2qFuqdDOMe9l0k9aoOy9eqC/2eeVmu
	 HwhNy5MgPmrFDxfq2LiUDHg/IXxzc6ht43+pz9GIICvqhP5xy6fnxWmqDdxIhi62z4
	 uU3+ek5/Dslvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AE2EC41671;
	Fri,  6 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add pairs_redir_to_connected
 helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169661763016.20394.6643518221099866402.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 18:40:30 +0000
References: <54bb28dcf764e7d4227ab160883931d2173f4f3d.1696588133.git.geliang.tang@suse.com>
In-Reply-To: <54bb28dcf764e7d4227ab160883931d2173f4f3d.1696588133.git.geliang.tang@suse.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: andrii@kernel.org, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  6 Oct 2023 18:32:16 +0800 you wrote:
> Extract duplicate code from these four functions
> 
>  unix_redir_to_connected()
>  udp_redir_to_connected()
>  inet_unix_redir_to_connected()
>  unix_inet_redir_to_connected()
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Add pairs_redir_to_connected helper
    https://git.kernel.org/bpf/bpf-next/c/fdd11c14c33b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



