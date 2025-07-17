Return-Path: <bpf+bounces-63538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51DEB08288
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3021A64B42
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649F1E5705;
	Thu, 17 Jul 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/0exGG5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7C1D5CC7;
	Thu, 17 Jul 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716402; cv=none; b=OowVnQAlG0YsZOrEjORGkm2I84AmB8wKIP2Y1rInigPN6KK3Ij4Gb7gSiKw/g3p+u94flaD/o57uPfX2UB/QleuwvLB7kEC97+5EVU4UHLpKejXssu1i8bGW9vqxVszUZGbrVYPdIZg7FRfSOMvO91Blgxl3s5L1eOztFZC0GGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716402; c=relaxed/simple;
	bh=58gi4xzM0JLIVD3K8RC0ZAEtUD3oiBPIAedir7mif1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tbAtgxMUyVwI+c2G0b2sP32T1PuS2iKfdFcUQ3ie+qEwyCrCGIx5ZXYMOde2M6uhJ8DTnsupFtrqmYr5QOKB9uT4e9vZKWiLGNnx8AaEl+yI5J60JseazOI48k2XKE+hlTz7bxLIHkV/w9ZsTwbNyvnW2WNoAB71z/LlI9rhIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/0exGG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06D0C4CEF0;
	Thu, 17 Jul 2025 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716401;
	bh=58gi4xzM0JLIVD3K8RC0ZAEtUD3oiBPIAedir7mif1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/0exGG5Cc/5ijte9hRmjXmCwHIrRwLG9y4p+9mJTMeP2KhaE8X20r9AokekrEtrN
	 ztQS6WJWxLmaLc1BzcoRP4cEax6Q9j1rQXLL5hjzdCa7yhi0QdHBlg5scpJpkQfrQr
	 0XptsYhqGiGnGFfrTF0z6ZUVwTvVKXNTwyuuKgGwZDfB6zACN434zc/GaavckObKC5
	 WDv4URLoqpaSRwiB3ElJGeAKlC+3Q9HGUySwgyrNsGVRdBGvPLZncJIEZ+SNyCY/wt
	 TEBM4RrReJ4Kli5Yd7oWGlc4YJjRrpFN6O/WlXb02P7W28FN04gDhErmMhvxwe8hB7
	 UXyA4cALdYjsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341E6383BA38;
	Thu, 17 Jul 2025 01:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add struct bpf_token_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271642175.1391969.17690324440245877462.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:40:21 +0000
References: <20250716134654.1162635-1-chen.dylane@linux.dev>
In-Reply-To: <20250716134654.1162635-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Jul 2025 21:46:53 +0800 you wrote:
> The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
> BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_FD
> already used to get BPF object info, so we can also get token info with
> this cmd.
> One usage scenario, when program runs failed with token, because of
> the permission failure, we can report what BPF token is allowing with
> this API for debugging.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Add struct bpf_token_info
    https://git.kernel.org/bpf/bpf-next/c/19d18fdfc792
  - [bpf-next,v3,2/2] bpf/selftests: Add selftests for token info
    https://git.kernel.org/bpf/bpf-next/c/fd60aa0a45c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



