Return-Path: <bpf+bounces-21249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE684A6F2
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B7EB27B6B
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48257322;
	Mon,  5 Feb 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRCXEZMH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549A85787A
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160829; cv=none; b=RwPPc/v1LIGYeSKkAhLn+mAaUcG1PPCGwEOcqj2nxoju2VJzDmt296ynaCaggqU7lsrkHUnS/uL/mbCOyxA8bYu9hW19kigH0j1OAflBgEN+P3EPsqZgiiOZHBbDVkc3v296ic7FyrsN47/jLkb0iFbJe6CgHndJngFe9a78pvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160829; c=relaxed/simple;
	bh=Tv4k9jXUhYTzF7b/RZXDXXUNlHJc8gfxUCB8/K1LP8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sb4na489B47kSKFvf05fbgVE2SgAvcuVrmO8vqyhjdRKKO0r8gn1QsB8/m5LCt3CFKQYn1t8WD1s90/XOTEUyRWyUmh4HFZ2F0xh66WM8YoOOyNDw2D3D+eCSBBImo+DBhBYk6XeijdqWqQqbwNMoSRkbP+xdk+b25Urthh/C/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRCXEZMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB5B2C43390;
	Mon,  5 Feb 2024 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160828;
	bh=Tv4k9jXUhYTzF7b/RZXDXXUNlHJc8gfxUCB8/K1LP8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sRCXEZMHytmssc6R+8ODX9IiiJpss20cp625XWuj2DWLRvmSMsiQtjxyI9JilgIx2
	 zxGoCAVqwSSc7QdiUNLhgmjn75/+8EKDPAFCazj1fQ0BMisexSPbmKjQBtJ6nRStS8
	 9qR6hYTuCtnrWe12cNpnSLYbobVv/CN+q0JqUiZ/nAr3qhHpyOv7gJtzBFMIPZ3Jkm
	 rUNBIsTF/TtMyJBcIGSD6vIQLON8PphyrLy7nRV7a4ROWhmNsOBaOF7uSqhLwJSt1D
	 zv3Kt1uM+l9spIJqPPbMig+zXanbUZd1fkiK48DJFt14jzBy0p5rFXfhKwMZ0TaE09
	 PA/14Fr8kXP2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFCAFE2F2F1;
	Mon,  5 Feb 2024 19:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky selftest
 lwt_redirect/lwt_reroute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170716082871.18832.4461967447800433469.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 19:20:28 +0000
References: <20240205052914.1742687-1-yonghong.song@linux.dev>
In-Reply-To: <20240205052914.1742687-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  4 Feb 2024 21:29:14 -0800 you wrote:
> Recently, when running './test_progs -j', I occasionally hit the
> following errors:
> 
>   test_lwt_redirect:PASS:pthread_create 0 nsec
>   test_lwt_redirect_run:FAIL:netns_create unexpected error: 256 (errno 0)
>   #142/2   lwt_redirect/lwt_redirect_normal_nomac:FAIL
>   #142     lwt_redirect:FAIL
>   test_lwt_reroute:PASS:pthread_create 0 nsec
>   test_lwt_reroute_run:FAIL:netns_create unexpected error: 256 (errno 0)
>   test_lwt_reroute:PASS:pthread_join 0 nsec
>   #143/2   lwt_reroute/lwt_reroute_qdisc_dropped:FAIL
>   #143     lwt_reroute:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix flaky selftest lwt_redirect/lwt_reroute
    https://git.kernel.org/bpf/bpf-next/c/e7f31873176a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



