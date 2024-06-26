Return-Path: <bpf+bounces-33199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A7919B54
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CA7282062
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F2B1946A3;
	Wed, 26 Jun 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJY9+Flp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C91922FE
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445228; cv=none; b=CAysLiprxtH1UwjO4qcFgr2sFiNWuSf/I1xzRj+l+LZIAIGxNeL7UBdhlEOaY8U7OQLzcHxMmSG5HiMij68sOiSqpyH5qR9f8myuCG/LA8R167HTXMYLPDdGPUTYRrwqgzXFVuc5AomBEA0ZzaYcFJS/PSh0bbNzqY4PFcKzp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445228; c=relaxed/simple;
	bh=YIwMygV/EZkHc1B7rsX6rWL3BV3prvoPq2gXiDIyWZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RKESVuW+ygyBHxyXYoULn5x1IqwD8K81YzG8jvsXCW3gptXm4oh7QwldyUBKu71PNpbdQ+kiPUg8Zg0AiwRMk14FRIHK3jFOLXZ46cmujsMGXKva2RGqOEs8fgRL8+kWGe9IZsGzEsOLFmbkRIm5BT+JMJXeKVZGAJ5Dzp1WWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJY9+Flp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DA6FC32789;
	Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719445228;
	bh=YIwMygV/EZkHc1B7rsX6rWL3BV3prvoPq2gXiDIyWZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZJY9+Flpqomp5cEIFJoW9qZMcSxQhNV/R83uOObqS9UdKtgPIYnrRwKffKgpDEhOG
	 oFBjH4mPUc7SMPAaHnC3YOcLYrfRAL0G7TvBX2uI7GV7rFhc2TEanSj3R/ZDNzYtTa
	 7qWQ1rUcIf6v5r+A+jDVQI5F1ZmkMEyvf98T/urJCLVICNwMMUxPXNhqOuEp79S0II
	 QH8LUAX6jxO9gu387HTftbhYuZWLkq2xXWd+6kCB68ZxcdFgS6qEgjN0rhRk+0+6L6
	 HGVk+4KPP5gcy3naRfZNYoP3Z0dI3HKfQjalkbHeudq+tSfRziey4u5S99pLhb/yfG
	 xkyWIQvXb+3iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D701C43446;
	Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: fix clang compilation error in
 btf_relocate.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171944522824.32321.11758226100316788839.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 23:40:28 +0000
References: <20240624192903.854261-1-alan.maguire@oracle.com>
In-Reply-To: <20240624192903.854261-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, acme@redhat.com,
 daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com,
 thinker.li@gmail.com, bentiss@kernel.org, tanggeliang@kylinos.cn,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 24 Jun 2024 20:29:03 +0100 you wrote:
> When building with clang for ARCH=i386, the following errors are
> observed:
> 
>   CC      kernel/bpf/btf_relocate.o
> ./tools/lib/bpf/btf_relocate.c:206:23: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>   206 |                 info[id].needs_size = true;
>       |                                     ^ ~
> ./tools/lib/bpf/btf_relocate.c:256:25: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>   256 |                         base_info.needs_size = true;
>       |                                              ^ ~
> 2 errors generated.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: fix clang compilation error in btf_relocate.c
    https://git.kernel.org/bpf/bpf-next/c/0f31c2c61f69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



