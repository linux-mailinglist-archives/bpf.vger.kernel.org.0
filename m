Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294E6D263E
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCaQxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjCaQww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 12:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083DB22932
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C77962AB4
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 16:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9977EC4339B;
        Fri, 31 Mar 2023 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680281419;
        bh=8oakKGZGDH8Tqv36JzYyk0tCz2iH5u4PXW82xXMWQG4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qDNU4NQyk63cNsri4vTlR9ItAyXkgR/f6prLQvbbAFkzdnvNpw6Gaf3ok2g77Ia1G
         pWZ2mrvOHFZIWF4vhdXa6q2aixSqKXOCrwCP+Ro6vxqp4rMdz/Z5QFJug47zDbc9UU
         LeVwfEczlmkrYppnUoThvwr9u7ZVXQs4c3pK7urA9AKYOvgSYctw/EEU3UZ5Shqll2
         Vjt4w3b9bjQ8wP50lfR27j0rBQS5UkKOx9lCmEd/2YOlFbpB6zWvELtv5S58LDLL3t
         QNn2OhZKk0BVXQpx84swmH4M/ib+IJZgRLUzRYi8D/SyxG3glmDIQbsUAHRepwNVV7
         zncWZ6r5sFI0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7995FC43157;
        Fri, 31 Mar 2023 16:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 0/3] selftests/bpf: Add read_build_id function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168028141949.20294.2685025381154219952.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 16:50:19 +0000
References: <20230331093157.1749137-1-jolsa@kernel.org>
In-Reply-To: <20230331093157.1749137-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 31 Mar 2023 11:31:54 +0200 you wrote:
> hi,
> this selftests cleanup was previously posted as part of file build id changes [1],
> which might take more time, so I'm sending the selftests changes separately so it
> won't get stuck.
> 
> v4 changes:
>   - added size argument to read_build_id [Andrii]
>   - condition changes in parse_build_id_buf [Andrii]
>   - use ELF_C_READ_MMAP in elf_begin [Andrii]
>   - return -ENOENT in read_build_id if build id is not found [Andrii]
>   - dropped elf class check [Andrii]
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,1/3] selftests/bpf: Add err.h header
    https://git.kernel.org/bpf/bpf-next/c/328bafc9a373
  - [PATCHv4,bpf-next,2/3] selftests/bpf: Add read_build_id function
    https://git.kernel.org/bpf/bpf-next/c/88dc8b3605b3
  - [PATCHv4,bpf-next,3/3] selftests/bpf: Replace extract_build_id with read_build_id
    https://git.kernel.org/bpf/bpf-next/c/dcc46f51d770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


