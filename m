Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289A6262B5
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKKUUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKKUUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD85183A7;
        Fri, 11 Nov 2022 12:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DB81B827C4;
        Fri, 11 Nov 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14341C433D7;
        Fri, 11 Nov 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668198016;
        bh=eGV6RtpLdZQo8P0iTLPHggVocEjhtKInya3nxr1WkXU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mW55+UT15pdb8ZJUXw3eSegxZy2xeVrHbGQNrzL/ty/6YC47d9WIoQeyttFPPJ9jc
         OpvvlHoj52H6ozKJS6eUXYMGYIXHCs0sXesHRvjgynXmzHhB2p8wsTuSABUXShEEQR
         jqQvVVg329pBgMmIqznIKMml69Z8A/4Dpag44I2J/V2AfSCpN48Z7qxwsSRS/at0gR
         xS2ucU+Uszj6TOjlk2XtwCEiKzuBPw6qCXpA6OrlKPgGloXA+LqvIN2wvA9s6k5UM9
         R3e+QpzT5penZTwEvGXiwjrZP0q/94GOuP45vOFtqzfiALzu97qm71ID5HXly+KjAF
         N40DKt68rV2eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9BB2C395FE;
        Fri, 11 Nov 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf: Initialize same number of free nodes for
 each pcpu_freelist
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819801595.25412.9466818114599026542.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 20:20:15 +0000
References: <20221110122128.105214-1-xukuohai@huawei.com>
In-Reply-To: <20221110122128.105214-1-xukuohai@huawei.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 10 Nov 2022 07:21:28 -0500 you wrote:
> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
> 8 nodes equally.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf: Initialize same number of free nodes for each pcpu_freelist
    https://git.kernel.org/bpf/bpf/c/4b45cd81f737

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


