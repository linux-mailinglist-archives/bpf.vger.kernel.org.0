Return-Path: <bpf+bounces-70980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89329BDE05A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973B7480741
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DED31D734;
	Wed, 15 Oct 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMYDJoas"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2B307AE1
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524285; cv=none; b=SC+ZdWB0/DRN+OszColN3SIv87xvn7CdOhV2PQRazbRkzxbe9FcN6xq0ypfqg46DLmGODGNz2zbCd88amW2y/h2zr8MU8hdrfwP1m2a2gPhgFV9mhFdEzV+yWMbbRXs6T3UxQSusPshIhy4OUIIcT5ifttKe0I/6+tucxb3qMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524285; c=relaxed/simple;
	bh=1n+bUnxTbBE8EknqcnxMtqsgtSOAIFCgs/K/zO4CNUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QGAJEdhLMFUtuEuzxaFECy8ACMMbCTTH7p+x3PaMmiK9iXbZyV00vRKXxa7GShnLhK4nzC2X5uf8H42TY9hJ9xzEG3yJbnVtvuO0fXip7c8aF4WX+mBZ7DoNh51m10Ufs3xcpvkaXoFXBzrXi01Zey+xvT0P204vcvyolLOzIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMYDJoas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA9C4CEF8;
	Wed, 15 Oct 2025 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760524285;
	bh=1n+bUnxTbBE8EknqcnxMtqsgtSOAIFCgs/K/zO4CNUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gMYDJoasKXL641lJV252CoiQMlV0VXd+PyD2mGkm8s1VtldzzSQ7wvKM7H5Z56f1C
	 1spl9dRmpoJNyVdm6c2e1IHhtWUOcCb5vSL+m6vw2OOSaf5UsB09OZ2M2tEsZ1SDTQ
	 evHr+DUegmE2FWgtBGh8CyD+/3gebei2z31DuO+2+tYyjiQRdSn9USRjga5do/Xy5n
	 UHKGsgjc6S/QZf3ZL5IpXxaqPI46SnflsWlXaZlV/AftP8izua555ToGFkzYhIOuov
	 QISHsMebADcRebGxZou/J+YQChJv/menrjqL9GkFh1y99AUGA6DIxoroVW3MP8t+Cv
	 tUOuJLZyha9zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6ECAD380CFDE;
	Wed, 15 Oct 2025 10:31:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] bpf: Replace bpf_map_kmalloc_node() with
 kmalloc_nolock() to allocate bpf_async_cb structures.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176052427024.282100.959584197933795259.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 10:31:10 +0000
References: <20251015000700.28988-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20251015000700.28988-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, shakeel.butt@linux.dev, vbabka@suse.cz,
 harry.yoo@oracle.com, yepeilin@google.com, linux-mm@kvack.org,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 Oct 2025 17:07:00 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The following kmemleak splat:
> [    8.105530] kmemleak: Trying to color unknown object at 0xff11000100e918c0 as Black
> [    8.106521] Call Trace:
> [    8.106521]  <TASK>
> [    8.106521]  dump_stack_lvl+0x4b/0x70
> [    8.106521]  kvfree_call_rcu+0xcb/0x3b0
> [    8.106521]  ? hrtimer_cancel+0x21/0x40
> [    8.106521]  bpf_obj_free_fields+0x193/0x200
> [    8.106521]  htab_map_update_elem+0x29c/0x410
> [    8.106521]  bpf_prog_cfc8cd0f42c04044_overwrite_cb+0x47/0x4b
> [    8.106521]  bpf_prog_8c30cd7c4db2e963_overwrite_timer+0x65/0x86
> [    8.106521]  bpf_prog_test_run_syscall+0xe1/0x2a0
> 
> [...]

Here is the summary with links:
  - [v2,bpf] bpf: Replace bpf_map_kmalloc_node() with kmalloc_nolock() to allocate bpf_async_cb structures.
    https://git.kernel.org/bpf/bpf/c/5fb750e8a9ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



