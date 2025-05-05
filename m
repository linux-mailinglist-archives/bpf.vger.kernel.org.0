Return-Path: <bpf+bounces-57389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B618CAA9E90
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7335C5A065C
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B5D274FEB;
	Mon,  5 May 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0yfV71c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47C1F78E0
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482389; cv=none; b=NDFtSUKywqUJ/As7ubiYhyqXvVPfc3Uvp6JubXv7qUUQO3MvJRi24RVO0ZDfe3CUDukmLSEG2YIgmgW6v5brMk4ivRlyrigp4kDu5NxNj/UFYo2QDb8uGhU1CpEP3/o41SfHMDQ+pUIF0tXNOSxf1tmkHh8sM5/wO5LcXKqbPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482389; c=relaxed/simple;
	bh=MYU+W9XwP1ANHHWBgF5ToKkMg8WcW9bTiS4kod4pbpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sDThSVklN0cOQtrMBkeAaJOvh5i6td5GH7lDTtZGVOkqUkpjOgvpGVmZhNDvxmtZ30FkWAazQbx3CLK47IWRV9pOnVnVuHEHy9RELzrKXA1DB7OL7EUT/JkvfjyYlS2qn6HzhR+3Nzo374HMLtYabj/MNu7L2wT+b1A5X+zJgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0yfV71c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E080C4CEE4;
	Mon,  5 May 2025 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746482388;
	bh=MYU+W9XwP1ANHHWBgF5ToKkMg8WcW9bTiS4kod4pbpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O0yfV71cxV8W5v+IWsDmt9FlBOyetAZEwSdEzpdqOA6dWxxYWB7hRLiVDc52RRWy3
	 LWh/QfPBjRjZAezTgtY+hXs/g+QQTgX4RFciq1dBUlKd8SmC/9QFPnpdBS08UkfpIm
	 3pdsOcH2PsOQ/boZgdauPpsNdEHHrNF4JN7uNrLwn+R9xLCFL5dfpXzZjrfFQ5NSFb
	 +q9d4KBGlE3ZkXBc/vvUVflaCdSODLdYgwcF9aTsZGff69S9rCMAiIhCwX/d+u3L0H
	 2lmLEYWL19DTLfLbqZvT1tYNtJaTnHRjKL+bFkCqQ/7T6JrUyVBj+0Ksx7rSkJWGGW
	 E3Cn70ehLTeDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8E380CFD9;
	Mon,  5 May 2025 22:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of "identical"
 BTF types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648242775.901475.6361056701698459458.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 22:00:27 +0000
References: <20250501235231.1339822-1-andrii@kernel.org>
In-Reply-To: <20250501235231.1339822-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  1 May 2025 16:52:31 -0700 you wrote:
> BTF dedup has a strong assumption that compiler with deduplicate identical
> types within any given compilation unit (i.e., .c file). This property
> is used when establishing equilvalence of two subgraphs of types.
> 
> Unfortunately, this property doesn't always holds in practice. We've
> seen cases of having truly identical structs, unions, array definitions,
> and, most recently, even pointers to the same type being duplicated
> within CU.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: improve BTF dedup handling of "identical" BTF types
    https://git.kernel.org/bpf/bpf-next/c/62e23f183839

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



