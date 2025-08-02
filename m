Return-Path: <bpf+bounces-64948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5FB18A0D
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 03:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EDA586BCA
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E83C465;
	Sat,  2 Aug 2025 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOeWPng8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024444414;
	Sat,  2 Aug 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754097298; cv=none; b=nrZeDBJw4OZzBWOIdXNpmB8PKG/Tm8QlEJTrKbk3QcnwSJu7rwbDaC4C530942zW347aDt/J8W2dh/dwvkYnCGQjOKaGbbZm5TNvET+O1szFiXN4ZITJImijsWgBEM6s+Pzoil2fZQk11ck4z3VlnUM6AH+xAmJry7rTHSXC39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754097298; c=relaxed/simple;
	bh=HxoftNhHBv0uBbeop5FXcE7i3c7IRocHCfGVxYwwpZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mf6Nh33a7/Ec+P5KSL5Kc81Gs3a1xjPXzELLEebaE98eUSeZM1h0p7u8G22hy1eCxem/RHino2XLnwT66qoE2N/7rnwAeUDi7h5+byyJ2qF/qNyk9W95IwdGcmkIS1W0w3lZoqWwTxqYfm4guVtB9knZ3krEw1Laos7Bm5DHMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOeWPng8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD43C4CEE7;
	Sat,  2 Aug 2025 01:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754097297;
	bh=HxoftNhHBv0uBbeop5FXcE7i3c7IRocHCfGVxYwwpZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YOeWPng8aIVCerzdZ+BeUxJ/unj9IhHCJ3+oJZmHi1s0PfUydyUS3JNdWKJP8eolJ
	 kdcKhN1n66s8LfJ0dC/5f9VnbERHh1UVoqe+v/iO9f/e9JhGYQNhsll7CCIluV+NUH
	 iWHgHevY/9RO11Hku6yQ8WLUMJWQoWtPxB9jgLJwq4K2ko4V0x136j/oL5+oqY3VN9
	 XJ5ku/uxtTcIixMZG+pSXlD5NDDj3h5F3PPneDRimzV/fBsfGCGGmkwSZTGh+bc7ct
	 pDmem/TbvRtS4HHbzkOxeXtH+iZotUelY8JTbbSobNcv9kYlmbWAOSYm594WnKBurv
	 2zfPoNBLqFkuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDD383BF56;
	Sat,  2 Aug 2025 01:15:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/4] Task local data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409731275.4179816.2887052648677961170.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 01:15:12 +0000
References: <20250730185903.3574598-1-ameryhung@gmail.com>
In-Reply-To: <20250730185903.3574598-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
 martin.lau@kernel.org, linux-lists@etsalapatis.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Jul 2025 11:58:51 -0700 you wrote:
> v6 -> v7
>   - Fix typos and improve the clarity of the cover letter (Emil)
>   - Some variable naming changes to make it less confusing (Emil)
>   - Add retry in tld_obj_init() as bpf_task_storage_get_recur() with
>     BPF_LOCAL_STORAGE_GET_F_CREATE can fail if the task local storage
>     is also being modified by other threads on the same CPU. This can
>     be especially easy to trigger in CI VM that only has two CPUs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/4] bpf: Allow syscall bpf programs to call non-recur helpers
    https://git.kernel.org/bpf/bpf-next/c/86de56487e5f
  - [bpf-next,v7,2/4] selftests/bpf: Introduce task local data
    https://git.kernel.org/bpf/bpf-next/c/31e838e1cdf4
  - [bpf-next,v7,3/4] selftests/bpf: Test basic task local data operations
    https://git.kernel.org/bpf/bpf-next/c/120f1a950e49
  - [bpf-next,v7,4/4] selftests/bpf: Test concurrent task local data key creation
    https://git.kernel.org/bpf/bpf-next/c/784181141782

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



