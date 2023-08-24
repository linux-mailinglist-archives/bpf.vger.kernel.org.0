Return-Path: <bpf+bounces-8489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC677873EE
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E29C1C20E2C
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4112B9F;
	Thu, 24 Aug 2023 15:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7010979
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A318C433CA;
	Thu, 24 Aug 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692890425;
	bh=qcaxRQes33clcsBtyUcSUxvpFzB8w8KpBKdYiso6luw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aB9h3moxqrFSoQkIVmnGLGa8Zu4yr+lhBifm1Z+ZsfhO8VJFt4TcwevwKxCOJAOWx
	 BdNANy4T2WtfbeESnilGGnYdxNUv9Rdv5qrt8M6JMYqXmBhwN4mOX9Rux9ieaXVuoM
	 748TVdGCWpuI2KnomzopIJ0Q/Bv1454y6u7g7uPFX4xxQgAtS7Dds6eNZqBmQzH+CX
	 +cOVQRO8Fq9kvkBAd+Xciml3okgRfihNvJFkyPth/pcweGRC4jTya+9lh8BJThju6h
	 viX0GIm9bKSV9BiAtv3HlyESB6vhyOKbAM95pmeJWW3ajKTYLMDCdxTbBZ+8NI1l7y
	 q2OoCgpVQ+SqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51154E33094;
	Thu, 24 Aug 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Remove a WARN_ON_ONCE warning related to
 local kptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169289042532.8092.10627981183140434594.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 15:20:25 +0000
References: <20230824063417.201925-1-yonghong.song@linux.dev>
In-Reply-To: <20230824063417.201925-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 davemarchevsky@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Aug 2023 23:34:17 -0700 you wrote:
> Currently, in function bpf_obj_free_fields(), for local kptr,
> a warning will be issued if the struct does not contain any
> special fields. But actually the kernel seems totally okay
> with a local kptr without any special fields. Permitting
> no special fields also aligns with future percpu kptr which
> also allows no special fields.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Remove a WARN_ON_ONCE warning related to local kptr
    https://git.kernel.org/bpf/bpf-next/c/393dc4bd92de
  - [bpf-next,v2,2/2] selftests/bpf: Add a local kptr test with no special fields
    https://git.kernel.org/bpf/bpf-next/c/001fedacc907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



