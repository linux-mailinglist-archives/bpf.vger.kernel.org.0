Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A595A4EB7
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiH2OAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiH2OAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 10:00:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5631B7A3;
        Mon, 29 Aug 2022 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35207B81087;
        Mon, 29 Aug 2022 14:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBBAEC433D7;
        Mon, 29 Aug 2022 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661781616;
        bh=f24Hdlt2fPIkAUzXmijLjWqUIfWBSBOdO9S/34q2NLg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PpQ3uM8/lo2mmePZkinbY6Bwq1/ZdhpSD0UlGs5/jP5a/coUM0CNN9lE2CnDAU/Ok
         XPB85BfmyYB0uJZAqzWcB1g4y54k1iz9J0ZcKLmKHLJ/rRjLJ1HcAG9fGeOk/wK3DV
         Tscbqf7jgUuuMvx9qHt5Ppm4wNDQCiKCePpBI0DSxBRinaYh1D1er4seOPY74GQosH
         v65oL1AuUovu/tfw0u1wEJseAqdQYNdaA6jSNfdukxM17q3dkG0plLy7gjiFgeaWRw
         +Fm62JQgn2+ugETH28VX3dHa0hXsIph/y+DEWJckwu4dLZOedI0mO5+vbcwHO7215I
         YWDHvxs4M0O8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0C51E924D6;
        Mon, 29 Aug 2022 14:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 mips: No need to use min() to get MAX_TAIL_CALL_CNT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166178161672.22044.323887276798287961.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 14:00:16 +0000
References: <1661742309-2320-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1661742309-2320-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        tsbogend@alpha.franken.de, bpf@vger.kernel.org,
        linux-mips@vger.kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 29 Aug 2022 11:05:09 +0800 you wrote:
> MAX_TAIL_CALL_CNT is 33, so min(MAX_TAIL_CALL_CNT, 0xffff) is always
> MAX_TAIL_CALL_CNT, it is better to use MAX_TAIL_CALL_CNT directly.
> 
> At the same time, add BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff) with a
> comment on why the assertion is there.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Suggested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, mips: No need to use min() to get MAX_TAIL_CALL_CNT
    https://git.kernel.org/bpf/bpf-next/c/bbcf0f55e578

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


