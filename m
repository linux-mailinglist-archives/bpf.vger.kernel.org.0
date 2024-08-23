Return-Path: <bpf+bounces-37957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2595D02A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04B8281D41
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358B185B4E;
	Fri, 23 Aug 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBi4IgYo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC43BBC0
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424032; cv=none; b=PJxfbAfN0N7wOq3unYRLK2B4YrpcXPJq/Pfb5eNxLmQWQMrLc7LiTWkSehXQJ1ps5R2URcA87DJPmjwfLQGMCddybr3WrYrWBTSqevJ+HJ06LcloQHo11qcJHoe5csqjmVDeJUdYht9lM+TImllwqdz0PKyLjPZs16yqEfa/7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424032; c=relaxed/simple;
	bh=zmN7S2tYyCcddxFp1Ctw/I6+SH7LxkjikjENiGQrDQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YCnlWZHpWyar7H9N7ajBJsIyZJ3Kaha/OVb00E9MIcFQtUCkpikGw88iFWbK1u0HD90qRwSKZBtb+oMi9VHOa15cpJuEJd/B8NpGu12Fz7aAvtlFpcF740Un0XsL89a3/rw98k1giB94UpY6BKcEceZv97Pl+pozHIKJ1Qhl69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBi4IgYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C52C32786;
	Fri, 23 Aug 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724424032;
	bh=zmN7S2tYyCcddxFp1Ctw/I6+SH7LxkjikjENiGQrDQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBi4IgYo5D+ttUTb2HAuE2zpC0o4VlGsq03eUdeiDCexqB4mioDpF8SGm7jb0tuqa
	 MbuvQ8p+QomrcDwSV9hPSAOseiGSNnyEdOIxyHXtg6DXAa4p4NIp4f5l5FTeCordE8
	 Xczldle9rPHnaSIW4bSfqvZnjXAYq8qfhIr2Q2zICNsdzhCdGpLoV8sjYmq3qtZfKD
	 FNQLMHZS6Z0poU59Q/yFBcJyhXht+egquQzsrUk/vw+VfQWsphIv/AQjyUUAvuuZLU
	 kE8psMvKtjMAeZVjEqAo+JFg8oNS6uenxF3h45GyxuKj7lCoaG5hmJTIRYzFaSZUZ1
	 OwMu8jiJrzn0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF043804CB0;
	Fri, 23 Aug 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] follow up for __jited test tag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172442403179.2986444.18288741918420530012.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 14:40:31 +0000
References: <20240823080644.263943-1-eddyz87@gmail.com>
In-Reply-To: <20240823080644.263943-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Aug 2024 01:06:41 -0700 you wrote:
> This patch-set is a collection of follow-ups for
> "__jited test tag to check disassembly after jit" series (see [1]).
> 
> First patch is most important:
> as it turns out, I broke all test_loader based tests for s390 CI.
> E.g. see log [2] for s390 execution of test_progs,
> note all 'verivier_*' tests being skipped.
> This happens because of incorrect handling of corner case when
> get_current_arch() does not know which architecture to return.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: test_loader.c:get_current_arch() should not return 0
    https://git.kernel.org/bpf/bpf-next/c/ec1f77f6557b
  - [bpf-next,2/3] selftests/bpf: match both retq/rethunk in verifier_tailcall_jit
    https://git.kernel.org/bpf/bpf-next/c/c52a1e6eb74f
  - [bpf-next,3/3] selftests/bpf: #define LOCAL_LABEL_LEN for jit_disasm_helpers.c
    https://git.kernel.org/bpf/bpf-next/c/21a56fc503fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



