Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3761A590
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKDXUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKDXUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E2BCA3;
        Fri,  4 Nov 2022 16:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22E962395;
        Fri,  4 Nov 2022 23:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32572C433D6;
        Fri,  4 Nov 2022 23:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667604016;
        bh=iRJkOVQyHmjbtDtLJkheDsjHeL9aqw1CaciBsYEkuG4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EKbQU5ZyzfA3RD/2n80ij2F/38RlFloYIO8YQtHTvq96NgZtECvrAgPlOqAL+I//A
         56JZ7BnafeVteXGf4lhM39rlJvMk61+LL0vAyWZSBeOFyA/gs5QYJPlvPWJofngUm7
         bAJWbd1WD7j3pg/Pbw6P360pYnzEdi2POWiaOKNNcDVNo41rSWh8GW7ON5mH0Au7sq
         NRB8mVWHncSVw/5+Syv66oDJ/PUjokB3JBEor+PfPQFOqFQDenasLXqsFWwLzYRJpK
         mGnlEV7y0auc/EnpQc7RrFRzVSqPKwnfaheSdqmN0qY92ePpmLxmcloGLRgmpxtcIL
         xeJYocHSMb43A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E850E29F4C;
        Fri,  4 Nov 2022 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF type
 name prefix
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166760401605.11022.14543244621373607639.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Nov 2022 23:20:16 +0000
References: <20221104123913.50610-1-bagasdotme@gmail.com>
In-Reply-To: <20221104123913.50610-1-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        corbet@lwn.net, void@manifault.com, memxor@gmail.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri,  4 Nov 2022 19:39:14 +0700 you wrote:
> Sphinx reported unknown target warning:
> 
> Documentation/bpf/bpf_design_QA.rst:329: WARNING: Unknown target name: "bpf".
> 
> The warning is caused by BPF type name prefix ("bpf_") which is written
> without escaping the trailing underscore.
> 
> [...]

Here is the summary with links:
  - [bpf-next] Documentation: bpf: escape underscore in BPF type name prefix
    https://git.kernel.org/bpf/bpf-next/c/25906092edb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


