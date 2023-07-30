Return-Path: <bpf+bounces-6338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4E768372
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEDC1C20A4E
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9602387;
	Sun, 30 Jul 2023 02:00:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D8384
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 02:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72DFC433C9;
	Sun, 30 Jul 2023 02:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690682419;
	bh=1cN7fa7tV9zeLZ8ECMKL/6yMXK8QTIjYXITZxHrRTAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DmDvBVE8I0DMD67DXw6SptK7+DI7UpUefCChO2j7i2obtpNfX1TYvp94KzTIwNzQ8
	 PTSZ/gDL/P9oiIvYUQnqdcV/ZPCQtE+OHdUH2dFySBKlLsw4QBgkxmprVXP3evgzlr
	 Fhy1oPztQgzv72xXihw4jB/pGwiFGzg/C69b0ceGgnAnTAMCaYPFauJMdfw/OLpzHz
	 rcD0u2wAkMLL3jd+MpM+vqLNzZKYkZmzbbjOledaVTYCIP1Da93JXg1ryN+QKj4Jv0
	 5dwAmexWxQzQ7+6DiCJjWKqqFnCYc1CJUnaFt9hjCST4yqVaUQduVK/TP4+ZlpjFqs
	 h0QuxAwZmYbPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0FCAC39562;
	Sun, 30 Jul 2023 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs/bpf: Fix malformed documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169068241972.10817.4536371967905235061.git-patchwork-notify@kernel.org>
Date: Sun, 30 Jul 2023 02:00:19 +0000
References: <20230730004251.381307-1-yonghong.song@linux.dev>
In-Reply-To: <20230730004251.381307-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 bpf@ietf.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 29 Jul 2023 17:42:51 -0700 you wrote:
> Two issues are fixed:
>   1. Malformed table due to newly-introduced BPF_MOVSX
>   2. Missing reference link for ``Sign-extension load operations``
> 
> Fixes: 245d4c40c09b ("docs/bpf: Add documentation for new instructions")
> Cc: bpf@ietf.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307291840.Cqhj7uox-lkp@intel.com/
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next] docs/bpf: Fix malformed documentation
    https://git.kernel.org/bpf/bpf-next/c/fb213ecbb8ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



