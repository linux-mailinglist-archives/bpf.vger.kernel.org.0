Return-Path: <bpf+bounces-43462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D425D9B58D5
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D81F2387B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28D282F4;
	Wed, 30 Oct 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2znUWjr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E71EB56
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249422; cv=none; b=ZtzTt5M5sCkcjnbpFObO22rwjw+aJOmRl/L9klnwaVIaocJedFt88W/BUmZiiO9s6uIj9FUA+OIhzeYmQ5hO6YiFDxm5Rfb5BrDVGUnr3HQmIeAnkUFlXjobfmT/4Uq7YfE7V8HQNV1ugy+3J6x7HWFSbC3wao/fwDcgQ7DtoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249422; c=relaxed/simple;
	bh=QsgYog+rXBl9JXro8jUft97mmVR+lxr1EvdysEKyHQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QaSrI6PAFaAXKE+sg+Pqi0eyxNInsfCS5DAw9Sv22z8BL5j+CpI86IsSl5M9KEVoLwgjYxXtm8HzRgTLkxq8Z4ouI0aFU0et4XwNORCfMAE21PGAKhg1HdgmCSQbppADX9pxmqDTFm9c2cuxYQHo1e7gecU9om3KARP8lqEhjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2znUWjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCDEC4CECD;
	Wed, 30 Oct 2024 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730249422;
	bh=QsgYog+rXBl9JXro8jUft97mmVR+lxr1EvdysEKyHQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2znUWjrfiKTG0Hezj7IWiA0k+xGynAOuAtJ/8se7DhAB4hbVCSh4/rl8rf7Ktpeo
	 7PlXRvOYK5CyrfCeBplz0Fxe6I/EmJcU8aepSqhV5NjJGbjNA1k3LrQdO2XVUNqamC
	 6ktS10Ulob0IGlqPoC3aPQ1OmJO0EzxOWQFnFjYYI/35gy5OwtGVjZ3PCF7XwzES/Q
	 Wb0nURpu4bt/OQ09yzsNoQTZCZ0TSrbVAnC1dCiRTVv4wz3+F2oVKGRJxv05Ehe5X5
	 EjRH9jfzBmQ5xroZYhAj91qEp1pnycbLyKzHvn1bdc4Yph7bsWJLetT/v2wUuQ6xUs
	 EhS5IaaIEOWFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F9E380AC00;
	Wed, 30 Oct 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: drop unnecessary bpf_iter.h type
 duplication
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024943001.871309.3321429707344187461.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 00:50:30 +0000
References: <20241029203919.1948941-1-andrii@kernel.org>
In-Reply-To: <20241029203919.1948941-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Oct 2024 13:39:19 -0700 you wrote:
> Drop bpf_iter.h header which uses vmlinux.h but re-defines a bunch of
> iterator structures and some of BPF constants for use in BPF iterator
> selftests.
> 
> None of that is necessary when fresh vmlinux.h header is generated for
> vmlinux image that matches latest selftests. So drop ugly hacks and have
> a nice plain vmlinux.h usage everywhere.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: drop unnecessary bpf_iter.h type duplication
    https://git.kernel.org/bpf/bpf-next/c/e626a13f6fbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



