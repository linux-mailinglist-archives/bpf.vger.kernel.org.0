Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8C637041
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 03:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKXCKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 21:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXCKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 21:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB537A36B;
        Wed, 23 Nov 2022 18:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A4B0B82478;
        Thu, 24 Nov 2022 02:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7EABC433D7;
        Thu, 24 Nov 2022 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669255815;
        bh=mgwXJoRszeN/zrBrz05Bo2C6euIBBlbKHCEqjpNAdAg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D0QZg4kAP99SFb7dhUG3QdxvGE8nxN4cOPyNVMpRv14V2m0mMbBSOXnC/ug/O20Hy
         zQIp4XWl3sKCND5VhoeSIEyAk2/xGsQ6NcBGOB9zQ+R+EiYaeRQkwC8e19G4vJPXP8
         OzU1BJCjbsLk4PETDwkAlm7wRxZmX4wC1w2/rY8zE775dHoO2hKNNb9owq0Yp67KlN
         33xO/7BdZxgu6AuYKDxpVu4G9CBfYoaPMuVEuKCUxw+/iZjV4e2HfqVq9TDbbnn7zY
         N8dLnRzROd2lgf6w4PoCZ3ziddOqSlh6dy1cvI1zTSmMZMghIeJ6Yh5+GxfwlALf01
         x25p3yTBME2Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8473C395EE;
        Thu, 24 Nov 2022 02:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Add kfunc for doing pid -> task lookup
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166925581574.23700.5716179637470412822.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 02:10:15 +0000
References: <20221122145300.251210-1-void@manifault.com>
In-Reply-To: <20221122145300.251210-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com,
        song@kernel.org, sdf@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, haoluo@google.com,
        tj@kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Nov 2022 08:52:58 -0600 you wrote:
> A series of prior patches added support for storing struct task_struct *
> objects as kptrs. This patch set proposes extending this with another
> kfunc called bpf_task_from_pid() which performs a lookup of a task from
> its pid, from the root pid namespace idr.
> 
> This allows BPF programs that don't have a kptr to a task, to instead
> perform a lookup by pid. This will be useful for programs that are
> tracking pids and want, e.g., to do a lookup to find task->comm.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Add bpf_task_from_pid() kfunc
    https://git.kernel.org/bpf/bpf-next/c/3f0e6f2b41d3
  - [bpf-next,2/2] selftests/bpf: Add selftests for bpf_task_from_pid()
    https://git.kernel.org/bpf/bpf-next/c/f471748b7fe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


