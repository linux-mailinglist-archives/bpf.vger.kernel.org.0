Return-Path: <bpf+bounces-14625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDF7E7223
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28BC2810AE
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F434180;
	Thu,  9 Nov 2023 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfUz7C+x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93120334
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B33FCC433CA;
	Thu,  9 Nov 2023 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699557624;
	bh=p6JBUbJthfRIx2QkEMmk3QGtHgFszZDpFDeiQRSGkak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jfUz7C+xIe1ccRIMFY+Q4J1rh+9bJl1Bd2+hfLk+PjeWZapwCnLbtbz/NKwdVHcj8
	 QB0rZlFA3rr7LIk0i9bhFRUTBmxlLlxNWYvC0HKVZaG/D0C3fNEDlnVX5noFl31Jnz
	 xHGxxeHM5x16CegmXdPfx4IE6ZDUAISpqzWKzRiC5/DuVQGHCuh0B7ZI5qUP8N6gac
	 JEu3prg2AioL+xI7Q7TimdV7FlrErHgEmsa9rN8etXw+nRl6lp4DOCIlmTJVPMNJXa
	 bEDQQLAyALvVZqIhsHYEtrU8+9b+xsVHOE8VPFs8n9jv5m5r7qXNoiGLWy21BO4KV6
	 CD2pCYyY09/LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 993BCC3274C;
	Thu,  9 Nov 2023 19:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Use named fields for certain bpf uapi structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169955762462.8073.10058023845816903917.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 19:20:24 +0000
References: <20231104024900.1539182-1-yonghong.song@linux.dev>
In-Reply-To: <20231104024900.1539182-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 vadfed@meta.com, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  3 Nov 2023 19:49:00 -0700 you wrote:
> Martin and Vadim reported a verifier failure with bpf_dynptr usage.
> The issue is mentioned but Vadim workarounded the issue with source
> change ([1]). The below describes what is the issue and why there
> is a verification failure.
> 
>   int BPF_PROG(skb_crypto_setup) {
>     struct bpf_dynptr algo, key;
>     ...
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Use named fields for certain bpf uapi structs
    https://git.kernel.org/bpf/bpf-next/c/e80742d91749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



