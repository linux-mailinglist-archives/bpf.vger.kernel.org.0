Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81116A9127
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 07:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCCGkv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 01:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCGks (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 01:40:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DE1ACE6;
        Thu,  2 Mar 2023 22:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D98F61763;
        Fri,  3 Mar 2023 06:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90280C433D2;
        Fri,  3 Mar 2023 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677825618;
        bh=2jGxhEqBHvw/EZ4+CwUECk2thXbmpiIFvPxFWzwFGeY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A9ioxzZ+DWunVW9M0zlrOEckw3XRxLTJWjHWOLQ2DeoHTOSLV7jgz7QHwqkh+DGSK
         RhAwkf/qwuED7TOch7XVYoc30+uYZjgyfnsnx74v5gOHaqxG4AiPtf5KRC5cj48/bg
         bP2uf7ZoFMgUaZrZruP+FDQFX7PNzaJTHYPJcJipppamdd3+EHv51rX6l3l83srfER
         ybS9XbkopUSwTwQFM4fn13p+Qx5t5cHRlYqCBwQNNOZqIcWlC5KgjTglAnH3k/4sGX
         HHgCa3XwojVFgP/9ak2LdN6vrYLAiSjeuju3qL5BgrmzmLTLwjSVGlx7OyN0fw+eXF
         pns4PGN07J+Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D741C395D9;
        Fri,  3 Mar 2023 06:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Make bpf_get_current_[ancestor_]cgroup_id()
 available for all program types
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167782561844.15961.8030839288480908972.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Mar 2023 06:40:18 +0000
References: <ZAD8QyoszMZiTzBY@slm.duckdns.org>
In-Reply-To: <ZAD8QyoszMZiTzBY@slm.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        davemarchevsky@meta.com, void@manifault.com,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

On Thu, 2 Mar 2023 09:42:59 -1000 you wrote:
> These helpers are safe to call from any context and there's no reason to
> restrict access to them. Remove them from bpf_trace and filter lists and add
> to bpf_base_func_proto() under perfmon_capable().
> 
> v2: After consulting with Andrii, relocated in bpf_base_func_proto() so that
>     they require bpf_capable() but not perfomon_capable() as it doesn't read
>     from or affect others on the system.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Make bpf_get_current_[ancestor_]cgroup_id() available for all program types
    https://git.kernel.org/bpf/bpf-next/c/c501bf55c88b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


