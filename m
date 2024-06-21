Return-Path: <bpf+bounces-32770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73796912F3F
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA771F223CD
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47A17BB1C;
	Fri, 21 Jun 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEmD0D4P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609F16DED5
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004231; cv=none; b=YEPI8Pm/+9J7q41O7dkcHPUDWgwMqBz5t+TgBxndWyoe/00QHdhxt4grpQrA407fC/S2PXP7I+kiNiNnBl6rOObfgHKo0lBNpgfiRvQcWBujXGq76hNeGoKHb1XSm8wKY4iCjFV70q/dcdJSQn0kS/abLj32Khr3gUkEb5yrCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004231; c=relaxed/simple;
	bh=we18sTbHxd8cEXNHiAcSe3PYix3881oHR6sXFNrCrpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S/0kJuq0W/4NlqcN4Jr3pwobnoE4Z0TTwGsCPbT7N6/LF+Y9htnUHvOefES+ZwBKIWn0Mwgrtbano7twdqgXtBJ5QbhQgBPGQuK4YFFG2aPF1gOV18cgItK77AJ2JIf3lNHR1RixHmUKxJcLvaQ99tYN8f0fxdS4XxkZteeVv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEmD0D4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72F7EC32789;
	Fri, 21 Jun 2024 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004230;
	bh=we18sTbHxd8cEXNHiAcSe3PYix3881oHR6sXFNrCrpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IEmD0D4P7URJG2zH5GwZQAzeajl1diG19hiNRUqHLpTgpsySx+YctNXQvVAclHhdJ
	 xsjLPrrzPpyGtCosjyuvzzBEyBIBrNoB8CF69T1t1uKu0Az/Fkgdy50ZVhdCIjm8PE
	 BAB+5WbounvRiYxkWjlJQJVV42x/D/41M2Y0KL7VBsD5Qw5SlpqDsF9JhTxeyYlfUZ
	 eBe9qSvh4PKqa+ucRLMEvjXISUQJbzNm3eQRKyArvNImdWoio//6FV/NC2vz5hxHUu
	 e2cExKRAuhxjec8pyIPe+Lps7HUA4HI/R0Zutw5devb2FbWrZ5a9Hyr3dutZ0pR0DV
	 b9Tta4fPLchbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65ADFCF3B95;
	Fri, 21 Jun 2024 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] Regular expression support for test output
 matching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171900423041.5714.3799709246447891404.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 21:10:30 +0000
References: <20240617141458.471620-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240617141458.471620-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 17 Jun 2024 15:14:56 +0100 you wrote:
> Hi everyone,
> 
> This version removes regexp from inline assembly examples that did not
> require the regular expressions to match.
> 
> Thanks,
> Cupertino
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] selftests/bpf: Support checks against a regular expression
    https://git.kernel.org/bpf/bpf-next/c/f06ae6194f27
  - [bpf-next,v5,2/2] selftests/bpf: Match tests against regular expression
    https://git.kernel.org/bpf/bpf-next/c/3e23c99764d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



