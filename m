Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCB59A6B5
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351167AbiHSTuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiHSTuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 15:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95A9D9D44
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 12:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB5461630
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 19:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C89FC433C1;
        Fri, 19 Aug 2022 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660938615;
        bh=PnttCiNHdoEocZUB2s5ulvIj9SFgha6nzpZb4ELQQvI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZB3NHopvoUMDEoNWZmhoLSgr9QNP0eeRmBa4bTsad5Bu0dhkICyR0Ok3OUR6shEmu
         u3frm2X1gaxmsx/mdYCZHEZker7hNGB22KJby+BKR/fWkHXBS8HOEAwQnw4SaEdOUn
         F/+F2mMv3AqMhqQI8h0EQL2CngtzAP0f86LidTCdIyO7gIDSubirA8UwmmhKD5dT9e
         YDLozLW7ixg1Uk4X3Oc4RHATeZ423CC7qFg5PriuH3D7bn9AxFqSacmkLv+7aw26Yt
         ztOXtmAvVxUkN98jbZct/+DIZfrvPSEEC22sfZhtTVFMSjbRVEWQu9+6My/xlEKbM4
         5niroBgKDKJ0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71F77C43142;
        Fri, 19 Aug 2022 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftest/bpf: Add setget_sockopt to DENYLIST.s390x
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166093861545.5341.3087962805868374180.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Aug 2022 19:50:15 +0000
References: <20220819192155.91713-1-kafai@fb.com>
In-Reply-To: <20220819192155.91713-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Aug 2022 12:21:55 -0700 you wrote:
> Trampoline is not supported in s390.
> 
> Fixes: 31123c0360e0 ("selftests/bpf: bpf_setsockopt tests")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next] selftest/bpf: Add setget_sockopt to DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/b979f005d9b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


