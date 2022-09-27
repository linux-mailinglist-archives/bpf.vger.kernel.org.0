Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49295EC554
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiI0OBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiI0OBa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 10:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2115E465
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 07:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6069619D9
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 350A1C433D7;
        Tue, 27 Sep 2022 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664287215;
        bh=eRlTaRORoioYKLgDKMjIrnh2nsPGmWos3QbCfKu/h54=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UcmqG9+2PBFYdFZ3OjeY5sJhn/IZN4BKElprVtofj9h51kfsn3cXFSW0qGY7UYDhB
         R4kWs2LpA/1SgfMeVdd7SR3k59ExV1UiNSjQhaXKQ2KyvbVCi5XtgLRvFFWxNqATn8
         i6cq5ejgUDPuC87STabGoJODqquDrQc4RUlVOiSuC7veSE/qckY2ZUuyvfxGVUMpib
         2ox3fx2tacp/1mTWxV/9sldIek4RD5IsQ9WHGRWCOXC4brz4eGi/txxlr4kw87tWod
         TgojDE7LOZb463oqOvrwZWqntESq4OVFwOw0xbB8m6j/GgsCJ3KTpWOgYfQgnUhEQy
         QmneXlApmdcMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E66DE21EC3;
        Tue, 27 Sep 2022 14:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests: bpf: test_kmod.sh: fix passing arguments
 via function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166428721505.21143.13973450052805090752.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Sep 2022 14:00:15 +0000
References: <20220926092320.564631-1-ykaliuta@redhat.com>
In-Reply-To: <20220926092320.564631-1-ykaliuta@redhat.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, liuhangbin@gmail.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 26 Sep 2022 12:23:20 +0300 you wrote:
> Since the tests are run in a function $@ there actually contains
> function arguments, not the script ones.
> 
> Pass "$@" to the function as well.
> 
> Fixes: 272d1f4cfa3c ("selftests: bpf: test_kmod.sh: Pass parameters to the module")
> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests: bpf: test_kmod.sh: fix passing arguments via function
    https://git.kernel.org/bpf/bpf-next/c/2702c789996d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


