Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC38507682
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiDSRc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 13:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbiDSRc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 13:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8518B26
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 10:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E333961519
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D1A0C385AB;
        Tue, 19 Apr 2022 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650389411;
        bh=6B7MWukco2g8CfN2Xdh/7rQPJDyBBQDhOPm3d5hqUcQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Sqt+8Giyns52oPMDdq1s2TuGblgnNdtdHOaKyPhPoM2UvhjBu1/pffKb91g2Gfjxf
         NHRRBQ/ekI+3OxmXTtVk63Y4L7U5X3dfsCJeW0A6T1BQ0FAYRcvDuz86bMBcHW0NVH
         /xgHhrPwPMk/gCiH1AEZ9xzMzkBj3zHqvgkALnR+JUOHjgWqAofWP+QZXNCw8EABt/
         u4FTqQHyEPvu7A2/1JzkM5AL0jqii7wapp8fWsCQIII1JQyfoWrWdtZbK2RPjbcOk1
         65LgAcdPGuCfasQP0iqnf/aO1TgtFXHxynbe56l7LfH9ESqcPo6SxHafJposRvUsFQ
         OHPhR8nHrZ8ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 310FCE8DD85;
        Tue, 19 Apr 2022 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround a verifier issue for test
 exhandler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165038941119.23729.4044950512990392090.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 17:30:11 +0000
References: <20220419050900.3136024-1-yhs@fb.com>
In-Reply-To: <20220419050900.3136024-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Apr 2022 22:09:00 -0700 you wrote:
> The llvm patch [1] enabled opaque pointer which caused selftest
> 'exhandler' failure.
>   ...
>   ; work = task->task_works;
>   7: (79) r1 = *(u64 *)(r6 +2120)       ; R1_w=ptr_callback_head(off=0,imm=0) R6_w=ptr_task_struct(off=0,imm=0)
>   ; func = work->func;
>   8: (79) r2 = *(u64 *)(r1 +8)          ; R1_w=ptr_callback_head(off=0,imm=0) R2_w=scalar()
>   ; if (!work && !func)
>   9: (4f) r1 |= r2
>   math between ptr_ pointer and register with unbounded min value is not allowed
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Workaround a verifier issue for test exhandler
    https://git.kernel.org/bpf/bpf-next/c/44df171a10f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


