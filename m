Return-Path: <bpf+bounces-27932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D28B3B40
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E37C28A510
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A814D2B1;
	Fri, 26 Apr 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQPHuT4q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686614BFA2
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144827; cv=none; b=TZ65YHgk2TLaUKdkrtDk1GrTyHDaLUhfROT0U3MUkqTotAnFgdccCslPa8RRN9cZXaDdhnhVcxGCiY9CWpeoKo65Oj5E5txYg8IXi+311e3V37ZgrBs/Nk2HnNb9Bpup6nnwhqcryM297PaN8WnlVa8X8E05DqMjvXFSaG5mtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144827; c=relaxed/simple;
	bh=oSm1tqs+NtHiEHlKeDIBZLDZeBfIvvywgQyBbYSUMa8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qdH8odzEXlynk6L/A9oNiGYdZTxBj5jPiFZ7s40O7xfOM9wfOsKyOVA01uAys3rrGbkQU6kSAFhuGVWcfXclMv9A8mDxRvpgT9u1VebrC/XlvXBrA16/Ddm+4JdotmxWgD84iJ+66dHnkJkjgFmFkXVZYsPxEuj2ey58tyaQIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQPHuT4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E897C116B1;
	Fri, 26 Apr 2024 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144827;
	bh=oSm1tqs+NtHiEHlKeDIBZLDZeBfIvvywgQyBbYSUMa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQPHuT4q4Iufcz6+SI4TTrEfOgyqsWBGunvJ4dA6pLvuoGY4TZxDtkYA+JQHJjl1T
	 d2e1zXxsb7Y3XwS3xJe6gOZLFdq+rczcFOKrolKD0xiOppFAwy/WzGHySpNQj+xl5w
	 8GUq+1DjrBz50MSXDnZNRmCVUCbb4aJwvxDcPvGUOJ5enZR1ujS7zpQeXGXY9m2dm2
	 HA7FLb8G7vPGJ+oe8QcfAxYEL9yCXkDP98J2xGT+/VWy/dktIk/R+J4P9EdKy6iSmA
	 EfdfoW1HWK0zoiUGdenHBruG7UJ+uhBExQB2BYwc+b58gzzqm17G2NaZSH7m1mwpTR
	 E2StNKuBuPFFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B58ADF3C9B;
	Fri, 26 Apr 2024 15:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf_helpers.h: define bpf_tail_call_static when
 building with GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171414482723.31416.4816635428805026983.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 15:20:27 +0000
References: <20240426145158.14409-1-jose.marchesi@oracle.com>
In-Reply-To: <20240426145158.14409-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, yhs@meta.com,
 eddyz87@gmail.com, david.faust@oracle.com, cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 26 Apr 2024 16:51:58 +0200 you wrote:
> [Changes from V1;
> - Add minimum GCC version that supports bpf_tail_call_static.]
> 
> The definition of bpf_tail_call_static in tools/lib/bpf/bpf_helpers.h
> is guarded by a preprocessor check to assure that clang is recent
> enough to support it.  This patch updates the guard so the function is
> compiled when using GCC 13 or later as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf_helpers.h: define bpf_tail_call_static when building with GCC
    https://git.kernel.org/bpf/bpf-next/c/6e25bcf06af0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



