Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E668E645
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 03:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBHCuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 21:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHCuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 21:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD1310A91
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 18:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80258B81B9D
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 02:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B074C4339B;
        Wed,  8 Feb 2023 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675824617;
        bh=R+/0acemikfgPeKq35KVPXonsTJrYUJ57MPgQoJ8kXY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Edbix2bn42pAwiGe+IMAzRYVeFM8wFGAQpZOA+YRtyvmHMlZTin+84LVMqidvoyNd
         xLvxiD43NDtMas2+duH+xu14DeWCmR0BTyeGFOwrIPius28n2muiFZO/acK31zJAdp
         mXq0O+3trhqjAWa+VAjJT9msNEGX4xrhEF2qFaMl7PXXZGOPRq3/PiZIZhIc8Hk2Z6
         Ez24ZPe0NJUj37LfzMkBdw1cAh0DodOaw06ErQ5YQMMD0h9txqWCiVa+d6mgW6WZPa
         NX8U232M/J1PqapMZQu+vNcWoNJOMWaGzxhEuOnMwVWtgwURQOb+0P8k1VnDVmkByY
         5KT/mcddBpQDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AEB7E55EFD;
        Wed,  8 Feb 2023 02:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf,
 docs: Use consistent names for the same field
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167582461710.22679.3313564141919145899.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Feb 2023 02:50:17 +0000
References: <20230127224555.916-1-dthaler1968@googlemail.com>
In-Reply-To: <20230127224555.916-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Jan 2023 22:45:55 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Use consistent names for the same field, e.g., 'dst' vs 'dst_reg'.
> Previously a mix of terms were used for the same thing in various cases.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf, docs: Use consistent names for the same field
    https://git.kernel.org/bpf/bpf-next/c/a92adde8d3d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


