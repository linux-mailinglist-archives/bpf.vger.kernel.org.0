Return-Path: <bpf+bounces-63536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F9EB08284
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1FA1A649FB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B651DB127;
	Thu, 17 Jul 2025 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9Y+5rVg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2491C8611
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716399; cv=none; b=qhL8FqJSpCRuAajth7sEj9k4/UtB8lQLrZN/CME6c4Ei2U3ju5dl9nQv18pdfT5TQK4nGXFFsEpez98OKlYpXXHuriwyOXwOa68eBLrX7rNspfg7I1YczLR5pLLA+XmlkpZmf8Rxi/+3c3Opan2BsCjqyDzAvjw2sinSF1keWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716399; c=relaxed/simple;
	bh=nWldhSsCnmzTbfn6GlL86dwSCg98j5mvwBnpn52mtF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JVBFPJVwP7TJTGXnPSgDvl/VKHfEnLoE22pOqn5TY7163m/s7nJtMLe3KetsL+OvVbecBh6W3Q67uXGx/A/1iXySwI1vFvFzqm6akKqsRAFfFoSRFcnpSh6s4MlyLUs/EutDkzNgY0j4s4ylgqACrlXgpk3VlsQpwGIdp9dE7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9Y+5rVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D25C4CEE7;
	Thu, 17 Jul 2025 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716398;
	bh=nWldhSsCnmzTbfn6GlL86dwSCg98j5mvwBnpn52mtF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g9Y+5rVgjhKR1Fbqv2hDcCcB0s+fjEj6ve6HSjX98HM0r0OxqVT1UUbhKVCmVoMvp
	 qa/F43jCMZVR6KmwOOVh3EBprJXd2vyRTp2bmKYuQmzZmX/tcBevhkxd7l6O4BuOV3
	 uqRHVsLf3OHK+XFuOYUAWveyvwqD7mqqkWr3LiQoWqle546q40CwFOslVAjNRLU7V2
	 gaj0kbROhNzXfTCC/wDfwkWFdl9lKqC8KD6bno2OpC6BZhcKoZeeS4yYZdMrnIdDLx
	 Xkmat7fR7izS2VeFdhz7jIJXUsctg+7GZ7vUH5BSxxuZmx0rxKabDwH+R9SCnQ52b/
	 7qUVPnD8lm9SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3398B383BA38;
	Thu, 17 Jul 2025 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Update iterators.lskel-big-endian.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271641875.1391969.4111042012922252421.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:40:18 +0000
References: <20250710100907.45880-1-iii@linux.ibm.com>
In-Reply-To: <20250710100907.45880-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Jul 2025 12:08:50 +0200 you wrote:
> The last iterators update (commit 515ee52b2224 ("bpf: make preloaded
> map iterators to display map elements count")) missed the big-endian
> skeleton. Update it by running "make big" with Debian clang version
> 21.0.0 (++20250706105601+01c97b4953e8-1~exp1~20250706225612.1558).
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Update iterators.lskel-big-endian.h
    https://git.kernel.org/bpf/bpf-next/c/1f489662fba8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



