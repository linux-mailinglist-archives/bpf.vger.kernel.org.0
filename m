Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3364C1AA
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 02:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiLNBI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 20:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiLNBI0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 20:08:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1E22534;
        Tue, 13 Dec 2022 17:08:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19CB6B8161F;
        Wed, 14 Dec 2022 01:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE3A8C433EF;
        Wed, 14 Dec 2022 01:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670980098;
        bh=OWOaO9+OnQafvqBbbccnRageLSrysGQzYa1feqvW4u4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ejr84DgC/6ARuR32AjFlg25qvGYazzHYK78wKNDpzvZK6lnxZG29D0j3JR09XiU9b
         Qa9uhU2VPZI8Pftw/qjvf/imJUg8FMQQ7z5r0BrDuVQWe8FhX6dhzGDXzAZu3TASWA
         feADZbKVMCU5YKBP8KyslwSWpDjrThWHRRIroVVy5EUvVoGYU1oO3Zi4OK5L+cv2WX
         XOHSFO85wN6yGsYexWG5f9dN3S1M5W1VX3ceplJ3x484kp3w2FwkObH/tiylksVGtn
         +Ei7f6hMj6IiRkyo5hFMNIkFKk+yxYyLiTkCMeS0eGYPwOyWXSY4VzkID+CaawL9yi
         5ik+Hp6L8/zMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 947CEC41612;
        Wed, 14 Dec 2022 01:08:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Dec 2022 01:08:18 +0000
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     corbet@lwn.net, paul@paul-moore.com, casey@schaufler-ca.com,
        omosnace@redhat.com, john.johansen@canonical.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (master)
by Paul Moore <paul@paul-moore.com>:

On Fri,  9 Dec 2022 09:29:35 +0100 you wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> The fs_context_parse_param hook already has a description, which seems the
> right one according to the code.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> [...]

Here is the summary with links:
  - [1/2] lsm: Fix description of fs_context_parse_param
    https://git.kernel.org/netdev/net/c/577cc1434e4c
  - [2/2] doc: Fix fs_context_parse_param description in mount_api.rst
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


