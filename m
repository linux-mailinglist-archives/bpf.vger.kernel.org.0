Return-Path: <bpf+bounces-12396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4E7CBFEA
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7904A281A66
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E00341219;
	Tue, 17 Oct 2023 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/fjEfZJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A5405F6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E97B7C433C9;
	Tue, 17 Oct 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697536223;
	bh=Ua9WsZ4O+9pZBiS7LFFXkeps1X3LydIQYJW76I/I9VE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T/fjEfZJeFiE3VJNr5xfFYl70twJAjxrOgpHE8zH56uLP0poCXiYkXAJnCkSKnrTs
	 dAbY4sq1nzyrnY/NQe6XG2603uTXB6iG3Mmb3ybk2eG38Ts0QWS6X9EEjTk2dIKLap
	 gnwtvzw6e9zJa+mXXVOOfh4JgQazA4epYZriRSUnw1/PI/HxCkt6Tt1Sy2lgEYgAuZ
	 fectq0I0mOh/4+6EoJfgttVFMwSEpngH3+G/qfYIBj6brp53FLcFpYfAnTMgLhOu3h
	 Zqu4CVs8W5ZkZeKUQRvpcy2Y3zD7yoI6DgOKapFRKRTWwJ1lprIHev96UJj11g6VZn
	 aid56iLx9I9tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF93EC41671;
	Tue, 17 Oct 2023 09:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence for
 SHT_GNU_versym section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169753622284.16413.11672373406256173995.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 09:50:22 +0000
References: <20231016182840.4033346-1-andrii@kernel.org>
In-Reply-To: <20231016182840.4033346-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, hengqi.chen@gmail.com,
 liamwisehart@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 16 Oct 2023 11:28:40 -0700 you wrote:
> Fix too eager assumption that SHT_GNU_verdef ELF section is going to be
> present whenever binary has SHT_GNU_versym section. It seems like either
> SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
> SHT_GNU_verdef actually breaks use cases in production.
> 
> One specific reported issue, which was used to manually test this fix,
> was trying to attach to `readline` function in BASH binary.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: don't assume SHT_GNU_verdef presence for SHT_GNU_versym section
    https://git.kernel.org/bpf/bpf-next/c/137df1189d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



