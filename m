Return-Path: <bpf+bounces-12162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1F7C8DD5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15F01C2121E
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB20241E6;
	Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbjCkkpR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41A21A0A
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8259C433C7;
	Fri, 13 Oct 2023 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697226022;
	bh=Pmx7s8xLqAeqGwL04/gRpWtEDCYH77oNsi99DPop4uM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EbjCkkpRem8RbHtAduUDc7n6sUuXhmdLSB+T0wNtXOyHjijVK+MwHh/Jt67Yuj7G/
	 ZbyWOcWhodFmjgKVzYu5CA6NLUMy6wiG9b8NBzM2q2HrLUkqMTqUZm3ujiX54ga3A1
	 cJwxgYNo9beMzkNIsvE3V1lsui60XrdCsScGiYENdzzBOviUeV1iSRtDp9BwsQEmNp
	 15hNvvqiP4q7EX2yLjVOIQyOsInqXAuiy/Cv/gK8spC0ZDHEsGsRhlU0w1hryd+LEo
	 4F66tIRYu3r0zDIZXUvoGH0QDGYzyQ0yiBEXCPznW8fIkTSO5UA3FPNEd2gI0CwJKP
	 SSunO76EYBiEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1C3BC691EF;
	Fri, 13 Oct 2023 19:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169722602265.5697.11601601955968053647.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 19:40:22 +0000
References: <20231012055741.3375999-1-song@kernel.org>
In-Reply-To: <20231012055741.3375999-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
 iii@linux.ibm.com, tj@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 11 Oct 2023 22:57:41 -0700 you wrote:
> htab_lock_bucket uses the following logic to avoid recursion:
> 
> 1. preempt_disable();
> 2. check percpu counter htab->map_locked[hash] for recursion;
>    2.1. if map_lock[hash] is already taken, return -BUSY;
> 3. raw_spin_lock_irqsave();
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
    https://git.kernel.org/bpf/bpf/c/a307f5a24924

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



