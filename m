Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C95E5700
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 02:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIVAKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 20:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIVAKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 20:10:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6419320B
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 17:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D061CE1FCA
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 00:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6491C433D6;
        Thu, 22 Sep 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663805414;
        bh=wKdprAypL7B7/2oFXLHyEkqa8e8yF0CYRY2xnJbsDbI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GH3KFLJeMAui5c+ND41rAulOCZN+dGDLICMgX86M/cV4++XI0sO6nf+E2hsGSzxvT
         5UkBp+SwwzM2OiAOtWeXfI/Ah/CJyieLBmTbDF3whZ9x/6QAn0TOoUb/UriMID6eWk
         C4LYCbgc7/3tQkZR3soUNGhmmhvO4kQLHHE5UfsRQZRR2cOX+b/Lb0t/9qWEaxjqt8
         NLJ0jGCrw7+m6LP/fq4ophqHSXEA39B8RZ5wt/14BdM2o7OwY0P3BXQn73muuEV7wb
         yp8V9AS+/Rc460TqbCE879YYZ6I1tyfqhBMKohHvIllqMgG9w+i5vTUIED7Y0y6tAq
         4sBYmyhh+PT3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA2D2E4D03D;
        Thu, 22 Sep 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Improve BPF_PROG2 macro code quality and
 description
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380541469.24155.14310055411423467013.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 00:10:14 +0000
References: <20220910025214.1536510-1-yhs@fb.com>
In-Reply-To: <20220910025214.1536510-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

On Fri, 9 Sep 2022 19:52:14 -0700 you wrote:
> Commit 34586d29f8df ("libbpf: Add new BPF_PROG2 macro") added BPF_PROG2
> macro for trampoline based programs with struct arguments. Andrii
> made a few suggestions to improve code quality and description.
> This patch implemented these suggestions including better internal
> macro name, consistent usage pattern for __builtin_choose_expr(),
> simpler macro definition for always-inline func arguments and
> better macro description.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Improve BPF_PROG2 macro code quality and description
    https://git.kernel.org/bpf/bpf-next/c/9f2f5d7830dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


