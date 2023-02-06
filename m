Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA70268C9B0
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 23:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBFWkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 17:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjBFWkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 17:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631930292
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 14:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB7D61059
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 22:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48465C433EF;
        Mon,  6 Feb 2023 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675723217;
        bh=utveTFJvtbZ9WJsBu+VHukrZb4z0N30a0dcHC1a9By8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uHEVO7p4AOHBNfRZgarnWT6JZyTaIfOtB96yWAccp2j9FYEmwDMebz/jZ3rL1Sb9K
         SJNv8MxrSymS0kYI2mnwvQ57STNY8lxgCwh+1695ZUGkmKjdD327xfesfnKij09h+Y
         LHNcig0ZPpIRhCfArltr2MKE0oApDyGuqiRbxqcnE7CBibRwv4AVJ84TWndEC/PNO2
         G4urdzpm14w4jutAjYVkvpfhrE6jrLfQYn1hWG9MXCrcy2Ppp3RwYNrid+fFPiiro6
         RfUNBhiYXxf8NAU/dFyvaAkJZjMvs0jA2kAdwzH8dpBNHD84LOd85HEW6eHJ9xt7/S
         Sn58XKPJ4jEyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C4DFE55F07;
        Mon,  6 Feb 2023 22:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/1] libbpf: Correctly set the kernel code version
 in Debian kernel.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167572321717.17917.7525968332821642999.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Feb 2023 22:40:17 +0000
References: <20230203234842.2933903-1-hao.xiang@bytedance.com>
In-Reply-To: <20230203234842.2933903-1-hao.xiang@bytedance.com>
To:     Hao Xiang <hao.xiang@bytedance.com>
Cc:     bpf@vger.kernel.org, horenchuang@bytedance.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  3 Feb 2023 23:48:42 +0000 you wrote:
> In a previous commit, Ubuntu kernel code version is correctly set
> by retrieving the information from /proc/version_signature.
> 
> commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
> (libbpf: Improve LINUX_VERSION_CODE detection)
> 
> The /proc/version_signature file doesn't present in at least the
> older versions of Debian distributions (eg, Debian 9, 10). The Debian
> kernel has a similar issue where the release information from uname()
> syscall doesn't give the kernel code version that matches what the
> kernel actually expects. Below is an example content from Debian 10.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/1] libbpf: Correctly set the kernel code version in Debian kernel.
    https://git.kernel.org/bpf/bpf-next/c/d1d7730ff875

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


