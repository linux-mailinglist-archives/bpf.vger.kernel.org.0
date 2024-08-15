Return-Path: <bpf+bounces-37339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C15953DC6
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C121C250BB
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB50155CB5;
	Thu, 15 Aug 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4+x9vCP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096E155739;
	Thu, 15 Aug 2024 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762839; cv=none; b=sa/QcaYJSHDPpCkgJ74xoW1kXWjvKUiiiPmu/6pk5YVY3TWmfnbamkMGpcQ7HmX7gzbxa5dh8mR8pc1pka+5zCidOCQpL8KH2KRyj6aAUKsU9WlB9AwXwQCmHcn8v9Dlf8txYkuLGCDb0l8uNhmwgvFooCwIjlzB2jnLDGH/QWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762839; c=relaxed/simple;
	bh=BWw6kHia2dKELi4TVCjO4Oy+dvD/gyaOEG7yPErxMsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SE/2scx7Hx0Z659kurBSPUPjgdARIoVpLFCF6dJMQ+XXKTrfhcLSMD9sDu23z5ghTLaHNp5VBAmKItcBsFY/G09b0ZLERH1bgCqFEItzQOaxOwQk+fljtieYaopdB1+/pYdUS2NCgIsq3K2Itog1W2Mqq0JnJnnh1lG37aIHz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4+x9vCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD237C4AF14;
	Thu, 15 Aug 2024 23:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723762838;
	bh=BWw6kHia2dKELi4TVCjO4Oy+dvD/gyaOEG7yPErxMsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k4+x9vCPNhiUxUBUm6QzldT+Soq0MD2XlNt4Y1H8rkmnwAxpFOvCIoxIU07fPU7NB
	 eI/iK9XmpEpABlnLInf4QtC39CwlipwkYfJj/i/Myj36bvFaxWkljMZvKNDh8ptLpn
	 dnzR4douRLP4uAJYN2/zSGN3SjNg7H3xLY43QMnWDRwEEAKNzOauWFRUGv437BXBWz
	 F6G+7qxoPXYxuQ5GpPRGdxYg/pyrDOxUMq3uWewnv42bK3UN2b3tDieZ710mOP5jlG
	 65nBdYlw6Vwc4SVmLxii1MJ6uyr9pEjSisPKfKhbYZz8nE0cgFdYpZw+qI/gbLtEhM
	 oLga5t0+8c09Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F16382327A;
	Thu, 15 Aug 2024 23:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: fix compilation errors with cf-protection option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172376283799.3058964.8728018764972507383.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 23:00:37 +0000
References: <20240815135524.140675-1-13667453960@163.com>
In-Reply-To: <20240815135524.140675-1-13667453960@163.com>
To: Jiangshan Yi <13667453960@163.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, eddyz87@gmail.com, sdf@fomichev.me,
 danieltimlee@gmail.com, linux-kernel@vger.kernel.org, yijiangshan@kylinos.cn,
 wangqiang1@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 15 Aug 2024 21:55:24 +0800 you wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Currently, compiling the bpf programs will result the compilation errors
> with the cf-protection option as follows in arm64 and loongarch64 machine
> when using gcc 12.3.1 and clang 17.0.6. This commit fixes the compilation
> errors by limited the cf-protection option only used in x86 platform.
> 
> [...]

Here is the summary with links:
  - samples/bpf: fix compilation errors with cf-protection option
    https://git.kernel.org/bpf/bpf-next/c/fdf1c728fac5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



