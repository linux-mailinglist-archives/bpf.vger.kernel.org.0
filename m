Return-Path: <bpf+bounces-69473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B957B97587
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB65321647
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2852302CC0;
	Tue, 23 Sep 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkLoqVsf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3A3019CC
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655810; cv=none; b=Vg3f3iORELpmKzZ5m1rLuOEzESMSq0Xzm8zyWms2pRgzeAbiwWotIUtFM4sjkP6edmu4Wbyivusigfh8Jtbu77OIdXhSIQyWG2ncWkiT53qTRRzPIcVeIf004DYJ3pXrYCEopqjvGWqB49cpoqOCl9r6X1gKgRnJQFvsTLtnVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655810; c=relaxed/simple;
	bh=Pk/CgtKUk15i2bJ6bzLxwDR2ZX8Pw/QjZ5V9LdKjhHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BYBRyC9pbqY1tVsqz6Na6NEMC8B+u+8VE6gpCpPIKQ5XYvKJYEWJBTpNIEJyvS46H0Lw8wtW05LG3zUNRF4b7iGAKT7X4VdIGluw0QXe1zLhMIUjN0LPYPm/fQXKTC0Oydnkr/naK18zfiYSpj2zDAnDaWkreSQKaQglXvcZu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkLoqVsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69AEC4CEF5;
	Tue, 23 Sep 2025 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758655809;
	bh=Pk/CgtKUk15i2bJ6bzLxwDR2ZX8Pw/QjZ5V9LdKjhHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fkLoqVsfgOY/3eZtrt/bUe6MTxh/cR1UwMMGfpKCQUR4tiax8ooPq8ZZt1l8EJxev
	 /IWVD5AideYBzNH1fj9+5xAmobk4ofv6I5DeRHLFGL6RzhKlPQVTMK6ZrxHE1wixqS
	 ie7lH+V0GoCZVgQucFFOa2F+IOQOcE12lkGXD2mJvib8ntGpWlYnV+/zZqNXOWaZ2+
	 U+TMa6gSCkWqPTOIpJa8UevbACY2Wwp4hbds3MsmG3hWAKzRZuF0tc1AOT0vjlBlc3
	 XPPYJY2XT754q1dzzpPWxizBheMhFHgXOPyyGmJiJhst01IBMB6fhRh68BHFMpWdQ4
	 kvSwoshKBNJkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA139D0C20;
	Tue, 23 Sep 2025 19:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Add bash completion for program signing
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175865580676.1896816.11157154943663251448.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 19:30:06 +0000
References: <20250923103802.57695-1-qmo@kernel.org>
In-Reply-To: <20250923103802.57695-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Sep 2025 11:38:02 +0100 you wrote:
> Commit 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> added new options for "bpftool prog load" and "bpftool gen skeleton".
> This commit brings the relevant update to the bash completion file.
> 
> We rework slightly the processing of options to make completion more
> resilient for options that take an argument.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Add bash completion for program signing options
    https://git.kernel.org/bpf/bpf-next/c/0d3bf643b41b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



