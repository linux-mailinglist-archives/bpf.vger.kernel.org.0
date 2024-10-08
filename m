Return-Path: <bpf+bounces-41183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A475D993D99
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66D11C23315
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D34433B5;
	Tue,  8 Oct 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2E7iGHu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CB38FB0;
	Tue,  8 Oct 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358828; cv=none; b=NRwhda3hIYgyyYlwUqqPFFGDapzbv3nDOxjsYYicFcCDEN3ZU4kHm0JbP2iSUFprnjxN9p+T0+t+KeOE3/KfzFiWP0W66wqCHCHM1oLQy7E0/9h4cTZNr904ERo/O49tC/ns+zGBidGvhV88vsiI7eE8lLiQlgekXDu5mexTR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358828; c=relaxed/simple;
	bh=K/M7OzASQwc6idKzykiA1kVMTTk4ntcqJDQQcsVY/cc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lkINwJ2GsWbn6yXonUrIUu9ES4N8G6iivbZGXi6D/sv+/CbsJAekoLRdM13AE3AIa9uilv2OEtRfaRnQBzAWeax34F1LtZYt7F/FRpXMC++Z7CRUti54FczvkxwymimiKgweFH2DhKdKU0PD5Nx+3PRCxgO715xWtbWymoE8sxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2E7iGHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D22C4CEC6;
	Tue,  8 Oct 2024 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358827;
	bh=K/M7OzASQwc6idKzykiA1kVMTTk4ntcqJDQQcsVY/cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c2E7iGHuFs6DIhOYGZClqYORfaZ9VzOwXeYqhB8SbKzPMb/f5xxCthzcKIOP/hrRF
	 2cwDuvh4BZzs+KPcTRR+I9GNUdV9+2cnWUbH4C/z1FrrHHn3G6KVAh6MV/sgOTN9QA
	 HH6FDmhxIXE54X33X+rNOHop2pt1I8297VEed85VNsTKVGegRwbdVqW3dX0noVKFAZ
	 deptMyDgrXRhRzIP/KoTLAjpO8p0r14aEHudp+EqUVEoAJ3eBHXsrzH73iX9yhEjsz
	 YHxSGTb+KbQipohnqiHDXYmAOJ4SHDuX1AkcxQXD1R0Nc1JGG0EjWcx+kVG/wM6n2Z
	 3FK6W5vb0SgEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE393803262;
	Tue,  8 Oct 2024 03:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, lsm: Remove bpf_lsm_key_free hook
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835883150.68999.16357891893479136360.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:40:31 +0000
References: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>
In-Reply-To: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 jolsa@kernel.org, casey@schaufler-ca.com, paul@paul-moore.com,
 john.johansen@canonical.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 05 Oct 2024 02:06:28 +0200 you wrote:
> The key_free LSM hook has been removed.
> Remove the corresponding BPF hook.
> 
> Avoid warnings during the build:
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
> 
> [...]

Here is the summary with links:
  - bpf, lsm: Remove bpf_lsm_key_free hook
    https://git.kernel.org/bpf/bpf-next/c/31dd994c031a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



