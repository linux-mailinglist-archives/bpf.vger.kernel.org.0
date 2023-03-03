Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053696A9171
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 08:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCCHKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 02:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCCHKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 02:10:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25D18A92;
        Thu,  2 Mar 2023 23:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF5D1B816C8;
        Fri,  3 Mar 2023 07:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41EE4C433D2;
        Fri,  3 Mar 2023 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677827418;
        bh=BL65YvtubUX7PMK83OHkJBiECyMu8eNBUr/lX/45iuY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E1WZ0E7z98qJglSJrVqSqcwGRIatQpbGXsAEOCys7HwJOOGGQDn7qypP3zimKWC2s
         gjXtC0imLWebR5X6NsbhtpcTNhFk4Roj0MdbIK1LU0H9h6oKeo4rnvMrw+T3GjAhu9
         oCqmgNtII3m+tt+BPmIiJRnkZIzqyQYFs1IvjuRxG3/nU73aWGkOuFw9AgrtE37dKH
         itTDVmMJ0bbumTWg7qpSmEEV2+cCP8iSfAJZ5ydnZXbpra1axAX4yM9BvHkRcvfhDI
         lyp1eG3xeB7apRpozzbn6ls3I2I4W4nVm5mC1xc+7gq5sFZG5VDfyt47ZWf06R0XiB
         HxLfRTabj5vQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20B21E68D5F;
        Fri,  3 Mar 2023 07:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 0/2] bpf: Absolute timer support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167782741813.30686.8858379957905019546.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Mar 2023 07:10:18 +0000
References: <20230302114614.2985072-1-tero.kristo@linux.intel.com>
In-Reply-To: <20230302114614.2985072-1-tero.kristo@linux.intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Mar 2023 13:46:12 +0200 you wrote:
> Hi,
> 
> v2 of this series just adds the selftest support. Patch #1 is modified
> slightly (bpf.h modified under tools/include) so that the new selftest
> compiles properly. I also added suggested-by tag from Artem whom I
> forgot to add in the initial upstream post.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,1/2] bpf: Add support for absolute value BPF timers
    https://git.kernel.org/bpf/bpf-next/c/f71f8530494b
  - [PATCHv2,2/2] selftests/bpf: Add absolute timer test
    https://git.kernel.org/bpf/bpf-next/c/944459e88b4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


