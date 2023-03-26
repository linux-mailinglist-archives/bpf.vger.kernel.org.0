Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A176C9252
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 06:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCZEMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 00:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCZEMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 00:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D149770
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 21:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94BCAB80BA6
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 04:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C1BAC4339C;
        Sun, 26 Mar 2023 04:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679803920;
        bh=Rjd41U2sR59weQjI83zdEbe0C63Toj7U3POn5zOX8L0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K0O0kVz8pwhtqdPc1eKZ0RoLdzri2L45+mOki8IaUFynFcG+fiIhz71PqClL0quSC
         kdBMy01QGSRb+zAXgnWNE6F8sbOEwH+qJYvocofIRgG33bvu1QznkRaGSa5+sHWEgz
         7uRQyC2HZveMGfNiYGA8L756mz+NktRB1oJ5zEIUUm9qV0/76MdvxVr4NjAap1gi03
         ERWQqaadWzLTTVaAQlDcjHxcLHEI77cwem8u/X4/4vzs+WevoiM/jI/jtGzYtcimPL
         HZqp0GBRN5Q/ArZlB7MXycMrgS4u2floixikFqduBPFBvUFeQIlxwRdSh+M15jIa73
         Rl6hR0N6w50Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 017E4E55B3C;
        Sun, 26 Mar 2023 04:12:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5] bpf, docs: Add extended call instructions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167980392000.14901.12533099274998539757.git-patchwork-notify@kernel.org>
Date:   Sun, 26 Mar 2023 04:12:00 +0000
References: <20230326033117.1075-1-dthaler1968@googlemail.com>
In-Reply-To: <20230326033117.1075-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 26 Mar 2023 03:31:17 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add extended call instructions.  Uses the term "program-local" for
> call by offset.  And there are instructions for calling helper functions
> by "address" (the old way of using integer values), and for calling
> helper functions by BTF ID (for kfuncs).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5] bpf, docs: Add extended call instructions
    https://git.kernel.org/bpf/bpf-next/c/8cfee110711e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


