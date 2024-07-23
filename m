Return-Path: <bpf+bounces-35426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4493A811
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEC91F230A4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D8143897;
	Tue, 23 Jul 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1nPacow"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453113B5B4
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766636; cv=none; b=RaQK8fL2L0ErYUZdyhQvzNLtDgS32yyF8T+0ryjbOMx9RRtQlr3plvsnwHea+qcRnVOqHz0/gz+ih1hsOkpo30gfLK3lBUf49n8uflnqJs90cw35uRtYALaFRRqOAOLIatTz3Gs6p/mkNUqK3/qiIn/7Aaa7tlfrNciCjUjr4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766636; c=relaxed/simple;
	bh=HkevzESJQD1XUBMNGXSehE/5dj9N0ilw+ybjtmwJffE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzV/XTd3QBQxOjxVBY4h4h7kW+SJkKlL9UQjzFVzT+QP9th8K5tMSqt/8LEEKWO7i4Z+qFssLy361etrxLdfkhZaAoUj1gUekWhTbeEwF+e2sw3ajuuqoQPFLEjDVoHZjuFnrBWfZTD8ZCrwL/Y/ZP0WfsFR/XhvUMT+Xcb4t+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1nPacow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99FC6C4AF0B;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721766635;
	bh=HkevzESJQD1XUBMNGXSehE/5dj9N0ilw+ybjtmwJffE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g1nPacowu2y/5NMvvGK49V7leqw509smlR8hVWOeWygEcgfTUWnPRaVKrYf4b2MfV
	 nGcfEXNzkM4IBirkwvskLiE1PeNmVt6OUo1MVKJhmB+cZnuxnKNv3WEEbImgaaLeI1
	 yl8oAcJiBYMHXPUvqtPJNBWJxiVU8ADDQrWX39Ta2cKVhsiE+qmrt+fSzflhyjDV4S
	 HM3ozzl7myqKOTsqxEbmkKPuQYkiy8bl45PlXjys5SZswDvBV7k77o1gEZ/E3A6oQi
	 8xMIiB/ibz8av79F0o90nLzeHsMhFKj+MhV4V7XZ2sOSnl51McqY/6KlH6jhZP4hrB
	 LPuGvdvEXVH/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85B2BC4333D;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add LDLIBS
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176663554.27466.6314434452346672344.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 20:30:35 +0000
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
In-Reply-To: <20240723003045.2273499-1-tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, iii@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 22 Jul 2024 17:30:45 -0700 you wrote:
> Actually use previously defined LDFLAGS during build and add support for
> LDLIBS to link extra standalone libraries e.g. 'argp' which is not provided
> by musl libc.
> 
> Fixes: 585bf4640ebe ("tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
    https://git.kernel.org/bpf/bpf-next/c/3929c8dca3b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



