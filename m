Return-Path: <bpf+bounces-57154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5EAA651E
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 23:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DFD9C5975
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D92609E1;
	Thu,  1 May 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7J/Rtaa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1E1946DA
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133790; cv=none; b=BpvGUR0R7j8PwkU20yB7Pz6DcniJE7Or6aVfT+JiyOYxiLLZ4w4F2WAm9FuNzC6coIb4lVjijIjIEw+ijE1JSseB3h3DoLubmdgBUnOmKMlFNo1TcXqQMCnb0lQ94Y8hh/8ddUjzd5k48zjEIT1tCh6RdlIRjjBx9F3esIADtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133790; c=relaxed/simple;
	bh=j5FFxgdu9d46xCDmsWW+ajdXm0kGyc1Mu6XwD8Os4oM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQNX8exEQvpc1A2dyNow8JF7DrRP3o1d3q/tP6leXcFmoKEPNJVH+KAPuYLFjUrILtecDhlCMfPU6jE75IY8LQwF68XZdglkHxfQcg9piLe92chH6Ezhug+I27h/wAQlq20DEVoA5SlN2CQb3shynLqZTkf5hLsghmwYNL2X+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7J/Rtaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B2DC4CEE3;
	Thu,  1 May 2025 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746133790;
	bh=j5FFxgdu9d46xCDmsWW+ajdXm0kGyc1Mu6XwD8Os4oM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m7J/RtaaDiPox3vdlyyWN8uePPKcmuKDg5v+3v2JJeXqlu/yo7aGIcITI68/Mslbb
	 Cea9H6sTB+NjuDFlGDNeh94L99aBs0VIUK3Mzuz+GUNWJdSNbIHGXF4WrCflOmSmp1
	 s11/IH9b4pxoHyGIW1TJyWq12r8AxL0SCySk/DD9fWMPcGmh75ThYrHIf4jvw08gIp
	 8OL1k8FComu6UT2q1icsPAYVIBiLAJNSVHryv0zmA8ZBJV7c8NYa/zcmkE7iR7PXtR
	 Luw2n1aaPTah/RpcjaL6gGtjr+zYZW+5DgsZ9HyvyqZl+geo5rbkkICoojD7xAXYJ+
	 wLiH5wJWCdnEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710583822D59;
	Thu,  1 May 2025 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf dedup test covering module
 BTF dedup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174613382927.3078424.12041468459544634294.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 21:10:29 +0000
References: <20250430134249.2451066-1-alan.maguire@oracle.com>
In-Reply-To: <20250430134249.2451066-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 30 Apr 2025 14:42:49 +0100 you wrote:
> Recently issues were observed with module BTF deduplication failures
> [1].  Add a dedup selftest that ensures that core kernel types are
> referenced from split BTF as base BTF types.  To do this use bpf_testmod
> functions which utilize core kernel types, specifically
> 
> ssize_t
> bpf_testmod_test_write(struct file *file, struct kobject *kobj,
>                        struct bin_attribute *bin_attr,
>                        char *buf, loff_t off, size_t len);
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: add btf dedup test covering module BTF dedup
    https://git.kernel.org/bpf/bpf-next/c/f263336a41da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



