Return-Path: <bpf+bounces-56064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468DA90DBD
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC211908793
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB892343C9;
	Wed, 16 Apr 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3T0d/ey"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7D233732;
	Wed, 16 Apr 2025 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838394; cv=none; b=F3rlJjoTjamyo3vK4Bl92u6dVzO4D3jw7ZlOVoPvRRXaIPFVZBV6Wok8q5nKgN3wVm8TwfUSScXuwfTwh+QcinhT+1xhroc33jP+NkjYM6XKism4wkLZy2NXSpngHSy5AxLrgpPpMkRbETxQ9gmjzNubmNMfRHR72FEZf5STtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838394; c=relaxed/simple;
	bh=jJwyjBv1Q16HJ2IBGjCDs+Ngq+HsbA3d3lyR6pIK8B4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uWCHJUy+2iVqkuGqCFeDwKMLIEeoc1Yx9UblI0h6k+PvtYo01m7H1A+/dGNoA4RDvi115/Hnj7M3xkzQh+CH+TUddqg92wwgJb5HAQiNypOeLZ72utA+fIHngAR1q1W7YPSdipzoQuDgif3ninltzoVjRQK6XyG3077Q90DZlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3T0d/ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E39BC4CEEA;
	Wed, 16 Apr 2025 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744838394;
	bh=jJwyjBv1Q16HJ2IBGjCDs+Ngq+HsbA3d3lyR6pIK8B4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X3T0d/eySWiCIvRTNiwpmTcRg6IBiuRxHvkD2bWKiS7d4pervMmcCQyphYX3qShhn
	 pJS8ICx9ZiAF9icNv3brhYv2soq/cVKALoLjmhV9wPVCHZSFy2odpJchcIaJaIbLRb
	 3FPkO1wJqdYq+LymwD6Q07Kss4AfcHze0S1xiqrngRN26bJX9UjebcWX3tvInIvgYL
	 iag4CIs/J+5tJljsZb79Hhw723FHk+8QScF1S/kEwBciUdsvsqyREzLG6APuCa5I1v
	 v16b4RiBjGJg9bHIpjqvW5RneCUniRZJbokhuJwqGdwQ0Chvf5QnOjjhqjcqbw5k0y
	 WsonckIClzT5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F663822D59;
	Wed, 16 Apr 2025 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: mitigate sockmap_ktls
 disconnect_after_delete failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174483843228.3501257.12770805261236189363.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 21:20:32 +0000
References: <20250416170246.2438524-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250416170246.2438524-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, jiayuan.chen@linux.dev, pabeni@redhat.com, mykolal@fb.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Apr 2025 10:02:46 -0700 you wrote:
> "sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
> after recent merges from netdev:
> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> 
> It happens because disconnect has been disabled for TLS [1], and it
> renders the test case invalid.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: mitigate sockmap_ktls disconnect_after_delete failure
    https://git.kernel.org/bpf/bpf/c/82303a059aab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



