Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595E1645081
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGAkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLGAkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD7DE6
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5161F61994
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 00:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3910C433B5;
        Wed,  7 Dec 2022 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670373616;
        bh=eOd8use/ifN3pTGzF9KjWFRVYNsSp+s5WAXtbVpxgYM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RwtF7usret52Zc6C0zSu7EohUuVPBCI/fVtT/Ujz7E9EJgPCtjfkvrOU6SexhfBBy
         YXOeMtdC8gqWWx2hO5kTl0JLK2eXCaQoCGhfFonG3ZIlV7MGiMqySuf+wOP0f29928
         OCZwZ41FgWYfB6UCdalQ90o8qSLpCFN6pimwchGJpxCAZZHDQw+fPqMviv57A/J3ce
         sr3/9tMx4s9u2xgY9O0KnSdEru0SXL2rYj2YxT6G8KoydXl/AbQMuyM4U7y5dqvzDR
         0XfwSnxHwVtXW8qjclN6W0bNBqhpGPdgoaCSE5xy3ZmZWJHL3h3zRDpacGTa7YH0cM
         PXdd4CNTo06VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85A86E56AA3;
        Wed,  7 Dec 2022 00:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] BPF selftests fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167037361653.14598.14851739698659506253.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 00:40:16 +0000
References: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
In-Reply-To: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  5 Dec 2022 14:16:15 +0100 you wrote:
> This patch series fixes a few issues I've found while integrating the
> bpf selftests into systemd's mkosi development environment.
> 
> Daan De Meyer (3):
>   selftests/bpf: Install all required files to run selftests
>   selftests/bpf: Use "is not set" instead of "=n"
>   selftests/bpf: Use CONFIG_TEST_BPF=m instead of of CONFIG_TEST_BPF=y
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Install all required files to run selftests
    https://git.kernel.org/bpf/bpf-next/c/d68ae4982cb7
  - [bpf-next,2/3] selftests/bpf: Use "is not set" instead of "=n"
    https://git.kernel.org/bpf/bpf-next/c/efe7fadbd59e
  - [bpf-next,3/3] selftests/bpf: Use CONFIG_TEST_BPF=m instead of CONFIG_TEST_BPF=y
    https://git.kernel.org/bpf/bpf-next/c/d0c0b48c8727

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


