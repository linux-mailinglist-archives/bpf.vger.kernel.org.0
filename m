Return-Path: <bpf+bounces-21922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34515854059
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76D21F23D71
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96B6340D;
	Tue, 13 Feb 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmlpK1MD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D11633F9;
	Tue, 13 Feb 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868228; cv=none; b=WFNIjhAbHfw/lDV78cQ6VPK9M6B4KFkC5QUtyGhkBFxTxSnWql/4wZGckixBIan1CEGqLZaZpZM1JpfHjS0WB4m55+3+ZEYxTJJEmjJzkopiSpY5RqBBKckrq3604HOZ49MWJtzcI7zZ1qIDdNUQUCELdqDDx/7UZ0M2JX44nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868228; c=relaxed/simple;
	bh=WjQ/X3NSmKyb4R692EA0pgmKMhK4o0O9Y2so7i2Lf8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a22HfHIh2tCufSjOcKet0dcSuVstF2wHWUEkS5jPQyK1BhrqIZxdtXB0tAXSHdHjxHEpmxsoCAyJB8Dt6kcRWvz0BsxHHJr2VA7S2eZtn/PDeLnqeVENPOY9QBWUo6DwMfBPtLOdNx5C1+z6HkBSYXKP7L0yaIbEzOoqCTEIo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmlpK1MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2D20C433C7;
	Tue, 13 Feb 2024 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707868227;
	bh=WjQ/X3NSmKyb4R692EA0pgmKMhK4o0O9Y2so7i2Lf8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GmlpK1MD5e7L838+/5zVQXkfmVxj6uuyHIuk9fVtHifuAtXpsZ0bn1dNtEfgtOmLc
	 Z/zlqEzUKhrw4DU0mJLM1P6Yt4gRp+lkOOYUZi4fi0vhsYE8A8kxi8DiuNWJ808YQ7
	 +CWFcFCa0/9a8ZS3ePvvOuObvOwLaodXFxCk+qYs5xkoJTKPAK6ciQoi/w+61sGl60
	 viuJiy9uAGvNqJvYSJBAhyQfzM7gGamWYYY4IVdaud7+NDFmdGlH0lKnrvgD+UdaiC
	 4NE4XG0kNdgcWWYQJi8cbn9bvhugLOw9ioQcyOhWQqmJP4vlEh/KgOD9X+FYCLC1Wz
	 yMQqsE8RN/6ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96819D84BCE;
	Tue, 13 Feb 2024 23:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170786822761.27066.7216418031548418747.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 23:50:27 +0000
References: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
In-Reply-To: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 9 Feb 2024 14:41:22 -0500 you wrote:
> Originally, this patch removed a redundant check in
> BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
> the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
> reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
> and add the checks to the other macro that calls that function,
> BPF_CGROUP_RUN_PROG_INET_INGRESS.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
    https://git.kernel.org/bpf/bpf-next/c/32e18e7688c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



