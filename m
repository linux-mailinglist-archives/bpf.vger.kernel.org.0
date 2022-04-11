Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716DC4FB193
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiDKCCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Apr 2022 22:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiDKCC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Apr 2022 22:02:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C3326F4
        for <bpf@vger.kernel.org>; Sun, 10 Apr 2022 19:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5C62B80EED
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 02:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C65C385A1;
        Mon, 11 Apr 2022 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649642411;
        bh=PvW6J7Bgmjk0NW9+Z6DcJeKGxghbxiere9v1NE9QjBU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IjD1wDHl80XflUH0JP/Be+Y4diDniYXnHviRvxMOrw+LqgKbRoX5F52uNtqAkaRgk
         jbQ5TT4KITCeUIFKzI/1Uga01HQGSr2IDPR3Tp2py00doIyHGU2tzXxCwXW1Yiijvw
         P5oFgMZ2Tx2a7z++u38kNxW7Jqr5h36r+gxchZrTZKauZvixTKJRkuT8vOE0YklJEX
         Ot0zysAPueQtEaptoxPeJBZxnadRVhOE6SJRHHkytlYxGPpYWaduSDbQd+t1spSjCK
         +XTWkKTNUtRBAUIpZ+7Y+UHJhN7/pqZ31HwtrXRVZYw4lN9RZXd8jO7WRMstjt1Kn4
         l2bUxwVG8567g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71DC7E6D402;
        Mon, 11 Apr 2022 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: add ARC support to bpf_tracing.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164964241146.8585.15262767390863920010.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 02:00:11 +0000
References: <20220408224442.599566-1-geomatsi@gmail.com>
In-Reply-To: <20220408224442.599566-1-geomatsi@gmail.com>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     bpf@vger.kernel.org, isaev@synopsys.com, vgupta@kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  9 Apr 2022 01:44:42 +0300 you wrote:
> From: Vladimir Isaev <isaev@synopsys.com>
> 
> Add PT_REGS macros suitable for ARCompact and ARCv2.
> 
> Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: add ARC support to bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/073859985654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


