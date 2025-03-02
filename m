Return-Path: <bpf+bounces-53001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E8A4B53C
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 23:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E3B16C78E
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7B1EEA2D;
	Sun,  2 Mar 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0g+AZCj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868A1EB9EB
	for <bpf@vger.kernel.org>; Sun,  2 Mar 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740953999; cv=none; b=sGkJfXLLn8HnbsS1mSeRgoBIilxQ0mjhV/+UjFuG0M3hgHVooaAclVHXdpQpzVlpjQdmpv5mnleRIaTL+a/64OSpMIIemtxz019XQypBjD84AZ1hzUO42pqYWuILzjyKp+FSq90AGqsTICCH6GxIJPTCQALK9bAgDF93ul8jPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740953999; c=relaxed/simple;
	bh=Yw6TGMjDpCP9l6YzWe+1Df2aPOnoE+LTZ6K2raCkQzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tDqJx46gTOksDWV5AU1Fu3At3rxlzuRFRHo3ze7s9qFQ2tNpqcBWjUgRtBY2m+TdmbPsO5kydvsCMHXiJ+387x3P5DduLC6z8dhSLKelA2QIWf3sfgi8jH7moj+XgAQLZ/Y+75jc1pmXHkBMjKCRsiIoX8nE7uTE7cH7rgezIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0g+AZCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76D5C4CED6;
	Sun,  2 Mar 2025 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740953998;
	bh=Yw6TGMjDpCP9l6YzWe+1Df2aPOnoE+LTZ6K2raCkQzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0g+AZCj/rQB7scWk2M4fgONlj4SBP7al/3Vah2D4iUs7VNDkU89ASxyzUcGFXmJc
	 7s6Nnf5XW2BUSju1umGswV6hugociZXHOCLO2boreoF80w23ZKRHcs7gm1yCM+ctc+
	 0d8kP2cbBPD0KvbnjO+3EyO0/KKnpszBIUvMl/4w26jL/n8fE46+XZVgB3zDGrd6aE
	 JUrUn0TPvCx0qWgPM74KpA1Tks/DhBwXHl1SlrTMrCTHzcDMwc74redC0Nu4EwR/la
	 ut45Qb63gY9I20zDq5ZlF/Cwj67MjK8+Rl6lR2PCGya2UGZe36P/EfRpdFyfBCzeJQ
	 gOxiUHk0ZmaSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7124A380CFE8;
	Sun,  2 Mar 2025 22:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Global subprogs in RCU/{preempt,irq}-disabled
 sections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174095403125.3036971.12648827982999331905.git-patchwork-notify@kernel.org>
Date: Sun, 02 Mar 2025 22:20:31 +0000
References: <20250301151846.1552362-1-memxor@gmail.com>
In-Reply-To: <20250301151846.1552362-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  1 Mar 2025 07:18:43 -0800 you wrote:
> Small change to allow non-sleepable global subprogs in
> RCU, preempt-disabled, and irq-disabled sections. For
> now, we don't lift the limitation for locks as it requires
> more analysis, and will do this one resilient spin locks
> land.
> 
> This surfaced a bug where sleepable global subprogs were
> allowed in RCU read sections, that has been fixed. Tests
> have been added to cover various cases.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Summarize sleepable global subprogs
    https://git.kernel.org/bpf/bpf-next/c/90d8c8980b5c
  - [bpf-next,v3,2/3] selftests/bpf: Test sleepable global subprogs in atomic contexts
    https://git.kernel.org/bpf/bpf-next/c/6e2cc6067e73
  - [bpf-next,v3,3/3] selftests/bpf: Add tests for extending sleepable global subprogs
    https://git.kernel.org/bpf/bpf-next/c/ce9add7b9028

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



