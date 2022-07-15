Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2571575BD7
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 08:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiGOGuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiGOGuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 02:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45B54CB8
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 23:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F44B82ABF
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 06:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A983C341C0;
        Fri, 15 Jul 2022 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657867813;
        bh=ftCyZwUk9FLL5Fjm2AI/Csn/jlx7Bwr8bvPsM59HOQk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZPfq51rS6Erxhml8ltuW7GrLBKRRViF1pt5oHBQsJy8k+eFyHiM4R7PPh04SbOaD2
         IFsLe9+t/osglVx3+o0JJKhRgRspD1QIgcWiW1KV7mgkDcOrU7s5V01gvsF3a74KoD
         Mj26dY/YaJrgv2xK/6Pxcub+BwRkXOZKB0iHuCR1eL2CC2Skot9orn95gzARWgE27/
         Vy8Xtqq1iwdgGSUa5nYOhzODo5ZmKxzaNhNJbqOeLIJ4BExRz+3HNHuGZae2gkWQLR
         FwTKgkKHPcYkSOjaPiiua1EfNXTLA+3tUbMzHaILE7aR0878nCR/dPHCeIfHgd2Nv5
         UEPIMwXQpcGjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 701CEE45227;
        Fri, 15 Jul 2022 06:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix subprog names in stack traces.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165786781345.30814.10177462569943681076.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jul 2022 06:50:13 +0000
References: <20220714211637.17150-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220714211637.17150-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, kafai@fb.com, bpf@vger.kernel.org,
        kernel-team@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Jul 2022 14:16:37 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The commit 7337224fc150 ("bpf: Improve the info.func_info and info.func_info_rec_size behavior")
> accidently made bpf_prog_ksym_set_name() conservative for bpf subprograms.
> Fixed it so instead of "bpf_prog_tag_F" the stack traces print "bpf_prog_tag_full_subprog_name".
> 
> Fixes: 7337224fc150 ("bpf: Improve the info.func_info and info.func_info_rec_size behavior")
> Reported-by: Tejun Heo <tj@kernel.org>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix subprog names in stack traces.
    https://git.kernel.org/bpf/bpf-next/c/9c7c48d6a1e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


