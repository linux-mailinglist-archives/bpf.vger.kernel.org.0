Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21967EF0E
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 21:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjA0UCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 15:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjA0UCH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 15:02:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A22005E
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 12:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B80A0B821D6
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CBFFC4339B;
        Fri, 27 Jan 2023 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674849616;
        bh=C8ykH8wOlrYwn37KcxJGOm/ctwUkfyWJaoFm1eSvt5U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pDxVDpcfkXeMjUMRlP6fZh7OjWvETDc3VWirPzawXuUb0GANzYUc34w12zTkFg2gg
         RGsD8MTdh3/0w+cYX15EK8Xo7WNV/SRV+N0OBu+JkTIMMDz+x1EnQ1Q+eme5VuRZkv
         S+UkFzX2cto05JCIX7h7MWTzBjmIYG6N8YjaDZTAA73uSUWeUp6DZDTOlD36qWmhKx
         bxAf2+pxy3yAiZEOQ+Lf0CvOsaspQS/VjzxJfCctaD1n+KsVuLsCjNuf3zil21n5tj
         o5uPOZ3tJCQ07vuWKXNGl5dmMTKnmaCPr8df8mErv8fqqufvhoKRQOxIeEeG9NiF40
         UutsoIakJAjWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 314B1E52504;
        Fri, 27 Jan 2023 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Add documentation to map pinning API functions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167484961619.8531.17127580329244288417.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Jan 2023 20:00:16 +0000
References: <20230126024225.520685-1-grantseltzer@gmail.com>
In-Reply-To: <20230126024225.520685-1-grantseltzer@gmail.com>
To:     Grant Seltzer <grantseltzer@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 25 Jan 2023 21:42:25 -0500 you wrote:
> This adds documentation for the following API functions:
> - bpf_map__set_pin_path()
> - bpf_map__pin_path()
> - bpf_map__is_pinned()
> - bpf_map__pin()
> - bpf_map__unpin()
> - bpf_object__pin_maps()
> - bpf_object__unpin_maps()
> 
> [...]

Here is the summary with links:
  - [bpf-next] Add documentation to map pinning API functions
    https://git.kernel.org/bpf/bpf-next/c/d8285883fd41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


