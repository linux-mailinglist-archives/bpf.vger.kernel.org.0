Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE626AEB7A
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCGRpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 12:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjCGRoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 12:44:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFFA224E
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 09:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85143B819BD
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48440C4339B;
        Tue,  7 Mar 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210823;
        bh=0bpNRWBJM0h+HZqybL6RrGk9DzYu2MzSSLBscotWTZk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LClQZmRT9ZjhS2Y+kSw/KgsTsjl4NfJR9sE12tEsbCRGr1F5j9d8ge/KQKHKpCbTN
         dBNuQwqX2MiA+wXf8zN248s34vTmgVYOMZghQaJB2p9bD3b64rA488F40Ogjc54wHz
         9COJkQhH3dyRzAoIj6zLkB2uKr9PuHqDhyvdTwFubgMyJOWoeDyF9C/bGIm5RVG5+D
         LCce/wmF9ua911v4aY21dx4dpkCU60mDHIhaCiUzn3Eoyq/PN2EKBvjjRyF4fCieqz
         wildF0QcXSAfckjVtOid7Otd5TjDnV1YFshTCL73bK3s11B/wVxGKJ7BveAu6xYfZs
         TK+ZlNRhQL6Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 272F3E61B65;
        Tue,  7 Mar 2023 17:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/18] bpf: bpf memory usage 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167821082315.1693.6957546778534183486.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 17:40:23 +0000
References: <20230305124615.12358-1-laoar.shao@gmail.com>
In-Reply-To: <20230305124615.12358-1-laoar.shao@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com, bpf@vger.kernel.org
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

On Sun,  5 Mar 2023 12:45:57 +0000 you wrote:
> Currently we can't get bpf memory usage reliably either from memcg or
> from bpftool.
> 
> In memcg, there's not a 'bpf' item in memory.stat, but only 'kernel',
> 'sock', 'vmalloc' and 'percpu' which may related to bpf memory. With
> these items we still can't get the bpf memory usage, because bpf memory
> usage may far less than the kmem in a memcg, for example, the dentry may
> consume lots of kmem.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/18] bpf: add new map ops ->map_mem_usage
    https://git.kernel.org/bpf/bpf-next/c/90a5527d7686
  - [bpf-next,v4,02/18] bpf: lpm_trie memory usage
    https://git.kernel.org/bpf/bpf-next/c/41d5941e7f9a
  - [bpf-next,v4,03/18] bpf: hashtab memory usage
    https://git.kernel.org/bpf/bpf-next/c/304849a27b34
  - [bpf-next,v4,04/18] bpf: arraymap memory usage
    https://git.kernel.org/bpf/bpf-next/c/1746d0555a87
  - [bpf-next,v4,05/18] bpf: stackmap memory usage
    https://git.kernel.org/bpf/bpf-next/c/cbb9b6068c68
  - [bpf-next,v4,06/18] bpf: reuseport_array memory usage
    https://git.kernel.org/bpf/bpf-next/c/2e89caf055a6
  - [bpf-next,v4,07/18] bpf: ringbuf memory usage
    https://git.kernel.org/bpf/bpf-next/c/2f7e4ab2caa9
  - [bpf-next,v4,08/18] bpf: bloom_filter memory usage
    https://git.kernel.org/bpf/bpf-next/c/71a49abe73cb
  - [bpf-next,v4,09/18] bpf: cpumap memory usage
    https://git.kernel.org/bpf/bpf-next/c/835f1fca9513
  - [bpf-next,v4,10/18] bpf: devmap memory usage
    https://git.kernel.org/bpf/bpf-next/c/fa5e83df173b
  - [bpf-next,v4,11/18] bpf: queue_stack_maps memory usage
    https://git.kernel.org/bpf/bpf-next/c/c6e66b42a348
  - [bpf-next,v4,12/18] bpf: bpf_struct_ops memory usage
    https://git.kernel.org/bpf/bpf-next/c/f062226d8d59
  - [bpf-next,v4,13/18] bpf: local_storage memory usage
    https://git.kernel.org/bpf/bpf-next/c/2f536977d6f1
  - [bpf-next,v4,14/18] bpf, net: bpf_local_storage memory usage
    https://git.kernel.org/bpf/bpf-next/c/7490b7f1c02e
  - [bpf-next,v4,15/18] bpf, net: sock_map memory usage
    https://git.kernel.org/bpf/bpf-next/c/73d2c61919e9
  - [bpf-next,v4,16/18] bpf, net: xskmap memory usage
    https://git.kernel.org/bpf/bpf-next/c/b4fd0d672bca
  - [bpf-next,v4,17/18] bpf: offload map memory usage
    https://git.kernel.org/bpf/bpf-next/c/9629363cd056
  - [bpf-next,v4,18/18] bpf: enforce all maps having memory usage callback
    https://git.kernel.org/bpf/bpf-next/c/6b4a6ea2c62d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


