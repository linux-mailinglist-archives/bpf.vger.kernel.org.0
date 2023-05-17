Return-Path: <bpf+bounces-786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D33C706BF7
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE96E2816DC
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF8566A;
	Wed, 17 May 2023 15:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07379D9
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 15:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FB31C4339B;
	Wed, 17 May 2023 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684335621;
	bh=EBtFhKzCPTg2KWNx11ir0NOfmYiThSGnN1Onpu9bBNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oxy90T56ncpDMIzp6cOTXwd5G8anbS1KuZvTf5Fk2z4CTJij2n53EIjcDNJrsigxW
	 eMKvvySeZ6W8LgwLOTs/27PjTax3YF9caAUCK8Hj+Jt8anrMX06XblNKI8aWW3Yn1i
	 4ddROUlOAEzEGohCz6ppn6zbhjFa1ZBGyA4ZsK3K6ntfOcfahHHKTy5UTlOqhAm8gl
	 XQ8y1AmrHDmtGrQJMI33StQSWQJwK927Hs+2kn+rb7WcU1o+30MXSDs6zhFhPAhIcv
	 WNEGQ+TLFDNrtLtIIBz9P2DrMqJeFDmUkDTqyMtTTk6ZSizgLDGPazBMXKGXrF7ML3
	 uQsHWM0wInssA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03232E5421C;
	Wed, 17 May 2023 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Fix dynptr/test_dynptr_is_null
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168433562100.7780.1861233631430475137.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 15:00:21 +0000
References: <20230517040404.4023912-1-yhs@fb.com>
In-Reply-To: <20230517040404.4023912-1-yhs@fb.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 16 May 2023 21:04:04 -0700 you wrote:
> With latest llvm17, dynptr/test_dynptr_is_null subtest failed in my
> testing VM. The failure log looks like below:
>   All error logs:
>   tester_init:PASS:tester_log_buf 0 nsec
>   process_subtest:PASS:obj_open_mem 0 nsec
>   process_subtest:PASS:Can't alloc specs array 0 nsec
>   verify_success:PASS:dynptr_success__open 0 nsec
>   verify_success:PASS:bpf_object__find_program_by_name 0 nsec
>   verify_success:PASS:dynptr_success__load 0 nsec
>   verify_success:PASS:bpf_program__attach 0 nsec
>   verify_success:FAIL:err unexpected err: actual 4 != expected 0
>   #65/9    dynptr/test_dynptr_is_null:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Fix dynptr/test_dynptr_is_null
    https://git.kernel.org/bpf/bpf-next/c/12852f8e0f70
  - [bpf-next,2/2] selftests/bpf: Make bpf_dynptr_is_rdonly() prototyype consistent with kernel
    https://git.kernel.org/bpf/bpf-next/c/effcf6241624

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



