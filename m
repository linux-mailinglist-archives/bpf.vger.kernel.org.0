Return-Path: <bpf+bounces-68411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5EB583A3
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81821207973
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84522868B2;
	Mon, 15 Sep 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P13sdEdu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9022857F2
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957405; cv=none; b=or5iibRVWMHxmyKaX7v7CdCUJBflDjlCn1qW2oglYP5+dkz89HVeze9ZlZJOWHcQiWXOprXP1d1s57gJTCaj3BIK7bbtOnDHa9GlAM3o4VXdKdkUX8IIzt+lj9KfTVCV+jNNSHQ0FMSoa6eXHSDtMV/31+NszYbxBIAPk5e/zdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957405; c=relaxed/simple;
	bh=r8N6qb3Riwd8kOCQcfLa8+h/Anpbfh8ZVPLmgR1f5AY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WxBUHrWsiMo8rPWghSdkV9/iDdJuMO3XH8rkCnGm0n74ps2jXHDc3DTziTiHOkskW8IytaStu5FufP7ooVtLz3siema3rqER1VToEZY40ddv7KO0OyRCVcaX85TiH9ueAx7B+V/0Zu/6kcBleCGUUr4vJvnVYV7EwTIJDz/nPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P13sdEdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E81C4CEF1;
	Mon, 15 Sep 2025 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957405;
	bh=r8N6qb3Riwd8kOCQcfLa8+h/Anpbfh8ZVPLmgR1f5AY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P13sdEduhDulkNplCOlQWWRquAuEjVRRrHzwGMsx6qxlWFtPbKMgyxU2SobiTUDDX
	 MGwWUfr0R2uDAIWUVoJq9rhHBycLaljq09m4BBqQohASpJqsdwfFkOrln5+KvycGys
	 to/vzUGoZFQ1f/Hp+12DlGit/59jyPx7hlJzqp9p5NmuxvrnswH1piAI9mBhH/TDy2
	 ManVjy753DqqTeT2gpkS6O7Ne/J4AS+8v+voKIS2UdlRuuhjwuSncpf3EdVtBE+xtj
	 fZY7xU8tI/eInuyl4iKg2M/8pXO0MqmkXyKVyvuikDz3ND3XuXscGfbOlCxCvSKvZX
	 R7ge9hqvEBwag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3A39D0C18;
	Mon, 15 Sep 2025 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip timer_interrupt case when
 bpf_timer is not supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175795740651.70512.4932386668355350266.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 17:30:06 +0000
References: <20250915121657.28084-1-leon.hwang@linux.dev>
In-Reply-To: <20250915121657.28084-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, memxor@gmail.com,
 yepeilin@google.com, joshdon@google.com, brho@google.com,
 kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 15 Sep 2025 20:16:57 +0800 you wrote:
> Like commit fbdd61c94bcb ("selftests/bpf: Skip timer cases when bpf_timer is not supported"),
> 'timer_interrupt' test case should be skipped if verifier rejects
> bpf_timer with returning -EOPNOTSUPP.
> 
> cd tools/testing/selftests/bpf
> ./test_progs -t timer
> 461     timer_interrupt:SKIP
> Summary: 6/0 PASSED, 7 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Skip timer_interrupt case when bpf_timer is not supported
    https://git.kernel.org/bpf/bpf-next/c/f7528e441213

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



