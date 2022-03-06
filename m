Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F774CE857
	for <lists+bpf@lfdr.de>; Sun,  6 Mar 2022 03:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiCFCvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 21:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiCFCvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 21:51:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008F22BF4
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 18:50:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E761661031
        for <bpf@vger.kernel.org>; Sun,  6 Mar 2022 02:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F319C340F1;
        Sun,  6 Mar 2022 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646535011;
        bh=QFdi4fxWPZrTz0BkAjrV2PUk1unF6zAtD+Poso7+n4w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fkGGwVkBB2e8doCxYMYSdXx/iqIbY7bn6H5ITtvPS+mxeRKtsJ9zDxwErz7Pras9A
         UuK173zeCHS7mEzxV0Y/A7rQmemh7QzIVOrFrGE1Kl9iKTwqRii0tJN1G8a2A9WCI3
         A2ldh+fz8qpyBv554IAYVGH6xjM/oPnvDcpMPVtG0+8J2BUam4PoqxEumOh9CCmLxY
         jVS1SVWtqb0JQW26jitxIMgmK9SyjQdsnX7s6xjuaFK8f4F89X40FWE2RRvcRSYRjO
         vMeCFL5ZrA9+pWPHya7kptUc2/V9cP5C+IKI8DAFNSA6tIjqW5Oe2rHkb2UUNoKpQJ
         pftB5q9jtNWGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E0BFE6D44B;
        Sun,  6 Mar 2022 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/4] bpf: add __percpu tagging in vmlinux BTF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164653501118.13752.451870897328051806.git-patchwork-notify@kernel.org>
Date:   Sun, 06 Mar 2022 02:50:11 +0000
References: <20220304191657.981240-1-haoluo@google.com>
In-Reply-To: <20220304191657.981240-1-haoluo@google.com>
To:     Hao Luo <haoluo@google.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, acme@kernel.org, kpsingh@kernel.org,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Mar 2022 11:16:53 -0800 you wrote:
> This patchset is very much similar to Yonghong's patchset on adding
> __user tagging [1], where a "user" btf_type_tag was introduced to
> describe __user memory pointers. Similar approach can be applied on
> __percpu pointers. The __percpu attribute in kernel is used to identify
> pointers that point to memory allocated in percpu region. Normally,
> accessing __percpu memory requires using special functions like
> per_cpu_ptr() etc. Directly accessing __percpu pointer is meaningless.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/4] bpf: Fix checking PTR_TO_BTF_ID in check_mem_access
    https://git.kernel.org/bpf/bpf-next/c/bff61f6faedb
  - [bpf-next,v1,2/4] compiler_types: define __percpu as __attribute__((btf_type_tag("percpu")))
    https://git.kernel.org/bpf/bpf-next/c/9216c9162378
  - [bpf-next,v1,3/4] bpf: Reject programs that try to load __percpu memory.
    https://git.kernel.org/bpf/bpf-next/c/5844101a1be9
  - [bpf-next,v1,4/4] selftests/bpf: Add a test for btf_type_tag "percpu"
    https://git.kernel.org/bpf/bpf-next/c/50c6b8a9aea2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


