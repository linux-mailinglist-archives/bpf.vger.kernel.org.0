Return-Path: <bpf+bounces-46763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94FB9F002D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FF4287AE3
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF7A1C9B97;
	Thu, 12 Dec 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuOywJ5m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49091DED52
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046215; cv=none; b=BSbLwfay5kq9U1jCYYDRB2y+oXxT3sFfXRz2sbkIq6XQcWmCCIA0lJ/4CmlhXCuTQ3t0wD1dUDb0ONjRfUBAxfx6dh6lJjlb07T1+XZk6DqDzpPYcaGHGiJH3IYoHEHdAI2ctHcr3yqGUrY2Q9b9JSErp6nw8xHSxPr5l5xOhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046215; c=relaxed/simple;
	bh=Rxwkw+a1nCZtDIZI+4qbPPll91ab2hbPmkPu6/u/1Tc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eu8pDnWUTW4YfM4+K32Hz+ftiNGKlk3+nuZwjiFCwIR/Cd3zwKMjHpBPvA7RZFyc08dz9wr8RMxgZW76A1P2JINiuhKwkKPCxvYnFM1qkqw53BM+HI47fhIl99fLtnJyEwC5B4Copq+basINcCFPpEilUVm1L+Ebxtz/J+82Yr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuOywJ5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74121C4CECE;
	Thu, 12 Dec 2024 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734046215;
	bh=Rxwkw+a1nCZtDIZI+4qbPPll91ab2hbPmkPu6/u/1Tc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TuOywJ5mDE69CzYSCA3oSF5mnM+KUU98rRZiE4WC4m0OpSFS7ZWEY8CfGjtE57ZbJ
	 ls8fzhGW1UTays3eU7Ti8g+OPwHpGBA8HJSdGf6aPaO7YqgFUTf/CvZSErKeYzBh/1
	 L9EEphaLuv+zQVxkK4aab+Z4FEEhYHTRyidirHNRvld0q/lrIffnV+ofrcVDJcsLy8
	 GC6gav7mPmNVPnq/7hRZY61Tv2A2RJoe46WE7MtiHW4npMdcLsPjDufvVOPn1n7Lz/
	 RboWGFTzTlDpMxn5QEThjfC8ZQSZX8anFcj1/YXfxXsgJ6x9YPGa8cLxt6dyKsqnQW
	 vDlHjaehL+ukQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6D3380A959;
	Thu, 12 Dec 2024 23:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] libbpf: Extend linker API to support
 in-memory ELF files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173404623143.2475341.388402079302847308.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 23:30:31 +0000
References: <20241211164030.573042-1-ajor@meta.com>
In-Reply-To: <20241211164030.573042-1-ajor@meta.com>
To: Alastair Robertson <ajor@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 11 Dec 2024 08:40:28 -0800 you wrote:
> This gives API consumers the option of using anonymous files/memfds to
> avoid writing temporary ELFs to disk, which will be useful for performing
> linking as part of bpftrace's JIT compilation.
> 
> v3:
> - Removed "filename" option. Now always generate our own filename for
>   passed-in FDs and buffers.
> - Use a common function (bpf_linker_add_file) for shared
>   implementation of bpf_linker__add_file, bpf_linker__add_fd and
>   bpf_linker__add_buf.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] libbpf: Pull file-opening logic up to top-level functions
    https://git.kernel.org/bpf/bpf-next/c/b641712925bf
  - [bpf-next,v3,2/2] libbpf: Extend linker API to support in-memory ELF files
    https://git.kernel.org/bpf/bpf-next/c/6d5e5e5d7ce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



