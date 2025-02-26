Return-Path: <bpf+bounces-52667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5729A46779
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A0F1884D9F
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD02222CF;
	Wed, 26 Feb 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8bCc4rZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1C2904
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589199; cv=none; b=nINwMC8A/TbLi55givROwnK+os88WDmk4RKW8Zwz6ZBpk++cl3On3+OxX5du/aZfDwW2te3JNVtPeR7RY9yoRHgHsx+3Ip/2tfhtGJ62Ll0Arl8RUtzBmASvrRgprP3tJI95ifjgwNxQ2/4tPbjBCBDCm35NeP0E/O0nZhpiE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589199; c=relaxed/simple;
	bh=NmBRCf33L+qCyGLhUM7Q4jX6FEJ5JXUaMVMiIvYEWko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KpFc1j08IWN6Rul76AooBlDHqpFeH9syMDbFEgy+KC0Cs7AD2JV1ZfOKadMxtcJnVzqBf0gVB8JH/KZk1nq3DQAicGKDWII5TnbVKhERXLy/ccqySDLUfiJKsOEb5q9LKN2mra36DF58dkZgCPCKI8zHWjkjic3fu8APNqExKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8bCc4rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B70DC4CED6;
	Wed, 26 Feb 2025 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589198;
	bh=NmBRCf33L+qCyGLhUM7Q4jX6FEJ5JXUaMVMiIvYEWko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R8bCc4rZddvSgyI6ZG3Q8ZKYKpv7ukjH0K5xSWkxYDUuJQ2QxMvOhnH5mkeMq5Gb4
	 xqI4qjPPHMnEbRl24LM+zPKLbnwf+WFMspN/mo+ebXy3ZK5Kf40qXYRK4hvNKvsTnA
	 NPEPUz1y2UrjZKFj2N79s/2/2/2wwX/0zpDobhWFXm88Dv/87VBBDBGE8Lcrcf8e5F
	 5xeSLp2abZU3E/gHe/33dNOkb9P5aBo9gDInB0WnVyDmYogu33LB1dbHSuClUe9zJM
	 mQb1cW2mwGQdM/KhfrkWELhoKK6ucieBzc82a+evyisdVS7335SFEJqae9kiNBDdau
	 2H2fdcgEXjEcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710FA380CFDF;
	Wed, 26 Feb 2025 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix deadlock between rcu_tasks_trace and
 event_mutex.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174058923014.775946.3941358248212778810.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 17:00:30 +0000
References: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 24 Feb 2025 14:16:37 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fix the following deadlock:
> CPU A
> _free_event()
>   perf_kprobe_destroy()
>     mutex_lock(&event_mutex)
>       perf_trace_event_unreg()
>         synchronize_rcu_tasks_trace()
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
    https://git.kernel.org/bpf/bpf-next/c/4580f4e0ebdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



