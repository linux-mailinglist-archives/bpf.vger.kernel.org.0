Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FD6C862F
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCXTu1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjCXTuZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 15:50:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B120042
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13013B82437
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3F70C433D2;
        Fri, 24 Mar 2023 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679687418;
        bh=0Hy5u4cvLpSa+lGNlckbUEGqgfTOIjOrfU7EawF02U4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FE5gvmFq0alvglJ1G5ByeNSJZB+U59XwvYIdm7mRXHohuHc5S2EwdFa8LLfbFvq43
         4os2C1XIw5T6zxEbe7EfE4EJBdjb4AzZLE4m4wu7OD4yd8o2eBA8pM3zYnGsGRRAsd
         YoS+Pjkr1Voo1mlqFtTgwpEIxnKqt5upH2VCn/koe7OyWzlXA0H9yaN2gA//6EoRNp
         Xjd06ZAjjOGlSqltne4aSswnY2OKpn8wFLUrd+wPaZsJog+PYR4nGi2G5zRNhsUmFU
         Ehd+hGW3+rMVqd7GfULF3DeTYYhmVAaHvBcbcBkEwuh6ylv2xScOW0ftGOCGWQzR+T
         /hI7U70ft5dng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BE02E2A039;
        Fri, 24 Mar 2023 19:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check IS_ERR for the bpf_map_get() return value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167968741863.13374.17216973053184162920.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Mar 2023 19:50:18 +0000
References: <20230324184241.1387437-1-martin.lau@linux.dev>
In-Reply-To: <20230324184241.1387437-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com,
        syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
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

On Fri, 24 Mar 2023 11:42:41 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This patch fixes a mistake in checking NULL instead of
> checking IS_ERR for the bpf_map_get() return value.
> 
> It also fixes the return value in link_update_map() from -EINVAL
> to PTR_ERR(*_map).
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Check IS_ERR for the bpf_map_get() return value
    https://git.kernel.org/bpf/bpf-next/c/55fbae05476d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


