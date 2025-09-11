Return-Path: <bpf+bounces-68187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B3B53CF1
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 22:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DF71638A1
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 20:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DC255F5E;
	Thu, 11 Sep 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEc7Qd8J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB623D28C
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621411; cv=none; b=TrwCz1hjmdY/us+vXzbq7wLzyost+/Mn+1nduwJbBw+aCR5cB7LTLEVq2NFbe3oD8VJbGVQ7Hi9cztzJRhaMtu+1KESn9hbvn8okSyw2nhYuMpUEAfrGGSdB67+mpZ2l1w5TrsbD5YK8ugVMqfTisDgy1UrTpXnK0+PXtkHOJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621411; c=relaxed/simple;
	bh=WknZgl06eCrlYN6/aFabrAxp6cf4iH9Dcd5uMkk0mAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fbzuZjrctR1S/AShrLeisSCKAtyH66lQYP959KzDrDu0+nIJdkqBlpHnqzLF8UbVaLietrQcSYX0TvOK6HH9zUmPVAFd+/7cHiDK8sWjjGj/URKclMDxcPYH0oPrGxM507b8afWgl/cflSvpUqk6MSFUOcq90ZvC0B/14FVsJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEc7Qd8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC44C4CEF0;
	Thu, 11 Sep 2025 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757621411;
	bh=WknZgl06eCrlYN6/aFabrAxp6cf4iH9Dcd5uMkk0mAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XEc7Qd8Jqmzt0xyw3+faZGzXA3OrJ0ginLlR6ckLjAJIbk8lCjBtW0hxuggCtKYrd
	 u5lifDSMKxVuaux/XfaUuYBdBfq/omhQ5oI3yPU1oD3lHvEVakIvmHmAQQUpZiZ59e
	 onVb/0Rovy5LbIc0v1hCoxJXu50xrKGgTWsbydG1NM72iMRw3s2EHxTOfzIlLxLEDI
	 wSkkc9sBHZ+HiUxq6m8TogXb7s7BNY7mhDimZj5uMMBv48C0mmEaiPZevWrU6NI5ua
	 TvI7lXVxeS0iOgHegMeaskuAYBFmdEBboWtm6Ik10lf7EBgUWkDjL4GdJNtTd2eYGb
	 aA7uM4vs9otKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34074383BF69;
	Thu, 11 Sep 2025 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/6] bpf: report arena faults to BPF streams
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175762141400.2303017.8378147069265354084.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 20:10:14 +0000
References: <20250911145808.58042-1-puranjay@kernel.org>
In-Reply-To: <20250911145808.58042-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 memxor@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 11 Sep 2025 14:57:59 +0000 you wrote:
> Changes in v6->v7:
> v6: https://lore.kernel.org/all/20250908163638.23150-1-puranjay@kernel.org/
> - Added comments about the usage of arena_reg in x86 and arm64 jits. (Alexei)
> - Used clear_lo32() for clearing the lower 32-bits of user_vm_start. (Alexei)
> - Moved update of the old tests to use __stderr to a separate commit (Eduard)
> - Used test__skip() in prog_tests/stream.c (Eduard)
> - Start a sub-test for read / write
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/6] bpf: arm64: simplify exception table handling
    https://git.kernel.org/bpf/bpf-next/c/0460484244e1
  - [bpf-next,v7,2/6] bpf: core: introduce main_prog_aux for stream access
    https://git.kernel.org/bpf/bpf-next/c/70f23546d246
  - [bpf-next,v7,3/6] bpf: Report arena faults to BPF stderr
    https://git.kernel.org/bpf/bpf-next/c/5c5240d02061
  - [bpf-next,v7,4/6] selftests: bpf: introduce __stderr and __stdout
    https://git.kernel.org/bpf/bpf-next/c/744eeb2b27c2
  - [bpf-next,v7,5/6] selftests: bpf: use __stderr in stream error tests
    https://git.kernel.org/bpf/bpf-next/c/edd03fcd7601
  - [bpf-next,v7,6/6] selftests/bpf: Add tests for arena fault reporting
    https://git.kernel.org/bpf/bpf-next/c/86f2225065be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



