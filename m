Return-Path: <bpf+bounces-73-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC476F7A10
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50561280F6C
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0677110B;
	Fri,  5 May 2023 00:30:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD61374
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C7C4C4339B;
	Fri,  5 May 2023 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683246619;
	bh=mEg+7wM4/yya/FCnEx5NMxhbHFSA1XVBWXQoROeCPik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b36F3jWJApVMui0mpb5/i0Exs5yWC2AbwqYSLg+xagEN35FSRDIvFPrZ0LaCiseWD
	 6VyQfXduqpFS7a8Lb9gPeAEx6CzBgwP57eoTgbCaV+FNcghFBp48LHm5PhSvgnQI7L
	 P7789TnhTywV+t0QalhdPHTt0rD3TKpA0CyiurafoiGXvYufbMXiOZsWYlnytwbqHx
	 RHgggUaTKJhYcxnxwktEdYLz9nnttcLSpTL0lwYJuixceWN+bX3F6MX0Pd0tmF4n1+
	 FFo/n6tyoUf92RK/JQTylUDMA41HHH6jsWi52HZxwKFWQ2rZ12NxZQxnlpappb1vsg
	 ugSVIIMtN/yEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 820D8C395C8;
	Fri,  5 May 2023 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix comment about arc and riscv arch in
 bpf_tracing.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168324661952.489.15184548058357542070.git-patchwork-notify@kernel.org>
Date: Fri, 05 May 2023 00:30:19 +0000
References: <20230504035443.427927-1-nakayamakenjiro@gmail.com>
In-Reply-To: <20230504035443.427927-1-nakayamakenjiro@gmail.com>
To: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  4 May 2023 12:54:43 +0900 you wrote:
> To make comments about arc and riscv arch in bpf_tracing.h accurate,
> this patch fixes the comment about arc and adds the comment for riscv.
> 
> Signed-off-by: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v2,bpf-next] libbpf: Fix comment about arc and riscv arch in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/7866fc6aa0de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



