Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7785A6BCD
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiH3SKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiH3SKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 14:10:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0453E03D;
        Tue, 30 Aug 2022 11:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37DC6CE1D50;
        Tue, 30 Aug 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C59FC433B5;
        Tue, 30 Aug 2022 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661883014;
        bh=E+0GumMHf43GJMuL3WMp/UctvGywv4fE3+GG2pVbefI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kMhcJTkY+gshHETkMEvi7CUT1MtuxyYeVMZCm5Mkim1LctQhkA5NMxsi8pywxhPwy
         vgo19gL8/YwPgLJlPM0j40f3OlzlsWfUGRMzGprR/SETQbNue51H1EmNC6u7he+g6g
         3cNAcAYA+mutfpUs3cRA5ItO4SQqfnslf1x12LaGyXPsZdZUgOeC9ryK5/6gxkyBhf
         PVpQREvT0zoabEsrVBr7XQi6Y6fI6aBHHCS/TxvlQsmElHCeHMUGKD1Qv81elhUWII
         xgNzIt2wDSMMLGM2VWJdyYrq0kJ3GW4WoCrqKX8v81U/eatwwm5BGCLCmH8lQYhzl5
         m4irxq+y7nGrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45304E924D8;
        Tue, 30 Aug 2022 18:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter
 link
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166188301427.32674.16752744307188143944.git-patchwork-notify@kernel.org>
Date:   Tue, 30 Aug 2022 18:10:14 +0000
References: <20220829231828.1016835-1-haoluo@google.com>
In-Reply-To: <20220829231828.1016835-1-haoluo@google.com>
To:     Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
        yosryahmed@google.com, quentin@isovalent.com
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
by Martin KaFai Lau <martin.lau@linux.dev>:

On Mon, 29 Aug 2022 16:18:28 -0700 you wrote:
> Support dumping info of a cgroup_iter link. This includes
> showing the cgroup's id and the order for walking the cgroup
> hierarchy. Example output is as follows:
> 
> > bpftool link show
> 1: iter  prog 2  target_name bpf_map
> 2: iter  prog 3  target_name bpf_prog
> 3: iter  prog 12  target_name cgroup  cgroup_id 72  order self_only
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpftool: Add support for querying cgroup_iter link
    https://git.kernel.org/bpf/bpf-next/c/6f95de6d7131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


