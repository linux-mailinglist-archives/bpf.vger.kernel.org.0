Return-Path: <bpf+bounces-56984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E31AA3A28
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 23:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E9E9C05EE
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7322F74E;
	Tue, 29 Apr 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWJu0GT5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99D132103;
	Tue, 29 Apr 2025 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963390; cv=none; b=s4tDrPXfgNVuSi1qqMrIcGsiOdsG03zZArltlB7kwRcNeJmDS0/n/CUv9uNcHMMqbZihwRUjNbLOf3M4aCRqh+iXz7rS2FS9MJC6lWZz/TSxxre8Dg1fzETV+n7OG/F/7AyQ3coqp3TMm3CVy6OwB3KDwGxbL/moaz/1ixux4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963390; c=relaxed/simple;
	bh=AVB47antGnRuSOkz4VXQX+zDZwDN54Dnu1gRBZtYLFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O6OKTkR5IyQfagZoqAAygXukntdanxPR4iW4eEEzpgaea+C2a7bm+JLGRPwpvSmk+qjsZjVzIQeOHe86KVu1X+9/Cps+f72oioZXwpFHNUUOwrQMrUDrxkgyEaHpGKhThm+bNAPx32Zo+9yMGk+Z67l2XunxIEmBtkaWCJr+VSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWJu0GT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE757C4CEE3;
	Tue, 29 Apr 2025 21:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745963389;
	bh=AVB47antGnRuSOkz4VXQX+zDZwDN54Dnu1gRBZtYLFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KWJu0GT5CDE5nJqp495YZgnGD7uCgUZYqp07QofV2fFTGZkH6ObM/1Eshb2vf3F3/
	 gOvhENP6QEQBzT/67kvZ2q5d50A/0PywbJdYN3L4ZoqKHn4JVRl5QaGVuOlf+R8bd0
	 7JVfTjI/FhnftfaQV4zaJ2hlRhcYywx2ARz0ije9n+oG/FmaeqrYgIthVzHyCaDv1Z
	 FjbYQXL7iL1OHsthM2E5mVWBhz3JqX85XlzkZKOabDbc28GPeH7ICuJHtI6RZ3FJQ2
	 ioicw5ZCDmzUKViGTUMFODlrMl5jvgJw4MmsQbkhSqcDSzySbi+E+CfuCxCZX9DTBV
	 zMyuX2z+stdaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB38A3822D4E;
	Tue, 29 Apr 2025 21:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next/net v2 1/1] bpf: net_sched: Fix using bpf qdisc as
 default qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596342875.1806681.1358143960820509677.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 21:50:28 +0000
References: <20250429192128.3860571-1-ameryhung@gmail.com>
In-Reply-To: <20250429192128.3860571-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 xiyou.wangcong@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 29 Apr 2025 12:21:28 -0700 you wrote:
> Use bpf_try_module_get()/bpf_module_put() instead of try_module_get()/
> module_put() when handling default qdisc since users can assign a bpf
> qdisc to it.
> 
> To trigger the bug:
> $ bpftool struct_ops register bpf_qdisc_fq.bpf.o /sys/fs/bpf
> $ echo bpf_fq > /proc/sys/net/core/default_qdisc
> 
> [...]

Here is the summary with links:
  - [bpf-next/net,v2,1/1] bpf: net_sched: Fix using bpf qdisc as default qdisc
    https://git.kernel.org/bpf/bpf-next/c/7625645e6945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



