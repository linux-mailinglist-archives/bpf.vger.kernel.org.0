Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408264A87DC
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiBCPkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 10:40:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiBCPkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 10:40:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D15B60A3C
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94885C340F2;
        Thu,  3 Feb 2022 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643902810;
        bh=JLzv11YokyjicufVqG1Dkx1aGLIznXh+Pl6sO1VxlwM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r02titVmE6M1ao/q3g/m3PmBVduGDbqoh7EFoo5Xe8jkeP9nZ73NoZrrbEk2h8WvC
         Bw/yOCxbCcEAER61GYZYIh6jELzvjdtjRXtVcYLaN/SFh0XkIzw2bEJ2aFUZ87Wn5n
         kvhR7vkT+fcakVNCZUCnX1/ZTreVq7E+mXEGx6exZNOCwbwVWhdb2F40KdTmsY5YtA
         AuJ8IMgBOOLiINaU5RjLLQAZr5IIj3GbAFzMkk724GRgWuXq4dqD4Fv765XXuvLMuh
         n02ZHPzcljCy4Nskvs7K7M+VwdNs/YfzV2PTAQQpg75BXlHTVbYsb85H2OMXtVGsuB
         mqk7SGCZuz/fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84FB7E5D09D;
        Thu,  3 Feb 2022 15:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/6] Clean up leftover uses of deprecated APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164390281054.30354.12360708187607455235.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Feb 2022 15:40:10 +0000
References: <20220202225916.3313522-1-andrii@kernel.org>
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 2 Feb 2022 14:59:10 -0800 you wrote:
> Clean up remaining missed uses of deprecated libbpf APIs across samples/bpf,
> selftests/bpf, libbpf, and bpftool.
> 
> Also fix uninit variable warning in bpftool.
> 
> Andrii Nakryiko (6):
>   libbpf: stop using deprecated bpf_map__is_offload_neutral()
>   bpftool: stop supporting BPF offload-enabled feature probing
>   bpftool: fix uninit variable compilation warning
>   selftests/bpf: remove usage of deprecated feature probing APIs
>   selftests/bpf: redo the switch to new libbpf XDP APIs
>   samples/bpf: get rid of bpf_prog_load_xattr() use
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/6] libbpf: stop using deprecated bpf_map__is_offload_neutral()
    https://git.kernel.org/bpf/bpf-next/c/a5dd9589f0ab
  - [bpf-next,2/6] bpftool: stop supporting BPF offload-enabled feature probing
    https://git.kernel.org/bpf/bpf-next/c/1a56c18e6c2e
  - [bpf-next,3/6] bpftool: fix uninit variable compilation warning
    https://git.kernel.org/bpf/bpf-next/c/a9a8ac592e47
  - [bpf-next,4/6] selftests/bpf: remove usage of deprecated feature probing APIs
    https://git.kernel.org/bpf/bpf-next/c/32e608f82946
  - [bpf-next,5/6] selftests/bpf: redo the switch to new libbpf XDP APIs
    https://git.kernel.org/bpf/bpf-next/c/e4e284a8c0d9
  - [bpf-next,6/6] samples/bpf: get rid of bpf_prog_load_xattr() use
    https://git.kernel.org/bpf/bpf-next/c/1e4edb6d8c4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


