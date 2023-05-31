Return-Path: <bpf+bounces-1506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266D717DC5
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 13:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B202C28142A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F641428B;
	Wed, 31 May 2023 11:10:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F9C8ED
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E640C433AA;
	Wed, 31 May 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685531421;
	bh=VxuY/fz45/1OPprJtBqqQvLX1YX5laMRp+5DrTcdACQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BE11DllLNI9e0jidWZPmC8GwYt4PYrmVI3Bx0oPMxpoh0nbWSOjXfEnVPfCfbCET2
	 2EN+M81Y4muvpD39kMSTuzFxXKoTo6U2RZBVqHlbW8hkais6TeNdyJgHtSq2hoYIPi
	 qY63nReaA/dWpbPmDDMM3rAMqCEKVybTMhbcfrX0KcpsMTRbSH8XutBqHRZGd+9xGb
	 SemGsABjXPvoixj5UzWdWZXlHCMFYEhQHMsnkjXk4Ph3Q9HDwOU0BpHwPb7dS0oNKC
	 andSZ9xAntGQEAog/NfN7HolOLstAXyHOZvfGp0mz1lbKo+XIDKMgFHYBtSddnrn3I
	 qTYiyqqzcpWfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37E97E4D002;
	Wed, 31 May 2023 11:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Replace all non-returning strlcpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168553142122.8778.8422261276573581725.git-patchwork-notify@kernel.org>
Date: Wed, 31 May 2023 11:10:21 +0000
References: <20230530155659.309657-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530155659.309657-1-azeemshaikh38@gmail.com>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 linux-hardening@vger.kernel.org, martin.lau@linux.dev, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, iii@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 May 2023 15:56:59 +0000 you wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Here is the summary with links:
  - bpf: Replace all non-returning strlcpy with strscpy
    https://git.kernel.org/bpf/bpf-next/c/ffadc372529e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



