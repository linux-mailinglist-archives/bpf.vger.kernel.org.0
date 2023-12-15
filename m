Return-Path: <bpf+bounces-18047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C23815339
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E79C2852D0
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C246495D6;
	Fri, 15 Dec 2023 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6i1zrR/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD65F871
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A354C433CA;
	Fri, 15 Dec 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702677624;
	bh=5zJNQ5n1flQjrKpwXCu9cHd1VvAmYPE5qLp4zFyvo/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m6i1zrR/HYPtLY1fAUOGCQK7hDbPDJMsXOMe2WWbs8izZfP6nEV4TekQYJOKTjg0R
	 ZNlKxRWrvRAZ6wWL0z4Wuq4kSBvFOIRqmF6Tm4ZG5VWKHeoE8KuMk2dVtXQu7NPy7c
	 DRMlhV+ighJ4DVTS5UnqTn9e7G/3Sm4GC0ovEbJQb2tmOE9gUmirV2/FPo95l+HHc0
	 ukX1mZlZ+bOyJWLg23KlUM1X45eoDzf/LmIi/DtvvQrGv+KaX5YJs55YHR/4hGeM5S
	 JVzDGM6Hz2ZjJzBRoTraWflxt/rGTTkdD19V+qg7kEGwK5lPiZVQ2+PE7CegWiiAu5
	 BRvPaGbU7ihfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D03AC4314C;
	Fri, 15 Dec 2023 22:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] bpf: Fix warnings in kvmalloc_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170267762437.4416.11863868567400479013.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 22:00:24 +0000
References: <20231215100708.2265609-1-houtao@huaweicloud.com>
In-Reply-To: <20231215100708.2265609-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 xrivendell7@gmail.com, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 15 Dec 2023 18:07:03 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the warnings in kvmalloc_node() when passing
> an abnormally big cnt during multiple kprobes/uprobes attachment.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Limit the number of uprobes when attaching program to multiple uprobes
    https://git.kernel.org/bpf/bpf-next/c/8b2efe51ba85
  - [bpf-next,v3,2/5] bpf: Limit the number of kprobes when attaching program to multiple kprobes
    https://git.kernel.org/bpf/bpf-next/c/d6d1e6c17cab
  - [bpf-next,v3,3/5] selftests/bpf: Add test for abnormal cnt during multi-uprobe attachment
    https://git.kernel.org/bpf/bpf-next/c/0d83786f5661
  - [bpf-next,v3,4/5] selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test
    https://git.kernel.org/bpf/bpf-next/c/00cdcd2900bd
  - [bpf-next,v3,5/5] selftests/bpf: Add test for abnormal cnt during multi-kprobe attachment
    https://git.kernel.org/bpf/bpf-next/c/1467affd16b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



