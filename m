Return-Path: <bpf+bounces-4698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3974E364
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2522815DF
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BFEC1;
	Tue, 11 Jul 2023 01:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12A37D
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 926F2C433C9;
	Tue, 11 Jul 2023 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689038421;
	bh=hn/g6yNfgEEXxR7VZVlWH5sSlNJkhabLWA9rOQ89w60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b32u56n1pDxs7P5+KTz1gErMYS8GsDdSj9Gjtkfmkr7qZTpzBFKk9MAxEBRtBBr35
	 SMen9PV7yHfanGaA/VNZGxMUi0AHeBkA/zrpjN31fQ4nSZRh7jdGil/8shc2O5JTAz
	 p7WHKJoqBjdSJWrdtF8MPv1wMH3kTga+5gvI+6BNgMbQt8wQYWdQgJyLwDpfxApXf0
	 Ngk5yJ61Df5dH+MOZeOrZmOltd7/Tpu+yyLNwWT+cW7TzrUH2sj6+hGEtQfDosktNi
	 ZlV8/qImboPZN37PosNni9D6Y+mvQx92U78+JSU8jSSORimdgerZzDWBnTwgpxrUEL
	 5+APkfnaDRBFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78D06C395F8;
	Tue, 11 Jul 2023 01:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,docs: Create new standardization subdirectory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168903842148.8047.7806856535858862596.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 01:20:21 +0000
References: <20230710183027.15132-1-void@manifault.com>
In-Reply-To: <20230710183027.15132-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, bpf@ietf.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Jul 2023 13:30:27 -0500 you wrote:
> The BPF standardization effort is actively underway with the IETF. As
> described in the BPF Working Group (WG) charter in [0], there are a
> number of proposed documents, some informational and some proposed
> standards, that will be drafted as part of the standardization effort.
> 
> [0]: https://datatracker.ietf.org/wg/bpf/about/
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf,docs: Create new standardization subdirectory
    https://git.kernel.org/bpf/bpf-next/c/4d496be9ca05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



