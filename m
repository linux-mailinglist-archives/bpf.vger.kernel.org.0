Return-Path: <bpf+bounces-20373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6683D355
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E81A28A56D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF3B660;
	Fri, 26 Jan 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljchaewl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C9B642
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706242225; cv=none; b=QBCvwE+PvorWUjmfRKDiyw8FXTFktMwh/fjMzinbVBgFHDPtwGBoyMRloaZ2wPKEynHi9JjPr+qewfKv/Q4gufzcp0QbbejAowKmiUoxscy3j7kVaLZfsLsIsy/HvJHFbzaFfsTnL86Ca17J5WGYvZHPxd1L9ASumB8DZEl4ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706242225; c=relaxed/simple;
	bh=YUUPmrl0bq1bKmkF067RohoNuvNGXWnhhsJl03Oq4gQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MgECd4c0zGAGN5iG3luxR8oklhyrA/lyJD1p1po7MK+euNsMR2d5nqrtB3oBQYd1sCihWu+GX/FzhkKZI6dF/W7p3SXGHHKVAp5xu368K/VHuLhzKD4LbRu4RwrsXX8dH41Uhj/I1TRqp1NOh5lv9ZvCrJ2hE7twOhGWcMcd5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljchaewl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83E7AC43394;
	Fri, 26 Jan 2024 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706242224;
	bh=YUUPmrl0bq1bKmkF067RohoNuvNGXWnhhsJl03Oq4gQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ljchaewl3H1YHLBJjrjjJ5dkqOebaLDDIQSf6FqqUlFH2hZgkS6+whM4L0ynRRFET
	 inmnP74VlYeA4DGbqtlIsO6O0WY/eFmy/Uyam3v0ZlyJjbPSeJ1/JTSPFUZk+dGOCd
	 KiqKxRGPyfOQoE+xeBC8KewlW3aTSyP10z1ePUv6Cca+LduDxBCTNkVtpC3LM2WEiK
	 ektxFYGkECyCl0+WPtIgr8MuVert0hvYwnKTOtI83Vu5DuMcze0ufwJNHNV1qxQaAV
	 cX3NUHIj3oTEYTK4qgNWM5xZSqQswztgvd85BLrQuL5CJXa9N4U1agplZ2430RSeCK
	 HJAz/ZvVuEaQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C561D8C961;
	Fri, 26 Jan 2024 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: One more maintainer for libbpf and BPF
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170624222444.17234.1417701845882565497.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 04:10:24 +0000
References: <20240126032554.9697-1-eddyz87@gmail.com>
In-Reply-To: <20240126032554.9697-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 26 Jan 2024 05:25:54 +0200 you wrote:
> I've been working on BPF verifier, BPF selftests and, to some extent,
> libbpf, for some time. As suggested by Andrii and Alexei,
> I humbly ask to add me to maintainers list:
> - As reviewer   for BPF [GENERAL]
> - As maintainer for BPF [LIBRARY]
> - As maintainer for BPF [SELFTESTS]
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: One more maintainer for libbpf and BPF selftests
    https://git.kernel.org/bpf/bpf-next/c/be4840b33eb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



