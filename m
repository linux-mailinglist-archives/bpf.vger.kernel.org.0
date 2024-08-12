Return-Path: <bpf+bounces-36947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8088C94F8B0
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D58282D8F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CE1946C1;
	Mon, 12 Aug 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4ahNnRk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF612139597
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496430; cv=none; b=bCYymb5uUt5sezDfbOPqvr3x7hZSizukb4OqjlRqHxPawp3Vd7jWh8KcmvPvRoWl93MN2eERhrhuyJ/CJ1bFBnAWgf3GmV+YdvfrxRGKRtMWs8z1LOif3HVMCPh66EOHX+fFHmJZHaODmdUvHYOz/rlfkYWfh1j/NACjfr36Vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496430; c=relaxed/simple;
	bh=kSHmVuuC59n3KOL5VUVIL/T/1IWMaE6Y1es4yUn/yI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U3hnkrW6UOOcBYkg420buuUa8HXNPV+bt7Chn3W9anZlIa4Hyxstw2JzKe9x6YHSZOlwaPXwF/tXJ1UdAEdBcRUpWRKrUw+ZXJLw2bH4FKtNwg9gxDFqwLt6kB/BzsJX5wTQFdOcVjnKblgogj6cN+4hsPzprzPXKlfX7MO9smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4ahNnRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B2DC32782;
	Mon, 12 Aug 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723496430;
	bh=kSHmVuuC59n3KOL5VUVIL/T/1IWMaE6Y1es4yUn/yI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i4ahNnRkZ4+b5L7H55fX2jNQFaHSkpScrddc0Z8VRo662izSrTrfr7JkxockmquT6
	 vpnRqB+4V56GmOhl+TiaSJD0rkDNkao+gbUD7i11Q/9yEzCVUEK0g5Zn8CRh34n0fu
	 OOQsN0fjgLLf/emqIXMLGCL4XQJG7viHYehf3MERjsdiLhyXbA738DSdcVBjLwuALq
	 2bn0Mi8uMJ8JNqCayAi4ydQktng6Ko6m+VlyiREqy+wnQzhNm0GHBLQcFjwHy+Lmfl
	 pbj2PFQXV828PXvAsXsRY0dH9/9h399JZVZ9ayOkU+Hdw0+9BC35kD253sOS1ZEXJ1
	 hRLfBn1E6/odw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FED382332D;
	Mon, 12 Aug 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix license for btf_relocate.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172349642926.1138062.4216241705533103326.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 21:00:29 +0000
References: <20240810093504.2111134-1-alan.maguire@oracle.com>
In-Reply-To: <20240810093504.2111134-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 nkapron@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 10 Aug 2024 10:35:04 +0100 you wrote:
> License should be
> 
> // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> 
> ...as with other libbpf files.
> 
> Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
> Reported-by: Neill Kapron <nkapron@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix license for btf_relocate.c
    https://git.kernel.org/bpf/bpf-next/c/4a4c013d3385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



