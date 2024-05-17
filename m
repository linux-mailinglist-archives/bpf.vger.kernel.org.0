Return-Path: <bpf+bounces-29886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22348C7F10
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F87B20E78
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9179399;
	Fri, 17 May 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqHqWPHD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A6372
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715904032; cv=none; b=IUlT6dvQVLEyHPQl5P23T2pL6B2hK1ZoOgVyYTL340qT/Ns/UvgAITrpHxyguuj8qOL4Du4VCjmBwU79zETNN8+9mKFSRFxOXBSMW8Sw1GuY6UcQEONjSdkgCgUdF4r6+XC0MjiNhA55yt/l09zY3b7CMaR5IRPfMKp4t/98gMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715904032; c=relaxed/simple;
	bh=EO4zqcCPHkPOgXyGXDVSsoiQBTB9FWRYIMqjUgOkHZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qf5JDmPpakwMgx6UrQ35Sv0bd95NKA8DiFIZXSyZMZn6X2EeUQumxozR/b4ozqvBFrTf0Yy5g28viULXTon5I7vtmCfvF3FV1q9jKgFqJGl1AtV0KamtF/4yv5kv0zvnXhhoZs5GsmuhvmxPUK94YLuwfDsuI3oGmb/nSTbgA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqHqWPHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A69F6C2BD11;
	Fri, 17 May 2024 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715904031;
	bh=EO4zqcCPHkPOgXyGXDVSsoiQBTB9FWRYIMqjUgOkHZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AqHqWPHDcnOaswg7NCgFFypA8nPK9tbtV0CTsgWc7EP4RBwNHPNIquuLXA4u5KR+k
	 ZFRPqorVIeETh8w6HKTBDCrgj3W9p4BjzZgcjyGcDraGWfci/VVQap+e05mDZcCgpt
	 dyfodvADuVGPYT8IjClY6cuk/mCGhgj0sHMvvdzGIaKFfP8opPONobNYNHtPvXYyZn
	 bkKFXVJ/e29ab1W1c1JFpKzhhOWnYJxQOamssPofl0zPAZ+OhNENjIgoqL4PCQv+iS
	 E64FfUspcrkvieEML9zRX+rnXRKPeqaRvfYsiM/GikYLAXBDxiPbSYL2mA6ifnyfBY
	 gbRrb2/RB8OOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94104C41620;
	Fri, 17 May 2024 00:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Adjust btf_dump test to reflect recent
 change in file_operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171590403160.16758.17938895621853444532.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 00:00:31 +0000
References: <20240516164310.2481460-1-martin.lau@linux.dev>
In-Reply-To: <20240516164310.2481460-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 16 May 2024 09:43:10 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The btf_dump test fails:
> 
> test_btf_dump_struct_data:FAIL:file_operations unexpected file_operations: actual '(struct file_operations){
> 	.owner = (struct module *)0xffffffffffffffff,
> 	.fop_flags = (fop_flags_t)4294967295,
> 	.llseek = (loff_t (*)(struct f' != expected '(struct file_operations){
> 	.owner = (struct module *)0xffffffffffffffff,
> 	.llseek = (loff_t (*)(struct file *, loff_t, int))0xffffffffffffffff,'
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Adjust btf_dump test to reflect recent change in file_operations
    https://git.kernel.org/bpf/bpf/c/51e2b8d33199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



