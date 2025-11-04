Return-Path: <bpf+bounces-73512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F0C333CE
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577B31888287
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C322C21CD;
	Tue,  4 Nov 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/oUzSE1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB42253FF
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295435; cv=none; b=i8ri+AHZ3andb4T+Fz6LIPx+U8ADBpcUCCthrGIlQbCqz9FEb1zwhMYLbozuaaBzHpqj+XzpgqXb5Zp81viqKFxJc28/qx//vj5y63L/eGoqs52u3JqGSJz/rvIgXaL41lPaHTGw2GcUi0CHD7Sh6O82rsws1jT0mvL362b4HIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295435; c=relaxed/simple;
	bh=bna4NUzZA2mcVgT/p7S4K+8WU4ZElOyF2SXtbhwKBVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZefqwT3NoWV561Tmh+gkmwmhFrB75fj2IpV5gYNx3wV3u6oYV8qwL/YEoWm1fxwN/dQl/i3i40Iz3mGMT/EE/lXLLWMIES4/Pqv8jOi/wkTl9njLG1N+HGGHuRcgthifhxKD+JHaSZPRGqEv5UAPCUccvUOE0WUF4SUk2PfjIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/oUzSE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB5BC4CEF7;
	Tue,  4 Nov 2025 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762295435;
	bh=bna4NUzZA2mcVgT/p7S4K+8WU4ZElOyF2SXtbhwKBVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A/oUzSE1xmj5womuL6hjKiwDfBcCpntxs0pidWWq/sv3PUP6cpYnWY2IG3icu77sX
	 DzzjfJPAALECagzMxsT7YRVMxAYFpcwMXNbvu1lo4Uvcilwys2FlKKBRvuYCqlt9Xz
	 i3O8aKiEJD84OYsmfhneGOZQkZ/taUjRQi6JZHZYCcCo5g5CyFtqhwGZ0Q0Jz59pyw
	 PIvnnrpwU+fqSXHWkKdZt6hveeD2argO+vU48biUV0Muvl0ToEdgfLxrL/Khkb0wKz
	 HCE6nPnTHzO5AoDwBOOwOo3nNSbreZKTE+sOzb03MtGA/kqqeSDPR3xoKsVDjFQAbA
	 /t5ob2UUIhN9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DBF380AA50;
	Tue,  4 Nov 2025 22:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/2] Multi-split BTF fixes and test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176229540925.3012376.2096305541338843807.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 22:30:09 +0000
References: <20251104203309.318429-1-alan.maguire@oracle.com>
In-Reply-To: <20251104203309.318429-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  4 Nov 2025 20:33:07 +0000 you wrote:
> This small series consists of a fix to multi-split BTF parsing
> (patch 1) and a test which exercises (multi-)split BTF parsing
> (patch 2).
> 
> Changes since v3 [1]
> - add asserts to ensure number of types in original and parsed
>   BTF are identical, and the calls to btf__type_by_id() return
>   valid pointers (code review bot, patch 2)
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/2] libbpf: Fix parsing of multi-split BTF
    https://git.kernel.org/bpf/bpf-next/c/4f596acc260e
  - [v4,bpf-next,2/2] selftests/bpf: Test parsing of (multi-)split BTF
    https://git.kernel.org/bpf/bpf-next/c/cc77a203896e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



