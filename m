Return-Path: <bpf+bounces-60853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B742ADDD37
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593C2189FEB6
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274016B3B7;
	Tue, 17 Jun 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhdkrK8Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0025B1C7;
	Tue, 17 Jun 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192204; cv=none; b=C5X56pr5FHe/vTrfM6xnFH1weTxTQOcfCDqgFSK4PiVqr3mLjDdAxCB06WVqS3PKDxYcM/7TL4O3BK90UgSwT2a+4O8afd7fXgCEzJzCTuzDfyC/XItoYg+Ox/E+mlfb8W5uRUTK9G7+StpVVc2TdqcSMbwJFNE0NZjUWWVjZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192204; c=relaxed/simple;
	bh=NFHWgcGBqSZfZnd+agL0tqMcJ1hgcAz1kvoYgJ9n3ZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YscWN/PbwMBadnetReX7E7KOCejhuoWa5kV2M6KExCeZM6FYsOobblOp3ZtldiRmrwBVuGWvKjSGoV1ibrcRdhjdOGsAsSOOy8gqBv4PcAjqbeU9AFOOhIaxDQlJTTzlaEsv/8vRFxFT22kqsS1V6G59VorU35PWeiIDsRlnamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhdkrK8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BECC4CEE3;
	Tue, 17 Jun 2025 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750192204;
	bh=NFHWgcGBqSZfZnd+agL0tqMcJ1hgcAz1kvoYgJ9n3ZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VhdkrK8QC0E3p1Y0Fhdbi/vSKMhlmt+bx2e7aA1FfOXHVf7+ojD41yCJAcl8EnZVt
	 L9bfrhGDOh1XWe0fmAj6RLkRR8y/j5znR8nLKaGH/N4gIol4eR6+QxSM64/Iaw9Qvs
	 xwf7lWqdZloM8GcGpUUpsABcDKlG7u1aPztz9OzYzEPdcSndvOkDlw/+iuU2rC784V
	 q2LAmosmXeO555u6doUhE3hHZSX9KWFNcrxRlQF/I2bYJOoo+QDRhr3gVyh9bjb3HJ
	 OV7Y59xV4xwcAzs6Rxg/FeiBek/3Ev7hyQEgHT3EeUtImiJK0wV7IXRJO7dnzSutSQ
	 +UAF45QCzQBTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD0938111DD;
	Tue, 17 Jun 2025 20:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: Fix JSON writer resource leak in version
 command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175019223226.3686091.5699904208996634037.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 20:30:32 +0000
References: <20250617132442.9998-1-chenyuan_fl@163.com>
In-Reply-To: <20250617132442.9998-1-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: qmo@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com, chenyuan@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 17 Jun 2025 09:24:42 -0400 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When using `bpftool --version -j/-p`, the JSON writer object
> created in do_version() was not properly destroyed after use.
> This caused a memory leak each time the version command was
> executed with JSON output.
> 
> [...]

Here is the summary with links:
  - [v2] bpftool: Fix JSON writer resource leak in version command
    https://git.kernel.org/bpf/bpf-next/c/85cd83fed826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



