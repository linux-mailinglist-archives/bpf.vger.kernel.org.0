Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA144B2F5E
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353651AbiBKVaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 16:30:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352860AbiBKVaO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:30:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE03C57
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4F8AB82D2F
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73AA8C340F0;
        Fri, 11 Feb 2022 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644615010;
        bh=gTOoTTpkcld0+VdOnr3JU/35x81oepnpIgl1ox/MBKc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cvCleHvXOdUoNTOJundgiE+0zdIWlj6aWliOIEoRfStyxm6x0+TX4f1Jg5vErqoNm
         Tm06KKhWZTsNotXjffjE0+GbL/gNDNXcRPpzLK1fwBkd6aLDCtTFkxCC3pVve3vMBA
         aK4bCdUzJvavXqnZ3tLxAWeAUchZD8S5o86TwXylpjRiTO2YcC/Ge2uD4yY/VcubZJ
         8eoJJsE73fytGSAPW3qtFzcMCfUquiBohFebXl223zOdQJDV6dKZcsIC9QBpyte/2I
         aWG5WqM12nahJ9lSsBYiWovwIpbIwmSyUnVpslvQhkmFptAEAQZnbd908jOxvtkeYu
         ar6YE7O+g0w4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E586E5D09D;
        Fri, 11 Feb 2022 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: fix a bpf_timer initialization issue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164461501038.10199.4843368758097321221.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 21:30:10 +0000
References: <20220211194943.3141324-1-yhs@fb.com>
In-Reply-To: <20220211194943.3141324-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, memxor@gmail.com
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

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Feb 2022 11:49:43 -0800 you wrote:
> The patch [1] exposed a bpf_timer initialization bug in function
> check_and_init_map_value(). With bug fix here, the patch [1]
> can be applied with all selftests passed. Please see individual
> patches for fix details.
> 
>   [1] https://lore.kernel.org/bpf/20220209070324.1093182-2-memxor@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: emit bpf_timer in vmlinux BTF
    https://git.kernel.org/bpf/bpf/c/3bd916ee0ecb
  - [bpf,v4,2/2] bpf: fix a bpf_timer initialization issue
    https://git.kernel.org/bpf/bpf/c/5eaed6eedbe9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


