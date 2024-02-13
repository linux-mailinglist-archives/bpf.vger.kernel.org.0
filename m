Return-Path: <bpf+bounces-21882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E60853B54
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A5B1C26D4A
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663BA60879;
	Tue, 13 Feb 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TccsijmD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5F612CD
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853231; cv=none; b=T46NYC+YEqOh2fGL3o6r+kjfzLRg7XlUqZtFKWR84nDilXJ8+ouzJOgDMF4piraOgFDD1C/Q294HXtOIejXoIUroRj3frqbA65J865RzAht1/M/b2mAn0OaUjp1TNxdqFDmlkNXwaCdyfoOzg5FISj8HgsgxwCEDAyA7RqCZP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853231; c=relaxed/simple;
	bh=EZwTgR6qJ1UOFLh3irx964t06P8L50+x6Eu1HSoVY90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kydfyz9GpH/DgsauCpZDRXzwwu5XeMq8J2k93v7V1ZXJMg+Rp/grpxJeE1aBYOV1vXRWGqQ+zfrZvRtlHnaQaaGTwZUAzt2X2WMSWtA8+9jW22Yhtxs9XxXZzM4FyDGzVgoiFQQYp4r7D4uLZZ1lPAEYe0darcBadMAtmJKUAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TccsijmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FD76C433F1;
	Tue, 13 Feb 2024 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707853230;
	bh=EZwTgR6qJ1UOFLh3irx964t06P8L50+x6Eu1HSoVY90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TccsijmD63LXp0n6+H+mcqSXHRL3022cHhdLEBRL7qE3X5TTUqWRQW4xwQHHibwds
	 iY2Gs9LoZPqO/DYcG8w3FCzxPLMflMRdh1BlzLIHr7xqd2TnyzDx9X9Tyfmm5+TQJd
	 zxtQDg2kRYDANGaLJHuzxgI5lp02s215A/kYlIABpMguZ3TVdEHtBD12COiy2ybWFQ
	 fKWHqBP/ddH7nfgQcaM7WdI41fDESjJYpaMdmSVfy0Zsi0Kc+yzgY5gEJxx57DzfT+
	 Q5C3KexFxEwJylpL8AlpbjRWlB+tWny+G131GGNCOjFVYyKB4u4PPdAMnNd8mQl1Lp
	 RIwYCuubZJ7Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52F25D84BCD;
	Tue, 13 Feb 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: add support to GCC in CORE macro
 definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170785323033.16134.4475272319728217015.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 19:40:30 +0000
References: <20240213173543.1397708-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240213173543.1397708-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, yonghong.song@linux.dev,
 eddyz87@gmail.com, alexei.starovoitov@gmail.com, david.faust@oracle.com,
 jose.marchesi@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 13 Feb 2024 17:35:43 +0000 you wrote:
> Due to internal differences between LLVM and GCC the current
> implementation for the CO-RE macros does not fit GCC parser, as it will
> optimize those expressions even before those would be accessible by the
> BPF backend.
> 
> As examples, the following would be optimized out with the original
> definitions:
>   - As enums are converted to their integer representation during
>   parsing, the IR would not know how to distinguish an integer
>   constant from an actual enum value.
>   - Types need to be kept as temporary variables, as the existing type
>   casts of the 0 address (as expanded for LLVM), are optimized away by
>   the GCC C parser, never really reaching GCCs IR.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: add support to GCC in CORE macro definitions
    https://git.kernel.org/bpf/bpf-next/c/12bbcf8e840f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



