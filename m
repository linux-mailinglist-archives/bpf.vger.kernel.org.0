Return-Path: <bpf+bounces-4334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34274A676
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0691C20E61
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223815AE4;
	Thu,  6 Jul 2023 22:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CD1872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63171C433C9;
	Thu,  6 Jul 2023 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688680822;
	bh=+22mzQguys2tJacNccyqcjYcqhLDAE6EoLukiGHOT4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FGMAiTXyVnJ59DKWD4YJtHEXCdLPwsuLyA6r8OiOEl77Uyw+lCXO6OBbpRYM+aGhB
	 na1pWiUqY9mBRQnLr4HkRjChxlWWSriJAZh3MrOyzBRInL4FYYGbsO+zNPEMTEChgc
	 niZokWEgoH1P3XpOJXq+lsF8saqHV2j+T1zrASp64+uXaI3WY5lEYDoXCTascMkS47
	 yeOhKia+b4Rm16JyUjCD9ZVo/PVH1xwQgnTXjrG4ZxlO8UscmlIJgE8KfyjuEfC8GX
	 hhtCXXsRmTobnh95s3ycl53mblocFDA7ft5ERVUnfIWk00gQGQXoJbxgrFVMJ8E3un
	 pkmXczO/li4kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 431D0C59A4C;
	Thu,  6 Jul 2023 22:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168868082227.13002.2727986296797379564.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 22:00:22 +0000
References: <20230705091209.3803873-1-liu.yun@linux.dev>
In-Reply-To: <20230705091209.3803873-1-liu.yun@linux.dev>
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn,
 daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  5 Jul 2023 17:12:08 +0800 you wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not all
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
> 
> [...]

Here is the summary with links:
  - [v7,1/2] libbpf: kprobe.multi: cross filter using available_filter_functions and kallsyms
    https://git.kernel.org/bpf/bpf-next/c/e5852934b647
  - [v7,2/2] libbpf: kprobe.multi: Filter with available_filter_functions_addrs
    https://git.kernel.org/bpf/bpf-next/c/0d28e1abb801

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



