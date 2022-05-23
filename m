Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6311A5318F4
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiEWUAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiEWUAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 16:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C67A807
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 13:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E2326140D
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 20:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 972F7C34115;
        Mon, 23 May 2022 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653336012;
        bh=2ApgDAMrwHYJRvhcakA/QPtHJUi0qgv/0Vqjsyf87Xg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UFkTOTvScIPHS875tXGj1WuFvrhGRaOQS9S7JQ6tFZ2z2GgvhlB3sFSQB0mtyJJpb
         pTgqtyeHTm9LjnGJHo/oO0d7HOLgwJJU6PRE7kgqJ33az022NxsDJSBXR4xBkpiQWO
         fCFDW6ffcRT1v3/5Y97sPdIbQGg1MHssYTXOv3IlWTzMTXf7seDuhkEZRabKbPTZlE
         JivE/jVJHX3I27HU0pUSeHOQ9dVBVymilQtZvTqQ8a/IxkzVL+pjZW+Q0vw2sCEp/Z
         VCvWFS+8h3ZrKhCX7EZYOBWpvPmIApU6Yog+8qpZ1Ai1mpTm8z5+iUdXMQlNICsYdV
         r4MYb1FUTn8kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 778D3EAC081;
        Mon, 23 May 2022 20:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix btf_dump/btf_dump due to recent
 clang change
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165333601248.24888.11360657395318959311.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 20:00:12 +0000
References: <20220523152044.3905809-1-yhs@fb.com>
In-Reply-To: <20220523152044.3905809-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, mykolal@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 May 2022 08:20:44 -0700 you wrote:
> Latest llvm-project upstream had a change of behavior
> related to qualifiers on function return type ([1]).
> This caused selftests btf_dump/btf_dump failure.
> The following example shows what changed.
> 
>   $ cat t.c
>   typedef const char * const (* const (* const fn_ptr_arr2_t[5])())(char * (*)(int));
>   struct t {
>     int a;
>     fn_ptr_arr2_t l;
>   };
>   int foo(struct t *arg) {
>     return arg->a;
>   }
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix btf_dump/btf_dump due to recent clang change
    https://git.kernel.org/bpf/bpf-next/c/4050764cbaa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


