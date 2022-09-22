Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5588B5E573A
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIVAUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 20:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIVAUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 20:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C79F0FF
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 17:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AC2AB83347
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 00:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36729C433D7;
        Thu, 22 Sep 2022 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663806014;
        bh=d4+QFJ+biREcE7U+4zzBh9NgMxxogsMDupOAs+jBy4M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Nc6zuaOJs+sjV36Sy3IUYxph0IZvKx8SbHhWS5oJsDqyCoet8BGw+glRxwXKhoBYe
         43EgOpyBb6jx/8tTye4SkTF6Z0kimR3SfNqrcHHmQmBSUaSqHWvbTVVPA7qQd8XyvH
         6ksT1riTxdH2jKT1/XgS5pP5gplGH/Zze9T6lrexybgWXThxDzBHbPhGaWVGQEaLLx
         v+4bX+PAezaifUrI16JlyElzeCbaDzDEiSHcePE5zbxjFZ2nCHv/oezveFTBEOuOGa
         r3K5MXLWel9ZaX+YCB0qU7OwK9lnWgRo0IN7s4ANLa8ny1iw0I6Ymb9ObLBVLK3eqc
         yCObvjntXNicQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 181BEE4D03D;
        Thu, 22 Sep 2022 00:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests: bpf: test_kmod.sh: pass parameters to
 the module
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380601409.30764.10238371292586600204.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 00:20:14 +0000
References: <20220908120146.381218-1-ykaliuta@redhat.com>
In-Reply-To: <20220908120146.381218-1-ykaliuta@redhat.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net, song@kernel.org
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

On Thu,  8 Sep 2022 15:01:46 +0300 you wrote:
> It's possible to specify particular tests for test_bpf.ko with
> module parameters. Make it possible to pass the module parameters,
> example:
> 
> test_kmod.sh test_range=1,3
> 
> Since magnitude tests take long time it can be reasonable to skip
> them.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests: bpf: test_kmod.sh: pass parameters to the module
    https://git.kernel.org/bpf/bpf-next/c/272d1f4cfa3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


