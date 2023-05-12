Return-Path: <bpf+bounces-455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EAF700F30
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76471C21374
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893623D6B;
	Fri, 12 May 2023 19:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A423D61
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 19:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B3E2C4339B;
	Fri, 12 May 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683918620;
	bh=RhQyUl7e9OT+8eL5IJ/vp1UZuRIhYARYQ3jJ9VhYqzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rjl7Mnl0qOk6qRuQhJZvfLWVPEgdn9eFgh1DmN1cVeK+Ytb7Nbd/PGbq5E/I4SZfk
	 9C3KG4UrDXaGjzxlTOPPlsGvaGN87vLw1cJVB9J6IUH/QgTgkGMvcxJLaB5bUYkW1W
	 nE0Hc+t+9sVO/fYKq38QJDI/7zhE16dpPapNmb+bG9CtLiU4dF55vDX3KnrXttjUZl
	 CoAVGqpanhyeFaqRm4q2OIX5R2/TMNiuw+0p00dethc7+pWW/irWGqDh1VmUWy9qHZ
	 fh0Y1+KQhW2F35nRlasCNyhTRQ6wQIIFhCbz81z9f816kddQfk7wjUhJHKmAxHtZ3h
	 4zd52p4FaN7fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71E25E26D20;
	Fri, 12 May 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix offsetof() and container_of() to work
 with CO-RE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168391862046.6084.8644595763871154951.git-patchwork-notify@kernel.org>
Date: Fri, 12 May 2023 19:10:20 +0000
References: <20230509065502.2306180-1-andrii@kernel.org>
In-Reply-To: <20230509065502.2306180-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, lennart@poettering.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 8 May 2023 23:55:02 -0700 you wrote:
> It seems like __builtin_offset() doesn't preserve CO-RE field
> relocations properly. So if offsetof() macro is defined through
> __builtin_offset(), CO-RE-enabled BPF code using container_of() will be
> subtly and silently broken.
> 
> To avoid this problem, redefine offsetof() and container_of() in the
> form that works with CO-RE relocations more reliably.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix offsetof() and container_of() to work with CO-RE
    https://git.kernel.org/bpf/bpf-next/c/bdeeed3498c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



