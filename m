Return-Path: <bpf+bounces-17759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090A81244E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381801C21458
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5F9645;
	Thu, 14 Dec 2023 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uef3egIE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806263D
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9A65C433C9;
	Thu, 14 Dec 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702516223;
	bh=A9krOF80WQ72p6u86RtjFsrJmswk5fS5tWhN/WTCjwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uef3egIE5UP0gK2psncxAgCvw0Bim255es4z5ACcKdK2LyLU++Wmr1VFP4CFB9U1P
	 ahQ91JuiLd2J+1ajrVD7HoGLSAa1doxceN72pf4JKWWzwBRJi/nbkkfEGk828VjZ/X
	 KFxMYstvXQPyo2107mV6bToo+qDs7Wk1g3ntk87BpBHD7UoCFYwPRE9Af3mhK92Exo
	 NYeB3QTYDDZf7CQbxogGX3VM7gsbe10SNIXZE475JCcxVZrgZ9vCQ+bPEQw+zwUjJ9
	 13YhzrsVT6qa2DaGc0k90Sk6CLGWKetYSO7KDKXmA4ktLlDj8si+U9KG7RbeBRfA0b
	 dhBwZCbe3EYGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B99DDDD4EFE;
	Thu, 14 Dec 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Update the comments in
 maybe_wait_bpf_programs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251622375.21032.3667664124559774409.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 01:10:23 +0000
References: <20231211083447.1921178-1-houtao@huaweicloud.com>
In-Reply-To: <20231211083447.1921178-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Dec 2023 16:34:47 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
> sleepable programs"), sleepable BPF program can also use map-in-map, but
> maybe_wait_bpf_programs() doesn't handle it accordingly. The main reason
> is that using synchronize_rcu_tasks_trace() to wait for the completions
> of these sleepable BPF programs may incur a very long delay and
> userspace may think it is hung, so the wait for sleepable BPF programs
> is skipped. Update the comments in maybe_wait_bpf_programs() to reflect
> the reason.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Update the comments in maybe_wait_bpf_programs()
    https://git.kernel.org/bpf/bpf-next/c/2a0c6b41eec9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



