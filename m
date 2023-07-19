Return-Path: <bpf+bounces-5341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80E759BBD
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6781C210E3
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103461FB39;
	Wed, 19 Jul 2023 17:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AA1FB34
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA02C433C9;
	Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689786022;
	bh=jDn5IGHs7brrjKaFQgz63KV3eL86oT3xJ5oW4yJx5qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vOb4sVElmfjTaUnC9i43y3lWwIrGj82pz3mD3n2TmGJ9Pqp+DWvlwObmgTp0d23jr
	 nmoqi+c/4J9g50qgosDegUBmM59VXC7ye/mGQZ/hZ1leAmpkGSYqNpfpRJdH7b45jy
	 HCbtuSLJDhTsZKDQSXzbQ91Bx46xhzApX3WRt4cK5kkp1NVOr5HuXgiGtkAjuEnLzc
	 RYHsXY0K3/wq2hnvmytR1gam7UoUfFQ4sMGuIdE7Msd980MfEdZ2+GfLET4GGrmQmG
	 hYUY45pN5IC1YjFD289Aed2wOSZ/CkQlZ8zTTZuxtMZl+V0mrqRGeVaBMHZfqzW6Hf
	 eAQj/nme+e4yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9787FE22AE1;
	Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] allow bpf_map_sum_elem_count for all program
 types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168978602261.22183.7368489912510631673.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 17:00:22 +0000
References: <20230719092952.41202-1-aspsk@isovalent.com>
In-Reply-To: <20230719092952.41202-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, houtao1@huawei.com, joe@isovalent.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 09:29:48 +0000 you wrote:
> This series is a follow up to the recent change [1] which added
> per-cpu insert/delete statistics for maps. The bpf_map_sum_elem_count
> kfunc presented in the original series was only available to tracing
> programs, so let's make it available to all.
> 
> The first patch makes types listed in the reg2btf_ids[] array to be
> considered trusted by kfuncs.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: consider types listed in reg2btf_ids as trusted
    https://git.kernel.org/bpf/bpf-next/c/831deb2976de
  - [v2,bpf-next,2/4] bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
    https://git.kernel.org/bpf/bpf-next/c/5ba190c29cf9
  - [v2,bpf-next,3/4] bpf: make an argument const in the bpf_map_sum_elem_count kfunc
    https://git.kernel.org/bpf/bpf-next/c/9c29804961c1
  - [v2,bpf-next,4/4] bpf: allow any program to use the bpf_map_sum_elem_count kfunc
    https://git.kernel.org/bpf/bpf-next/c/72829b1c1f16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



