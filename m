Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4A4F1F4B
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 00:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiDDWsp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 18:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiDDWsK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 18:48:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C641FCD2
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 15:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ED1AB81A52
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 22:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08EE5C34113;
        Mon,  4 Apr 2022 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649109613;
        bh=OqTTXfglCOvI2yvj/dbL9xTsR4cuO5jcxbUEv8Bgzvs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m4n9aZtS69ES2Edn003nA6gDVlCnZsuqN19MH9kxWemuUfnUXbeFXwyWV6OMvirEB
         wv00OjHu1rPVflp9cSv9MaTloyO7bOfpRMDBPKx92nPgArASn4A2YzOvjlOmUmqL0a
         wcfH9Z3uc1MZh1kiOP2ZBYLGeOOnZ0e41V4H7P9LUdaWH+ohNBfJsktlFS9p2+jhuA
         6LwrrWOQ8wJsqqgXZYFDvNcqcXb4rml295lmhyLd6C4iwgnd9rKt/uFdXONGjKs/ms
         uNiGe4H/9zZBwcOGH0ZsFR1BrUOaH9smhvCiierE/sycF0XyZ0XwKqOycSVvi9T7iT
         mcos4jLxYUOhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E21D5E85B8C;
        Mon,  4 Apr 2022 22:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for
 aarch64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164910961292.9198.7184406194523003743.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 22:00:12 +0000
References: <20220404142101.27900-1-iii@linux.ibm.com>
In-Reply-To: <20220404142101.27900-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, bpf@vger.kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  4 Apr 2022 16:21:01 +0200 you wrote:
> attach_probe selftest fails on aarch64 with `failed to create kprobe
> 'sys_nanosleep+0x0' perf event: No such file or directory`. This is
> because, like on several other architectures, nanosleep has a prefix.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/test_progs.h | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for aarch64
    https://git.kernel.org/bpf/bpf-next/c/d298761746d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


