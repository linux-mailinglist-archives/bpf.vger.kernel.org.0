Return-Path: <bpf+bounces-45592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD449D8E72
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8A2B2480C
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E241CDFD4;
	Mon, 25 Nov 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJmNN59Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FE1CDA3F
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573221; cv=none; b=eJU5kceF2F6nMY8Ca1tuuPlzzQ7j2Q7jknISx+9UlVfFuQZNBkv5QV6JhRpihl/vhmZW+GjewFWnlI4xy4pwi7BjgpJ2WtXICF5p68/mDK9q25NmxCUC87v0s1XbRTY0+Ais0QWp1BPD81QZEYtleu8BxC0kiM9i+SDsdbzXzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573221; c=relaxed/simple;
	bh=5zUKTiBQHc4Yw3CEAY5B4nvTGk66FatuuN12RSppnx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FptyOBqdWJLOnhcYz3xojFf5kTyKGV9wipPhoks2bF6LQ8sf6pa31wCpTmaiPCvKi9Y7ILvImw9Z/hpwPfxHnGXdHo9Xp37i0rN1VxLf5/ph3dsoRUmNWGLtnBb6DmieBNbL5T2hxCBC9DPLRpLp8Ovt0c7WpvThOy6PBuQHz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJmNN59Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDADDC4CECE;
	Mon, 25 Nov 2024 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573219;
	bh=5zUKTiBQHc4Yw3CEAY5B4nvTGk66FatuuN12RSppnx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iJmNN59Q7YbBSGRUlcsJcYbzsax+093GNJ3N91URRa/Wi9XJib3UPWs5U08By1Zrw
	 ZAnMURPR4SRtORs04durPcD/2qJfpxMWLO1gO0M6L/dGf5C1p7/PLPqbztCar0N/i3
	 flnUFeEwTU5TnivUCB3sR/HaUk93WI17eRFMJinlGfZGRAmqTOV/7UGkr5xbAC8/E0
	 cPX6rgp4BbayBey88mnR+ZqmABQL+oQsEsBPIHLP8/Yrx2Bs9EZHeYXqdZ6jLEYNkd
	 nn+nZX3R/4ltcZpxtwpBwGrrgvMSYzYE/KLNgK45/os4sMYFOOvvQbfr9vT0fDJqS4
	 zHjpHz6o7p58g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC0C3809A00;
	Mon, 25 Nov 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: don't adjust USDT semaphore address if
 .stapsdt.base addr is missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257323249.4055688.7017818062668183425.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:20:32 +0000
References: <20241121224558.796110-1-andrii@kernel.org>
In-Reply-To: <20241121224558.796110-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Nov 2024 14:45:58 -0800 you wrote:
> USDT ELF note optionally can record an offset of .stapsdt.base, which is
> used to make adjustments to USDT target attach address. Currently,
> libbpf will do this address adjustment unconditionally if it finds
> .stapsdt.base ELF section in target binary. But there is a corner case
> where .stapsdt.base ELF section is present, but specific USDT note
> doesn't reference it. In such case, libbpf will basically just add base
> address and end up with absolutely incorrect USDT target address.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: don't adjust USDT semaphore address if .stapsdt.base addr is missing
    https://git.kernel.org/bpf/bpf-next/c/d00058e676a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



