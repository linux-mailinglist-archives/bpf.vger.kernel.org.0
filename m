Return-Path: <bpf+bounces-7052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3C770B96
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA381C20AB8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BE921D40;
	Fri,  4 Aug 2023 22:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEC1AA8B
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB2C5C433C7;
	Fri,  4 Aug 2023 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691186424;
	bh=M5OSAhQLv8Nu8Z+Ryhi36QQGLvGpa8yq/ysCVIq1RNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ixq5yI2jJ88MiyRzjZTWP6C9GmfTvTp6Yd8/NharQUWUIw++4ZV+xXk7eLFxR4Tc6
	 5ZHzv4nkcIIZ71wz4Yj6WBGqAF1LWiwu4epII8WVI30hyfemxj3AUSCVUkoSpOUbul
	 abPBAxl32CA1M2jRhdd/hZz5oreXNaKMYUbd/9RJ4lRDjXx1lgnrXTQt+Feej0bQCe
	 TlorAroo57xyIT6LChvdY7TK5/gMVed5aECvASTDgriCeL7vOIuZxeBqhQR1dXW4kS
	 v4Sj/b4/GPRW8e1y1+kS93wRGFYqZ1tqz/D+97NUjfFgus70X/a2oV/ta5DUd9tOKX
	 kbt3Ynp6ZFjqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8877C6445B;
	Fri,  4 Aug 2023 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix bpf_dynptr_slice() to stop return an
 ERR_PTR.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118642381.15117.7048596186596410083.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:00:23 +0000
References: <20230803231206.1060485-1-thinker.li@gmail.com>
In-Reply-To: <20230803231206.1060485-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com, dan.carpenter@linaro.org,
 alexei.starovoitov@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  3 Aug 2023 16:12:06 -0700 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Verify if the pointer obtained from bpf_xdp_pointer() is either an error or
> NULL before returning it.
> 
> The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. Instead of
> solely checking for NULL, it should also verify if the pointer returned by
> bpf_xdp_pointer() is an error or NULL.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
    https://git.kernel.org/bpf/bpf-next/c/5426700e6841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



