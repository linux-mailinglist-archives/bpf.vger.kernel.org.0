Return-Path: <bpf+bounces-29615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4D8C399A
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D824F1F2144E
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0C79D1;
	Mon, 13 May 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmmGBva4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AF6AB9
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560227; cv=none; b=AeNP1bWKsSJEJl70ImJErUToXKM+WF+M15S6XocQ7znrXBmSZK6671hWcULYi6xIcv2bE9QK2AY90406mYflvO3+lttYxP6v/2nBKvUeX7Uznkj0F8KKq6Z8j/tM9r5Zh7rg8gGBUlD6TGr8RbkjM5VnTMzTEyb+DiLT9jF73s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560227; c=relaxed/simple;
	bh=GLP70xJSPbvTdLN7ZvInlg7rHu7gjdx9pFxFqr2YOhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ICAb6fzHKHr+AAE+wRoYpBysFcheAHZO1xQi8NedrOK2aIUuc2TwluvyAl9f3WB0gIkkInjD1wXRgpATEBtADfwsCtNap8IpHuTJXc/QtYXIgxqHo8emSTawnbAvp1FRicn+UqkmpvmkX+2xAGKqPL8mzOrzvdczScYI9GTzUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmmGBva4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 263B7C32783;
	Mon, 13 May 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715560227;
	bh=GLP70xJSPbvTdLN7ZvInlg7rHu7gjdx9pFxFqr2YOhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dmmGBva4yVqoKBdSmGpDf9fdJBnFDSvG/fUaknsZxWiIKiuPt15v1b4AkDSpuaFJZ
	 +Lxp1uehyxe810E+OdSyib3EXqjDqxEOyoDIEZed80Kqh+D1/hOxuz3vL6yjYg+4pT
	 FrYoDE1epvGuHK7OBN9B7fJY1xnscYawRPJCS0b4YYWpqDYAmIFZNOAPUJ8gOM7njG
	 nsh7BSilRZ3y0uxE+2LLOtx8ZvsxZv0FSn44H7XZLuX25UvuPEQ9wY/uywLpgZefpP
	 +ztSgFTpoiSLgq0zIbdTFxdThGunmY1TP4dcNliiT0KtAaiAZbGw6MJEVd/VWSHblN
	 K80hG9ZZnJW7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15B5FC43336;
	Mon, 13 May 2024 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next n2 0/1] selftests/bpf: Fix a few tests for GCC
 related
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171556022708.884.16690967686964316921.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:30:27 +0000
References: <20240510183850.286661-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240510183850.286661-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
 yonghong.song@linux.dev, eddyz87@gmail.com, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 May 2024 19:38:49 +0100 you wrote:
> Hi everyone,
> 
> This is version 2 for the proposed patch.
> In initial version I rather disabled the warnings from showing for the
> particular tests, as I was afraid I would change the test purpose by
> changing the code.
> This time I corrected the warnings in GCC by adapting the code.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/1] selftests/bpf: Fix a few tests for GCC related warnings.
    https://git.kernel.org/bpf/bpf-next/c/5ddafcc377f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



