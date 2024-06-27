Return-Path: <bpf+bounces-33210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A99919BB8
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A058A28146D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E817F8;
	Thu, 27 Jun 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuBWlRcn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452B1367
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719447629; cv=none; b=jOate8BFlxtBxK2LZhTsDT4Y23Q1HsQh1CQSjskmRdwm2WYfl/2Yuub/Kw/HunjZZm48LnGLJ/sbffOwwtEhtM4RbLWAYD/8ynTqa7Mi1XDF+66n857UyTH8Yh8oFNIsaJMhiHOFgzQUQMXntwHlrwG9iXUOYqPGDOZ3uAU7gl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719447629; c=relaxed/simple;
	bh=Au296W5V6+Yf5cv/kuovhAB7iFdoAP6MiDmFW8ns8PQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PLgO8A9IfJyUbV8f5oxlBO6/96GsGOlp9Qnuzh2YSs5vDhmk+rfn9fi1iOcpx4O7lbUswZa9f2ltGr0qKTwmigYK/2THDp/ZoZUxElkg3ikJrVCm77hNRnMn7Inym53Ny9HFZjyZyUpPDdxvQrBz2gGzXYO3+IvsQeiRHnRlSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuBWlRcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A63C32789;
	Thu, 27 Jun 2024 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719447628;
	bh=Au296W5V6+Yf5cv/kuovhAB7iFdoAP6MiDmFW8ns8PQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tuBWlRcnsB1ozQtx1q4k1+PEPALGWlx+WCg6zyLULyf8ULQKjRZvUMrz91cWLSYKZ
	 QDsQwc0gx9vqibYhEKz19TEqFvTktWGZ7Mt54jlVSkd3eAQMDgeES45HnQP+SJja90
	 Tj3DDdduKzCL/u3nnqWmvnlfnLiAnv9eVFUWR61he7KQRwPTQ7hNnUpmunF9+maRBu
	 YZirxQ9QrOTUAAjFdsABDqchvnWLruox7/6d1vVI4VdXpPJPzSebM+5i+HSAO51ON3
	 IdJ4Ie7n1h0miP3ykj5E3gra07LOUvZSgxGW75xF+pebmwtacO52qwpkUyvimY5vbE
	 7xsaxyPWNiaEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0BF3C433A2;
	Thu, 27 Jun 2024 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171944762872.21717.4688853708632719826.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 00:20:28 +0000
References: <20240626134719.3893748-1-jolsa@kernel.org>
In-Reply-To: <20240626134719.3893748-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alan.maguire@oracle.com, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@google.com, haoluo@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 26 Jun 2024 15:47:19 +0200 you wrote:
> ARRAY_SIZE is used on multiple places, move its definition in
> bpf_misc.h header.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
> - wrap ARRAY_SIZE macro in ifndef/endif [Alan]
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
    https://git.kernel.org/bpf/bpf-next/c/a12978712d90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



