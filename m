Return-Path: <bpf+bounces-46969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39899F1B5C
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F85188EAE7
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52062B674;
	Sat, 14 Dec 2024 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH3YsI5B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B56AA7
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136814; cv=none; b=HuduQARcxzmSeSZ8AIQzFlu3RoXO7ZdCdv4+Ki/p7i5C3Hw5vKTJbCXgdzAB6cw2Nod2ZZqg8h3EFot3Q0CWD2j455mux2IIJwN2s9SQ9uhF16QtOsiUO6yMe1Jt2dl1QZ0tYOOhd+cpC6km7P/e6mYL721WpUz2LmVbjx9iZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136814; c=relaxed/simple;
	bh=CiWzUrAUtTjFx0lZZZqrDMzgCnIZlQIxVI2OTYRtR3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfGOtSTDAddZYRRveVBPmCPwENZL7pJwVWQqORdOKaF/+YcFdS92CvW+azBxj3sA6N+Ib0ShYLkeVREPfHycdQkf40ZUf6a60BI1V4rVFQOun+J9BLYkf4Du9rYgGUmGAePlXnUFoPL8O9sT9aTGymlR5L+2Om6t+/keTkFbQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH3YsI5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A70C4CED0;
	Sat, 14 Dec 2024 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734136814;
	bh=CiWzUrAUtTjFx0lZZZqrDMzgCnIZlQIxVI2OTYRtR3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OH3YsI5BGa1Pn5IKkZZCl4slP8FgZjpX4nmhvonxN1gZANBwCT/k1RFWAsHgR7rOT
	 shYTvQ3rZctzSs8XruONOdlvBcQVTYRwC1mjKza6gLGcgEGHy0zO/dhiYRz+mbKLeC
	 HJAsaR3w/3Vm3GcHF4FyplLoqbTK/tmubsEMhpLBUx3I2Y5jdYSQm8OQoWw8HlAYFs
	 cD37hxnF8Mo0LU1s30tahO6zlpLntnhdJC1nnq7iF1gQ7qDP+WV67CMlYSI8hA1xqU
	 sEYHYjGbVWpaZyRjbmWzkHHi1g3AQ6yswzW3evRS9mgbH1HcGtFyxaZg+24xc2MJCT
	 Iouz9QyFW+DAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF11380A959;
	Sat, 14 Dec 2024 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] Explicit raw_tp NULL arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173413683045.3207690.9026484572328553006.git-patchwork-notify@kernel.org>
Date: Sat, 14 Dec 2024 00:40:30 +0000
References: <20241213221929.3495062-1-memxor@gmail.com>
In-Reply-To: <20241213221929.3495062-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 chantra@meta.com, jolsa@kernel.org, juri.lelli@redhat.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Dec 2024 14:19:26 -0800 you wrote:
> This set reverts the raw_tp masking changes introduced in commit
> cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL") and
> replaces it wwith an explicit list of tracepoints and their arguments
> which need to be annotated as PTR_MAYBE_NULL. More context on the
> fallout caused by the masking fix and subsequent discussions can be
> found in [0].
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
    https://git.kernel.org/bpf/bpf/c/c00d738e1673
  - [bpf,v3,2/3] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
    https://git.kernel.org/bpf/bpf/c/838a10bd2ebf
  - [bpf,v3,3/3] selftests/bpf: Add tests for raw_tp NULL args
    https://git.kernel.org/bpf/bpf/c/0da1955b5bd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



