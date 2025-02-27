Return-Path: <bpf+bounces-52772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8170A48518
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AB23B190E
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271A1B4155;
	Thu, 27 Feb 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYfrG0x5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2E1D4335
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673799; cv=none; b=IfCNqRXcCTddZCND2XQRQqr2gWLAZ66fHKW1/R4/PAkGJWARwmmoTlzxhxCLQHlyDX0I0AjE1gCKIBC8DVquKLChIlyjyWdYVKfnxsH7G0+8GHaUCII98SDh6y1fZp98CaQkFIsmwxkmXkphOKKndg/JBswOBDt7Am+phS7WUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673799; c=relaxed/simple;
	bh=w8WF0/IiL501AEngNCN0qhQxZhpm5PJ5qEiYWNwGKjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7qVTe7ZwoYTQcDoDO/d6sUCt7bOEDxkAg5AcMqKs9i1fdo94jTPN/EDuyWC1ZuSkap13phhQPTpUfBdl8hDknV0YdNyjFgaOWu5yXhE3zXgBVOLIUNCHBWAL28HbaD87xvDysEinlLBpMJkb1hqc4d6LZN4Cu6pDFMOu7LBH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYfrG0x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A843C4CEE8;
	Thu, 27 Feb 2025 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673798;
	bh=w8WF0/IiL501AEngNCN0qhQxZhpm5PJ5qEiYWNwGKjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYfrG0x5txSlcN/MKmtnNn4xKcZ2JruuAvN/Z99kwo3YFhnv3Yi6MGdcBsrbw620J
	 vAzJo7ZKqX9ebfJ58GI06bJGiFLwqZnOImQS0/xfhx0YFxsE4IkBAeffWmmzm1EDcZ
	 Gg7khaao+0rkAQOM8kmvYGocdPqArOJ720V/GVIZT19UEFpJ949CdTSH+hHFqkLp6A
	 qyv6Ddyj2KcLHNdRl7hGlt8H18HfbnNlWooXngZlxtx/bwcskeW7AhrDnDCDp+aZiC
	 3lUuQ6C9vOIDZHXBrzxRShi6R9Qkz4dImPoh8KyQw9OpY+e/aPRhoSfrOFpF9ERHkv
	 E4bioUyor4ruA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71197380AACB;
	Thu, 27 Feb 2025 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Allow pre-ordering for bpf cgroup progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174067383026.1487768.12826421713291472353.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 16:30:30 +0000
References: <20250224230116.283071-1-yonghong.song@linux.dev>
In-Reply-To: <20250224230116.283071-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Feb 2025 15:01:16 -0800 you wrote:
> Currently for bpf progs in a cgroup hierarchy, the effective prog array
> is computed from bottom cgroup to upper cgroups (post-ordering). For
> example, the following cgroup hierarchy
>     root cgroup: p1, p2
>         subcgroup: p3, p4
> have BPF_F_ALLOW_MULTI for both cgroup levels.
> The effective cgroup array ordering looks like
>     p3 p4 p1 p2
> and at run time, progs will execute based on that order.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Allow pre-ordering for bpf cgroup progs
    https://git.kernel.org/bpf/bpf-next/c/78a8a8556040
  - [bpf-next,v4,2/2] selftests/bpf: Add selftests allowing cgroup prog pre-ordering
    https://git.kernel.org/bpf/bpf-next/c/42c5e6d2accf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



