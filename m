Return-Path: <bpf+bounces-2554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046272EF19
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6641280C25
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F163EDA5;
	Tue, 13 Jun 2023 22:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88973ED8C
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 22:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38736C433C9;
	Tue, 13 Jun 2023 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686694822;
	bh=GYLW+FxpDeaLqVBk/pJx5EFySwxnXi9w8k7oShG5MlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGuAHoe9dTh9lAkPO33XbT9Jbd9m5K+/ci+1KiGPVhG0Xz4B08kWqLGNkEzw7pQ/1
	 E6UcYwB6CRJI+jUkVhP2yNzYx7ugC9DB6Br9FIiXc4BR5kSmgvQ9eGHX7weXsg0X+k
	 /GJ0d0MCZD0QqgCDXIWo8ygyz0jHNhZh1hh0gbMVxeQxOLKF3S2nX3VuBpnan3NVu8
	 qbxUKEoRmJAco73N50kBr6V216PPSPRc0A1LxfgRRGnBJRBxD4p7oFeBao2UdrUp6l
	 tC1JkHYRnEYD1BdX/O/wb0yUZqdZiRFn0prtOXMOxou3gU6mOZWk6vxJRFIHysCo0h
	 88AA30Rl7pL+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15504C3274B;
	Tue, 13 Jun 2023 22:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/4] verify scalar ids mapping in regsafe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168669482208.27908.11963237417084366484.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jun 2023 22:20:22 +0000
References: <20230613153824.3324830-1-eddyz87@gmail.com>
In-Reply-To: <20230613153824.3324830-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 13 Jun 2023 18:38:20 +0300 you wrote:
> Update regsafe() to use check_ids() for scalar values.
> Otherwise the following unsafe pattern is accepted by verifier:
> 
>   1: r9 = ... some pointer with range X ...
>   2: r6 = ... unbound scalar ID=a ...
>   3: r7 = ... unbound scalar ID=b ...
>   4: if (r6 > r7) goto +1
>   5: r6 = r7
>   6: if (r6 > X) goto ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/4] bpf: use scalar ids in mark_chain_precision()
    https://git.kernel.org/bpf/bpf-next/c/904e6ddf4133
  - [bpf-next,v6,2/4] selftests/bpf: check if mark_chain_precision() follows scalar ids
    https://git.kernel.org/bpf/bpf-next/c/dec020280373
  - [bpf-next,v6,3/4] bpf: verify scalar ids mapping in regsafe() using check_ids()
    https://git.kernel.org/bpf/bpf-next/c/1ffc85d9298e
  - [bpf-next,v6,4/4] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
    https://git.kernel.org/bpf/bpf-next/c/18b89265572b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



