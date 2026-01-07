Return-Path: <bpf+bounces-78028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E590CFBA22
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F49A3032113
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 01:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1118227BB5;
	Wed,  7 Jan 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOyllyxo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996F22256F
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750813; cv=none; b=ort/rn7UZ4z0BM5NNbOCo+OXubadWPGavJSDwrLjpPAU1ES5NjmG0WF9WiRlG2jW6iwuT1b0o5dh3DfvxMccooEYPXMKfPQHwYU5/1Nj0dT+o5ng0oObTmrKOi96pXmCrhcvcO9B8FAB/Ynb+ij5c1HW9DABcFqXqa3lWxKR4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750813; c=relaxed/simple;
	bh=Mf6VNMjA7tZesZa8OCTdOiePt80Jd093jR8Z/NlfFjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f8hIYEUtW6Z/CdzU0wJstDYmObsa/N2yrHevTJ0UILuaufeR2enksHa0JB/JnC6iivY5+wK6CXLpT6XOe41fAcwxNBpOcZWO3O9g55TIClzjWrRoz4IxNTt6B/qwGjxdw7F+2Qp2QXsbq7+Y2To187Xz3e4Cy38JFCxQG3l0mzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOyllyxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F62C116C6;
	Wed,  7 Jan 2026 01:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750812;
	bh=Mf6VNMjA7tZesZa8OCTdOiePt80Jd093jR8Z/NlfFjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XOyllyxoBhwmaq8e7/9O8bkAxhC4nI+ksNhsG4J62JTPUx0DPrewjj6DeWPvEgiVg
	 LUMmUkkV+gpr+stoDFxwiFzNTn5liGmhl6nbSoRpxGC5By61zhtJ7tMSzBO6F+GuKW
	 R1CkrGgNwnvaMi6Y4BsG7RHluvL4kqzhB3cKQGaTrjfXEDaOoKFTczbnmZgE7emgZf
	 c2U5ZJiIJ7C56Y90RJpRhOuJ2xSgvsI+QFUyH7Km00hOYIrSLeYNpA97GHNjVxggjV
	 hgJsdWOQYAy6krLvLZIMOXLmyPVSVQfc1GR+erWiq9SyD/EMJ99jhOHPOTy5H4+3KI
	 QYf+C4LkitvHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A59380CEF5;
	Wed,  7 Jan 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] bpf/verifier: allow calling arena functions when
 holding BPF lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775061028.2196201.1398498907628337983.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:50:10 +0000
References: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
In-Reply-To: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 memxor@gmail.com, yonghong.song@linux.dev, puranjay@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 06 Jan 2026 18:36:42 -0500 you wrote:
> BPF arena-related kfuncs now cannot sleep, so they are safe to call
> while holding a spinlock. However, the verifier still rejects
> programs that do so. Update the verifier to allow arena kfunc
> calls while holding a lock.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/3] bpf/verifier: check active lock count in in_sleepable_context
    https://git.kernel.org/bpf/bpf-next/c/b25b48c7d376
  - [v2,2/3] bpf/verifier: allow calls to arena functions while holding spinlocks
    https://git.kernel.org/bpf/bpf-next/c/39f77533b6c1
  - [v2,3/3] selftests/bpf: add tests for arena kfuncs under lock
    https://git.kernel.org/bpf/bpf-next/c/b81d5e9d965e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



