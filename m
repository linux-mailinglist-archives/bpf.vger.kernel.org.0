Return-Path: <bpf+bounces-56760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD9A9D68B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 02:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9752F924CD1
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F718787A;
	Sat, 26 Apr 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knW1Sj44"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9F185B4C
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626191; cv=none; b=nxvX1NbXKa33xUj6yTmko5FNw3XoyhM3fkVBjcvyUGFzO7leO3/ZIsWf60aszqJGsOW6Q+tbfwj6lKCxPR3T4rMJaPnZrUIilF5Zh6YDnDll1+CwPR9ueGwPMMCMT7YX8ELH8P4g+soAp+ZIkvvCeSuiVF8mU3HHd7mvdYOC0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626191; c=relaxed/simple;
	bh=wdypCGo2GR0jINurx0AbcPRKsoQY6mKaNw89EL1MKOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u7jw82lu+2jkqYZUJqQX2qX79KhP2rIw2CY95Lffm6cK8HVIcy6v7KUIBi2nw72kvR1ptfbgXCrVGtR+AqaY2sjHoiYrpszT8m7ZhHq77yKlOYgs72n5/9Nwgp38msG2Nl7V/+oWtY9x+7t4epim7YYkh1Wlm5h7hOTbcD0HTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knW1Sj44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE43C4CEE4;
	Sat, 26 Apr 2025 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745626190;
	bh=wdypCGo2GR0jINurx0AbcPRKsoQY6mKaNw89EL1MKOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=knW1Sj44Uzaun5nnEBOvbTK6awpLDbvrNUSKmxMY62t4K/wUe8nxCreCCk84M8nGa
	 2jppihzoR4jhPQyGbKIFGgsD/8+Rn8xyNeVPL/a+5mB0cKEZAj2DgXgFBoBIWfkoKq
	 S4/d1NIq1si2ALGa/sMFVNOZ3GzJH1QOHquCpyUetlOBuxoDbDj1Nk/KKvfh8YlnpB
	 gw3I/9PZoJxWTUD/ONVac808pDhguTzsupE1bgf8uZShpI5rnm27O7nSxHzeWFlIDC
	 8GKE8jXXUqh2Gj1bTXVtMqD/IL3BPILpt6bVc0pZoudxEAjEkGO0KDb89rDryhFuaK
	 8hboq8HkmkgLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F78380CFD7;
	Sat, 26 Apr 2025 00:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Correct typo in __clang_major__ macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174562622925.3882727.7510208033301826958.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 00:10:29 +0000
References: <20250425213712.1542077-1-yepeilin@google.com>
In-Reply-To: <20250425213712.1542077-1-yepeilin@google.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, joshdon@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Apr 2025 21:37:10 +0000 you wrote:
> Make sure that CAN_USE_BPF_ST test (compute_live_registers/store) is
> enabled when __clang_major__ >= 18.
> 
> Fixes: 2ea8f6a1cda7 ("selftests/bpf: test cases for compute_live_registers()")
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] selftests/bpf: Correct typo in __clang_major__ macro
    https://git.kernel.org/bpf/bpf/c/f0007910784a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



