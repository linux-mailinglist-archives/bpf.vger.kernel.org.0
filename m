Return-Path: <bpf+bounces-41182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376F6993D98
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F2B283D75
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924640858;
	Tue,  8 Oct 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAkCGqtC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D538FB0
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358826; cv=none; b=AklABRYM5NrCbi090gj12mDb5U481YEWKV/4u5UiLk4vp+aKnAjAbzIqo6pqzYr/chYj9XwXJ+/WccbxExmmBwQemh/dMptCLWxe+vOreYVpiH7jHvH5MzDjsOPqZlD37zQT55EnEDZHSxVBwBI1gTaUZ2D9ll7lQtlvp4YvjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358826; c=relaxed/simple;
	bh=S9jPewrzBhBCelpXtfmgw/dlqxLRkRIYoCwCCl8pPOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vvb0VJFo2gsKinZYcqHqdshuiuAEtXO6dtYVZgzabX0zyCf5UD+P7RLH8QOmJnZvYZPt+5VSR6CgZtRnMnXTKCtK5c3Pfe0yN4gkJMYSZnVaU6MuocpZrJcOTLbTNnfcFooPobiJbH8qAtGX1SPHonsWhDNDUEdYo9AlShUWRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAkCGqtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4DFC4CEC6;
	Tue,  8 Oct 2024 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358826;
	bh=S9jPewrzBhBCelpXtfmgw/dlqxLRkRIYoCwCCl8pPOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oAkCGqtCKtz16DkCRaKECvrdGa1h7sNkJwkD1kxz9VYg50LzumD3WBaRxXJN0hh6k
	 NukaTBuPxNTgjrrVyDat9zkmnkVJEUNTdpyQlVYCeqJQm9YiF3s5kNjMjt0DipIYLg
	 7RC2DcKGWNqnFbfwZFQNLVvMosXBmoMILJbO3/f1Cgu4qNS3uu/iK31XzRfhYwN7u6
	 zmDC0tqrlq9DLAkiCXbfM8IOIku1WaPUkyaI5/V1DyRDOFxCKhFUXlCl7njQHnpHWu
	 fuXEfPzGPgVD22WXya+pZ2P4XVnMcMIoTPq71fwwX+AfogBW1nX05AR2R2y1dRPK/g
	 zB0ULob9gLXsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711AC3803262;
	Tue,  8 Oct 2024 03:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: fix backtrace printing for selftests
 crashes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835883025.68999.15240027395216643547.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:40:30 +0000
References: <20241003210307.3847907-1-eddyz87@gmail.com>
In-Reply-To: <20241003210307.3847907-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, tony.ambardar@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  3 Oct 2024 14:03:07 -0700 you wrote:
> test_progs uses glibc specific functions backtrace() and
> backtrace_symbols_fd() to print backtrace in case of SIGSEGV.
> 
> Recent commit (see fixes) updated test_progs.c to define stub versions
> of the same functions with attriubte "weak" in order to allow linking
> test_progs against musl libc. Unfortunately this broke the backtrace
> handling for glibc builds.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: fix backtrace printing for selftests crashes
    https://git.kernel.org/bpf/bpf-next/c/5bf1557e3d6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



