Return-Path: <bpf+bounces-9306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FF79330B
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2AB1C20958
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7146E634;
	Wed,  6 Sep 2023 00:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90362B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EFF6C433C9;
	Wed,  6 Sep 2023 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693961427;
	bh=gRNf8QKUPF4h8QbBrNtIEsKythsdIajhaC9TK4vvFmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hzynwn4hX1zfeubTMd8qHiazRFZS5EoxQwzKjzNhUIHuFWtpYTOXn8jqzU5LNiTYH
	 YS7eohFoxMHCrp4Cerqs0zcVKStRwmp6w8Ck/FIwSkLi2ecIWmHvW4JmYlbyMs4jkF
	 jrIkrADIKZQctRkBrBotcBJ8oUTH7/ZgLj7BCpJk+hT0YQS/1/ByY726LW/N51Xm3/
	 YPbHKrTtJYWsT3kpnb6QlCMtKMt/PwSWL3wnEdvipM7emook0xOKaj3WnHpgBcJeea
	 7ysQDvBBrrkyMVxGKownkKhukUPmlGAhnIfcRo3ymfYw13au5D9JWJ2AUhQUHMtRPA
	 BC9v93wHzrz9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D64DC595C5;
	Wed,  6 Sep 2023 00:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Add support for local percpu kptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169396142705.8605.16350464414399784636.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 00:50:27 +0000
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
In-Reply-To: <20230827152729.1995219-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 27 Aug 2023 08:27:29 -0700 you wrote:
> Patch set [1] implemented cgroup local storage BPF_MAP_TYPE_CGRP_STORAGE
> similar to sk/task/inode local storage and old BPF_MAP_TYPE_CGROUP_STORAGE
> map is marked as deprecated since old BPF_MAP_TYPE_CGROUP_STORAGE map can
> only work with current cgroup.
> 
> Similarly, the existing BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE map
> is a percpu version of BPF_MAP_TYPE_CGROUP_STORAGE and only works
> with current cgroup. But there is no replacement which can work
> with arbitrary cgroup.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/13] bpf: Add support for non-fix-size percpu mem allocation
    https://git.kernel.org/bpf/bpf-next/c/baa9555b6c1c
  - [bpf-next,v3,02/13] bpf: Add BPF_KPTR_PERCPU as a field type
    https://git.kernel.org/bpf/bpf-next/c/b24d13fa6081
  - [bpf-next,v3,03/13] bpf: Add alloc/xchg/direct_access support for local percpu kptr
    https://git.kernel.org/bpf/bpf-next/c/b3122748321a
  - [bpf-next,v3,04/13] bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj
    https://git.kernel.org/bpf/bpf-next/c/119f4dfb73c5
  - [bpf-next,v3,05/13] selftests/bpf: Update error message in negative linked_list test
    https://git.kernel.org/bpf/bpf-next/c/dc5ed69ef3c4
  - [bpf-next,v3,06/13] libbpf: Add __percpu_kptr macro definition
    https://git.kernel.org/bpf/bpf-next/c/9ae302fe598b
  - [bpf-next,v3,07/13] selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in bpf_experimental.h
    https://git.kernel.org/bpf/bpf-next/c/7a03199abbc7
  - [bpf-next,v3,08/13] selftests/bpf: Add tests for array map with local percpu kptr
    https://git.kernel.org/bpf/bpf-next/c/ef570811b2e8
  - [bpf-next,v3,09/13] bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
    https://git.kernel.org/bpf/bpf-next/c/616334e5036b
  - [bpf-next,v3,10/13] selftests/bpf: Remove unnecessary direct read of local percpu kptr
    https://git.kernel.org/bpf/bpf-next/c/974da9f3ee66
  - [bpf-next,v3,11/13] selftests/bpf: Add tests for cgrp_local_storage with local percpu kptr
    https://git.kernel.org/bpf/bpf-next/c/38bbd586889f
  - [bpf-next,v3,12/13] selftests/bpf: Add some negative tests
    https://git.kernel.org/bpf/bpf-next/c/2bc5f8c5dbe4
  - [bpf-next,v3,13/13] bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
    https://git.kernel.org/bpf/bpf-next/c/fb94bcc2b286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



