Return-Path: <bpf+bounces-52019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5AA3CE87
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C613B3C97
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BC1A8F94;
	Thu, 20 Feb 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbCVRDCb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A53192B82
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014400; cv=none; b=koUyI7FRB7aTF6MxC6f06CguIWVPrV2BanjE++DJWovt0zWjhw6hlamzcjM/ssf9paCrOS2I+lb4Sgv/lHBP+525mv+wq2+2Xjfpwod/2S8ye8InxOiE39k0eswkDLyBVqjhxPGSimUkeXxS2Pexd5acgEOYfOjncBOKfrbp9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014400; c=relaxed/simple;
	bh=UuOHqAdq3MHY72I6D8OD0O+fPWvQWR3ZtBa7hbj8Mhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m0CVWjfkLxuMihiouAfY+5ALL/yrIvsBG/G9ZPLsezHZj/Xa+Heyb/QIrxcnxv49nu7GjsPzAv55bK4V4Exf0JA1mnwW/U2tieI+1jq82JX/o1tD2FsqJt91poKZZmu/Zl6ep9M000H6DJJQTzwF7e0MTcKsHKS0X2v7KDmqsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbCVRDCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3BEC4CEEA;
	Thu, 20 Feb 2025 01:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740014400;
	bh=UuOHqAdq3MHY72I6D8OD0O+fPWvQWR3ZtBa7hbj8Mhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbCVRDCbrqf/TJBmpwh5xNDxmPkybFJjRmKon4NgdAfEKpiNd/fXH62ZTWj93/vqx
	 3V8vhcKAa8R0d8s6GejRytOVL8khkY+s3q4vnXf1tACgs0WHA+GzvKlhaunGRBwxhd
	 tznamr8wTbi+Ycn+S03uNrCalHFF0L1RtZCmI6USXU/101U8yzBdLzOMkd/JanVlhp
	 iUnHnk6LOmi0KGJZvV1cTfL4k7b+HimWAeu8CpziWdoYxqYtFebMHPfLMFdciShpEq
	 fWcS53RwPV80VrXI+qcsbOKSnyNI1UBBtwPuZObtUaMSO6DRGjjklpHzsf8zQsZU/k
	 G141UFmlXWP9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB585380AAEC;
	Thu, 20 Feb 2025 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174001443079.803988.12953607627468709110.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 01:20:30 +0000
References: <20250213152125.1837400-1-linux@jordanrome.com>
In-Reply-To: <20250213152125.1837400-1-linux@jordanrome.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
 akpm@linux-foundation.org, shakeel.butt@linux.dev, glider@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Feb 2025 07:21:23 -0800 you wrote:
> Similar to `access_process_vm` but specific to strings.
> Also chunks reads by page and utilizes `strscpy`
> for handling null termination.
> 
> The primary motivation for this change is to copy
> strings from a non-current task/process in BPF.
> There is already a helper `bpf_copy_from_user_task`,
> which uses `access_process_vm` but one to handle
> strings would be very helpful.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/3] mm: add copy_remote_vm_str
    https://git.kernel.org/bpf/bpf-next/c/f0b79944e6f4
  - [bpf-next,v8,2/3] bpf: Add bpf_copy_from_user_task_str kfunc
    https://git.kernel.org/bpf/bpf-next/c/f0f8a5b58f78
  - [bpf-next,v8,3/3] selftests/bpf: Add tests for bpf_copy_from_user_task_str
    https://git.kernel.org/bpf/bpf-next/c/7042882abc04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



