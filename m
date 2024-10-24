Return-Path: <bpf+bounces-43017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A589ADB5C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEF91F22E7B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D0171E76;
	Thu, 24 Oct 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a004ztBm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF751662EF
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747232; cv=none; b=pb3T3EAUntMgVaL+hwk6ZpXNc6mSguyLWdpLJwK1qWZWOcop/rQODBRP7SiihukMNoCU5RUePEe1OTU5MutwaePUM5onnMh1RVXP6FcRudIV+laNdtUxkP/YyyRJaW5ooRPscXnGrpOJf2ZIbhSTuujyiRWh2v+Z3TGL8vl0tM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747232; c=relaxed/simple;
	bh=qK3/Pa/vs18Ed7TlOGk9il5Z2O9bBpCBWz5+wLqa37s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pw29FwHaTdisXditXxql1zBW5VJj57fKoIXGG66oGh29ejh1eqwywDougPpHiSer9/8jro0fuSwT3DU9pfdvLM/Y2C9DIJ+QWDt8lhSaKlULZOSGJR2uyGH2OIpesdIgK1y95JFOYgu7+RUo8yA8SCOpp0ys0eZCtNev0NM1Fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a004ztBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9EC4CEC7;
	Thu, 24 Oct 2024 05:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729747232;
	bh=qK3/Pa/vs18Ed7TlOGk9il5Z2O9bBpCBWz5+wLqa37s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a004ztBmlr7W5TVvT/gxo9/tqKKGJ2rMSWiGAhjL+29mh5dalzi8s53fjuws419Ek
	 GB96b/iq4sfzQtoUTRImZBvNlXQjmvT4ovL3/YG42YOXGC7I2OD6V8jZdDMWLwy0ZP
	 92kkeRfmU5ilhj9AwovCmTwmUPGOPKYhn3M0/CRw0+9c7EcIcPMeXJrsDAP9h8cosh
	 hOv9s2O1Npi9StEWVvxygn1hQyZ/WlMGMBWOoFS3i6kLx9GoHnybDeg7MhZIt1xlva
	 ni9sjmAhr4ausGsHJ18p8yjo5Ei0Trh+tx4a1GjYIlgIMU8xgG4NN4geUH2ZzYtBm9
	 3S87ib5UPgiRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACEB3809A8A;
	Thu, 24 Oct 2024 05:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix libbpf's bpf_object and BPF subskel
 interoperability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172974723848.1812236.15733569083629256183.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 05:20:38 +0000
References: <20241023043908.3834423-1-andrii@kernel.org>
In-Reply-To: <20241023043908.3834423-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Oct 2024 21:39:05 -0700 you wrote:
> Fix libbpf's global data map mmap()'ing logic to make BPF objects loaded
> through generic bpf_object__load() API interoperable with BPF subskeleton
> instantiated from such BPF object. The issue is in re-mmap()'ing of global
> data maps after BPF object is loaded into kernel, which is currently done in
> BPF skeleton-specific code, and should instead be done in generic and common
> bpf_object_load() logic.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: fix test_spin_lock_fail.c's global vars usage
    https://git.kernel.org/bpf/bpf-next/c/1b2bfc29695d
  - [bpf-next,2/3] libbpf: move global data mmap()'ing into bpf_object__load()
    https://git.kernel.org/bpf/bpf-next/c/137978f42251
  - [bpf-next,3/3] selftests/bpf: validate generic bpf_object and subskel APIs work together
    https://git.kernel.org/bpf/bpf-next/c/80a54566b7f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



