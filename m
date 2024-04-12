Return-Path: <bpf+bounces-26634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A868A33F5
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3484D1C224F4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038214AD0A;
	Fri, 12 Apr 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHyUTXfk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701714A4CC
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940029; cv=none; b=CpB5y/ofBT1bn/yCSHo4So/NO+IkKAvjeJOAYzB95lErS/Ze8fd5yM8/y0wkf7sN54CxD2MGKlTYDu1jAP3yfUs+2ZVQ5KPUz+ruOuJG5B2S9XlN5FLsLyK+pvnrGE190OspKVzH1lunyKsteJhLTudCcJNYb6tceSE+ZMfzGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940029; c=relaxed/simple;
	bh=xGM7pZeOomgJ8qI64bX8s7m+Jm9UHNEhfn4o21im4Sc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J3iys2wDnIKiHgfnx/ArLkM9SAFAOIVngJ46otJbqsrs9MuY3Sgv84MCaPFQm8xDXS4EFqYkYp3azx45FUQwAws7jOJ15tZAfly5eu8ven08M9hzR7fpZtTMUU/0mdlCNlPs+n3TqdNPns58CT3jLTj9RkM8mxMFyoDH1/G3/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHyUTXfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9EE1C2BBFC;
	Fri, 12 Apr 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712940028;
	bh=xGM7pZeOomgJ8qI64bX8s7m+Jm9UHNEhfn4o21im4Sc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qHyUTXfkU4+P6vq5KHfg31vwga1FPCRKRBTI44KhFCAJxPNBvqByg9hzyffWLAGYj
	 TRYs7IlmZRWdBdpTQTEaZy85dDYM2qfUUDEE9Gdu27z6VTou3ahEcYUYLIFs1MqRyw
	 eN+iRhA4TvQhwSHSM/TXrpNkE7QjKjKGiox/ktilY240PDtd3LR5mFw4UdIMNR/VcZ
	 9nTr0dGKpRc6wpKZ66Q6DUdg7E+brPnl8Yrr2tsfDogCSPWPyE9wRIqseR4cu09l9k
	 Sv7yy3uNnk/DabmUCtVhpM9LV7sCL48b/B9rSBhX9yGrXkN7FJcNND0yvfPpR2/rGM
	 1E3123yImHi1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 969C2DF7858;
	Fri, 12 Apr 2024 16:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix a verifier verbose message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171294002860.22562.13255273895033166786.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 16:40:28 +0000
References: <20240412141100.3562942-1-aspsk@isovalent.com>
In-Reply-To: <20240412141100.3562942-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
 martin.lau@linux.dev, sdf@google.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Apr 2024 16:11:00 +0200 you wrote:
> Long ago a map file descriptor in a pseudo ldimm64 instruction could
> only be present as an immediate value insn[0].imm, and thus this value
> was used in a verbose verifier message printed when the file descriptor
> wasn't valid. Since addition of BPF_PSEUDO_MAP_IDX_VALUE/BPF_PSEUDO_MAP_IDX
> the insn[0].imm field can also contain an index pointing to the file
> descriptor in the attr.fd_array array.  However, if the file descriptor
> is invalid, the verifier still prints the verbose message containing
> value of insn[0].imm. Patch the verifier message to always print the
> actual file descriptor value.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix a verifier verbose message
    https://git.kernel.org/bpf/bpf/c/37eacb9f6e89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



