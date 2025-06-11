Return-Path: <bpf+bounces-60417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A2FAD63B1
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210A418863A7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F2257448;
	Wed, 11 Jun 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9YySEnf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92632254848;
	Wed, 11 Jun 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683416; cv=none; b=fIPW5kvnirsUQ7VNeB4UL6/kCTSeNgVTPbl5Vbajy9YpN4VT3yKu0ActJQS11TkBvHiRf6hcqPm3Rv54vDSJKMALHWgl/KQdlwHG07ach2RlpvHwRUdg1AO8lZ2Nuv+ggMxyU65ig2cs4GgItj9XGI7i+gxtmchNY2pg30T4wOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683416; c=relaxed/simple;
	bh=S/zN57o/a580ZWcuxntqq1DlFtuBBkxLAkhEXK6n3Kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pYNEx1yp9OrOQ5sqBkyyjUu2r1a0vVxgxYiw3sdLSVA01GFST9LVNnbZX5QX9x81tPSmfgv++wqFVLE13XMRzTyvOuz2nel+mAJlWwXdDNfsl/DrxvCt4auWTnjGXyqbCKi+Qwhr0wI7Swh/e6KeSPL3mClPGbHX8oCDiV8YOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9YySEnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C9BC4CEE3;
	Wed, 11 Jun 2025 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749683415;
	bh=S/zN57o/a580ZWcuxntqq1DlFtuBBkxLAkhEXK6n3Kk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9YySEnfyfXm93lZDKpUcZMnK3Owl7UPmVV0M8tXmrmbnorwXuG+Dp5MLA7NxNwj2
	 lNpLJyFdz96APUeAyJL3DyuBP+zIcdJ24PxejExWwu+px2PR3bz/d2RKQIQObNiF4c
	 2ZSzYr68ItHZO2U45eN6eMSP/XMYLQ509OFf9FXfHhkZWvbNGWAEiolYmudGdcWjyo
	 qRq329a6V+jRBXNTlkh0z+28NxFuIR+R0B80ABP+71ojQ0eBWvwCUCJjzp25x0ZEMe
	 uFA88+OHxYOWgyKlMQsNRbt3VWHm48vkYL4xWTeI8mSBmb/ztBtkJ0OhG/9+i7Cdlc
	 1Wa+VeL+lmZ2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C97380DBE9;
	Wed, 11 Jun 2025 23:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix state use-after-free on push_stack()
 err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968344511.3524559.6735332386842029341.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 23:10:45 +0000
References: <20250611210728.266563-1-luis.gerhorst@fau.de>
In-Reply-To: <20250611210728.266563-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com,
 henriette.herzog@rub.de, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b5eb72a560b8149a1885@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 23:07:28 +0200 you wrote:
> Without this, `state->speculative` is used after the cleanup cycles in
> push_stack() or push_async_cb() freed `env->cur_state` (i.e., `state`).
> Avoid this by relying on the short-circuit logic to only access `state`
> if the error is recoverable (and make sure it never is after push_*()
> failed).
> 
> push_*() callers must always return an error for which
> error_recoverable_with_nospec(err) is false if push_*() returns NULL,
> otherwise we try to recover and access the stale `state`. This is only
> violated by sanitize_ptr_alu(), thus also fix this case to return
> -ENOMEM.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix state use-after-free on push_stack() err
    https://git.kernel.org/bpf/bpf-next/c/1c66f4a3612c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



