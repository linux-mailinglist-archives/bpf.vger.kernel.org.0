Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C826F6E34A0
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 02:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDPAuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 20:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDPAuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 20:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B078835A3
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 17:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E2AB618DB
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 00:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A6CC4339B;
        Sun, 16 Apr 2023 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681606219;
        bh=IyA2yVujfgvuALCdyEcZNch1EtRrSaaoRJd1zmeiQGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WDilotui9I/CQcTFZAmxpLc1pG7xD2v9j+ZmnUOmjsxl+5JC8bFWVAbgvw8adquTA
         YPFHB4NtndjkV1N6KwNBWn9nge1pdBHvwV3/sqdIafq9slqbj6/P3pwyOg39fR+IYc
         raDMoe5/p+/afqzRkT99/HKDTtmgs3+NJ622DPMiJYhNZg+6dT/HzI1pdMsMqCJ8qs
         BbCumM0yq2UmVFsNzDJ9OW+LTp50z4Il2011EqQaCvkdozIuHtCerAvGeAUMZJ30kO
         NUawPAiRdRIAE2sE6rYImg9GXVRgF5RoOD92enrrC2a7ZiRvjtKVQ8p0DGo1ArlcWz
         9Y4QSTunOTBIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B746E21EDE;
        Sun, 16 Apr 2023 00:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/9] Shared ownership for local kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168160621950.14536.17272966925999064717.git-patchwork-notify@kernel.org>
Date:   Sun, 16 Apr 2023 00:50:19 +0000
References: <20230415201811.343116-1-davemarchevsky@fb.com>
In-Reply-To: <20230415201811.343116-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com
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

On Sat, 15 Apr 2023 13:18:02 -0700 you wrote:
> This series adds support for refcounted local kptrs to the verifier. A local
> kptr is 'refcounted' if its type contains a struct bpf_refcount field:
> 
>   struct refcounted_node {
>     long data;
>     struct bpf_list_node ll;
>     struct bpf_refcount ref;
>   };
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/9] bpf: Remove btf_field_offs, use btf_record's fields instead
    https://git.kernel.org/bpf/bpf-next/c/cd2a8079014a
  - [v2,bpf-next,2/9] bpf: Introduce opaque bpf_refcount struct and add btf_record plumbing
    https://git.kernel.org/bpf/bpf-next/c/d54730b50bae
  - [v2,bpf-next,3/9] bpf: Support refcounted local kptrs in existing semantics
    https://git.kernel.org/bpf/bpf-next/c/1512217c47f0
  - [v2,bpf-next,4/9] bpf: Add bpf_refcount_acquire kfunc
    https://git.kernel.org/bpf/bpf-next/c/7c50b1cb76ac
  - [v2,bpf-next,5/9] bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly fail
    https://git.kernel.org/bpf/bpf-next/c/d2dcc67df910
  - [v2,bpf-next,6/9] selftests/bpf: Modify linked_list tests to work with macro-ified inserts
    https://git.kernel.org/bpf/bpf-next/c/de67ba3968fa
  - [v2,bpf-next,7/9] bpf: Migrate bpf_rbtree_remove to possibly fail
    https://git.kernel.org/bpf/bpf-next/c/404ad75a36fb
  - [v2,bpf-next,8/9] bpf: Centralize btf_field-specific initialization logic
    https://git.kernel.org/bpf/bpf-next/c/3e81740a9062
  - [v2,bpf-next,9/9] selftests/bpf: Add refcounted_kptr tests
    https://git.kernel.org/bpf/bpf-next/c/6147f15131e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


