Return-Path: <bpf+bounces-70172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D05BB20D6
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 01:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2DF7ACA64
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAB26A0A7;
	Wed,  1 Oct 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDw2W8Xp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1722B594;
	Wed,  1 Oct 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360214; cv=none; b=QK6nkbhejqWQOT2WXHUjZwGjYCncGRFu8fE5V+hfwYyWCCjm6Q3PVyghA1h85ce8jGlESpEDTofuUzMTm5BjdyK6xdZWAqRBnq/FtMmUrg0OdXuxbZ4C8SwYN2wpxkg5XQ7wEQ+xKhgPsH6oXqWwObbMuR2SRrrh16qUsRaqEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360214; c=relaxed/simple;
	bh=B3HRz/KTZKMuWnZ9hNBFnBaZDPuY8XrrLTdRe2xAai8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMcX9/tYewPZ3rAiiHkn4Z+kxcOFyVfoSZRbhg3svxmqSiG2R5wboAaaJqtkdrZZaAe4yNRgEllQESuRhXuL/cX50yRkw2VgynVAuas/8RtLOAnSqAPKAQevVv2iYNt/6M7G6N9o8w1hG+T+QkdIutN2Ch+ZiJPiaQeVz6rOzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDw2W8Xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA24C4CEF1;
	Wed,  1 Oct 2025 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759360213;
	bh=B3HRz/KTZKMuWnZ9hNBFnBaZDPuY8XrrLTdRe2xAai8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fDw2W8Xp5Ta8+91AAyaPxsdvIORwvF8Obx6omjOwd4UIX2e4gxT0fGR5g5O/8MXAb
	 TsMmJHXPE0aGV0VVGaLmQWh76b57nqD2zZMpiT8+o76vP5NnZVJsSVCkp7yAE7noCN
	 gbDFXe7yY+VXZ3MhkFbFmRTpONERI87tZztR7x/ugV9V/tothtHdkoY0qXrFJY2T7U
	 OymupCp933xZn0cSv+kOA97wAPxW4fnTYpqhBH21wC1bSR+CRiBEmqXBMKKCsZqQTZ
	 T7Ffv+Ej7V1Zsfl0WxijhNUO3ZPa5uxi6VaxGS/33PiS1YLr1mlcRycfE4cLEBuCpW
	 G04d6QW21RwWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BC639EF947;
	Wed,  1 Oct 2025 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for libbpf_sha256()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175936020626.2655520.13016987725533835451.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 23:10:06 +0000
References: <20250929192721.144640-1-ebiggers@kernel.org>
In-Reply-To: <20250929192721.144640-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-crypto@vger.kernel.org, ardb@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 29 Sep 2025 12:27:21 -0700 you wrote:
> Test that libbpf_sha256() calculates SHA-256 digests correctly.
> 
> Tested with:
>     make -C tools/testing/selftests/bpf/
>     ./tools/testing/selftests/bpf/test_progs -t sha256 -v
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add test for libbpf_sha256()
    https://git.kernel.org/bpf/bpf/c/f09f57c74677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



