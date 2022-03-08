Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202814D1045
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiCHGbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 01:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbiCHGbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 01:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A33C731
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 22:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1819B615E4
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 06:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DACFC340F4;
        Tue,  8 Mar 2022 06:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646721010;
        bh=WWk4P3G6/Zqibs8qdXttI2ETHhQ8wBwL43woOdhg1WE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G4zOlIJk1NSrQQqZIo5i8KLxaWN74TtDbWQQ5hSV4azJE672o08P08MPttZNQC4i7
         ma2BnL2dfndF5G0fnqVIN7HhTvt+vDmiHK44BeaxDFYz6qYwKTyP/wm5p9+NDS4FBf
         N4ElAqjat0CtEOL9TNnTqtGccSSHR5PkgpxV/OpQtCBUDOzOYyH2mUzZJ/ZV7c4d5i
         QBS1WWZ5J/kIRYfKjbd8m39zWpde1iF/tkCfyRUCN9t5sb+flO9VCHp7/QjeU9Z7Dd
         9kZAIKTtKtzhJsX1qH/5v9JVTFQ8g5XFf2lQ9PX9YnYN8uBYVsP8p9AQuxCZwI/6xl
         7N1R5qJydvjgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5021EE6D3DD;
        Tue,  8 Mar 2022 06:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf/docs: Update vmtest docs for static linking
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164672101032.16776.13800629923645627488.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Mar 2022 06:30:10 +0000
References: <20220307133048.1287644-1-kpsingh@kernel.org>
In-Reply-To: <20220307133048.1287644-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, geyslan@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  7 Mar 2022 13:30:47 +0000 you wrote:
> Dynamic linking when compiling on the host can cause issues when the
> libc version does not match the one in the VM image. Update the
> docs to explain how to do this.
> 
> Before:
>   ./vmtest.sh -- ./test_progs -t test_ima
>   ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf/docs: Update vmtest docs for static linking
    https://git.kernel.org/bpf/bpf-next/c/5ad0a415da6b
  - [bpf-next,2/2] bpf/docs: Update list of architectures supported.
    https://git.kernel.org/bpf/bpf-next/c/e878ae2d1df5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


