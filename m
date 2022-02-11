Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB74B2EFC
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 22:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbiBKVAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 16:00:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiBKVAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:00:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDDA5
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC610CE2C0B
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE896C340ED;
        Fri, 11 Feb 2022 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644613210;
        bh=+WZQoC7KY7O1Y3hbfWtClLm9qKQ8UqZW4hs/IlNSmy4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T/5aqatZNzbQ2vpFP9mdB4bbJr9FZX4AvzOj5JgEAsG//1XeaJAy5sALnjrAaaghn
         HyzWBRxt9hintFOSfCJfpa6QtRjMBKZ9PHb+gWPLXHLMfKhS5iy/20/tWOHhadSDDs
         HHAZM6Eok4R0DltmrgBPzD+BrLKHY3My5LbcjmqM6Zt+Kls5XCbGuTyjJLLMPwPoHr
         3JD1bb+nB4c0tLmTHFwbxc95JK1VlqX7ULN3RetOlbCKOUHNSrbUbRoPnG6MwMpEp9
         4yMlaISgKTXlsApLfX6HPIgxCHiRRdFkP7xdPr7fnauYi/VPzfM3GUADFnd+80oYmI
         Ouw5ZI+SLqzRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D71D2E5D09D;
        Fri, 11 Feb 2022 21:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix libbpf.map inheritance chain for
 LIBBPF_0.7.0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164461320987.28756.9414412371077892191.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 21:00:09 +0000
References: <20220211205235.2089104-1-andrii@kernel.org>
In-Reply-To: <20220211205235.2089104-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Feb 2022 12:52:35 -0800 you wrote:
> Ensure that LIBBPF_0.7.0 inherits everything from LIBBPF_0.6.0.
> 
> Fixes: dbdd2c7f8cec ("libbpf: Add API to get/set log_level at per-program level")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.map | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: fix libbpf.map inheritance chain for LIBBPF_0.7.0
    https://git.kernel.org/bpf/bpf-next/c/d130e954a002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


