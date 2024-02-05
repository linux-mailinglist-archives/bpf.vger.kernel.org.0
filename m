Return-Path: <bpf+bounces-21245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4584A2B1
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82786B2254F
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B43482F1;
	Mon,  5 Feb 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D59onucB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CB47A4D
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159029; cv=none; b=VHDPAyJKvnR1fd26GlGd3tL3wpwXaT9km8Jvwa0H13XhsmovBZlphuuPUGhC0/4mDarRzIBL0+ue985OnzSn2ZZiyHEFxarjE9WlMiFE+jZy1s24JGjoy6OXl8Il/RneOnH9AuesZouQtbxqVOQfEUYEXaDrAYKeGkFdgul5zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159029; c=relaxed/simple;
	bh=Wx7ktJDvlRJhYjcDsicf0GbqSVliYCky0ODb2TyEEmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BUXlgdZnIlS5xKPn/Hl5QqmnSQa9Ex1hI3QqxW17mIwwkQ1eY0COQfKVg/IVY7/e3fMbkJe2eSWLWg7qcqe8mKVtM17i4h+/nEFRR4U5w6/rcommSS6Uhkwby5d8paDrxEVA60RkoXgxvBcI47o/SX++GdM/wpynjZ4TZrgSjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D59onucB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01294C43394;
	Mon,  5 Feb 2024 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159029;
	bh=Wx7ktJDvlRJhYjcDsicf0GbqSVliYCky0ODb2TyEEmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D59onucBPjWRInX3M4yHpUuJjITA6V/v1hpZUzNtvZvZEILI5Zvz9+cL03ayJYQMB
	 s4JKNclJW4t2JMWZ42S3f2wHpmWM7R4qsWIKOKrhnI2Xje7TP+eEO90Z7lf9yFaU8L
	 ljCfpejlTTornZXbW1xxTxJmtoEZaH1YYElCgvKYz7vlaH7Rsj1ybo1/VnF4TKR8M8
	 9WUg6vhYBc1l3GmB4RYki7MAX8u/28UiJxbHIB1SfZssXisaQzcmuoSQJ2B6gKZwcA
	 8f6fGLEvdnFb00qzRaQQ2O2iguc50ANToe5huEf+wtZBcxhKHZypszErn2rQ/mang0
	 1pESC/IdpqWJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA65BE2F2F1;
	Mon,  5 Feb 2024 18:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test ptr_untrusted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170715902888.1829.12591862433783089480.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 18:50:28 +0000
References: <20240204194452.2785936-1-yonghong.song@linux.dev>
In-Reply-To: <20240204194452.2785936-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  4 Feb 2024 11:44:52 -0800 you wrote:
> Somehow recently I frequently hit the following test failure
> with either ./test_progs or ./test_progs-cpuv4:
>   serial_test_ptr_untrusted:PASS:skel_open 0 nsec
>   serial_test_ptr_untrusted:PASS:lsm_attach 0 nsec
>   serial_test_ptr_untrusted:PASS:raw_tp_attach 0 nsec
>   serial_test_ptr_untrusted:FAIL:cmp_tp_name unexpected cmp_tp_name: actual -115 != expected 0
>   #182     ptr_untrusted:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix flaky test ptr_untrusted
    https://git.kernel.org/bpf/bpf-next/c/7e428638bd78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



