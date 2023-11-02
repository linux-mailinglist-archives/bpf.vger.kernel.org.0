Return-Path: <bpf+bounces-13914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A8B7DECB0
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C743281B26
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF16134;
	Thu,  2 Nov 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUis9d88"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0085227
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27F83C433D9;
	Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904825;
	bh=I0wXETA4AbIoz8BHZZN8jCwendUkEDs+qt7KqKpVNmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jUis9d88b/xw+wpb4eKjGEepAvwO7WSVGFgjlxbQxRrBm7alqUG+KfrKs9QfW7PiM
	 2jHK0gxD3dpuePA8bahBzZvKjOHAxXRnseZcKrCnx83gQrxvVYmSn77RycS6aVnfrL
	 Rmu1i4cX4AohQoC/Qyme9EW/aBGg0dbdMing2sAFvIcv0k/pysWUDmCTbQ3upJY3GW
	 WrAFP7IGtVYiyj2Yn2aKvXTAWBaS/8oZaH7vG4WjmSd9iqd+hSjXm+pWRcVe3r9dj3
	 5XcMO+FxFZXXK0UoSUYTO7UZfKYjXCTgghBKz0079okdSn37FvNLbifaqOHgrD06LJ
	 fq8i1Die879hQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06F3CE00095;
	Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_maps' use of
 bpf_map_create_opts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890482502.9002.2730494123004229037.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:00:25 +0000
References: <20231029011509.2479232-1-andrii@kernel.org>
In-Reply-To: <20231029011509.2479232-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 28 Oct 2023 18:15:09 -0700 you wrote:
> Use LIBBPF_OPTS() macro to properly initialize bpf_map_create_opts in
> test_maps' tests.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/map_tests/map_percpu_stats.c          | 20 +++++--------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix test_maps' use of bpf_map_create_opts
    https://git.kernel.org/bpf/bpf/c/9af3775962af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



