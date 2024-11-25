Return-Path: <bpf+bounces-45597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE589D8E88
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B9816941D
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7F1CF2A0;
	Mon, 25 Nov 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU/jg6da"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA51C4A24;
	Mon, 25 Nov 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573828; cv=none; b=d0aYGpNVWi5qRTXjUB8pGQFbmcKaIFey9i7cCi9hpsZP45c5Xsrcrz4jKHpkcr/Sf45Zh5IJwE05CQfnyuoEukAjudoc2o7Jju2H3m+BJsmVv+/Kf7Z1Sr5Ow+j2EPBM4PW0sIRv1IlXQgHdYFs92SF75HJODlJ4An8aKb55rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573828; c=relaxed/simple;
	bh=3Ze8WNZVIEs/3RRPaixDwQG12MEeQYAGjjwqmum/cvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WKn7WTQqH7NxY5Viyo5bV55/R7VwycRP7eWhuEtUOG0IS2kRBkaoXlXSvaOVcK989KUmVdpdrHQAz5NyMruobKb4JnMHjEpQMwNIp83rNMICNceALcxjIcV4FUWCXaVH2xdv4rSRe4ODNKxVtaOTOHYz07yk4zSZdqyTaB9oED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU/jg6da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137BDC4CECF;
	Mon, 25 Nov 2024 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573826;
	bh=3Ze8WNZVIEs/3RRPaixDwQG12MEeQYAGjjwqmum/cvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QU/jg6daM+VXtQFteZuvT6AiFRUmvLdB4g3bst2ekFVhnonhTi3QgLUKn/Yc5VJhj
	 BTLa1ztYEmbW/6Fe2fI/iVpk4lRHQWt4cAubaDt+J1bRHZ1bNQsW/YJivcHa4pfBto
	 lCNpOu9dzvpgfFvY3PGAMjYkjp3u0Pv9eLTlIy/0UU3JTA2GxIbhL7JwTNEaOjW3Yc
	 xe15aePfTY5/IUuXibBLH0KV02xHKnxnkwnMpr6ad+SNkAewbX9g9nZLW6X+HJ9fr2
	 IiSJkWALgxXDwT/tgGwZ80FNjbaYhtuaJKZg01s1eM//1OBTkGvfl5F38NMqAJGOPH
	 PHQ660GZqumyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8A3809A00;
	Mon, 25 Nov 2024 22:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpftool: fix potential NULL pointer dereferencing in
 prog_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257383850.4058254.13003653135433020600.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:30:38 +0000
References: <20241121083413.7214-1-amiremohamadi@yahoo.com>
In-Reply-To: <20241121083413.7214-1-amiremohamadi@yahoo.com>
To: Amir Mohammadi <amirmohammadi1999.am@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, amiremohamadi@yahoo.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Nov 2024 12:04:13 +0330 you wrote:
> A NULL pointer dereference could occur if ksyms
> is not properly checked before usage in the prog_dump() function.
> 
> Fixes: b053b439b72a ("bpf: libbpf: bpftool: Print bpf_line_info during prog dump")
> Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>
> ---
>  tools/bpf/bpftool/prog.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [v3] bpftool: fix potential NULL pointer dereferencing in prog_dump()
    https://git.kernel.org/bpf/bpf/c/ef3ba8c258ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



