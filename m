Return-Path: <bpf+bounces-28495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3228BA6EA
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 08:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFED1F2281A
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 06:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF1139CF1;
	Fri,  3 May 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxkmRKHX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738D1C6BD
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716628; cv=none; b=PfO3zYrpmQA9qYOhwSKVuN0ejjfZC+0J0CXAxCdFMFvETd+wX1dTHIaxtuubghXY2tXdUHIKnmEpiqbalD7OWYCajw1SCafP8LsnPqNnqXYFnRNoSIGT6Y8SKa5FQfOeMM9trWHwADtTyYWyTNRjus+Fb66FHZv5L44tFGbGQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716628; c=relaxed/simple;
	bh=q8Y3G7xC7wv4CNBqJwAv7n4uHB/3+/kRcT/1pyVUa6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AuojV0v/bYsE6OfAL2YK/dN4oII7GyVuCSPW9hwxjahOjxlYP3XVqN5rx9o5VBEHtLXYTDOhPbZEMl8xR5ltgjaEu9zL4mkJL2z1OHI2KaDxEXhp0p01Zz2hXtRDyM3UPJ9xbwMID7STEez2ULuN8YrkCHToZBRe4c7Y64/90Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxkmRKHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB1C8C4AF18;
	Fri,  3 May 2024 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714716627;
	bh=q8Y3G7xC7wv4CNBqJwAv7n4uHB/3+/kRcT/1pyVUa6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UxkmRKHXEQgfjmMlsU2zVoMQVNeqlnTKKTmyU4KETHLlTnTKqPm+gDq6apNasJJmi
	 TUMaqBqqcgl5CYynbSOmHVMH/m70hRSO3V/56W6x8Vgux3MSFgHWuCghh63tWzOTKg
	 xZDuf3JzghUjfwcStTzyFBy5GhF1a/umK+AsEy+ao4f51bteUC/3ELHOulEjBI5QNY
	 +6F2BWCPCFKLQoCK46RDFIMP2F2Q+UJof6nKEtC8GVfTLPCZDy/xCpfo/LTB5x8AIK
	 gc/Ihd1eYS67Dv6nSbhAFbvA/kELlpK98yNUnKTjZjuTcOrScgoDxYxGDmA9eZD/Rg
	 zaRxXxYqk74VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A31C8C43338;
	Fri,  3 May 2024 06:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf: avoid casts from pointers to enums in
 bpf_tracing.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171471662766.17090.15300759896796743808.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 06:10:27 +0000
References: <20240502170925.3194-1-jose.marchesi@oracle.com>
In-Reply-To: <20240502170925.3194-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, david.faust@oracle.com,
 cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  2 May 2024 19:09:25 +0200 you wrote:
> [Differences from V1:
>   - Do not introduce a global typedef, as this is a public header.
>   - Keep the void* casts in BPF_KPROBE_READ_RET_IP and
>     BPF_KRETPROBE_READ_RET_IP, as these are necessary
>     for converting to a const void* argument of
>     bpf_probe_read_kernel.]
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf: avoid casts from pointers to enums in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/a9e7715ce8b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



