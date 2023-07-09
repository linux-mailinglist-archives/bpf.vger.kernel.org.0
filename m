Return-Path: <bpf+bounces-4510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105E74C053
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E6D281118
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09B415B1;
	Sun,  9 Jul 2023 01:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61910F2
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 01:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B37BEC433C7;
	Sun,  9 Jul 2023 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688866820;
	bh=cCSoNdGhByAcijFIGmpoKqHnbwrgQX07PWN6H3JHoxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gdmRzLTAlL8lwG//5JfNGpXD0g6NltnVSqqJ0B5n38Boz335q8wAJ46gnh2DSiuDY
	 iHNqR/qnIhxENOmdQ+tnetp+ZjDIvFzxWZtrSocS6S4YWmRodZUbQ+eTGYyP1jcVz1
	 TtNsH/fRF35hLQqukPUtBZSHEL9UV0pHTi0gBiEqp7cFDbDc5zSYm/gDwPwh6NB/mq
	 M3YqvmOEgMT/40TGx2pUqCWz0t9LtoD2vTpPT5Ov40y7+d+qNvo1GUZR0MRpnL7mWX
	 klTC3UNKlnCrW3Ht6rNRdwqnhvU4nFC/ILWTb7iHQmVhCw0NJJY7sQkCQkcdKYqZx/
	 6N3nxe22+x2zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E2BFC0C40E;
	Sun,  9 Jul 2023 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: only reset sec_def handler when necessary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168886682064.2231.10209973851568634649.git-patchwork-notify@kernel.org>
Date: Sun, 09 Jul 2023 01:40:20 +0000
References: <20230707231156.1711948-1-andrii@kernel.org>
In-Reply-To: <20230707231156.1711948-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, acme@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 7 Jul 2023 16:11:56 -0700 you wrote:
> Don't reset recorded sec_def handler unconditionally on
> bpf_program__set_type(). There are two situations where this is wrong.
> 
> First, if the program type didn't actually change. In that case original
> SEC handler should work just fine.
> 
> Second, catch-all custom SEC handler is supposed to work with any BPF
> program type and SEC() annotation, so it also doesn't make sense to
> reset that.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: only reset sec_def handler when necessary
    https://git.kernel.org/bpf/bpf-next/c/c628747cc880

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



