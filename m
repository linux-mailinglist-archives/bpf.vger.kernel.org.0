Return-Path: <bpf+bounces-38931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5896C897
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF551F28575
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE0148833;
	Wed,  4 Sep 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrzNlBMF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0562A02;
	Wed,  4 Sep 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481831; cv=none; b=sSrkO+BPkKOG/qOr2U2LGciSlQ76G97UgEwn00wx/4ysiOuUZ13ZktTZQpCq2pBDhntp5Gig2QEIVZIUJMzFQM5QpvbuozU4EfrfZBnv8yw7D5hm/EtT8uSQZs2rrykIcqulG4A4IlGxWcwb/W7PSZqzzgMPVZVg/E087TrdW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481831; c=relaxed/simple;
	bh=ZDVqpTpXFqfaQOBp5jbdRI+wlIMqz5/1OVyt667YST4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pq8qeGVDujU5WL+dfVVe7RSDiP7lruwxffpwxKDU9dpbSEyXrq5WWjsbxIkkoYKdAbvJZvA+pzLXX9tg4XmE8ED8WVz02VA+x+qejq7jbVT/bIdezY42u23q+skZeAqdQ9nTzCahJBZXbVyuSguz27JlfSCn1SM4nN8IYb/YXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrzNlBMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEB1C4CEC2;
	Wed,  4 Sep 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481830;
	bh=ZDVqpTpXFqfaQOBp5jbdRI+wlIMqz5/1OVyt667YST4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mrzNlBMFEsp7n8AE5qk3UQVmKDA2R/m+wCfhYHJ0nrP0WwtV+3YLXgzPbuXARX4tv
	 jS0KSkgsZk//TO+fCx0l2I1HVyUmV5YGRSjFieQDi5OUtXrWVhS0Sx0SNO/A6kttYI
	 l5vNW5MU0O6oThFon7QQGUT91pTT+v13l1pU8nyZwwSQi7PboAhv/HnajNyaZEo/jL
	 mJOM+zquArWYrloWULK9D1f2BTTl2nJeEoBHc4Kc4FfkBZAFyjGHaFcG+GlQks55lV
	 Lnh0JpDmo63LtKdlhqwZm48SatHEJZZrRrMQwTU4xRqTDoLMBLFWpYJFAWi0P9Vio6
	 vFgnfKqO1b2bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFD3822D30;
	Wed,  4 Sep 2024 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] Fix accessing first syscall argument on RV64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172548183128.1158691.9881712792582282151.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 20:30:31 +0000
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
In-Reply-To: <20240831041934.1629216-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, andrii@kernel.org, bjorn@kernel.org,
 iii@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 palmer@dabbelt.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 31 Aug 2024 04:19:30 +0000 you wrote:
> On RV64, as Ilya mentioned before [0], the first syscall parameter should be
> accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
> otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
> test_lsm, etc. to fail on RV64.
> 
> Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.com [0]
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] libbpf: Access first syscall argument with CO-RE direct read on s390
    https://git.kernel.org/bpf/bpf-next/c/65ee11d9c822
  - [bpf-next,v3,2/4] libbpf: Access first syscall argument with CO-RE direct read on arm64
    https://git.kernel.org/bpf/bpf-next/c/ebd8ad474888
  - [bpf-next,v3,3/4] selftests/bpf: Enable test_bpf_syscall_macro:syscall_arg1 on s390 and arm64
    https://git.kernel.org/bpf/bpf-next/c/3a913c4d62e1
  - [bpf-next,v3,4/4] libbpf: Fix accessing first syscall argument on RV64
    https://git.kernel.org/bpf/bpf-next/c/13143c5816bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



