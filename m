Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7270A636EA2
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKXAAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKXAAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668628F3DB
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B789B82573
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56E7C433D7;
        Thu, 24 Nov 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669248016;
        bh=X/wn/wO4p44Y2/euGRuJGxZlhqpHnGaCj+XjLOqB5qM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YqfshLDA81qRawLcLpf41g9Rp0t4usi8G/exuYtQ1f4xR42Bs8pMk1NkWkD7Q8evS
         WsOg+PAQo4KS0I89NMyR9aBERb0/n1AeCBKIUyhveJAB0sNnUhd9EhbOzbP/08PsKd
         6h9dnV28WLO5IiheM3Py3SDOJkA+Pd+ABbrEE4th/dnDFNmtd8/DRkQCpZ5uzd3oKL
         jSiurlVRcHJnxqm6GKeq+GsJfj2dtH5/qeoCzjlvYk0idm+PwDyNzLnmVjq+1sEBuv
         icNvgHFLQKns+7lRtxP32kc+A3JprVzVt8Db645AQDQOY7gN09FMa3NC1q8illNEd9
         B/82IAxiRJf5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC367C395EE;
        Thu, 24 Nov 2022 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add reproducer for decl_tag in
 func_proto argument
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166924801670.22285.7312876485034854827.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 00:00:16 +0000
References: <20221123035422.872531-1-sdf@google.com>
In-Reply-To: <20221123035422.872531-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 22 Nov 2022 19:54:21 -0800 you wrote:
> It should trigger a WARN_ON_ONCE in btf_type_id_size.
> 
>     RIP: 0010:btf_type_id_size+0x8bd/0x940 kernel/bpf/btf.c:1952
>     btf_func_proto_check kernel/bpf/btf.c:4506 [inline]
>     btf_check_all_types kernel/bpf/btf.c:4734 [inline]
>     btf_parse_type_sec+0x1175/0x1980 kernel/bpf/btf.c:4763
>     btf_parse kernel/bpf/btf.c:5042 [inline]
>     btf_new_fd+0x65a/0xb00 kernel/bpf/btf.c:6709
>     bpf_btf_load+0x6f/0x90 kernel/bpf/syscall.c:4342
>     __sys_bpf+0x50a/0x6c0 kernel/bpf/syscall.c:5034
>     __do_sys_bpf kernel/bpf/syscall.c:5093 [inline]
>     __se_sys_bpf kernel/bpf/syscall.c:5091 [inline]
>     __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5091
>     do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Add reproducer for decl_tag in func_proto argument
    https://git.kernel.org/bpf/bpf-next/c/8e898aaa733e
  - [bpf-next,2/2] bpf: prevent decl_tag from being referenced in func_proto arg
    https://git.kernel.org/bpf/bpf-next/c/f17472d45996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


