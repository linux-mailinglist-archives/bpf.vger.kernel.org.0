Return-Path: <bpf+bounces-3827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E47442D0
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB34281219
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE31774E;
	Fri, 30 Jun 2023 19:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5F1772A
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 19:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3030C4339A;
	Fri, 30 Jun 2023 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688154021;
	bh=qpvGYOdaqJrEcyQAsFhHIQDf6AaXEaBTiRzm4SMY/jE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHlIMz+9ZOHbAjZjtcS/kIe9tNPpz1jQsi2/X3g3P+/SNAsaNaDfu23BuE3z09Nem
	 McuNY34LBOO6tpE3gwunSi7EGfE2hNsqTALs6F4HydPkrTekQPdqCI2Ob9IIzhwNRG
	 HfRpZAPu3X17vVsGyOLhNI+DHSMttNmR6hwW6X3vNVLyBsoa8616NeSDTOhNU/DPJZ
	 1C1FaJYcsUEjXTWxDLlcXMl2521S1a5mknhk4DXlMpkXXbK2N5lRrSMpeh/RTdIf+I
	 UH3QMT867V5iUUzk15xockIvA8ItlNH5XIqrJDPghe7aWlzaUKR4aH0CP4tkrR5Qx2
	 IVTYNg38wH00Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B08BCC40C5E;
	Fri, 30 Jun 2023 19:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: skip modules BTF loading when CAP_SYS_ADMIN
 is missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168815402071.30308.4089856315075647063.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 19:40:20 +0000
References: <20230626093614.21270-1-andreaterzolo3@gmail.com>
In-Reply-To: <20230626093614.21270-1-andreaterzolo3@gmail.com>
To: Andrea Terzolo <andreaterzolo3@gmail.com>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, nierro92@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 26 Jun 2023 11:36:14 +0200 you wrote:
> If during CO-RE relocations libbpf is not able to find the target type
> in the running kernel BTF, it searches for it in modules' BTF.
> The downside of this approach is that loading modules' BTF requires
> CAP_SYS_ADMIN and this prevents BPF applications from running with more
> granular capabilities (e.g. CAP_BPF) when they don't need to search
> types into modules' BTF.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: skip modules BTF loading when CAP_SYS_ADMIN is missing
    https://git.kernel.org/bpf/bpf-next/c/2d2c95162de8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



