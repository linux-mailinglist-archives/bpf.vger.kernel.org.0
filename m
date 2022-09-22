Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FAA5E6D7E
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiIVVA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiIVVAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 17:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB0B2DA8
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 14:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107F262EAB
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65268C433B5;
        Thu, 22 Sep 2022 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663880417;
        bh=92aKVlAiPt5ykpe91j8t+fg56O/8PDu1b/aseKR94cw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ecd+wMEZi1MQOX6duraf1YvFRFs6mlXdb1hr7QLnCxOFnk5QUnST71vzUuGBrvNG3
         30zvNSgBKzV8JEFJmTl3j5bc6LdXLH6iL6amGGYF0brNDubb0YfZ9AHjUAmqTOPHhE
         Heti5XNtyoeC2Jvbpxkr6a0u4Zq3eyORIb/XvQi1JjymayqYolUjFrrrY66AdnIC8a
         1yyI9J7FYD1z6hItldZh61BX2ql8MEQbWOsoOh2jkA/P9efRoZYDp0iq1LXPy2QYPC
         QA62VgPqfq9SUl/gPAdhTJsqK7f6IecrJR54j8mYSCpfUl+NnXzG/vvHv1EdAOUe3k
         OZJYM5/u6firQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46320E4D03E;
        Thu, 22 Sep 2022 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add liburandom_read.so to
 TEST_GEN_FILES
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166388041727.16958.5249979566996384705.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 21:00:17 +0000
References: <20220920161409.129953-1-ykaliuta@redhat.com>
In-Reply-To: <20220920161409.129953-1-ykaliuta@redhat.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        vkabatov@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 20 Sep 2022 19:14:09 +0300 you wrote:
> Added urandom_read shared lib is missing from the list of installed
> files what makes urandom_read test after `make install` or `make
> gen_tar` broken.
> 
> Add the library to TEST_GEN_FILES. The names in the list do not
> contain $(OUTPUT) since it's added by lib.mk code.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add liburandom_read.so to TEST_GEN_FILES
    https://git.kernel.org/bpf/bpf-next/c/b780d1671cf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


