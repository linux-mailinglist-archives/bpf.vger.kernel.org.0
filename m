Return-Path: <bpf+bounces-72959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC5C1E029
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE3D74E4E73
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD1264A92;
	Thu, 30 Oct 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUR1AyIh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CD23A9B0
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787234; cv=none; b=WMcF/ctKz59wsc5yeni/DeGvhVEVbKC9X6uumLNk8b4qD9WtLAtnM+Rc4QTUOeBxZd6wCoppgitaHDrrp82q6erNWeTf4QEn4Yi8t3z4xXB75D9Qlk8E3v6kESmPytPagWz9saxZb1oxgQbU/UMTLyc+DCGcHPQWXX+Kjol/bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787234; c=relaxed/simple;
	bh=nQkuyAgUZ0/9giqmBpju5su58fpW4NWej71wxMgfv6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HGoGqHupgy37htCDBAHALDPGR654CUSAIz0I9nbPu1tR4dNDhvJJUJ8GICORGOFs+8Voc07lZUCP2bG8M41YcDJBw23FtfPoBxMKw9HllFfYQpCG3Ai6kkh99DbBQc9oEcc09nsnqM5Zz3h//r5EVwt2YJu/jnovHcLakUq69EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUR1AyIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456EAC4CEF7;
	Thu, 30 Oct 2025 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761787234;
	bh=nQkuyAgUZ0/9giqmBpju5su58fpW4NWej71wxMgfv6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sUR1AyIhN7+kcUadpox5ccmQ0OktdZGGq7nEmixh1ouDvAv6hQFvAwnau7NfF7Hkt
	 0TvYXf8y01wEJWp9ap65TbIoA1gzwIiMod8Bl6WXbrAZWZX42QSmT8FF1ijG5USgrh
	 XqOI1gc3IU9foy+A4aqclDiyaX/SAfeuuf6g9cVNTWTAwhpUXKJABFGcemgtf08m3F
	 2DLjeDX4qv0Rus3psSSH126NmivAEyo4/xQZ6XC4J492lNo251dSA6msV9aOftBwSX
	 Ty6RCvyUNzZdT072nozCB5EosmOkYl5q2mc4aqrDRB3RGbO1rfucIGx80818J+vDk6
	 A6WHbes+2gKYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC23A55EC7;
	Thu, 30 Oct 2025 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: fix file_reader test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178721116.3274494.395914655154993574.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:20:11 +0000
References: <20251029195907.858217-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251029195907.858217-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 29 Oct 2025 19:59:07 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> file_reader/on_open_expect_fault intermittently fails when test_progs
> runs tests in parallel, because it expects a page fault on first read.
> Another file_reader test running concurrently may have already pulled
> the same pages into the page cache, eliminating the fault and causing a
> spurious failure.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: fix file_reader test
    https://git.kernel.org/bpf/bpf-next/c/5913e936f6d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



