Return-Path: <bpf+bounces-3169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DB73A7AE
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C449B281A3A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7F200DC;
	Thu, 22 Jun 2023 17:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB8200C7
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADB74C433CA;
	Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687456220;
	bh=uXMcv50YZrV44lRrzHLNryicbcL5bw4mfure0TXWuqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I0CVtA/XuRYmSK7sLzMNzNclJZ6yqst1BdrfKV9DkFtK5M1GaORHjksHECFnm+YcM
	 gEiIkhJfL6uXFEhUey5sl4OnNtQ/4G30eyNTbANO9+lr60QWZpsnn+IuC8Dtz13vKj
	 qMPNJ5VQuIujHFJ0ia6Y5a9Q5XWNInoG2J8tfcfdEoHncesfMP8vtU5K0XsRgY1Ft/
	 6nYjB2dj5f/tgH2Ngxm3iq7FhIeQyY/iku4b6NzyPBsREsipfvEPgyapI2fxlOo/Un
	 Iiz2eB1Xl0vsFhxUkw8wprUe80mHOvcmTY1oTjwULTlO0EAkcSMepxDMV+VhfzQ4bf
	 eFQ34zTYZdZSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AE78C395FF;
	Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: document existing macros instead of deprecated
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168745622056.7216.13092598536929315129.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 17:50:20 +0000
References: <20230622095424.1024244-1-aspsk@isovalent.com>
In-Reply-To: <20230622095424.1024244-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, void@manifault.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Jun 2023 09:54:24 +0000 you wrote:
> The BTF_TYPE_SAFE_NESTED macro was replaced by the BTF_TYPE_SAFE_TRUSTED,
> BTF_TYPE_SAFE_RCU, and BTF_TYPE_SAFE_RCU_OR_NULL macros. Fix the docs
> correspondingly.
> 
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: document existing macros instead of deprecated
    https://git.kernel.org/bpf/bpf-next/c/fbc5669de62a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



