Return-Path: <bpf+bounces-10327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC17A54C1
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 23:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2E281A73
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 21:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7002286B9;
	Mon, 18 Sep 2023 20:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265A27730
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70BB8C433CA;
	Mon, 18 Sep 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695070222;
	bh=Hxu4BPK4GaTEMHjRLIQtKv7B9zWn40lHuXt+qUczQAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nlf2TRXaabMle3olNLnoXKPRJTAhcBA4eM2+ISOSxGVTgnIMozzEx7+D26cEi1Fhf
	 bHkChxkgc9UoPh3T0hJ8lwZ/CqrWr6uYSWeYsK6X5aCCqWOn4I3/ZBBNQVdtoT4EJh
	 McApqV9dYIemkl2F54s700o9Ld3ULZcuYYBWt7bnLsc90oukYnD59f/sWvw6DQreVN
	 1kxRkAKK6xB1/LnddGRkHpWp4l8nmoQZQyv1a7wFsZZHoiwqF9Gk3eIlFai8zUvpPh
	 jJzt9edJO6ZqIlj2px8w1OCW/nmVwbp4gTL3FwOv+JcQKOFrHQkStpbAQ1bKVINQWm
	 6Czerl2m2OjhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58A3EE11F41;
	Mon, 18 Sep 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Fixes for Exceptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169507022235.24573.8693498429487666041.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 20:50:22 +0000
References: <20230918155233.297024-1-memxor@gmail.com>
In-Reply-To: <20230918155233.297024-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Sep 2023 17:52:30 +0200 you wrote:
> Set of fixes for bugs reported for the exceptions series.
> 
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20230918143914.292526-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: Print log buffer for exceptions test only on failure
    https://git.kernel.org/bpf/bpf-next/c/c425a3501f24
  - [bpf-next,v2,2/3] bpf: Fix bpf_throw warning on 32-bit arch
    https://git.kernel.org/bpf/bpf-next/c/00b7e8f4c02d
  - [bpf-next,v2,3/3] bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
    https://git.kernel.org/bpf/bpf-next/c/43c6e890472e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



