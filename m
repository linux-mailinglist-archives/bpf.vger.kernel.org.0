Return-Path: <bpf+bounces-20646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5D8417D6
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771171F2558D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640134CDE;
	Tue, 30 Jan 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6zXyft1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF31E486;
	Tue, 30 Jan 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575825; cv=none; b=C8Qmv24fXzKH55tPbqoCMpe0hmaPyw1FBg5rccHZeM86ey/hQmM14vxuvKIreXRURMOPwabVqbU1MUcuzBjC0RaF2An93ZUwusm1zrzQCJbkgH/8mFUnnEGq58SRxYj+YaM3/GmD2EWsKdNGNaHtArFfSRZ+OWTkvJtUK3tmp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575825; c=relaxed/simple;
	bh=2K8jBWaEyMo8eKMem30LVGs//xEAxTJwO8LKiRT1SXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BovKTArhJzemSCTMUotPxP07zbhBc7N4lBkr9Qf2l9VDjotJ/wj25jbdvZY45dYq50WgvY6mUUX5vA2EuSEcXtR+fgmqu0CduUDS4UN8wTqWxYscxC52j36eUf9lm9QJgd682f4OOu5paoGFo6q/oV2xD63SFJPZX6kapLu179g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6zXyft1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7233C43394;
	Tue, 30 Jan 2024 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575824;
	bh=2K8jBWaEyMo8eKMem30LVGs//xEAxTJwO8LKiRT1SXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j6zXyft1iCHGI+lTSbogs1drp9hyoyWkAxPhZHiZ3CoY2q9Lk48mNa0l7o7chelSX
	 CzTkJTZJt8n4KxhFIRYKgEs2klVWfzNmdQJ8hhl0yI0QrIM5iCCqoIkL1SjIYC/HPh
	 6xm0PxhOUxYbrOvmVKUb5qcwhfMwJSzCQVj0+ypxj06eJk117tYWtpPl+Y5IGzV4Vf
	 1/k2gflGYGzvE7OFycRXjqz2F/7z9n84+0BN+UJgZNdXR9wsYCOPOzeLy7OKw+YCh7
	 f3CepePUtb1Vlo+QSb/h3dF6Zrtc8x6VmbI+o2gej2d2/5Hs6oHfDKf4kIj3uwhNSO
	 hMSEHk0LFMh0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE5E7C00448;
	Tue, 30 Jan 2024 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] libbpf: Add some details for BTF parsing failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170657582471.7562.5549307900236882760.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 00:50:24 +0000
References: <20240125231840.1647951-1-irogers@google.com>
In-Reply-To: <20240125231840.1647951-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 25 Jan 2024 15:18:40 -0800 you wrote:
> As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> valid kernel BTF" message makes diagnosing the kernel build issue some
> what cryptic. Add a little more detail with the hope of helping users.
> 
> Before:
> ```
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> ```
> 
> [...]

Here is the summary with links:
  - [v3] libbpf: Add some details for BTF parsing failures
    https://git.kernel.org/bpf/bpf-next/c/f2e4040c82d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



