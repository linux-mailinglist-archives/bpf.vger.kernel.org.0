Return-Path: <bpf+bounces-65213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F8BB1DB88
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E562418977FF
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248026E705;
	Thu,  7 Aug 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/dDvxZr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DD146A72;
	Thu,  7 Aug 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583596; cv=none; b=Hjlss8uQQf5dX9lnoYorX7MvtWNjDbfe5hnVZdsTD6IW6ZiK7+tdgDtDK0XJYzpIeP6SlfKsyZLmsOv+blhLiUDxVgcjdSqLI2vNz0aTPARI6TUclLq3PAg7wzvB+ltT4mZJbovqIOh0KegMqz4TF9Gmqo5hRbFFhNeV/vHPfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583596; c=relaxed/simple;
	bh=XEfHPKSktUmKnDddPO998nRTlmFtkYWmxCYrK5ds3IY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=luuPm3VGxv3ovo9nwF6lV5TwEkhn/W9Im4G5ofoNuRLqjC9qiHk7aEOXYFRkNkENsBJ7Qz4iKKFr1M7jnQuf7e7U5+d7Pyw/zu20YKpA6C3W05B13vskGtApiADOip6Tu43EmaVLJ3lVPRqi5rHaKVPRtPlFuvcDNcI0EcVwmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/dDvxZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7F9C4CEEB;
	Thu,  7 Aug 2025 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583596;
	bh=XEfHPKSktUmKnDddPO998nRTlmFtkYWmxCYrK5ds3IY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H/dDvxZrxxn6SyFIQHQTJZDmho3MOWpLXQuPi6kPIOamraCjq8XYlkuX1rSKjv8gm
	 yZgUjAZDgrU4iaOPM/snpGjtIeC41nCi5h7++CTNVaN5Yf6f4trKy4UZMPzplXByco
	 Ccz8E8e3S8J4mAdfXqMOoEA/ckwjPuwL4HkCDZ3tcW6uisHDkv4VHJ3TNvasywnDyp
	 XVBj8Xqu9d97lH1ZrEf13mzZgJuYkiiEnyB41EhHQ0zTeLle0U2ZcDnBCOsL4JFRak
	 xAymfXRScKNgr8JlOUzCzSy0NMCKccAx/WCGUhD/FpdmvGHJDStY5Yrd0KzUUKUW3Q
	 idKuNnXQbRLBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE006383BF4E;
	Thu,  7 Aug 2025 16:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] perf/s390: Regression: Move uid filtering to BPF
 filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175458360947.3615598.15789792776386317397.git-patchwork-notify@kernel.org>
Date: Thu, 07 Aug 2025 16:20:09 +0000
References: <20250806162417.19666-1-iii@linux.ibm.com>
In-Reply-To: <20250806162417.19666-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 irogers@google.com, acme@kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, tmricht@linux.ibm.com, jolsa@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 Aug 2025 18:22:40 +0200 you wrote:
> v4: https://lore.kernel.org/bpf/20250806114227.14617-1-iii@linux.ibm.com/
> v4 -> v5: Fix a typo in the commit message (Yonghong).
> 
> v3: https://lore.kernel.org/bpf/20250805130346.1225535-1-iii@linux.ibm.com/
> v3 -> v4: Rename the new field to dont_enable (Alexei, Eduard).
>           Switch the Fixes: tag in patch 2 (Alexander, Thomas).
>           Fix typos in the cover letter (Thomas).
> 
> [...]

Here is the summary with links:
  - [v5,1/2] libbpf: Add the ability to suppress perf event enablement
    https://git.kernel.org/bpf/bpf/c/9474e27a24a4
  - [v5,2/2] perf bpf-filter: Enable events manually
    https://git.kernel.org/bpf/bpf/c/5e2ac8e8571d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



