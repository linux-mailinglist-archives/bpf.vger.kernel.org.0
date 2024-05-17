Return-Path: <bpf+bounces-29906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B378C801D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13451F22C31
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F358C13B;
	Fri, 17 May 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+EXJe2f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3442946C;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715915429; cv=none; b=cr9h65WZuVyEuHd0scY16aMxJigZwwqf7j9P6GMv+S/BIGDeb5Bbq8LPI1LtQRtrtaY1HtBrrvaRVh0qbPbTFrs9+aoOIf6uZ4huqfGzjGjXeTS449RgqjObcHOf0eoKUwRcGgKpJns0MYDxnOdMj8wVbSVxFVDE83blfsjix4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715915429; c=relaxed/simple;
	bh=ho+G++EVa3pSaTwY5Pr6aRDUUn1h16fhxowMP9wah9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+k5w2VxnUG+v7Wh3MHvurXkQ9ulQr6wuJK028a1y8bTq0TVLQeFhFK+EVW3oAWakh+KZlQb1CHgukBOuhNIxLKarO/X7xLZWqcR6lIg/J9+3QQVBdHOHNfZYvDtl3xacIWa3tynqpGvI19dm9xhBhFkf/dR8rubhEJP+yLUTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+EXJe2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50129C2BD11;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715915429;
	bh=ho+G++EVa3pSaTwY5Pr6aRDUUn1h16fhxowMP9wah9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F+EXJe2fHkNcV1svRvTMGHSJdM8zYNj2ZHDEHGfISsymLG1bqSGAfTb+p4FlKA+U7
	 gHxkKzGZygrugdMNqmy2MemC8eu6c80P1VlwFeS2UayiJ3TaF5RchXrdHwSQftAibQ
	 9ilmVfajEM+zlkvxEWQkq1iRHb8SnbNY82ZDcop8xXshg9VZ3zT+Swt0egi2caQEld
	 XR6qCgYDqSkBW6i0ua9r3lyImyN3Sc9GjIbbqYWPvQ6bse+qLoLMwtvnZR99wxJR/0
	 WuHpcVo0eMMAbrLMTojdWfegHE5av6LjhyX/Zq9VIpOmr9ZGK85B7fL2gKrqTJ7ucK
	 PoYCfKoQiigew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D540C54BBB;
	Fri, 17 May 2024 03:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix order of args in call to bpf_map_kvcalloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591542924.18753.7459839871800509964.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 03:10:29 +0000
References: <20240516072411.42016-1-sheharyaar48@gmail.com>
In-Reply-To: <20240516072411.42016-1-sheharyaar48@gmail.com>
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 16 May 2024 12:54:11 +0530 you wrote:
> The original function call passed size of smap->bucket before the number of
> buckets which raises the error 'calloc-transposed-args' on compilation.
> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - bpf: fix order of args in call to bpf_map_kvcalloc
    https://git.kernel.org/bpf/bpf-next/c/71ed6c266348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



