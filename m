Return-Path: <bpf+bounces-35388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD693A0B4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 14:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258BB1C221AC
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FA152E1D;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbOd6yJK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF3152532;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739516; cv=none; b=GuoaL1x29CHy+7V9n81HptnzoGeeZMGNXx+8y/mk4UpJn4AEOVQrBJ8TR6LgiNfLYVCa4hD/XSk6YOFh51j0VrTUN03g51kkCaSwu53L8vCZNB2W4SaGYrB3a/h8t9/yXZLQOnXklyO9LCssTuVChkAdXjjbiLcnHNtKN0+xc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739516; c=relaxed/simple;
	bh=Tze2ALouysJNEmGp2FNtBakloN2kVqPKlYAXAJeH8Ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kABFCpll9Zu3Dgp+cAfacPv8yXoidnFOO6mdqeQp2EL8LKPNhEFVujwRJQlqZjMaeqXiCXYHpBVAKzidlSVst9G+iHrZvTp5nLZf3mE9jT1AMaQV7jDcGvNElz3EWEEd0c6amyv+PU5ED1ozWlwCoVAEdALMQCXiWs4DQ+UmQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbOd6yJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76694C4AF12;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721739516;
	bh=Tze2ALouysJNEmGp2FNtBakloN2kVqPKlYAXAJeH8Ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VbOd6yJKk0vLB+UClJR/+FCf1Ndh7/6ZjNuOgUEUGrl8lQm/vw8K+wOSHuiBJjwnO
	 UFTwPY63vd2Q9U7erz44Ji/nLdMol9WS0Vtc26R+vdCK1zTUncu0E56wrnWm5eCxdp
	 yXCnlU3mnnmEPDLU88A7h1lhS9WZlwZBwBag7a5wB6umDKB2CfV7E/tQsaH7Xcft16
	 WuKGc2/aCDEh176HLdPdNmukyMAgIHr+L2w3IGzPY+6S0jc4OWItlJZBQqERVPCzht
	 +BkNb+41HCOmpBWAlQ4RAG9fZqjDoEyuI+/80tJbESqF+xJgWe6EFv3xKieITcAFT5
	 r2sEnX04TQK6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6933CC54BB2;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv, bpf: Optimize stack usage of trampoline
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172173951642.10883.11057688804753906770.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 12:58:36 +0000
References: <20240708114758.64414-1-puranjay@kernel.org>
In-Reply-To: <20240708114758.64414-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: linux-riscv@lists.infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay12@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  8 Jul 2024 11:47:58 +0000 you wrote:
> When BPF_TRAMP_F_CALL_ORIG is not set, stack space for passing arguments
> on stack doesn't need to be reserved because the original function is
> not called.
> 
> Only reserve space for stacked arguments when BPF_TRAMP_F_CALL_ORIG is
> set.
> 
> [...]

Here is the summary with links:
  - [bpf-next] riscv, bpf: Optimize stack usage of trampoline
    https://git.kernel.org/riscv/c/a5912c37faf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



