Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892DE629C43
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKOOkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 09:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKOOkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0431DF1F
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 06:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711E7617C2
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA563C4314A;
        Tue, 15 Nov 2022 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523215;
        bh=UDNJWbRBBDJ3c10DY/CGnm7Dhp6ninPzItxC0AsaFB0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nYk0p8uGHy7/Pf2HKUvV2tBhDUz1geOfWw2GSESF6KM4S9yODnVHaENbuDtM5d5aR
         ggmW90MC6Pd9tfLLRCkZoRE6QVgoBr921GRmoKhCRCDyTwsy+A+RXFcDgfFJ9STtGf
         sqgPhrS3OkOtr4IX7JheWabJmFmwKCCibFQaIfpJCu9q0slgYHgSpEfOu0PSviSktR
         kwxEfYJPwK1bkbcxkpY0m9uEXs0SiCNQKGPazPVmV3gkq7KRDsuCnui1fdIgHoy2b9
         c/jPin7RsCkk9Ez8AMIBCtkG1CWXfiS7nvgoX1NhhoC1lhkWrDbN6rIZZitp+aomAn
         Opjm+9kcCeB+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7F53C395FE;
        Tue, 15 Nov 2022 14:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs/bpf: Document how to run CI without patch
 submission
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166852321575.8656.7700058541583153256.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Nov 2022 14:40:15 +0000
References: <20221114211501.2068684-1-deso@posteo.net>
In-Reply-To: <20221114211501.2068684-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        quentin@isovalent.com, eddyz87@gmail.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Nov 2022 21:15:01 +0000 you wrote:
> This change documents the process for running the BPF CI before
> submitting a patch to the upstream mailing list, similar to what happens
> if a patch is send to bpf@vger.kernel.org: it builds kernel and
> selftests and runs the latter on different architecture (but it notably
> does not cover stylistic checks such as cover letter verification).
> Running BPF CI this way can help achieve better test coverage ahead of
> patch submission than merely running locally (say, using
> tools/testing/selftests/bpf/vmtest.sh), as additional architectures may
> be covered as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next] docs/bpf: Document how to run CI without patch submission
    https://git.kernel.org/bpf/bpf-next/c/26a9b433cf08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


