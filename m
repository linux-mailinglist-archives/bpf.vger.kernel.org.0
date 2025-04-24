Return-Path: <bpf+bounces-56634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B996BA9B660
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C19234D6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928928F528;
	Thu, 24 Apr 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7/E2Pdk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCE28E61F
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519572; cv=none; b=BDwogtmXlNTSaL9yTz3fB7b3OTkn3c/9zppWaMFMNy4PT2Og3qKv6FC8g70zbrq23kK+P9p0ZJSUq3B31f4RgiF2U5Qb7p5JR01np2B9QIRk9fBOz0oNbpjLX2qwilAogMPjcuDT+kaB/HDVQZBo73jOiJLrgjAQBD/6whZXccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519572; c=relaxed/simple;
	bh=6l8JTEjNrcSTi0uZsGYY581aG0K9Ci2LC6GVPdDgYXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BzFd/w5n+bpRpVNWWK4YUKxqFDk82dh0mKKVlvgwjcbh3/Ttl0FUozrFN7ELRKZsZ4y3EjNuDFlDEuPM8XZ1JKEyY2KuzWIEQcxj/h+YwRjEkVncaOPSKGkGa+LoVGB5WAZ2m42m2SItltti4j+NZDHiFoINzrzkN7nT+NQWJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7/E2Pdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56548C4CEE3;
	Thu, 24 Apr 2025 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745519571;
	bh=6l8JTEjNrcSTi0uZsGYY581aG0K9Ci2LC6GVPdDgYXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7/E2PdkbQRWcG2gMCMRgVcqjl5LcP/DaKF5/Ql7clFdfG3jI2cR/fliylP3SpCXM
	 TXFAQdG8e+fTYGGUhLxoFC/j4czSY/xHtb0f6lE0RdML3pz6Xv8pr1KsV8UDbH+a6g
	 rMfBrpUfiRCeOThVlIB+n8pLWCHtWQpzltTGMBxTSgSklbVhz4hpzPduz5BUqonbBs
	 9S5ffgy/n8gy0N6a4niigaxvWE4Iv5d0Sbcj8hzkviJhBseTC28BqX+TRSoygayoo7
	 R0nnO7+vBB9ZX/vJlaLtGY4wvAZbQY5FKLOT8bMRT+PGEFjENXZpLKTFs6w9kCjvB5
	 Pkz5/bUvTzJJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9F380CFD9;
	Thu, 24 Apr 2025 18:33:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 18:33:30 +0000
References: <20250424165525.154403-1-iii@linux.ibm.com>
In-Reply-To: <20250424165525.154403-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> Hi,
> 
> I tried running the arena_spin_lock test on s390x and ran into the
> following issues:
> 
> * Changing the header file does not lead to rebuilding the test.
> * The checked for number of CPUs and the actually required number of
>   CPUs are different.
> * Endianness issue in spinlock definition.
> 
> [...]

Here is the summary with links:
  - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
    https://git.kernel.org/netdev/net-next/c/4fe09ff1a54a
  - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
    (no matching commit)
  - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



