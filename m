Return-Path: <bpf+bounces-69005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1AB8B8FF
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C930E1CC3EE0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA382D73BC;
	Fri, 19 Sep 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2m6wJcK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F842D7D41;
	Fri, 19 Sep 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321608; cv=none; b=qwQXGSd010jpMD8o/DNTO/9itSkxiw07LNAO62ScjVWQsHglA7c+vFuW4dWHeOQJmF0UjVOFPCiI5hkGdB/YcXENtB6yTQk6XDe4CGYwuf4PiwafwN7HUzvhMXJEHZX3xJE2Q/Ow5kLBheYsDCvv4QOd2Zf+TM31W6IiADr+UNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321608; c=relaxed/simple;
	bh=gbxk2lz3iaQkfUAJz68cW4lxTTzG65snBniw4qO93OQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pp40I2l55hVnOSuApbVr3GjTrzCAIyW0HcbqRNuHuCTfFkznJ1Qoue8cLi1ln16naonMHcYSAkZnm7tpgPuZP+eXXdTBWKQ+Td+a6PB6nrrQ5YhQJonxu5gf0LQRO2lV5VclpxvmrV709iGMYlcZ9zwCmrD+R7JuVa0lp5f962g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2m6wJcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF38C4CEF0;
	Fri, 19 Sep 2025 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321608;
	bh=gbxk2lz3iaQkfUAJz68cW4lxTTzG65snBniw4qO93OQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r2m6wJcKX711Fx/bYonmB720Grp1LmWMslvKOX2+HcBQEMMA3USeQD19IXd0K0eK5
	 t7cymY/4wTM0yctfdI/YokPYoSMr+VMToCCH9lLuUrrYmMBSlYBbpgqnms9g7LKdJJ
	 aHiow1IWonfSuFLKB+ZZUmaEBakoD9Ko9rB3pVaaCajnD5MQ27Ba5qHjAJA42zGtXq
	 oQRmWoUEfitbLuOJz2oPR0tXhXorCSoafUmm4UDJoOpKm1xDWltIBVDeC0bk8o2Bor
	 icVKpfM43qSEeiHlfUMw7K3F0svJYIjSnD3NIEcQZ7V7ppiTSJ5RvEgrViqUD71DCG
	 NLPo2r8sGlwnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B039D0C20;
	Fri, 19 Sep 2025 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832160725.3723695.6247239404298049655.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 22:40:07 +0000
References: <20250919034816.1287280-1-chen.dylane@linux.dev>
In-Reply-To: <20250919034816.1287280-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 19 Sep 2025 11:48:15 +0800 you wrote:
> $ ./bpftool token help
> 
> Usage: bpftool token { show | list }
>        bpftool token help
>        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} }
> 
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
    https://git.kernel.org/bpf/bpf-next/c/bce5749b0201
  - [bpf-next,v4,2/2] bpftool: Fix UAF in get_delegate_value
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



