Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9A63E302
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 23:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiK3WAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 17:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiK3WAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 17:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD62769F9
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 14:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40C2CB81D11
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 22:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9378C43470;
        Wed, 30 Nov 2022 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669845618;
        bh=JVOZYkhcHGIinhoIRQ7JewtuCbnlKcoyH4EI+4kUwr8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KYakUZReGPtjcV7Elb1K/N5FP4zMI0NsniCicLjoUZ8Hi6WwGiXbBhJoIq9Ltk6dS
         AzZ/QeJsssmLMT+et2oc1PhIK/cFKNIIE4U/OtAtuOhZWBmGihlyTCj2fcL/yu5OCY
         GZ3YHU0uJV1Y8EPjc4e44zkjakJJjcUkvQzoeHVqvQH7oE6xrsSk4v2GcX92a2wKZi
         iNNh0VuR+tbqauGqkbvaOD8mkAhUm4bOjne8g9MRSdQjhRdUGjS1CvBXaBpbpPztLe
         HiepKyQb9kAez7H5Hxwll2+N1nSLE+9AtIkFJkxpHNz2CSQJLP6MBW1okzrVQRagOw
         TKYiMjkzS8G6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFF7FE29F38;
        Wed, 30 Nov 2022 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: avoid enum forward-declarations in
 public API in C++ mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166984561784.15567.17028344819753502325.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Nov 2022 22:00:17 +0000
References: <20221130200013.2997831-1-andrii@kernel.org>
In-Reply-To: <20221130200013.2997831-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 30 Nov 2022 12:00:12 -0800 you wrote:
> C++ enum forward declarations are fundamentally not compatible with pure
> C enum definitions, and so libbpf's use of `enum bpf_stats_type;`
> forward declaration in libbpf/bpf.h public API header is causing C++
> compilation issues.
> 
> More details can be found in [0], but it comes down to C++ supporting
> enum forward declaration only with explicitly specified backing type:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: avoid enum forward-declarations in public API in C++ mode
    https://git.kernel.org/bpf/bpf-next/c/b42693415b86
  - [bpf-next,2/2] selftests/bpf: make sure enum-less bpf_enable_stats() API works in C++ mode
    https://git.kernel.org/bpf/bpf-next/c/f8186bf65ae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


