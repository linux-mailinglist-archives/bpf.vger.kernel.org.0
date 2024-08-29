Return-Path: <bpf+bounces-38417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B0964A96
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0049FB24991
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9041B3B1D;
	Thu, 29 Aug 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8tJnRlP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC11B4C49
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946630; cv=none; b=gQNZfVgr9TkMF9bauQcbTGIi2EkvAmR9zbZGaxfR6eafpB/RRChyKH32dsjKQ209n0rsAlsQMxXyPxFKA98Hc+i5PWLu/j6WyKdlGMLyrohqXVRjAs02FujnqcKcLHoe9GPELF4FlpQCH9IVDdCuM9RxO3coPxV7n8YSnGcha3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946630; c=relaxed/simple;
	bh=l/AW/HRFpSZmJbXsBm2Nrn17VDpF6aVOVWH+UaatL14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BIZF0Fp9W9sETrNqKZndaqCgGZHEW2xLJFn/UaF9nbfWCVEcNMt1MSCzmRtonQ3H0pjpaKE2F2PVFvnSMvrUcV61r4WNG0H9uGBZwBmsBNqclAVh6hdp7ubUWeDYGH97DRKQZhmxYHdPg2yMEHYE/uUHqMMEsU5ZwjZ32sau4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8tJnRlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A40C4CEC7;
	Thu, 29 Aug 2024 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724946630;
	bh=l/AW/HRFpSZmJbXsBm2Nrn17VDpF6aVOVWH+UaatL14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8tJnRlP9K32RF1yYQ6BjBEqfVWC22z7sb9h92+TT33kwKzNgsWdJFEM5GDYLBTDx
	 NSIoKP9jGcYvry7zOW8u6vxUK0ISv69aLxtRYpl94MK6hMq/sL7n0ESuZqSz9Ox23w
	 1S0PgaTwxDTf49/hBiGG3iBNAVs6fiR2oxqeSVf2vfP5LgZITOzoCbve9LcIgFhZ2h
	 yfgPzOqxNdRqEptGKQ1/cS18YgFwsmzqjJKiAZOULeYhjagvvc1Im2HcGDkMOPVIrn
	 tMYP3dx/wcznrqFKYSTsC9GHJVAponJpuH2v0ggQsmP0AXgVU1Rg+4ocRQv9XoO0fX
	 2u5AnGSRF//0w==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 912CC3822D6B;
	Thu, 29 Aug 2024 15:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix bpf_object__open_skeleton()'s
 mishandling of options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172494663158.2000498.12444325129726377147.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 15:50:31 +0000
References: <20240827203721.1145494-1-andrii@kernel.org>
In-Reply-To: <20240827203721.1145494-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, deso@posteo.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 27 Aug 2024 13:37:21 -0700 you wrote:
> We do an ugly copying of options in bpf_object__open_skeleton() just to
> be able to set object name from skeleton's recorded name (while still
> allowing user to override it through opts->object_name).
> 
> This is not just ugly, but it also is broken due to memcpy() that
> doesn't take into account potential skel_opts' and user-provided opts'
> sizes differences due to backward and forward compatibility. This leads
> to copying over extra bytes and then failing to validate options
> properly. It could, technically, lead also to SIGSEGV, if we are unlucky.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix bpf_object__open_skeleton()'s mishandling of options
    https://git.kernel.org/bpf/bpf-next/c/c634d6f4e12d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



