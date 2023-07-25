Return-Path: <bpf+bounces-5847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE1761FFD
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A842818AE
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AE2517D;
	Tue, 25 Jul 2023 17:20:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F503C23
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0599CC433C7;
	Tue, 25 Jul 2023 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690305620;
	bh=xHCvdhIUBr3Cv1iiG+PelmZ6ZIuwBfOJQybi+fLZ+tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LcVYYNu5hV/SAfMHpPSFHb1Y+9Kg88eC7QjV+AhtozF5R8IUSrU+xconASbF/ePuw
	 5/ILVt/VszqH9E4e+Ki4LVVf71Am1p2X85YwIyNRDI/nmKEaDl1g8P84TtmyG8Mt78
	 TO8XhTR+b2sbQuwtyd6aKG68OgwEQJnHl465/Oe78mSgzQvU54gDrzM7BZ73rAnqrb
	 zsnvjHqPmK4KGdXmMmiSrX1hWiSRSHLasPKwcHye1Zs3XcNCXUiEsllSA7j6SDfHbV
	 bmSZF/xz3W2lYRWigcDTdd0YlyUq4zHxlTy1M0WQgv1ekbYALS6elaTn8BuVA4MUBM
	 Ol7KqTy2sqZTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2D23C73FE2;
	Tue, 25 Jul 2023 17:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: Replace my email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169030561992.1699.10491493682707249510.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 17:20:19 +0000
References: <20230724171102.3915336-1-yhs@fb.com>
In-Reply-To: <20230724171102.3915336-1-yhs@fb.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 24 Jul 2023 10:11:02 -0700 you wrote:
> Switch from corporate email address to linux.dev address.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] MAINTAINERS: Replace my email address
    https://git.kernel.org/bpf/bpf-next/c/7b2b20125f1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



