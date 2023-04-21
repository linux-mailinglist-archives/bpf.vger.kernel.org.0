Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC206EADEB
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDUPU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjDUPU0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 11:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB3900C
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 08:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66436516A
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 15:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28CB7C4339B;
        Fri, 21 Apr 2023 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682090420;
        bh=fQiYJQzZ5GXoRDHjSfxNM08yGUX/SY3zevCwtcgTJ/Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QjQGlzIOoSAboy1yZgTr7ZCIuXZKVit6hK22yloLloUWbCIJ18tKzfQdFZHAmOG8z
         gzq4v19J3lw3izktBuAqJysgocfkS2Za2LGLlCNoCPqGBN9lhrAPRkhA2LB7w488Ik
         wb3JUXe8GsFiyZlDvgYwRVbgzg7gUQ5kG9pqtGET6FFrkFcX+1eShGKCtbDlPROj2d
         badbf+CvxGE0HLHQqtBAyGQaSP8TdwhB5o+4ntxf89WvYeAOjZzjlrkBKYJIk+YptL
         RYxSTNu8F/90vkdWXb7AsY3j3oDNuflLMH4tnydvmUEALIExeAlsckAvOQ7G+Bmh/i
         9Zh95M4k4kfSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C58E270E2;
        Fri, 21 Apr 2023 15:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/6] bpf: handle another corner case in getsockopt
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168209042006.27061.4586711432488397653.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Apr 2023 15:20:20 +0000
References: <20230418225343.553806-1-sdf@google.com>
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, martin.lau@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 18 Apr 2023 15:53:37 -0700 you wrote:
> Martin reports another case where getsockopt EFAULTs perfectly
> valid callers. Let's fix it and also replace EFAULT with
> pr_info_ratelimited. That should hopefully make this place
> less error prone.
> 
> First 2 patches fix the issue with NETLINK_LIST_MEMBERSHIPS and
> test it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/6] bpf: Don't EFAULT for getsockopt with optval=NULL
    https://git.kernel.org/bpf/bpf-next/c/00e74ae08638
  - [bpf-next,2/6] selftests/bpf: Verify optval=NULL case
    https://git.kernel.org/bpf/bpf-next/c/833d67ecdc5f
  - [bpf-next,3/6] bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
    (no matching commit)
  - [bpf-next,4/6] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
    (no matching commit)
  - [bpf-next,5/6] selftests/bpf: Correctly handle optlen > 4096
    (no matching commit)
  - [bpf-next,6/6] bpf: Document EFAULT changes for sockopt
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


