Return-Path: <bpf+bounces-15938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A17FA1D0
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 15:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34FE2818B2
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECF315A7;
	Mon, 27 Nov 2023 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irlqOZXb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3AA31590
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 14:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16283C3277B;
	Mon, 27 Nov 2023 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701093624;
	bh=mUTPritu/fIQ+yto2AE3kDkMI8tBuxgsqRNKbwHJQws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=irlqOZXbz1Ivt69zJsq1JS4kYIhFCywWI/kIUFsbHtpD4cwBLkXrfbnzmCRgU5ZMt
	 13ThZ50Ap1LRtSG/BXUlDjQpKtzexnppL5oWzA+DJPBvu4Y4LgbaTVSU3qOwqe+dyC
	 aRWFNSHzwN4/PC2WdvNeF0maZOTfH8m0Xg/o3yNuy8VAVrkPynJJWzS/cd2NAmFbEb
	 X0TfGwHeaVKqUCtCR3/57xoDC6qHkc2sJpuEZEWiWAjfng/tiRhS5M7YPFC+X14fLw
	 CjXw2yseAP9PmdiIVGVNSDjfCZxAQp0opyc6fxDvzWLZpjsU4qXYgcoIu30vCFEmrz
	 Agw7O3DlgHeIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA582E00090;
	Mon, 27 Nov 2023 14:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix a few selftest failures due to llvm18
 change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170109362395.30312.3689958762072528759.git-patchwork-notify@kernel.org>
Date: Mon, 27 Nov 2023 14:00:23 +0000
References: <20231127050342.1945270-1-yonghong.song@linux.dev>
In-Reply-To: <20231127050342.1945270-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 26 Nov 2023 21:03:42 -0800 you wrote:
> With latest upstream llvm18, the following test cases failed:
>   $ ./test_progs -j
>   #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>   #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>   #13      bpf_cookie:FAIL
>   #77      fentry_fexit:FAIL
>   #78/1    fentry_test/fentry:FAIL
>   #78      fentry_test:FAIL
>   #82/1    fexit_test/fexit:FAIL
>   #82      fexit_test:FAIL
>   #112/1   kprobe_multi_test/skel_api:FAIL
>   #112/2   kprobe_multi_test/link_api_addrs:FAIL
>   ...
>   #112     kprobe_multi_test:FAIL
>   #356/17  test_global_funcs/global_func17:FAIL
>   #356     test_global_funcs:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix a few selftest failures due to llvm18 change
    https://git.kernel.org/bpf/bpf-next/c/b16904fd9f01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



