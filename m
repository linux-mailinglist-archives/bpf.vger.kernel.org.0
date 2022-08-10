Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5323858E4C3
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 04:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHJCAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHJCAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 22:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393312AF5
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 19:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BA061265
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 02:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA5AC433D7;
        Wed, 10 Aug 2022 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660096815;
        bh=h++PrISgcBEXlziCAir/RW25FKYGjfRCy8sfu5LtPDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GDJDDLqRqY20BS2cA+UDB7LXQuF5PxZ0yVN8teE0/WPOSmp/zo1yzgL4IetOsVcd4
         RU/M1AEs/oovcHuBVwi96I8ujo6x8DpvEp0e46kKd8OFW9edtYy0nFUThHdcrI5lY1
         0NhlWXKR/N0E4VRtPKmQZvuPePeF2elyt6qydBIKzggEGm1KSz2P0Sc0/TvAnkvCtu
         K11PNuockT40jpmiNBMRwT9v58cM7CrV7w4ar9/kz/qGMz1xiBim7cwFrQBWZ1Nthd
         iwepyISlVOq5JGdQK9f3Jo9Z6hOpA0uI43D55VSYh+wt2prhI/P49LU6n/C8W1zMsH
         wRo3mSeZN/pag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D789DC43143;
        Wed, 10 Aug 2022 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] Don't reinit map value in prealloc_lru_pop
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166009681487.29831.12016451715348052623.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Aug 2022 02:00:14 +0000
References: <20220809213033.24147-1-memxor@gmail.com>
In-Reply-To: <20220809213033.24147-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, daniel@iogearbox.net
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Aug 2022 23:30:30 +0200 you wrote:
> Fix for a bug in prealloc_lru_pop spotted while reading the code, then a test +
> example that checks whether it is fixed.
> 
> Changelog:
> ----------
> v2 -> v3:
> v2: https://lore.kernel.org/bpf/20220809140615.21231-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: Allow calling bpf_prog_test kfuncs in tracing programs
    https://git.kernel.org/bpf/bpf/c/1f0752628e76
  - [bpf,v3,2/3] bpf: Don't reinit map value in prealloc_lru_pop
    https://git.kernel.org/bpf/bpf/c/275c30bcee66
  - [bpf,v3,3/3] selftests/bpf: Add test for prealloc_lru_pop bug
    https://git.kernel.org/bpf/bpf/c/de7b9927105b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


