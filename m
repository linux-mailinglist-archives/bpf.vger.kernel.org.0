Return-Path: <bpf+bounces-66112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B74B2E736
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F95CA25398
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE83054CF;
	Wed, 20 Aug 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3iEOGoE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AF36CE0E;
	Wed, 20 Aug 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724197; cv=none; b=QszBwxSgxNun9qGcp3I9l5/w1lJ9FcejUREJ4/ieMHHXIkBL5INRQ6Ol34b0AZ1iR44tDkSt99sNvAETq9BWUzHpY5J6vmwZ9IwPjiRjwRjtVK3w7AWVzh5wmueBLspWXQbUi8VbsBvgKMqf11iytJvCICzSvsMbXmK6jvpv6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724197; c=relaxed/simple;
	bh=vG8Bmp6NPUM2g5lbG51OaB2Fu82pX3N6AMVtHGqTlFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iD7Zer9RPqNBiSI/52JodrIssdM+1U4gR+qq3iLA3PIaEGdmQUBhjVyFkoMDhmERjZnpVohm/mT0Rl3Fpn2L6HdzrAXrCtZkjvKmZiylZu2fLr6As0386+v+TmHD/G+3vuzlv61dnA1SKb7Z9xXxY3Ue7W+ucE0+sTFA4bOv+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3iEOGoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872E2C4CEE7;
	Wed, 20 Aug 2025 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755724196;
	bh=vG8Bmp6NPUM2g5lbG51OaB2Fu82pX3N6AMVtHGqTlFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3iEOGoE5U5P5zO1qWHxOrvephxOm21WH6+2Isj1ELkGHZsOjeWcSQmgtXLo63qds
	 b6Ge56d0VKPlcktVWoEfmm/UNy5uQnDYUpVj050TKvZ2Kh8jVu+Cmkl2g67Lq2azTy
	 QS9mcGl5Am8OzeRmiAL+PE2ih5d5kvi6e6JbZukpfVV5qLBccf4yCpCLPUE0x8EmZj
	 0uEPxo8YfwfBxvi1rvY8Sg16F/WdRzx4jnTAsKb8fs7ZWHdLEWc+dTz/loDabCoVas
	 f2cy/WgU9REaOcFvFbcb9SgfynXUkn1uGSv6Y/MUy2Plw88jk6g0Qtd2Hjv/E4xjjX
	 eltlLC5RyOG9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34090383BF4E;
	Wed, 20 Aug 2025 21:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: add documentation to version and error API
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175572420601.377827.6962652629421001960.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 21:10:06 +0000
References: <20250820-libbpf-doc-1-v1-1-13841f25a134@uniontech.com>
In-Reply-To: <20250820-libbpf-doc-1-v1-1-13841f25a134@uniontech.com>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, niecheng1@uniontech.com,
 guanwentao@uniontech.com, zhanjun@uniontech.com, yt.xyxx@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 20 Aug 2025 17:22:42 +0800 you wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> This adds documentation for the following API functions:
> - libbpf_major_version()
> - libbpf_minor_version()
> - libbpf_version_string()
> - libbpf_strerror()
> 
> [...]

Here is the summary with links:
  - libbpf: add documentation to version and error API functions
    https://git.kernel.org/bpf/bpf-next/c/78e097fbca71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



