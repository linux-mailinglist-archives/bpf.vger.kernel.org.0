Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D43B69813C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBOQuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 11:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBOQuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 11:50:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD349747;
        Wed, 15 Feb 2023 08:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBAEB61CED;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52076C4339E;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479817;
        bh=Ppg5Lw0syIaOQbx7tKQT6J+9i/+U/v5NnOvPAfvJ8xE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S4oGPt1wk8hTblliNjEUQP8rIKGwTdyIQS7lZ29BlBXGIlXQwHujXk2Ye1h3Gl7H7
         hOPi4q05VdQ8MQNFwTHOCMYf7LT/XbWF/vDgpQyxKV5KvRjF1HsXMh6+71ZALKl3DP
         lfnKjMEwzIZgU3VmKI3Ou3Y33dCg54Lj0LTj06TdL4m0B0B1EizKLk3lyF5UT0P+wl
         1fxIa/ZoPDtWtvn+52Ez5D1sXaizs0azo/2BvqFPXvOU7RByGu8BknPJOVLnEBdn1/
         66xqBhkLzQPmW0vyVmhNdy7cgA+UVsANxfETVQ76s32BL5y4kfC3dkUn/xDPuEmP4e
         HB46uLqCV9DSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A42FE29F41;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Add myself to BPF docs MAINTAINERS entry
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167647981723.6958.10599726108070077422.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 16:50:17 +0000
References: <20230214223553.78353-1-void@manifault.com>
In-Reply-To: <20230214223553.78353-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, dthaler@microsoft.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Feb 2023 16:35:53 -0600 you wrote:
> In commit 7e2a9ebe8126 ("docs, bpf: Ensure IETF's BPF mailing list gets
> copied for ISA doc changes"), a new MAINTAINERS entry was added for any
> BPF IETF documentation updates for the ongoing standardization process.
> I've been making it a point to try and review as many BPF documentation
> patches as possible, and have made a committment to Alexei to
> consistently review BPF standardization patches going forward. This
> patch adds my name as a reviewer to the MAINTAINERS entry for the
> standardization effort.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Add myself to BPF docs MAINTAINERS entry
    https://git.kernel.org/bpf/bpf-next/c/213aacb8a27b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


