Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C15BB505
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 02:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIQAaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 20:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQAaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 20:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A27A52D;
        Fri, 16 Sep 2022 17:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E8D362DD1;
        Sat, 17 Sep 2022 00:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54DFAC433C1;
        Sat, 17 Sep 2022 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663374615;
        bh=qyTbOVBRLn1Ohw1NH3eeV8IiuE2MnxAZbyVK1Z/cGp4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RadtOxCRUzi7jG7dbVPr8DC0hXZ3etp7hWka1roVSliUIVB4F3S2NkfN7AY6yvKck
         rR/AW75KlF0PgWDMFvHc8o9RhFDOT6Zi53XFfxqkH3OtvXuMaaUh1pjHhAtZFp2mKl
         yVA22n6MOD7zv5enWh7v5Z39wNco9eNpMqZFLGLTnDoNb+ow17al3ABAOkETHLYxtn
         iPVaGrpfALd3p4XneZ20pt2rWVKGjNStx2KEJBNrPqKqxGfwZ75FwLlg7hATZ/EcVE
         KiGdjfEfntzRUJEtIULNmgNYxkEyrT23H4D1Yaf379wzWTMlORIMvxBrxLpxoxsqew
         YuALbXIU/di6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 372A2C73FEF;
        Sat, 17 Sep 2022 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf/btf: Use btf_type_str() whenever possible
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166337461521.10363.5012920273929105256.git-patchwork-notify@kernel.org>
Date:   Sat, 17 Sep 2022 00:30:15 +0000
References: <20220916202800.31421-1-yepeilin.cs@gmail.com>
In-Reply-To: <20220916202800.31421-1-yepeilin.cs@gmail.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     martin.lau@linux.dev, peilin.ye@bytedance.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
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

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 16 Sep 2022 13:28:00 -0700 you wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> We have btf_type_str().  Use it whenever possible in btf.c, instead of
> "btf_kind_str[BTF_INFO_KIND(t->info)]".
> 
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf/btf: Use btf_type_str() whenever possible
    https://git.kernel.org/bpf/bpf-next/c/571f9738bfb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


