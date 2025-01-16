Return-Path: <bpf+bounces-49131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F461A1466D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144A91668EC
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85386244F92;
	Thu, 16 Jan 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkSj8/V7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B81243870
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070209; cv=none; b=fETySj+r1XEOpWRy+BWayigCkSmwRpBlfFducfTRNUDDD68NI3B1cKQ5JEU2Ex7NrXdl6JXU4PyuAQSTwhKAJvRiHz90iY6tTq6yMCAm4K5mC4p/GmUbHLqQ+rA5nJL1zUX5cay2QvRaiazjWNxAIaWNK69oaVYpJKUEEu0dHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070209; c=relaxed/simple;
	bh=qtppu4DHCZUbudAGxZX6ANXBidchvH8eWj476x9JOkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E135UCZVVF0RtwFVlW4/VPmwN+7lNvo6wO2ovczwpHWOhEsyWOr1TZT93yLjZrO/SJYhFHqnyt7vWgvsCLyvNAVhWGu9tx9AxRNjjSH8p8Q3V3n5VB1mghYo9tO8OEp4WZnf4GaatOvfitZYXT1ybL4/vk/7jGClfGq96USdIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkSj8/V7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4DFC4CED6;
	Thu, 16 Jan 2025 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737070209;
	bh=qtppu4DHCZUbudAGxZX6ANXBidchvH8eWj476x9JOkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KkSj8/V7AjYeU+yUFVKpezckIwmVRe6hvcCKW3Nm0qjxEg8VIqCiIs750ZzNAyCzx
	 f9LUbzGidqHiXiJh4yvIEGeD+ohyZsXeGTVBRQaNtNx32ECZEmfOYWY5w9TufcaDUF
	 iX2H9+P+emNj94pwUyk//JGESXUDYe0cdH7T7bri1OQ68ds+GSZ6q8oHMbTnbsQ4Dp
	 Sz2K1/ZigPNZUFolFrcU9F0JNgccQ0EO4RLYm3y9iGe9vznmh933EGYPsv2kLSpgds
	 VAqWruditZztTjrhtbyF9nE2XzOEdQ2Q+OUpmxilUbwBDGqEATTePvkBpyIzC1PxoQ
	 ZKyoRI1X3uyLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F1380AA63;
	Thu, 16 Jan 2025 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix undefined UINT_MAX in veristat.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707023227.1619724.5787640490693896648.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 23:30:32 +0000
References: <20250116075036.3459898-1-tony.ambardar@gmail.com>
In-Reply-To: <20250116075036.3459898-1-tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 15 Jan 2025 23:50:36 -0800 you wrote:
> Include <limits.h> in 'veristat.c' to provide a UINT_MAX definition and
> avoid multiple compile errors against mips64el/musl-libc:
> 
> veristat.c: In function 'max_verifier_log_size':
> veristat.c:1135:36: error: 'UINT_MAX' undeclared (first use in this function)
>  1135 |         const int SMALL_LOG_SIZE = UINT_MAX >> 8;
>       |                                    ^~~~~~~~
> veristat.c:24:1: note: 'UINT_MAX' is defined in header '<limits.h>'; did you forget to '#include <limits.h>'?
>    23 | #include <math.h>
>   +++ |+#include <limits.h>
>    24 |
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix undefined UINT_MAX in veristat.c
    https://git.kernel.org/bpf/bpf-next/c/a8d1c48d0720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



