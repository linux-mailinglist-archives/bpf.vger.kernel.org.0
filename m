Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6BB674C77
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjATFee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjATFeL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:34:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9672C16
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 21:30:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA01EB8278D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83C1BC433F1;
        Thu, 19 Jan 2023 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674171017;
        bh=9ylwBSE9zBvlG4CIZqxjHSe+fYRrl1j595516h+sdc8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HdU3OpPnDdIBJInX0XFWorljEMemzDu50eHPrcS/w5N+KWplaRGT3aW7aOFm5MQGK
         qXTtGV/FlZuZY6HFHb/bgzmqo22A2nwcOBzqIJEgLM1M9CHg+a/RZosN2Ms8Hs8cSu
         0E8sIvp5Nug1xhwwVSENwKoRjhln4rE9FgKh/kDmGWvmlf3o7hjutHi383Z1cvzT2f
         X5zXP35pQVCs4wv3EeaANPQrDwz5CZSrExDSpf4YsMxPGusId3HAAaeBAvFCmIdiOI
         Ho70yQfa207+zUUbXkkNDdLXnMSqFlizgFRdaoxrXWr+fBbsJU6n4FUQnlqjymVLaN
         5C4vLE04wOPCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6232EC39563;
        Thu, 19 Jan 2023 23:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live fields
 when copying range info
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167417101739.14186.1975937279783014146.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Jan 2023 23:30:17 +0000
References: <20230106142214.1040390-1-eddyz87@gmail.com>
In-Reply-To: <20230106142214.1040390-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Jan 2023 16:22:12 +0200 you wrote:
> Struct bpf_reg_state is copied directly in several places including:
> - check_stack_write_fixed_off() (via save_register_state());
> - check_stack_read_fixed_off();
> - find_equal_scalars().
> 
> However, a literal copy of this struct also copies the following fields:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Fix to preserve reg parent/live fields when copying range info
    https://git.kernel.org/bpf/bpf/c/71f656a50176
  - [bpf-next,v2,2/2] selftests/bpf: Verify copy_register_state() preserves parent/live fields
    https://git.kernel.org/bpf/bpf/c/b9fa9bc83929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


