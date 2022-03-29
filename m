Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381144EA5BF
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 05:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiC2DMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiC2DLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 23:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC623DE8F
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 20:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2446B61359
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 03:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C143C340F3;
        Tue, 29 Mar 2022 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648523410;
        bh=4uTJB14QGxglymshXT0/kRAigFTr8HZYmVEbWrhtUNM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fy7MzkGN+JvzIU2+uh45QKLAB7fKH8S0UqL8/NRRSpE25558TnydTThvqPqeysUcb
         V6d9+QsqVzuz/2kWg5I42wD2hKJplPSMcXI5vybFGyp+U1e+WfbDiK7M0AHyZMHM0h
         DQ6psfcylD1kYtasydUfuBPwx3sFBNVkIiMmjpjXYIKU3FYLoz79Z9clXMdMqxSeuS
         eZ7wZWdi9VP3tqa99I1vrZzJr4bWYWrvCIHff3+eTxCWOTtcXTOMvfx8vvE9tcrDgq
         iGKpQcbtUBFQF33pZ/G4YQ+C7ciTSV1Dn70JrYquchYNWo3p+AkNyCzjVx+ydOYygM
         zd/htnpkUOsPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60B61F03846;
        Tue, 29 Mar 2022 03:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix clang compilation errors
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164852341039.27405.4269508266754649125.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Mar 2022 03:10:10 +0000
References: <20220325200304.2915588-1-yhs@fb.com>
In-Reply-To: <20220325200304.2915588-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Mar 2022 13:03:04 -0700 you wrote:
> llvm upstream patch ([1]) added to issue warning for code like
>   void test() {
>     int j = 0;
>     for (int i = 0; i < 1000; i++)
>             j++;
>     return;
>   }
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix clang compilation errors
    https://git.kernel.org/bpf/bpf/c/ccaff3d56acc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


