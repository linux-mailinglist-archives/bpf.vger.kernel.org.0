Return-Path: <bpf+bounces-44971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0929CF31A
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E95B3C062
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E891D47C8;
	Fri, 15 Nov 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH7ha9CW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FEE1BD4FD
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687620; cv=none; b=M9RQ4abkNfYuIJ6OcQ9K1FFKO7ooRvq586sU0Wt8+On5WFpTfzPBbCYWxwvxFs71CL4YWhiOBQfw6TUtnng57lIqRSWJo4J4sORyZxgPSHiL0eKqTsa/aUSBK0EHa+3bJvgbzd/KlTQucYOTd6M065Bh75uJ/pxuDnxKp9T/tHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687620; c=relaxed/simple;
	bh=5rxsIBRpKwsct60++6PQbxOi19L1j5TjQbCzdGmJzP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AftSZJX6eUdnWAP0SpKioUuHvDFYfCtPkaJsEQf+X6hl9SzXcA92+xfOZ4s7/TyImiF6uN3n0Ib9qZUgo79AjC9Pl2K7G5Hhwssv9r+cqG4dvTslLVQ97svFWAAX3LBTPj5lNCz+4YWIpr1r3dbg0AVujoKCUb/dBxkVvcQIU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH7ha9CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C45DC4CECF;
	Fri, 15 Nov 2024 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731687620;
	bh=5rxsIBRpKwsct60++6PQbxOi19L1j5TjQbCzdGmJzP0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HH7ha9CWeoH9zXmzGun4bIFMN20GUqes4wCeCvbpm/XLQWsHIRywJOSNdiTzVYfde
	 HywR+wdB3CjtDzsV3y2QWVgdMvshOGJnayqH0GPN2oYT6lSitViML5/vMgl0rE90Zi
	 Ln3lCcyqHv5uYWmJcz/xGvkjkIdQ61khD44943NzeZkRGX1MVAD5xK73b6/WqUct7d
	 aOiMWtPu9Yoiv5/DT4DSNc89ggjK0+dObAZTywG3u9S0wiLPj65AwIKg4o32G3Je9h
	 863SMeedGzop/uBjN9lc+72C+8KLVAekqUnbvyJiWWFTQ6T9PxZvm8HTFr5zcnJsQW
	 CIWyht9Mzz9pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD903809A80;
	Fri, 15 Nov 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Do not alloc arena on unsupported arches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173168763049.2635622.13543213341607100159.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 16:20:30 +0000
References: <20241115082548.74972-1-vmalik@redhat.com>
In-Reply-To: <20241115082548.74972-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 Nov 2024 09:25:48 +0100 you wrote:
> Do not allocate BPF arena on arches that do not support it, instead
> return EOPNOTSUPP. This is useful to prevent bugs such as soft lockups
> while trying to free the arena which we have witnessed on ppc64le [1].
> 
> [1] https://lore.kernel.org/bpf/4afdcb50-13f2-4772-8db1-3fd02bd985b3@redhat.com/
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Do not alloc arena on unsupported arches
    https://git.kernel.org/bpf/bpf-next/c/ab4dc30c5322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



