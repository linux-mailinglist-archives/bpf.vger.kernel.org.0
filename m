Return-Path: <bpf+bounces-9957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D979F164
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 20:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B33281943
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFEEB8;
	Wed, 13 Sep 2023 18:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830F813
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 18:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0A10C433C9;
	Wed, 13 Sep 2023 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694631024;
	bh=pjoRbTgCErKCAtk79jBqizoxI2iDbOKmaX4F49GHq/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jt3jW+1sdMhbiDQIk2sSW5iURsZaobSWnK+X2tsDSjQ6pfd/NVTxcZrGuk0y89KtA
	 ySuWDt+x3jLI/Fg5gejzutbOHX3XilO5/ClQRpXx9GpAcUkRDwXytcXTDUBGosMrb5
	 t2aoNgkVPx5a55ZPylR+LPAqrVPcrJOPDRDwZ/A4YRYyeJAcXgxoRyx0l7cjkb4z/5
	 jIIoILnreeqK/hA5zC00r0rSEyhfwaVCXDEY0CJzMwvK17sE4ZdVZmgl5TxjyxSx6u
	 F2ujBZEug+kuUUT66je32AXDfatJ5bJ0d/w0cEZBC8WGKraX+3DkFszPuLyrwyid/f
	 nwZPoXgHiL+7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8321EE1C290;
	Wed, 13 Sep 2023 18:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf] selftests/bpf: Fix kprobe_multi_test/attach_override
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169463102453.14252.1553643164526204933.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 18:50:24 +0000
References: <20230913114711.499829-1-jolsa@kernel.org>
In-Reply-To: <20230913114711.499829-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 13 Sep 2023 13:47:11 +0200 you wrote:
> We need to deny the attach_override test for arm64, denying the
> whole kprobe_multi_test suite. Also making attach_override static.
> 
> Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64             | 9 +--------
>  .../testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf] selftests/bpf: Fix kprobe_multi_test/attach_override test
    https://git.kernel.org/bpf/bpf/c/8a19edd4fa6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



