Return-Path: <bpf+bounces-38739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83027968EF3
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B161C223E7
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F541A3A89;
	Mon,  2 Sep 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuFZaB7X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD91A4E9E
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310229; cv=none; b=TnLr4OkOoM3uSBRL/t5H4wiOg6QEEDqRM3we/dGrRiTjn8iq34U9V1IRrSimK4DbRTQr/PKQk2F360Ip6PQnG0WokAM62PE2EHguxF/Tks1wJ2mNxtjew8FAKGpRJ3howlYdAx3t75lO62Mra/2vcnQz4PJJUkFvipPo8K+4aMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310229; c=relaxed/simple;
	bh=FVxzUrsphseir3RbofbtThyqgR7tGgRmV3GPn1c/gdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgRetGqfTdVY780kQVC9HGRqvdjJRG9nnCO5ugreu5p1Q04RpbUfyooB/IWkniDzOQOpYxE362ENJBs8aFG/nYnOieIFk1CZspd3qBkGW8NNxBfBlg6RDY5V1wTezq2BpVZVTcTcLMamCnAUyoP028UJCmuWHXHWD0nNhz7U4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuFZaB7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B77C4CEC2;
	Mon,  2 Sep 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310228;
	bh=FVxzUrsphseir3RbofbtThyqgR7tGgRmV3GPn1c/gdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CuFZaB7X4+o62CprJqdRTVsUZG0j5mn1H1RFdnYWQlAcpZMNWLC/o91bD2ewPZMgt
	 fiNmtotu75ACrMdNoCUkphQoBnRU9/BsGawyaWqKmdPXmJwFZxk86SMyrgTN9ib7T3
	 vUtnozkst8NiOJWmxFIASPms3D6Nq4BIs2+X4dQK/SHbBKPUIXRWD6X4hTgKsZAKK3
	 KpX6WOO6Dnj5DYZKbmzmJb2n6QwS2UX9zOV5qmgUaS+I1JGbI33rt1UZV/NFqo2Xew
	 h8Tse19OG6fCQziSrYd2eHs1pLmW6akrCG0YMQkHWI5KMmslc7W725bLP+D1p4cDCN
	 Nu3pXeXc34xOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB33805D82;
	Mon,  2 Sep 2024 20:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172531022952.3985147.10601442279616841934.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 20:50:29 +0000
References: <20240902171721.105253-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20240902171721.105253-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  2 Sep 2024 18:17:21 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Wrong function is used to access the first enum64 element.
> Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Fix handling enum64 in btf dump sorting
    https://git.kernel.org/bpf/bpf-next/c/b0222d1d9e6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



