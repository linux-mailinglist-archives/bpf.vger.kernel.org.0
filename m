Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD45AD44B
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiIENun (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiIENuc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 09:50:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D837191
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 06:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0030ACE129F
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 13:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F7F1C433D7;
        Mon,  5 Sep 2022 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662385819;
        bh=eUwYmKGhoZgjo0QHg9FxI6Saw0fbHPgPwOVDMCzxMo8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uzZab+qKXmix3D/2FOdAojpGTbxOZrXrO1RO1XthauIKX6AWV1fGDkX47IMuNXhhb
         eJLWNZDXsuTkl87j4PEPg4/RNy0TpPgCZhNC/BhXGsZf1gBXp+yzxKEhVt3YJhmeXa
         qKv+zYTxb9z7KCXZtDg4+v7Nciptnqga9+HWNn+/6ck+RKr/zovQddEwkj+6oA4KKx
         XTR3kta+zPgYewhyS6snVFahKTIOlJaLBd63Fafoqydwp8UIlHjgWEQFLvF0mNkyPX
         /u2W0gF6Ji5GPVBpV6hBCU1nshnmFYZ9XuO28547yDDovrt5nnUBVPJzJZE12JhNFt
         Y2nd8rVDGtH1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E41C0C04E59;
        Mon,  5 Sep 2022 13:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 00/16] bpf: BPF specific memory allocator.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166238581892.6349.8060523732700103598.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Sep 2022 13:50:18 +0000
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  2 Sep 2022 14:10:42 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce any context BPF specific memory allocator.
> 
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
> Front-end kmalloc() with per-cpu cache of free elements.
> Refill this cache asynchronously from irq_work.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,01/16] bpf: Introduce any context BPF specific memory allocator.
    https://git.kernel.org/bpf/bpf-next/c/7c8199e24fa0
  - [v6,bpf-next,02/16] bpf: Convert hash map to bpf_mem_alloc.
    https://git.kernel.org/bpf/bpf-next/c/fba1a1c6c912
  - [v6,bpf-next,03/16] selftests/bpf: Improve test coverage of test_maps
    https://git.kernel.org/bpf/bpf-next/c/37521bffdd2d
  - [v6,bpf-next,04/16] samples/bpf: Reduce syscall overhead in map_perf_test.
    https://git.kernel.org/bpf/bpf-next/c/89dc8d0c38e0
  - [v6,bpf-next,05/16] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
    https://git.kernel.org/bpf/bpf-next/c/34dd3bad1a6f
  - [v6,bpf-next,06/16] bpf: Optimize element count in non-preallocated hash map.
    https://git.kernel.org/bpf/bpf-next/c/86fe28f7692d
  - [v6,bpf-next,07/16] bpf: Optimize call_rcu in non-preallocated hash map.
    https://git.kernel.org/bpf/bpf-next/c/0fd7c5d43339
  - [v6,bpf-next,08/16] bpf: Adjust low/high watermarks in bpf_mem_cache
    https://git.kernel.org/bpf/bpf-next/c/7c266178aa51
  - [v6,bpf-next,09/16] bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
    https://git.kernel.org/bpf/bpf-next/c/8d5a8011b35d
  - [v6,bpf-next,10/16] bpf: Add percpu allocation support to bpf_mem_alloc.
    https://git.kernel.org/bpf/bpf-next/c/4ab67149f3c6
  - [v6,bpf-next,11/16] bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
    https://git.kernel.org/bpf/bpf-next/c/ee4ed53c5eb6
  - [v6,bpf-next,12/16] bpf: Remove tracing program restriction on map types
    https://git.kernel.org/bpf/bpf-next/c/96da3f7d489d
  - [v6,bpf-next,13/16] bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
    https://git.kernel.org/bpf/bpf-next/c/dccb4a9013a6
  - [v6,bpf-next,14/16] bpf: Remove prealloc-only restriction for sleepable bpf programs.
    https://git.kernel.org/bpf/bpf-next/c/02cc5aa29e8c
  - [v6,bpf-next,15/16] bpf: Remove usage of kmem_cache from bpf_mem_cache.
    https://git.kernel.org/bpf/bpf-next/c/bfc03c15bebf
  - [v6,bpf-next,16/16] bpf: Optimize rcu_barrier usage between hash map and bpf_mem_alloc.
    https://git.kernel.org/bpf/bpf-next/c/9f2c6e96c65e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


