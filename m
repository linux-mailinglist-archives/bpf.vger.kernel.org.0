Return-Path: <bpf+bounces-9114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5B78FEB0
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABEC281B0D
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1BBE7C;
	Fri,  1 Sep 2023 14:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3763846B
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 14:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 571F2C433C9;
	Fri,  1 Sep 2023 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693576823;
	bh=nUAXwCBaIlVIv5ubdwDDqk0X/2sNnkpxYUJ/oK3/v88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oMkQ0JfSYRx6G/mDpuhgSbzr6jSMSba6YHh9ouUgq65/cjv/ltJfTQjwjLPXAxOyY
	 UHlFBMbRYVefBOiK4RzS8yGwMLhSmpmhmFhgIR5BGoH97s/q9XsymDy2gfN6rDeXfY
	 u98y+tIHyZ7SZqS8hdJ/mW8PBRHCvx05LjRVY9x7LDTr1o/LDCzaBDPKX/lsD7dtOk
	 dt5KLjg+DIjdzGcv2oeM+JvRCJpvbnu+CL1BU9RGtjYkb0HlqbpKgHX1zZoEqlrMRU
	 Jm6U/tukijqsoX7NJgqIok2DbJt8Nx0ObqoJop6Zvf5DU1hKkUsaYjFQtO5rVy+72b
	 j2jqww25WDujA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 392BBC595D2;
	Fri,  1 Sep 2023 14:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] docs/bpf: Fix "file doesn't exist" warnings in
 {llvm_reloc,btf}.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169357682322.2435.4121559456719119847.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 14:00:23 +0000
References: <20230901125935.487972-1-eddyz87@gmail.com>
In-Reply-To: <20230901125935.487972-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, lkp@intel.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  1 Sep 2023 15:59:35 +0300 you wrote:
> scripts/documentation-file-ref-check reports warnings for (valid)
> cross-links of form:
> 
>   :ref:`Documentation/bpf/btf <BTF_Ext_Section>`
> 
> Adding extension to the file name helps to avoid the warning, e.g:
> 
> [...]

Here is the summary with links:
  - [bpf] docs/bpf: Fix "file doesn't exist" warnings in {llvm_reloc,btf}.rst
    https://git.kernel.org/bpf/bpf/c/3888fa134edd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



