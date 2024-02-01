Return-Path: <bpf+bounces-20989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0F84629C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FAC28D5F4
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFAC3F8F9;
	Thu,  1 Feb 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd4kSX6O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6D3D0A1
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823027; cv=none; b=MWzAEzbqxxG7vCFixWygfPR/XdSAPpfdbS4pkMPFGjnMbt14NRGcmAO530CBUnDrweipHu14rRy15RG/67jRc8hj5q9Q5mBgVrTyVF5bN949Od53zwAY/USK1umPJ261zkkaoTP016uTUFCEeeOiO/ZlXSqiEcejUOpaAriYEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823027; c=relaxed/simple;
	bh=Q9aoLWKANBepjNUIBHscRbUBZ/jrIFQBVzNWbnOW8C0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ejSBsi/tC0U71AraZZLdDSjDrEKqnOMNJ3gcXT7oZ8rA0UKzacitvBfrheYeIO4/Icyr/lwi/h/DegFDJro+fdIvrNYOPnAFJZV1JScZpVZJqY0Wk0ihmAqUSA1s7vSxx8gwkK0pGcSooYVDibrdq4y5ZzLGtk9jaG/FDMOIaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd4kSX6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C22C6C43390;
	Thu,  1 Feb 2024 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706823026;
	bh=Q9aoLWKANBepjNUIBHscRbUBZ/jrIFQBVzNWbnOW8C0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fd4kSX6OV9Ki+r1F9Tu+4LA6xAOSJahGv+W2lxm3P5li5s29T0MWKsHau9HKDk7gG
	 8YuXqw1XL9SG1K9lsrRi6pMGCd0+vUCwtbOdYP0AQ9STYSQJrztg9MGY3BEid03AKI
	 nMDyoqxDyk//shT2UzotS0N2j/L+pxG16/5PxuJXPBvBcHZWyUnosnt8N3RXalussi
	 l41BtBdGAwZ/8hAK4D9MhUOvD8e0ZbY0zOIeZpvl7qMIQoPa/MK13hx7Bth+Ndo60z
	 s/pvOPeqrfBoJxlhCusQppnTVmkrO/vEQ6fhLXySqqzA3zEFJCwSwzympiEMrWtAr3
	 YRMSVkKEVUrpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC0DCC1614E;
	Thu,  1 Feb 2024 21:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/5] Libbpf API and memfd_create() fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170682302669.8450.7126648000478013846.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 21:30:26 +0000
References: <20240201172027.604869-1-andrii@kernel.org>
In-Reply-To: <20240201172027.604869-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  1 Feb 2024 09:20:22 -0800 you wrote:
> Few small fixes identified over last few days. Main fix is for memfd_create()
> which causes problems on Android platforms. See individual patches for
> details.
> 
> v1->v2:
>   - added extra Fixes tag in patch #2 (Yonghong);
>   - improved commit message in patch #5 (Yonghong).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/5] libbpf: call memfd_create() syscall directly
    https://git.kernel.org/bpf/bpf-next/c/9fa5e1a180aa
  - [v2,bpf-next,2/5] libbpf: add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
    https://git.kernel.org/bpf/bpf-next/c/93ee1eb85e28
  - [v2,bpf-next,3/5] libbpf: add btf__new_split() API that was declared but not implemented
    https://git.kernel.org/bpf/bpf-next/c/c81a8ab196b5
  - [v2,bpf-next,4/5] libbpf: add missed btf_ext__raw_data() API
    https://git.kernel.org/bpf/bpf-next/c/b9551da8cf3a
  - [v2,bpf-next,5/5] selftests/bpf: fix bench runner SIGSEGV
    https://git.kernel.org/bpf/bpf-next/c/943b043aeecc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



