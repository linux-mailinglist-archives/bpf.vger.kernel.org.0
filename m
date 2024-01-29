Return-Path: <bpf+bounces-20630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93E841533
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523441C22CE0
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606931586D9;
	Mon, 29 Jan 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcVXjAJu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810D266D4
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564424; cv=none; b=Qrfj3QEQTsVFJAyRUcNDNpnmJ3t7okqJSmxwEUQrg+Jklcufs/MjX8pWzoERdyKdYXnjl7GGPaalpLbxcAKSYYHDDSYSTM9zwWsmLjotWP5GEUw1C6VEXqA/RUGWRGgeArCSYHOAqzWN6ar0Csb4VOOkQ+gus95a1AdMKF/eY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564424; c=relaxed/simple;
	bh=WJrKi70vcAlQZNNX6pKpINy9oPZ5kZSx0JRBbyiy3Ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=prf3xcOxaIGSrQLPr8fXK0rfGLtOyhYDKX0+LhEzBIyR8/Dxgxu907Yth2nd1vVtHWB6OfPmdDL34H0ecicVZZtGLbQsNWyXkFXmQJ/KwXkb2+7BoN7vASTsAei18acRVBy8HGDZTRyt0h3513pZXw88Uqg40NqfAGpxhLo1424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcVXjAJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99209C43390;
	Mon, 29 Jan 2024 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706564424;
	bh=WJrKi70vcAlQZNNX6pKpINy9oPZ5kZSx0JRBbyiy3Ag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CcVXjAJut2s6fnZ3TZYlF+AnB6bwaPGVkjZv6geUi0AOBrR3S9x/3kPivtccufmHW
	 KE1jreUi79wgQb6toqcsAoHtpfy5kmul7hAJSMn/9MJN4p6xH7hBFz0UWCzVLmbfdA
	 U0wMiodJ0HeOtBqIb3r6ATryv6NTJsIfIDdDlYe4dDJPOHK2uikWBezDWB535LBrQd
	 THlID0qM/gT29uGkwQukMuFKdBm9ZKc8AmrkuQhFnapF91lrWee3m/jcy2lfwhG56r
	 zYCUymJce92jlKdcBxeXp4U0WH+YIaR8iIMzTHSxUZ9zcmsR9aBOwVvf5658/SiUPJ
	 ebbnJB61Rs4uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8025BC00448;
	Mon, 29 Jan 2024 21:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] bpf: use -Wno-error in certain tests when building with
 GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170656442452.7127.1356888671511922005.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 21:40:24 +0000
References: <20240127100702.21549-1-jose.marchesi@oracle.com>
In-Reply-To: <20240127100702.21549-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yhs@meta.com, eddyz87@gmail.com,
 andrii.nakryiko@gmail.com, david.faust@oracle.com,
 cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 27 Jan 2024 11:07:02 +0100 you wrote:
> [Changes from V1:
> - Build rule simplified, as there is no need to use $(if ...)]
> 
> Certain BPF selftests contain code that, albeit being legal C, trigger
> warnings in GCC that cannot be disabled.  This is the case for example
> for the tests
> 
> [...]

Here is the summary with links:
  - [V2] bpf: use -Wno-error in certain tests when building with GCC
    https://git.kernel.org/bpf/bpf-next/c/646751d52358

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



