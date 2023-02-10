Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74325692B7F
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 00:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjBJXlD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 18:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBJXlC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 18:41:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01143C78D
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F2B3B8261A
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 23:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F5B9C433D2;
        Fri, 10 Feb 2023 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676072421;
        bh=3U8sq/QHpK9mmvkIONCiKcShpVmmqe44OvWijyP5XPg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rd8aVXX2G/kOBTX05FyPuOC3Lv4sQMFP+E2kewCf4xqmsEzYFpXmCB2mFWy2qh4uy
         kOxNvkCmgXK2sDZvqwFs0YGBBxv5bNIIZnke+XLKblnAplDppURhZdIHA1EvBPvukM
         Kfn6wTmEdSxOjq8IbAl7aW8HGQUc/7GUrGyC3aNQUyaI+nI98g3717u3h5OK0lj9Tj
         FxH25uMcYUdjfG6Pf7OxvfrarLGrbWMG1Xp4QU6sSixe9HP6xlN1QnVzX45R2WKVEJ
         VN0d50YjACfaN2g7zqMrrvurQe6LdiTSt0yStQjtCwoAb7MvFkQNUuTVSkNNBbhQ85
         UJdUzEy4HmlqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E28DDE21EC5;
        Fri, 10 Feb 2023 23:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/16] selftests/bpf: Add Memory Sanitizer support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167607242092.8376.16236928310453239357.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Feb 2023 23:40:20 +0000
References: <20230210001210.395194-1-iii@linux.ibm.com>
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
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

On Fri, 10 Feb 2023 01:11:54 +0100 you wrote:
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
  - [bpf-next,v2,01/16] selftests/bpf: Quote host tools
    https://git.kernel.org/bpf/bpf-next/c/795deb3f9747
  - [bpf-next,v2,02/16] tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support
    https://git.kernel.org/bpf/bpf-next/c/585bf4640ebe
  - [bpf-next,v2,03/16] selftests/bpf: Split SAN_CFLAGS and SAN_LDFLAGS
    https://git.kernel.org/bpf/bpf-next/c/0589d16475ae
  - [bpf-next,v2,04/16] selftests/bpf: Forward SAN_CFLAGS and SAN_LDFLAGS to runqslower and libbpf
    https://git.kernel.org/bpf/bpf-next/c/24a87b477c65
  - [bpf-next,v2,05/16] selftests/bpf: Attach to fopen()/fclose() in uprobe_autoattach
    https://git.kernel.org/bpf/bpf-next/c/907300c7a66b
  - [bpf-next,v2,06/16] selftests/bpf: Attach to fopen()/fclose() in attach_probe
    https://git.kernel.org/bpf/bpf-next/c/202702e890a4
  - [bpf-next,v2,07/16] libbpf: Fix alen calculation in libbpf_nla_dump_errormsg()
    https://git.kernel.org/bpf/bpf-next/c/17bcd27a08a2
  - [bpf-next,v2,08/16] libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
    (no matching commit)
  - [bpf-next,v2,09/16] libbpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    (no matching commit)
  - [bpf-next,v2,10/16] bpftool: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    (no matching commit)
  - [bpf-next,v2,11/16] perf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    (no matching commit)
  - [bpf-next,v2,12/16] samples/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    (no matching commit)
  - [bpf-next,v2,13/16] selftests/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
    (no matching commit)
  - [bpf-next,v2,14/16] libbpf: Factor out is_percpu_bpf_map_type()
    (no matching commit)
  - [bpf-next,v2,15/16] libbpf: Add MSan annotations
    (no matching commit)
  - [bpf-next,v2,16/16] selftests/bpf: Add MSan annotations
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


