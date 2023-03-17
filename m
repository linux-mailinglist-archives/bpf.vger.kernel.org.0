Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7B6BE99F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 13:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCQMur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCQMum (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 08:50:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768ACBAD16;
        Fri, 17 Mar 2023 05:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78626B825A7;
        Fri, 17 Mar 2023 12:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D6CC4339E;
        Fri, 17 Mar 2023 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679057418;
        bh=4Kco3SZN1tyzESjQTfolhWtYEc5u7BLKs8kvlYoAnaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m16W0VvEqZ8F5p8x/hIU+oM5OmaZsI5zZngyCVx/El3i1+fTTxRXh8h57okxoCf7x
         aciG6+t1zSg/eNNAWT267OpjAv/+Q6slYHG3cmDn739zgFaut3x3FDyJGWz3TcYuNq
         nl5V5f5NX/a8bKjukDp04keI+AisHufWYyKJOk0OgRB8f1DhyYytIttzacR2udFoXc
         /eXwKPL4FfIunlzyVQh5JE0GQjarvoDc9XOa920NTp7iu7xpyUcqqA4SvtzfQE9QmE
         jhZ3QZsFSMzPvFX3OBK4uCJcz6w2Q+sdnt3w3VxxfUdlWSH5jGJen8K+rtihhm5148
         ieZN+KreFGc4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 112FAE21EE8;
        Fri, 17 Mar 2023 12:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] kallsyms: move find_kallsyms_symbol_value out of
 internal header
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167905741806.12724.17197641552332492380.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Mar 2023 12:50:18 +0000
References: <20230317095601.386738-1-vmalik@redhat.com>
In-Reply-To: <20230317095601.386738-1-vmalik@redhat.com>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, mcgrof@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 17 Mar 2023 10:56:01 +0100 you wrote:
> Moving find_kallsyms_symbol_value from kernel/module/internal.h to
> include/linux/module.h. The reason is that internal.h is not prepared to
> be included when CONFIG_MODULES=n. find_kallsyms_symbol_value is used by
> kernel/bpf/verifier.c and including internal.h from it (without modules)
> leads into a compilation error:
> 
> In file included from ../include/linux/container_of.h:5,
>                  from ../include/linux/list.h:5,
>                  from ../include/linux/timer.h:5,
>                  from ../include/linux/workqueue.h:9,
>                  from ../include/linux/bpf.h:10,
>                  from ../include/linux/bpf-cgroup.h:5,
>                  from ../kernel/bpf/verifier.c:7:
> ../kernel/bpf/../module/internal.h: In function 'mod_find':
> ../include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct module'
>    20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                                                      ^~
> [...]
> 
> [...]

Here is the summary with links:
  - [bpf-next] kallsyms: move find_kallsyms_symbol_value out of internal header
    https://git.kernel.org/bpf/bpf-next/c/bd5314f8dd2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


