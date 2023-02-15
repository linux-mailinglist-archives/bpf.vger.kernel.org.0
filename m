Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC91698140
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 17:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBOQuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 11:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBOQuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 11:50:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2C1C7E8;
        Wed, 15 Feb 2023 08:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9811BB82314;
        Wed, 15 Feb 2023 16:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45701C433EF;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479817;
        bh=QeMABZ30EUa3T2qfy+hxFQFwxIHlCCWIHBouH1cg8o4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Lwba+EvReADHUwOSU6mj2eSlQ23G2H3hGDxuV2c+kPjDIJXo3F+bCF7GAAKRosuFm
         Kt0hlSp80LVo/G2PLTSxwrsjjb5Wz/xnA0ImsFJ7nw90zIZ+e+ImHI3PEn5xQLOVQv
         Fb8n1HkutjyLatOU3vfIpFsP+qz+gQvhWGgzeGB5jsnZoKFMEduse15+YwbTT9w19w
         OBrUwKCZcPY0ascl4CZeHUOTWrhGtudq+SvZJSGxb17tXB0OLiEDgDRHFHRCqk1aMH
         aKNnsDhhS0jbSrqoWUl7m9ip3mLbzSQ2haTD114zfAAG3UOl4y2Q4c6OwhJSc3avQg
         6um4Esnl6xlYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 251E0C41677;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Documentation fixes for next-20230215
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167647981714.6958.9219328838471519095.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 16:50:17 +0000
References: <20230215123253.41552-1-bagasdotme@gmail.com>
In-Reply-To: <20230215123253.41552-1-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, corbet@lwn.net, ray.huang@amd.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, pbonzini@redhat.com,
        thomas.lendacky@amd.com, davemarchevsky@fb.com, perry.yuan@amd.com,
        rafael.j.wysocki@intel.com, wyes.karny@amd.com,
        mario.limonciello@amd.com, oe-kbuild-all@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Feb 2023 19:32:50 +0700 you wrote:
> Here are fixes for documentation (htmldocs) warnings as reported for
> next-20230215. The changelog below should be self-explanatory.
> 
> Each patch can be applied separately by respective maintainers.
> 
> Bagas Sanjaya (3):
>   Documentation: hw-vuln: Wrap mitigate_smt_rsb example in literal code
>     block
>   Documentation: bpf: Add missing line break separator in node_data
>     struct code block
>   Documentation: amd-pstate: disambiguate user space sections
> 
> [...]

Here is the summary with links:
  - [1/3] Documentation: hw-vuln: Wrap mitigate_smt_rsb example in literal code block
    (no matching commit)
  - [2/3] Documentation: bpf: Add missing line break separator in node_data struct code block
    https://git.kernel.org/bpf/bpf-next/c/e2d323a1f009
  - [3/3] Documentation: amd-pstate: disambiguate user space sections
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


