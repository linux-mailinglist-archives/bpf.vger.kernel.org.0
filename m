Return-Path: <bpf+bounces-44927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043C9CD636
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 05:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C04128185E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D6156C6C;
	Fri, 15 Nov 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARaFjhKQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62335674D
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645019; cv=none; b=ivfwedsjGoQUanQgGQxeoQJPGJTYyC3biRwm0HwGT6hHsT5pcYcsdCOvIRFQ4D5Ua6e9MFg4m13M8tiK2gauvgNB0u2QU7is1O+KCmk53Xky89mHhChRi/XXS2SqEWC7Tb99qBgIp3D6zvmyL7ZMwm9e34pfrdDaclm3B2mvWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645019; c=relaxed/simple;
	bh=gb5MH2SkV2HUSvDA0MIPZ8WGqZrYQY8ngtCtDZBc2Dw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JcWkY7mPcBew0U0z830AbHmBQp8Lny7WqdAhsuVAvDSweCI7JLNtvUnrUJr3QSNlVS08JjcNVy2hkzbq+soas4W9zC3zWkjed8jVWxt01W561Ag2MKo3nVN1/c/J2w+eech9n1b/pK5e7PHlZkOSs+E5wR5rwlEBqVluSMBOE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARaFjhKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B4C4CECF;
	Fri, 15 Nov 2024 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731645019;
	bh=gb5MH2SkV2HUSvDA0MIPZ8WGqZrYQY8ngtCtDZBc2Dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ARaFjhKQMowEEPofxL63CUAs4rBdPDxX0wZ+0eJ0vg4Ge4xJGfkEkbqcRWb4F6OxF
	 k+hBWCoXMlqoe16FYtQ4Iv5RXg2zL/42CIOyW9aszzp4A+o1lFZdqWVBll3R1Uh4Tj
	 FMXLEKdHBVlq6H4dAbqfkOsIUol7dL7fxPHHbc2fCAdMVEDd0Oa5JSBg+aEMrxjpyj
	 48NHNWFAWR/0nl193qujsSgBzyoB4XX09i1SAudjN6tTXdLCfK+FgvB1YfAdi/HjnC
	 Wyx1j35sEq8ZrsCSZ7x6L3Vpr4ZtO64uaI+1Cq9srF4owVkO/RiagouidWPbXlyt81
	 ZASH6zhJyqUQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FCD3809A80;
	Fri, 15 Nov 2024 04:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: set test path for
 token/obj_priv_implicit_token_envvar
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164503000.2149970.2767573372764815163.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 04:30:30 +0000
References: <20241115003853.864397-1-ihor.solodrai@pm.me>
In-Reply-To: <20241115003853.864397-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 15 Nov 2024 00:38:55 +0000 you wrote:
> token/obj_priv_implicit_token_envvar test may fail in an environment
> where the process executing tests can not write to the root path.
> 
> Example:
> https://github.com/libbpf/libbpf/actions/runs/11844507007/job/33007897936
> 
> Change default path used by the test to /tmp/bpf-token-fs, and make it
> runtime configurable via an environment variable.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: set test path for token/obj_priv_implicit_token_envvar
    https://git.kernel.org/bpf/bpf-next/c/f01750aecdfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



