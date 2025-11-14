Return-Path: <bpf+bounces-74565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69933C5F516
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209BA3B89F8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763D93002A5;
	Fri, 14 Nov 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOoAkslk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00991E1A3D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154641; cv=none; b=ZvvNc9Qc2pka5YHTlxF5yNe5TxN4j+PcXp52mX/J+iLzn967sGxgDPQnnDMPxrMEOeUYRWLv1YdTm4hb0FUirFDpWmF3F+vqGxYyJm8zctKJkEA26g82aN5n7eOeRopmEM0K81xhNNHHBobqbJPVhl81KEQt5f8uyZafOMEKC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154641; c=relaxed/simple;
	bh=iMfC6oXUu1Tgqq9v3zVcdoBb9JXrBzY50ISUHFAcSvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NhjM+YiMQPc2/sEyn/iq/gufQMKD4ynXVaDE7F3gq9q8eWjOHymbf6KUcuxmfF9/HtVNQBhJUMiN+pB8177XST+Xr+rKqsVjPsVrksOCs0esEBanYdFYiQvJZ5w5im1r0yr0/e3xpz4t6HjfgazizOLMs8CWPK2gxC22IhU2fgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOoAkslk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70932C4CEF1;
	Fri, 14 Nov 2025 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763154640;
	bh=iMfC6oXUu1Tgqq9v3zVcdoBb9JXrBzY50ISUHFAcSvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tOoAkslkR/nFfbMmU2TRbB9difi8zbc/0SZfUatCjTv8ZrDTXwAzfQayRhSKrCwE/
	 pJXOvHv3V8he37Syxuk1HVtGYLcyYBtbLf79EEEdssTxFIuzp+fgWX64WdnpL0EESu
	 VLgNHmyUPqhP1zqpI4KvsHN+4pB6fgKGx65wOQlFmQIVqbJnBtWIx97UchsGGuEs9x
	 4Id6mYcQ3gx2wF2oV/GSLxtwA2O7x93z+f04sBQoSjgEn5xGNZyShu5XRJsjbrv2pa
	 pp1TLENBAuCXxFMLEIk8znY99vOZrR8vO9VwExwKMwlI0pQ0weL8OwMbiFPZb/Zzxi
	 SXBDSLUKq7W3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AEB3A78A5E;
	Fri, 14 Nov 2025 21:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: prevent nesting overflow in
 bpf_try_get_buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176315460900.1836273.4880914220928458994.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 21:10:09 +0000
References: <20251114064922.11650-1-chandna.sahil@gmail.com>
In-Reply-To: <20251114064922.11650-1-chandna.sahil@gmail.com>
To: Sahil Chandna <chandna.sahil@gmail.com>
Cc: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bigeasy@linutronix.de,
 bpf@vger.kernel.org, syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Nov 2025 12:19:22 +0530 you wrote:
> bpf_try_get_buffers() returns one of multiple per-CPU buffers based on a
> per-CPU nesting counter. This mechanism expects that buffers are not
> endlessly acquired before being returned. migrate_disable() ensures that a
> task remains on the same CPU, but it does not prevent the task from being
> preempted by another task on that CPU.
> 
> Without disabled preemption, a task may be preempted while holding a
> buffer, allowing another task to run on same CPU and acquire an
> additional buffer. Several such preemptions can cause the per-CPU
> nest counter to exceed MAX_BPRINTF_NEST_LEVEL and trigger the warning in
> bpf_try_get_buffers(). Adding preempt_disable()/preempt_enable() around
> buffer acquisition and release prevents this task preemption and
> preserves the intended bounded nesting behavior.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: prevent nesting overflow in bpf_try_get_buffers
    https://git.kernel.org/bpf/bpf-next/c/c1da3df7191f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



