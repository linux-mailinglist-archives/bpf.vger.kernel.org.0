Return-Path: <bpf+bounces-69471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38608B974CE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966C93AE2FC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AE7302CB0;
	Tue, 23 Sep 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyP6gk4p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56078F39
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654617; cv=none; b=MXGDFiYRTLc1IarO7tGhH/gjjwr/tUsIfnYmwqb3dkOijQgpo5cpVF1py0LWtTFOLYVluUDinJjR91Ci5pBsBAWeOtKZKCl/ldBKHOu5Kb/10oxINhjHlc9liLy4+i8Q9HzihyZ8tKI0qInPWGpU8sR9Gii/5HQueza9pgC1VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654617; c=relaxed/simple;
	bh=1J9lyT6PQXnxc+PcXgJ7bXnxmxH9tfKR19qV/0SRg2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kxz+31GWUSyh9sbVV1ksrKLXy7SBMcNd3OkmAOz98qSzv0wgSLU4FkNdk69gU/6yShhCeiUBGs77f64XsuHtL0XuizDJXxM0ObaYJpmf2zSFn9C/Wiuok9q8s2CTp0PwaEBUOs1o2tYJcaGXGqz0o/phr1hSsxHEm2EQUc/S1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyP6gk4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A7C4CEF5;
	Tue, 23 Sep 2025 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654616;
	bh=1J9lyT6PQXnxc+PcXgJ7bXnxmxH9tfKR19qV/0SRg2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TyP6gk4p6iI6Iz6bTMXXPB7Ct96CLSov8YnJElT5Ty1rewk0gJt/zaLt+WxjPOc76
	 92IXDZrlnNR5MyhJbqfe3GP2kZ6EKWRXT7+U+0HSNvki/TiVhKA5Ke0Z4RVZx4q5tK
	 guvkFH1kAByLPIag/F7K46nDyyE9Il91jefpQHDoDzh1tzK/fAq+IKWY6hBj9HLA8j
	 JEDGHCfurSBTkwThCo9tE/8vpKRIg6Z00dydVSKmOdTo1owsdEg2NY3CNne2yWLxTk
	 alaB5UZfiQTIStXgx2Qh8a3qrjo/nsu4bzy0kxXxitpqoDejr4Zp6ANk3a46QWsdjw
	 8hHOGTBXnZKwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8639D0C20;
	Tue, 23 Sep 2025 19:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Signed loads from Arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175865461300.1891567.3835370629018390163.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 19:10:13 +0000
References: <20250923110157.18326-1-puranjay@kernel.org>
In-Reply-To: <20250923110157.18326-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Sep 2025 11:01:48 +0000 you wrote:
> Changelog:
> 
> v3 -> v4:
> v3: https://lore.kernel.org/all/20250915162848.54282-1-puranjay@kernel.org/
> - Update bpf_jit_supports_insn() in riscv jit to reject signed arena loads (Eduard)
> - Fix coding style related to braces usage in an if statement in x86 jit (Eduard)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf, x86: Add support for signed arena loads
    https://git.kernel.org/bpf/bpf-next/c/a91ae3c89311
  - [bpf-next,v4,2/3] bpf, arm64: Add support for signed arena loads
    https://git.kernel.org/bpf/bpf-next/c/eab2a71f3a6a
  - [bpf-next,v4,3/3] selftests: bpf: Add tests for signed loads from arena
    https://git.kernel.org/bpf/bpf-next/c/f61654912404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



