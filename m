Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836F6B867B
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 01:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCNAAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 20:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNAAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 20:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1491E868A
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 17:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A20BA6155E
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08E5AC4339B;
        Tue, 14 Mar 2023 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678752017;
        bh=fGMcEkTxE4HwXigGMYx4CSwGT5xwtxZxbublCpv/Msc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pSNLT0rez03h+YuoU2oDVsa0O8i9+WkmlLk7OBPKrUeGYrXXnPwyAj5gvEJoC8XVv
         ++JRq/2r6kcw8ATuGYeg4cephdyVq8LxYrTWACTfGGPqFQoMQAKaIcNsRZtE2UxgEy
         WSMykQAtyRUMIFIx3O92HiNb1AhJwzi0Tw35l6Lw3lCntKhJHoFNQQTdOWXK28PaOu
         8RDyhBrMvpNhwgk1eV19bNyIN/I9wwz0rE+CtRas10YmM4QBaTpVMVGD8JRyTJB8xw
         BBC7us83z1UyWWyPYhuGHJZ/vheSdFLM59SiOxyKU0poTThL4cfZgmSEKK8SRqgA2c
         QyAy3UMFG5N/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEFBBE66CBA;
        Tue, 14 Mar 2023 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] bpf: Disable migration when freeing stashed local
 kptr using obj drop
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167875201690.9292.11466523661883628604.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 00:00:16 +0000
References: <20230313214641.3731908-1-davemarchevsky@fb.com>
In-Reply-To: <20230313214641.3731908-1-davemarchevsky@fb.com>
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Mar 2023 14:46:41 -0700 you wrote:
> When a local kptr is stashed in a map and freed when the map goes away,
> currently an error like the below appears:
> 
> [   39.195695] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u32:15/2875
> [   39.196549] caller is bpf_mem_free+0x56/0xc0
> [   39.196958] CPU: 15 PID: 2875 Comm: kworker/u32:15 Tainted: G           O       6.2.0-13016-g22df776a9a86 #4477
> [   39.197897] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   39.198949] Workqueue: events_unbound bpf_map_free_deferred
> [   39.199470] Call Trace:
> [   39.199703]  <TASK>
> [   39.199911]  dump_stack_lvl+0x60/0x70
> [   39.200267]  check_preemption_disabled+0xbf/0xe0
> [   39.200704]  bpf_mem_free+0x56/0xc0
> [   39.201032]  ? bpf_obj_new_impl+0xa0/0xa0
> [   39.201430]  bpf_obj_free_fields+0x1cd/0x200
> [   39.201838]  array_map_free+0xad/0x220
> [   39.202193]  ? finish_task_switch+0xe5/0x3c0
> [   39.202614]  bpf_map_free_deferred+0xea/0x210
> [   39.203006]  ? lockdep_hardirqs_on_prepare+0xe/0x220
> [   39.203460]  process_one_work+0x64f/0xbe0
> [   39.203822]  ? pwq_dec_nr_in_flight+0x110/0x110
> [   39.204264]  ? do_raw_spin_lock+0x107/0x1c0
> [   39.204662]  ? lockdep_hardirqs_on_prepare+0xe/0x220
> [   39.205107]  worker_thread+0x74/0x7a0
> [   39.205451]  ? process_one_work+0xbe0/0xbe0
> [   39.205818]  kthread+0x171/0x1a0
> [   39.206111]  ? kthread_complete_and_exit+0x20/0x20
> [   39.206552]  ret_from_fork+0x1f/0x30
> [   39.206886]  </TASK>
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] bpf: Disable migration when freeing stashed local kptr using obj drop
    https://git.kernel.org/bpf/bpf-next/c/9e36a204bd43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


