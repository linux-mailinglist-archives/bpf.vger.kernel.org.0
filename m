Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002F75BF1F6
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 02:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIUAaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiIUAaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 20:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ECA61B27;
        Tue, 20 Sep 2022 17:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9265B621CB;
        Wed, 21 Sep 2022 00:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD4FBC433D7;
        Wed, 21 Sep 2022 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663720215;
        bh=cTqYbdRcBHWww8iw1AD22jkblXYSWxFNQO4+ffNaujA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=puPHizb4d//ODdJLBsq80f4qr7sDFaXQuV9vv77xpKSSML/AH+572xGo2bKKTmYOf
         nWUDmEstoRsf3LTZsYwbvVgkdUXG2Xn4VwIjlCpvPd1qGgCFZz6R3GkAIRzgZqkWKg
         dutMW6z6w5rJ88h4w7HHypfYI8wbabIxgxwGcrkbIhk1ktdkFv65P1Ib6DcHKJK5uf
         mkQDs1CZby/gMJs+hY4tIQTxr8Lwcrjiq55eKKoh5GUUABFCJ3GoWdT+XHp4AeFy5d
         ZIQcbMLDVsm/KlDZ+C4BTFugYUeqTaOjyKwegORr4rr5FA7ua0IxFToXgGMz7bdJ/e
         /uDDGsSecc/Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9508E21EE2;
        Wed, 21 Sep 2022 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: Replace blk_account_io_done() with
 __blk_account_io_done()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166372021474.352.13363570014654346928.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 00:30:14 +0000
References: <tencent_1CC476835C219FACD84B6715F0D785517E07@qq.com>
In-Reply-To: <tencent_1CC476835C219FACD84B6715F0D785517E07@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     sdf@google.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        rongtao@cestc.cn, song@kernel.org, yhs@fb.com
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

On Sun, 11 Sep 2022 21:03:30 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit be6bfe36db17 ("block: inline hot paths of blk_account_io_*()")
> blk_account_io_*() become inline functions.
> 
> Signed-off-by: Rong Tao <rtoax@foxmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: Replace blk_account_io_done() with __blk_account_io_done()
    https://git.kernel.org/bpf/bpf-next/c/bc069da65eec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


