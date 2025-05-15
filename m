Return-Path: <bpf+bounces-58267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1393AB7ACF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 03:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C164C6991
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED32397BF;
	Thu, 15 May 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khZC89BP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754EF9D6
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747270796; cv=none; b=cPceGROzRXpzBiGT641EKTYTZU5y8iDO7sKpMLTilk7FCUGm+k95izlG6Q5tfspiOYsWiq3IdeYqbz3bNld3zD3Qn45JhyN7Xt5NE8/xWBzWmV2Yssgn6GPMdetyrMM+M4LikDHOQdfNqD5Az0bCILtObMka5bM/xoxNnd9/HTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747270796; c=relaxed/simple;
	bh=e1mIlkOD6crmBYqQ5XjjlRBiXPzgiHNMiz3NMdTQ2oE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZmuRz09FUriYZeeIaEudv7IzW3tEC2m8jtzl15gUMmcDRr3Grlh1C6qAX06MYQXYza9lAh8w46ro/80rvfajynpButUXG3xuQtRCydTGqWNo6qPSfogsNyXb2SQgK3wMgxB3JtHs/erkAHyKMbVRuMs7WXSUXFHRfo+uSPWUYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khZC89BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05306C4CEE3;
	Thu, 15 May 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747270796;
	bh=e1mIlkOD6crmBYqQ5XjjlRBiXPzgiHNMiz3NMdTQ2oE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=khZC89BPzIN+TEvKDY1SS12wCYQgPnRRqo5yuTgj9ZWBTfv5LjtcOtuDtrvxIFzre
	 vUNu3RMh1BJbU8t4oj2b6WnHSpqUvOhFSsDacLnnBgUpwzWrKImP/tlxn/24kOm/5h
	 FuOqzffPSxpbccn7TyGgY6ud+aQnojsxnn9QP1QtcfxWV8FjpgEn7oZuqP+UctVnNb
	 yIWf6LwZIC/u+X/h5ykHGlCXjAJkVOx7Z4hnaWtuWMR+le6nURpYDmOOBHaegJQtsP
	 9cKFPvQBMLjGsm1pJEznNdFK7mVB/OIpdp0lx6jmZUv+FDEA9yhC1Wl8Hh5HtouD55
	 NHo1XDwaNec1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DDC39D6545;
	Thu, 15 May 2025 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] s390/bpf: Remove the orig_call NULL check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727083326.2565117.18404684129254773412.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 01:00:33 +0000
References: <20250512221911.61314-1-iii@linux.ibm.com>
In-Reply-To: <20250512221911.61314-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 May 2025 22:57:29 +0200 you wrote:
> Hi,
> 
> I've been looking at fixing the tailcall_bpf2bpf_hierarchy failures on
> s390. One of the challenges is that when a BPF trampoline calls a BPF
> prog A, the prologue of A sets the tail call count to 0. Therefore it
> would be useful to know whether the trampoline is attached to some
> other BPF prog B, in which case A should be called using an offset
> equal to tail_call_start, bypassing the tail call count initialization.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Pass the same orig_call value to trampoline functions
    https://git.kernel.org/bpf/bpf-next/c/94bde253d3ae
  - [bpf-next,2/2] s390/bpf: Remove the orig_call NULL check
    https://git.kernel.org/bpf/bpf-next/c/8e57cf09c84c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



