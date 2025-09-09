Return-Path: <bpf+bounces-67947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D0B508D1
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4644B1B243CD
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142B2698A2;
	Tue,  9 Sep 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7YHPDUX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E6DDC3
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456418; cv=none; b=nmv6vCLRrBux1uueX7wDHiptBD+FNugS1TZ/dcn9MA4Nr2n7dORmORCmFgTydUDcCTyUibE7VNjQJaqPFTM4xBocHP1LQDFb3b6O3e1AqjLlWlroWKSEHaifoc4HRLjluLFPFo56vx3mc9B/ushXKUsuM5Tnp8HS71gRWE9lK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456418; c=relaxed/simple;
	bh=k543HBY3iPS5FEJ45yq8cqoQji/9GFCbQc+MS9+u1M8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZsHGgzrbHHRWascdig5nkmz3+rcC7aigBi5F8BjQQgv4Bt/IkjIDuc3Wy0a3pB3CqYWcRbYTuDvjPZYKOCkLyA1R3LN3MkJmPJR9theEu0JhXMgCQIjmUBrb4qtUJo4Q+xlwfKW0L96p75Dv3Cxk1pfSfRJD1wbbhWh7oZuMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7YHPDUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF7C4CEF4;
	Tue,  9 Sep 2025 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757456416;
	bh=k543HBY3iPS5FEJ45yq8cqoQji/9GFCbQc+MS9+u1M8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B7YHPDUXh3EDGedKESwNylPzeSxBpTrOTW0d6hEhr7//kE4Cg6n+QbtirCHThhI+y
	 3J5fYLeWw8awLrTMtjPPWOGzEz4mEW5Clz17cCNGmCYv3/H3JcyBF52c35qE73P0nN
	 /k88qvBxcYbhbJvbC75zp7M5dO0LcVdna6oO+D20SuE5jxUqaQ/vjttHOMPy2NcC9h
	 ixmOQE1QKke48KCsFrkiheFg8YQa5CqYnxyO1eOO288rrHhFE1MSkSuxzayxp9IikT
	 ZYjF3KDLCeVskVDC/4YF7WbvVbluLePub78uHDLRqqnb88u269tlDmZL2q7r+HiYTQ
	 D4L9iY+sYrj7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34344383BF69;
	Tue,  9 Sep 2025 22:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] rqspinlock: Choose trylock fallback for NMI
 waiters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175745641999.833608.430490724192273857.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 22:20:19 +0000
References: <20250909184959.3509085-1-memxor@gmail.com>
In-Reply-To: <20250909184959.3509085-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, josef@toxicpanda.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Sep 2025 18:49:59 +0000 you wrote:
> Currently, out of all 3 types of waiters in the rqspinlock slow path
> (i.e., pending bit waiter, wait queue head waiter, and wait queue
> non-head waiter), only the pending bit waiter and wait queue head
> waiters apply deadlock checks and a timeout on their waiting loop. The
> assumption here was that the wait queue head's forward progress would be
> sufficient to identify cases where the lock owner or pending bit waiter
> is stuck, and non-head waiters relying on the head waiter would prove to
> be sufficient for their own forward progress.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] rqspinlock: Choose trylock fallback for NMI waiters
    https://git.kernel.org/bpf/bpf/c/0d80e7f951be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



