Return-Path: <bpf+bounces-58081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4086AB48F1
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6276E1B4151A
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60F1917ED;
	Tue, 13 May 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnD/VvKb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7518DB20
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100994; cv=none; b=KGQsFqyxxprWsatRjYk7JnemduQ52nL+V56OEwH5noXrzGWre/oEP6lh4JWOuX/mqs8cVRtDR3u+5r7EIDXUdzPQhne0QmvQbxeqbbn6O7UDAH8lXc+JVyk0BRlzWG9A4Ggq0oAmEG0/0UctQVamanQ9EheBYQdGFMf8CGMbI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100994; c=relaxed/simple;
	bh=q8K6mxGRru0QNyjraOO7a/gsJ0HhgFXPQj6Bvs5SGmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sBB90PQr5uCHMIV9g5H+8jPFnCvmjGvYG6dkSdsDHL4sqEBR1CeBh9jnjeluHbSIHfGtIG4fqJFkJtaSvZJ+DltTiu/+INS4pGm/54QvvPEtuTj5BAZLWZHzQbm4wQ1sAhuJ0nIxwv0NdTj+zXVet4vf2Bst4a7q3lWjJeWhUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnD/VvKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0BBC4CEEE;
	Tue, 13 May 2025 01:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747100993;
	bh=q8K6mxGRru0QNyjraOO7a/gsJ0HhgFXPQj6Bvs5SGmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nnD/VvKbLYYpEE3ncCWP8bRZabz0R+mS3H+1FFthRinFA4+h4K40Kgk/sg69EQLS7
	 oPcNQf76Ln4umAh+mxDr9GzZyS63zv7fTk6T6w/LXCLPFFvWbVXABDQ+79xuVJQhzR
	 Go6kSqZL5bbVDjFb53CCEkcylNgxNxb2s6oG6a4bJoagPY+FVJOCo3+QRSrAqvy+UD
	 Fh7HF3+h2iVo/cZOtaILaxJBflerOsfjsUCDB0r/Xm3bEe2iMfJ3DFpPRWnKipcO9u
	 F1Erbr6fmnid72LTDiGyNWnqlq1tQGwSaag/01cKzkAOrtSrqMI7BEbQJLQZLj1xvH
	 7tWEg3GVAjY6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3339D60BB;
	Tue, 13 May 2025 01:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] Introduce kfuncs for memory reads into
 dynptrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710103150.1140764.7546467971754173476.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:50:31 +0000
References: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 May 2025 21:53:45 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> This patch adds new kfuncs that enable reading variable-length
> user or kernel data directly into dynptrs.
> These kfuncs provide a way to perform dynamically-sized reads
> while maintaining memory safety. Unlike existing
> `bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
> reads, these new kfuncs allow for more flexible data access.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] helpers: make few bpf helpers public
    https://git.kernel.org/bpf/bpf-next/c/d060b6aab031
  - [bpf-next,v5,2/3] bpf: implement dynptr copy kfuncs
    https://git.kernel.org/bpf/bpf-next/c/a498ee7576de
  - [bpf-next,v5,3/3] selftests/bpf: introduce tests for dynptr copy kfuncs
    https://git.kernel.org/bpf/bpf-next/c/c61bcd29eda9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



