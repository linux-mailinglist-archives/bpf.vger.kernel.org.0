Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193FA69A2D7
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQAKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 19:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQAKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 19:10:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD063A860
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 16:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C36E611E3
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 00:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C44C4339B;
        Fri, 17 Feb 2023 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676592622;
        bh=+C1tYV9xZXh9ut+FwTMYdc43uc3XoQMiE5iHyqpz3Zg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ViwDsDUWNutBR7azaXNxPH0YPE+qLp++AFu5AklM+DJS+5E3k57Z+GIJYOTc6IAOk
         imWV3BiySRaK9CgKbMAtN+3QG50NDnbgrkE+bMyGsjP02h91w+uoCoc1UZZFBjeG6G
         jDMxIsdvqB3eMH7lBbhVhidngLHkYdS2hnINtRUr4ViE4uG0/GWyMjvXfkOw9bmzxS
         USi8KKpTPidZzMyBu4lCDpdxBmwXQMjcFS4svUi0YlK2QuoHqKl8v9170+wPP3NWoK
         IGTimZ7aPRvUuBbSukzYDqBvFDfL/gItRzeahaDT+FxzKWZHXNAaxL5uSHuKS4ud5T
         l5IiqITqN98aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60993E21ED0;
        Fri, 17 Feb 2023 00:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/8] Add Memory Sanitizer support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167659262239.25191.2826239074993055951.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Feb 2023 00:10:22 +0000
References: <20230214231221.249277-1-iii@linux.ibm.com>
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 15 Feb 2023 00:12:13 +0100 you wrote:
> v2: https://lore.kernel.org/bpf/20230210001210.395194-1-iii@linux.ibm.com/
> v2 -> v3:
> - Improve bpftool commit message, shorten error messages (Quentin).
> - Drop perf patch (Andrii).
> - Drop integrated patches.
> 
> v1: https://lore.kernel.org/bpf/20230208205642.270567-1-iii@linux.ibm.com/
> v1 -> v2:
> - Apply runqslower's EXTRA_CFLAGS and EXTRA_LDFLAGS unconditionally.
> - Use u64 for uretprobe_byname2_rc.
> - Use BPF_UPROBE() instead of PT_REGS_xxx().
> - Use void * instead of char * for pointer arithmetic.
> - Rename libbpf_mark_defined() to __libbpf_mark_mem_written(), add
>   convenience wrappers.
> - Add a comment about defined(__has_feature) &&
>   __has_feature(memory_sanitizer).
> - Extract is_percpu_bpf_map_type().
> - Introduce bpf_get_{map,prog,link,btf}_info_by_fd() and convert all
>   code to use them. If it's too early for that, in particular for
>   samples and perf, the respective patches can be dropped.
> - Unpoison infos returned by these functions, paying attention to
>   potentially missing fields. Use macros to reduce boilerplate.
> - Move capget() unpoisoning to LLVM [5].
> - With that, only a few cases remain where data needs to be
>   unpoisoned in selftests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
    https://git.kernel.org/bpf/bpf-next/c/55a9ed0e16ba
  - [bpf-next,v3,2/8] libbpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    https://git.kernel.org/bpf/bpf-next/c/629dfc660cae
  - [bpf-next,v3,3/8] bpftool: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    https://git.kernel.org/bpf/bpf-next/c/38f0408ef756
  - [bpf-next,v3,4/8] samples/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    https://git.kernel.org/bpf/bpf-next/c/c0ca277bb8bc
  - [bpf-next,v3,5/8] selftests/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    https://git.kernel.org/bpf/bpf-next/c/c5a237a4db21
  - [bpf-next,v3,6/8] libbpf: Factor out is_percpu_bpf_map_type()
    (no matching commit)
  - [bpf-next,v3,7/8] libbpf: Add MSan annotations
    (no matching commit)
  - [bpf-next,v3,8/8] selftests/bpf: Add MSan annotations
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


