Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6B9636A60
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiKWUBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiKWUA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:00:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2217972084;
        Wed, 23 Nov 2022 12:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B46F761EEB;
        Wed, 23 Nov 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1824CC433D7;
        Wed, 23 Nov 2022 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669233617;
        bh=/rn1PzmD7jbMZAzucVrrjH77YxRrb54TP7UDsr2ApnY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Nq6nXsT+mcnFq58GaYBeHy+bw708f/70jWl47X7vPl/oRAefbNTcdtj8GMzFUkGZa
         HLk0QEBtnbWwDl1Y5SlIevCuUaa7NCAbigHlwU/o+hn3Ot2wM1Zh7C17f3jq29ztH9
         ghhR3ytldx7L2IPW89IBCZlv+jJ25wfmeeveZOqfRme3GSlE4guv7Z1FHgyeyu/h+s
         T1w9NxmFME/BUtdcBZGrflayxK/fCFfTbpUPANKN/ebyNwVkWuc2ERhr7q9lG63ID9
         3DgPYxhDn8uzf97Et2Q2WJvLVE9JykTrKv1RmlyWnHWvEqc+QuJhUKsZUPRRApkzdQ
         ks5WRix51fbqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED919C395ED;
        Wed, 23 Nov 2022 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Don't use idx variable when registering kfunc
 dtors
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166923361696.21034.18352770057506612392.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 20:00:16 +0000
References: <20221123135253.637525-1-void@manifault.com>
In-Reply-To: <20221123135253.637525-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com,
        song@kernel.org, sdf@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, haoluo@google.com,
        tj@kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org,
        lkp@intel.com
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

On Wed, 23 Nov 2022 07:52:53 -0600 you wrote:
> In commit fda01efc6160 ("bpf: Enable cgroups to be used as kptrs"), I
> added an 'int idx' variable to kfunc_init() which was meant to
> dynamically set the index of the btf id entries of the
> 'generic_dtor_ids' array. This was done to make the code slightly less
> brittle as the struct cgroup * kptr kfuncs such as bpf_cgroup_aquire()
> are compiled out if CONFIG_CGROUPS is not defined. This, however, causes
> an lkp build warning:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Don't use idx variable when registering kfunc dtors
    https://git.kernel.org/bpf/bpf-next/c/2fcc6081a7bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


