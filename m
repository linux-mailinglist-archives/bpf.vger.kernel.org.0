Return-Path: <bpf+bounces-60936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD6ADEEA9
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26423AAA40
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FDB2EA74F;
	Wed, 18 Jun 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcyeCCSo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A72EA746
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255201; cv=none; b=ns7Ud3rzaIGozw1nsl3FiVg2shlv6Cflg6yEYt729eFYuuaJiq+QmVXaZstwP+GhS4QIYUkBjURK4qFKbdcnImS+wBAsvn6jJ8RYusAMwWeoyHDl6nEm4zBguFOpVug1cKVsE90W/DsGRtv2NBwi6eiM85pHOhfZ7zpoTPEcIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255201; c=relaxed/simple;
	bh=N8Tku9R3S8viKPNSoiQoK5FlLcjLLKvCeceXmdOqWEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AXr+afdz3CxMoFdZ7QQfnWLPPqxYQtVpkCdh1/y28AfC1JFpk3kfQdKhCsE1vgvJUlOOTWRWD5hIKje8Vho5eWk3eFQkEo6DpgIBxdiqkBaNADaA1RcKyGDPBIX7W7TfC2r7pOk5tDFjm9zy9fZxu0yLRLgA902L1JyB/n21p0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcyeCCSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B21C4CEE7;
	Wed, 18 Jun 2025 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750255200;
	bh=N8Tku9R3S8viKPNSoiQoK5FlLcjLLKvCeceXmdOqWEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YcyeCCSo5QIKy4qgKzBWoXc3gcvdwYQHXr7JREzAw5n4KI84y9pcka2+IZ3nath8+
	 7o1BKLmwute/bCf3ZOzNh5kzmnFPLDTlrHHWL/0T+87gfsFcueKClqIYmykXFZP3WW
	 4h2jDbmHeT5cVH2fSh+ihIh+UrUxTBIJ93jYr3BiGCEfSaFkCp59k5QPN7yjSFVhec
	 miH2jC5yQoiBwHkvm4MRAZr/tAaMCkPSsuJeTOH790HojPazeGE48DmO4q3QSNjUWG
	 pgAD5xPgZA/5JpyFTJRy1SGFt1ZsLvZcTBATNYDUWNxk4CF9aP3XU7bVloyRIaavls
	 w6Zoa2BZE9EnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6A3806649;
	Wed, 18 Jun 2025 14:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: include limits.h needed for
 PATH_MAX directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175025522925.120902.1276202444786474477.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 14:00:29 +0000
References: <20250618093134.3078870-1-eddyz87@gmail.com>
In-Reply-To: <20250618093134.3078870-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Jun 2025 02:31:34 -0700 you wrote:
> Constant PATH_MAX is used in function unpriv_helpers.c:open_config().
> This constant is provided by include file <limits.h>.
> The dependency was added by commit [1], which does not include
> <limits.h> directly, relying instead on <limits.h> being included from
> zlib.h -> zconf.h.
> As it turns out, this is not the case for all systems, e.g. on
> Fedora 41 zlib 1.3.1 is used, and there <limits.h> is not included
> from zconf.h. Hence, there is a compilation error on Fedora 41.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: include limits.h needed for PATH_MAX directly
    https://git.kernel.org/bpf/bpf-next/c/cd7312a78f36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



