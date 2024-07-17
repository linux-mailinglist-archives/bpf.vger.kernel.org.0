Return-Path: <bpf+bounces-34964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D643F93435F
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 22:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F07B2124B
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D642D18508E;
	Wed, 17 Jul 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFWfB+hY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8571836D8
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249434; cv=none; b=sI3+6Y+f3kId+MfFRdz2VU8i+ka4eXhDoVNwB+40GhORMRyfPGiaoXITnM6gHSECZNd90u6j7dsoYT4dPpLOCb0cG4tjToomKwAGQBCRiUc4gFyIDTwx51SaotIk3Zl9kcoSA+4eQ1XYYXufoRiEk22QwvHZNRDwxpgscc2ho+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249434; c=relaxed/simple;
	bh=nV7X2uiKXvD7eRUNCTjREp9SizA8ka5vqm1LSpkInUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rhVy+wc9EeimxK9Rom1QFI+I9U8glnQBD4pZ0uihKOHdjPHULA7BrcOwva522VGZCJSM5nT2NixnRTPcqOlRWArGYibXZD5FMbAgbyNzpT6PdNvnfAhEF8E35VLeQEjHH7rdl1yCz7/KErrP/I0sQCdOZhkODQgZ6N8bPWRtHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFWfB+hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D520FC4AF0C;
	Wed, 17 Jul 2024 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721249433;
	bh=nV7X2uiKXvD7eRUNCTjREp9SizA8ka5vqm1LSpkInUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFWfB+hYpExI1AO010Y3gxgQmb1oMBYhkvL8uz67mKnWzFR7EfMWJeAH+cwJGKG7u
	 JBMKeHOk+ZqJBvRg1y1+1LbNHxY0KCfLi8d2LroA4cshuLtlNUp1Ox4xivdBMmjPqS
	 0qh7laxZUj9va20w0krqmDGTrYFUAh1kFQHzN0jqMirjtAAx0PjWupSAnE6Y3EypoG
	 iwlyEiT65AxM0pguxggJNbc01bgSDX262Cka9QB9RMVcp9iUHJcV/dJsvw+JMGsG6F
	 eKpl7woke839vQ25f1DKO6SCDX5/sjVNe3iRV4UvjO4Qa0guy57rVBqPRK+niB8shp
	 wOkvWkFJrCUdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9CD4C43601;
	Wed, 17 Jul 2024 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix typo in usage help
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172124943375.32411.7854367381247333565.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jul 2024 20:50:33 +0000
References: <20240717134508.77488-1-donald.hunter@gmail.com>
In-Reply-To: <20240717134508.77488-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, daan.j.demeyer@gmail.com,
 donald.hunter@redhat.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 Jul 2024 14:45:08 +0100 you wrote:
> The usage help for "bpftool prog help" contains a ° instead of the _
> symbol for cgroup/sendmsg_unix. Fix the typo.
> 
> Fixes: 8b3cba987e6d ("bpftool: Add support for cgroup unix socket address hooks")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpftool: Fix typo in usage help
    https://git.kernel.org/bpf/bpf/c/3c870059e9f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



