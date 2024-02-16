Return-Path: <bpf+bounces-22129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F928573F9
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF87285395
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2523FC05;
	Fri, 16 Feb 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzGtOXY4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62950646;
	Fri, 16 Feb 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708054228; cv=none; b=ndxf4jD0a593TVip/QzP2nNVatLy4jO1a7b6MppUfsS49gsVPt4QBj/GUbzIpysAIpS4Gxoy9uFjaYawQlMxJ2GDKUTXXdAv2OGa5sEVlJiJ7J2UQN6qeD10JNLHxzWmfw1OtglpKcEUSEzdzWtePAPdsLVZlO4guKYZ2WvWZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708054228; c=relaxed/simple;
	bh=yis5j+kuKbFEkfOigSfagwNj4LlTZyMS8LWzTsFv6m4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jwr+tKfkuFmzzoTM3JWiZzZomBoKspIu5SppUHMyX5vmyiYBKe6+uCo2fnQyYgMxRzwfXeK1pvy+xkoY6ThfEal9FnODBStC8Wx+w1lw3RK7YDapViBTETyCNVykPhvr8K9Jsgt1mfqlBzwuT7BDb0pa85YE9hqncT2OcYCwG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzGtOXY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21894C43390;
	Fri, 16 Feb 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708054228;
	bh=yis5j+kuKbFEkfOigSfagwNj4LlTZyMS8LWzTsFv6m4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzGtOXY4E/Cjid5zcVMIvrAR4qZV9RHEkOTXNjSvIMlWy7hGEYqj3C7Dog2N9viKp
	 uHdHBdu6wQ/69vgKzrWF1fCRniggL575+B5ZnRK6WydC+8k2S0la74MgjVKV8LkwPN
	 UvwEZbLmBsua8KLtn7TX7ZLnqfRcmisLSARYlyaH6QciOYSzD6JaTIxBrPIciYBdTR
	 386f1d1+n4iPOll7xXKuGNNu1jTvRe20yNA4dA5KV3XHZlkSHG0f+9ogyhu4Es05Ij
	 bLP7hJvQgf2+gqKPcbcEauYyHXXtMKxOGIMZn278KdBOzokcA4QSWZmwbeWnUsRXZ7
	 Q4x4yHey6eJKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05C0CD8C978;
	Fri, 16 Feb 2024 03:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] Fix the read of vsyscall page through bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170805422801.26502.12244225184380221288.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 03:30:28 +0000
References: <20240202103935.3154011-1-houtao@huaweicloud.com>
In-Reply-To: <20240202103935.3154011-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: x86@kernel.org, bpf@vger.kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
 xrivendell7@gmail.com, jannh@google.com, sohil.mehta@intel.com,
 yonghong.song@linux.dev, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Feb 2024 18:39:32 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> As reported by syzboot [1] and [2], when trying to read vsyscall page
> by using bpf_probe_read_kernel() or bpf_probe_read(), oops may happen.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
    https://git.kernel.org/bpf/bpf/c/ee0e39a63b78
  - [bpf,v3,2/3] x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
    https://git.kernel.org/bpf/bpf/c/32019c659ecf
  - [bpf,v3,3/3] selftest/bpf: Test the read of vsyscall page under x86-64
    https://git.kernel.org/bpf/bpf/c/be66d79189ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



