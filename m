Return-Path: <bpf+bounces-46418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B39E9DBD
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7328165CCD
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3677176ABA;
	Mon,  9 Dec 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEMw2dW9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69702148855
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767218; cv=none; b=Y58AHttUoiXWuFuOYIAZJ7T02TCTQEUkRLTSNDaavB2rNCaqA7lWFL3OkcU83zTPd453FN+Q3C2SIvCTEETBHWZ3HEotllPH0Q/0i+9InIkVcFemsKxnGXRh9n/LyD6ScT/8VxbE824gg/ug5QyVaLU0/rwbLDDprP/gCNyDNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767218; c=relaxed/simple;
	bh=fjMLUoIgnKaBouZ3vH5rtYQUCQbxbfA470TfTOI8Q1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lQ30OxgprAJS4CoyKPVnhtqSC4+YsK0QbnSj4hE8c9OvcxqX9Hc2ixicgyJsi2nvb/cUKqPheF5VYNqiz8fb6PcPwYhwSgUESSu7KDhi1U8ps1hP43UThqOZS4bw5m8t8161kwX1qZKlhTsUZZbqA9EzaZdEuUzC2t0d8JX5aEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEMw2dW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0BC4CEDF;
	Mon,  9 Dec 2024 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733767217;
	bh=fjMLUoIgnKaBouZ3vH5rtYQUCQbxbfA470TfTOI8Q1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pEMw2dW9b9Qf5qI3JaJMDpIRHvZWoU+j6vDmlZjrX3bzPz3AkxqBDokHIPA4H5aBy
	 WFp9lSNriUJfdN07tSBDuKtanPDgATU1yfxX0U0aYdwI4wYRXN8A0kOhD9gOZL89mE
	 ttGGvKPDt7p0hh7Gz/iQQLIkgJj78hXp63Y66jyk4e71bSkVsAp9e4qBlfjnDLx0Xs
	 bK/MTfopMVGhGPEpVx6iG4fecBVrc0lHNMrOi0hlVkahKcyEp+bB0tTrjulV8NrOtH
	 OjZvv4wqeQocp2WcTBNnBIbmuYe/AEeOxnlypFan1IIBA2jGNIRRXY2tZ13ZvKKqf5
	 dZtE83WRZckOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1AB380A95E;
	Mon,  9 Dec 2024 18:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add more stats into veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173376723353.139140.6342619009359223996.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 18:00:33 +0000
References: <20241209130455.94592-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241209130455.94592-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Dec 2024 13:04:55 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Extend veristat to collect and print more stats, namely:
>   - program size in instructions
>   - jited program size in bytes
>   - program type
>   - attach type
>   - stack depth
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: add more stats into veristat
    https://git.kernel.org/bpf/bpf-next/c/82c1f13de315

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



