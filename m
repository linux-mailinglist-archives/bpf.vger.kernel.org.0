Return-Path: <bpf+bounces-61999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C04AF041A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C94189B2C9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A7283137;
	Tue,  1 Jul 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwUqkTKo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09270281353
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399385; cv=none; b=eb5hNB0QIFNv/6aMKDa2HZwwC3X3KlVCOWuQ4TJ1uIe5O17CybbkW/24sVuv3BYYN99mAySHnWABeylpQlzvrFeWBVukCVkI0mCQEfzMUtemWE2sPe2fNxN14ak6bXEhAiqccYCPH/AbuCiJkcmcJsOD6J9C+CoJ/Sq+11OPuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399385; c=relaxed/simple;
	bh=mUjHLVK4zEVnf++3L4qJ2JAu5tqVtEOA8/K4ycE+r7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C1AS6ZxR2bjFX2mlGRXGEMETPsJMM4UzPmAzu7NHRuQwqGueFiJbcUd9zdRjO1vSTeEUZXKqKnHVL6YpMukims8HO2II7NETPkxxumNYf0UJt2/GOT44Xlu0Z1WPjhSthDK4oQzcussjdWnRGXZ0AHNs7T4dMwd3uXCpNU29TME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwUqkTKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52E2C4CEEB;
	Tue,  1 Jul 2025 19:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399384;
	bh=mUjHLVK4zEVnf++3L4qJ2JAu5tqVtEOA8/K4ycE+r7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NwUqkTKoY1DLr2A71yNp30Q2MrPB/bNSv5jn2pfncS0fpbYBh5ZlBLZVk5Xx0ejTq
	 cBEOYayS6RZMk56jB2yL/ieYsZKseL0oAu6tScIA2SPlWQ2HW9uE8lQ1FnJDdIoHom
	 rNj1L5qqN/g4qFKWOgLHlCCmbWa7fL4oAkWJJueBGIbWxVlE8VCsq+qBNKYa0RyBPX
	 lKz9U/4rnJvaPSRsPE6XZnBQ+G+F5wcszS4YC6zKnfC7s+MQqa7kfPv9dxjAYg7C83
	 KvyhdAQelPJ6VUyVjddzcFqoxLpxUs2qmQ/ie+UDajz8uCg7ad2llUyA05CFVrlt0e
	 elUrWy5jMHLaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB261383B273;
	Tue,  1 Jul 2025 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Warn on internal verifier errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175139940975.99585.8430581767252368457.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 19:50:09 +0000
References: <aGQqnzMyeagzgkCK@Tunnel>
In-Reply-To: <aGQqnzMyeagzgkCK@Tunnel>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 1 Jul 2025 20:36:15 +0200 you wrote:
> This patch is a follow up to commit 1cb0f56d9618 ("bpf: WARN_ONCE on
> verifier bugs"). It generalizes the use of verifier_error throughout
> the verifier, in particular for logs previously marked "verifier
> internal error". As a consequence, all of those verifier bugs will now
> come with a kernel warning (under CONFIG_DBEUG_KERNEL) detectable by
> fuzzers.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Warn on internal verifier errors
    https://git.kernel.org/bpf/bpf-next/c/0df1a55afa83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



