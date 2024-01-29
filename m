Return-Path: <bpf+bounces-20608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F3840AB6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607801F2677C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1015530D;
	Mon, 29 Jan 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGBrE037"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E9155304
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544025; cv=none; b=ormCohsnj7fKrZLg5jH0fiboT8eWa/EtYCmVp0/ve3/MjoweOu83OWBQtMfcAvJaKRldzWoHvqW8EFx5S1uCcto3JWps/FUadk586rgINNRLGoluRVPOn2Svv74L9Bn6CL19qNGYxAmFhcF8f7/WibSUmIkdhG8uo4ioDJLp7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544025; c=relaxed/simple;
	bh=pMl6rmuDtk5k3L0Yc+a3rgcygJ6tP2vAksfp15Vj0pk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qDXhF6ALSFQ/JiIFJIkcwwm6QyMQYM5g2y/gHbRpUl7VXkImGf8vcO3/XuBWqnEGmNRrgJV3HQx7bUKm62/uAMGugAKxKB+Wmh5HprgEzkXsBySwjS5P/ZlLLFQ8958XnPwt3OU66BUNwCCso/sKuzKfoeHLF6mlAJlBwKsXlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGBrE037; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A548C433C7;
	Mon, 29 Jan 2024 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706544025;
	bh=pMl6rmuDtk5k3L0Yc+a3rgcygJ6tP2vAksfp15Vj0pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NGBrE037/D82HlenfQJenLIxiDS2zs3x6mFPYDsmGYVYY2DlAnkmFVygpmaeWhbEx
	 foKR2Y0Ty7kw6Hb7pUxCVV+cNzmqLlHhiF1HL6C7GcoiGyhq9YRMZmaVGkXtFBqW3O
	 9mwCFMP4Dufx2M+URSBdeniFSQ+CVteDODOQlQTZmZeIFpIR2XC/8VPElb94GVaO0J
	 Tb04FhycwmB4/j7cksKTJaYAySollZbhiLYoC9W7TicuL+FkNEkJaLSqe3Xj2qABHe
	 grAz+kWZzZxUk10Vo9aoH17TCseSBxnZxxMplyG/M69rX7BTyehdS6yTfFGXKM8L+K
	 O3WOkUHWk5sJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F882C3274C;
	Mon, 29 Jan 2024 16:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] [docs/bpf] Improve documentation of 64-bit immediate
 instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170654402519.22018.10243846835533963218.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 16:00:25 +0000
References: <20240127194629.737589-1-yonghong.song@linux.dev>
In-Reply-To: <20240127194629.737589-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 27 Jan 2024 11:46:29 -0800 you wrote:
> For 64-bit immediate instruction, 'BPF_IMM | BPF_DW | BPF_LD' and
> src_reg=[0-6], the current documentation describes the 64-bit
> immediate is constructed by
>   imm64 = (next_imm << 32) | imm
> 
> But actually imm64 is only used when src_reg=0. For all other
> variants (src_reg != 0), 'imm' and 'next_imm' have separate special
> encoding requirement and imm64 cannot be easily used to describe
> instruction semantics.
> 
> [...]

Here is the summary with links:
  - [bpf-next,docs/bpf] Improve documentation of 64-bit immediate instructions
    https://git.kernel.org/bpf/bpf-next/c/ced33f2cfa21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



