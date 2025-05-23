Return-Path: <bpf+bounces-58861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653A6AC2AE1
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D534A443A9
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE141F4CBB;
	Fri, 23 May 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3O3CF7D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9322338
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032196; cv=none; b=DRCAW4fwzHIkz/qeU+htu6OJ9T7I8n4a6Bb/owdpnqWl010B+Dr11VETd17Unn9lNkO5ijuRqk0CwvKPa0XznKHaxxvPaN47JvXdV+RaXVRDwqeQf//+DOJpwJ2xB1YR0EPZJxyr99kcvCXaVX0CcTQAGYL5GSlwfnfalwcAiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032196; c=relaxed/simple;
	bh=7yW1VYfS11ynnhUbW2Zdweg33NW9XDToWJI62AwFKr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cIsoL8XaffMBTEBKCapMsn0gTWEixKs1aXA6Qgt0Aktp4ZnfBe0Xj8zFYTQRn1o97ShX9JyAmOXFKnREcf+Ac65aiN1HcpG1HyMHzUJ4+zCrC2zuwsoNjop1ZScnGXFvbNjAueuafN3MepwnZjjq52+HuDUV1vEu1ibcVkpS/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3O3CF7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57C0C4CEE9;
	Fri, 23 May 2025 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748032195;
	bh=7yW1VYfS11ynnhUbW2Zdweg33NW9XDToWJI62AwFKr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3O3CF7DHv2abX2aPg4y9+hZfsggnBaavqUes2wSmfveWUdpNknGhsV1FOXDG1h8o
	 ctf5nW49BTAyP82ccO8n+rZXGsIwoTx5u5/t3HFxveQA7eEX27hcnz8BMsh5jeiUeQ
	 +wjlVoIYY62o/T+osDZzIKi/q+CbROrFVKvqruVNyXC/MsepOPg7nIEXFliT9sQ6if
	 rub2juusSLFlElcXP4yBlN2ZFPu2Nq6SweOD7tSal4ro90of57XJPL7ZDBJXHDVeEN
	 CgVkwcZkUB8FUPLJpeuoVn273mPJTIvoeyYEbk8A5Xz6f/+cu1gs0SiTEz5ZiUhz7J
	 sn7pReEoCGTQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF4380DBEB;
	Fri, 23 May 2025 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix error return value in
 bpf_copy_from_user_dynptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174803223099.3720362.14328269248541188946.git-patchwork-notify@kernel.org>
Date: Fri, 23 May 2025 20:30:30 +0000
References: <20250523181705.261585-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250523181705.261585-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 dan.carpenter@linaro.org, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 23 May 2025 19:17:05 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> On error, copy_from_user returns number of bytes not copied to
> destination, but current implementation of copy_user_data_sleepable does
> not handle that correctly and returns it as error value, which may
> confuse user, expecting meaningful negative error value.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix error return value in bpf_copy_from_user_dynptr
    https://git.kernel.org/bpf/bpf-next/c/079e5c56a5c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



