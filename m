Return-Path: <bpf+bounces-46186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C499E614E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E73283129
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1801D5165;
	Thu,  5 Dec 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXX5nAzW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B41B3946;
	Thu,  5 Dec 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441417; cv=none; b=cpTpWC+yeV980IQJDSNLfAq590qdgLb6cgptN3iVyTmRYZynl5wH+MQayVxy1WAw1M0aRB+NRERYqBauZmqDySRfcFgL1CjZjmRf6yMEaeUg825LA6jB9hLkAGZCkPbQ0moHeWsm46k/q9pe8EPsHQMeHjjR7NnKXURTJ3rxNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441417; c=relaxed/simple;
	bh=v0aCjExrEYT9A2vnbljBYSVw5ijp9uV6nA24U24Bq/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qzdtpSMHH8Wa3ALfxbb6yUWlm4YTLYPyGbXwNI90hYvq/yhSMNarGFAuj7nfbjVo7FMROIhAxsDbZqqkA7aUgRZ+AAMrno2dulsU46F5GYiz9qwkuyNGGbLfXZDebKBCOMXePGy3jH81WTfCagHoqvWsOYIMLlfCf5Roeall6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXX5nAzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79747C4CED1;
	Thu,  5 Dec 2024 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733441416;
	bh=v0aCjExrEYT9A2vnbljBYSVw5ijp9uV6nA24U24Bq/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aXX5nAzWGNl4qAd/OH4fUThkiY6Ey10zWUjwcj3Lrw8NDx6lXZo9iYRkjamxz8RXw
	 InmuMD3bEtcWnH6ojePAAA2PmhxkIIrjtfRntvs7IypNx7q97UheG/sY4DE682U9Y4
	 sjpM1N0zd4ELPZPoPo8N5r6t9XDMBOuql+nz/3fr1CRkO11fezOr748cD9FftnEL2U
	 wiujtwi0KiAvhvKbBXYo2ZVsw7BH0QaJ/crJgA66gSlTocj9xiChijGqBDUX2HRVbn
	 jRfUNCYH4N/sMkbpNAfdVS1qNttiLb3V8bvJKy5HinNU2TIO7oGGq8LqU6ZbS0m7VM
	 hyy64TUhI2csQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714F4380A952;
	Thu,  5 Dec 2024 23:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] kbuild: propagate CONFIG_WERROR to
 resolve_btfids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173344143126.2102866.16200180283142893645.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 23:30:31 +0000
References: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
In-Reply-To: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 04 Dec 2024 20:37:43 +0100 you wrote:
> Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
> Allow the CI bots to prevent the introduction of new warnings.
> 
> This series currently depends on
> "[PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs" [0]
> 
> [0] https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] tools/resolve_btfids: Add --fatal_warnings option
    https://git.kernel.org/bpf/bpf-next/c/2fd821354772
  - [bpf-next,v3,2/2] kbuild: propagate CONFIG_WERROR to resolve_btfids
    https://git.kernel.org/bpf/bpf-next/c/0a7a188468c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



