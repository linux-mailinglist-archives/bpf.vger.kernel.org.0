Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603926637F6
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 05:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjAJEAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 23:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjAJEAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 23:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85D1EC66
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 20:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A93614D1
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 04:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA1A2C433D2;
        Tue, 10 Jan 2023 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673323216;
        bh=uMO1JZGXjWHvtXsqCvlJjnhCsXLTdze1k4PZvm9Nrc0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BlqIXB2g9Vfd8uhp940jSGdWzRjRX8vyH+VBArt2LO74yRzV89BvH5C8WrCrWcvjV
         ErBNNdLUGFu9LVnmNJzRtFkY0zS8EnsYJ18sCACgmP5AqEkoT3+CTMKh687w2EQiZK
         A+G0Z8JnZgxfnZpDZrVUwng8T6SyyrHLgsajaN3d5cZ/3LODXiQKT+h/1hyheaQurf
         afNSks5fsL7s5L2kLP2aBzAvw+uciYRjRFTwHNqUY9OVHfkGyzGvXUloWZibkclq4k
         RrOpyST5hMe25T0ZuX4cqb6GeAxmY5C9yHr42eBWAkTIsCOgs9zIHhslS787HZqtsL
         lcwll8UGQmFoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBF1EE524ED;
        Tue, 10 Jan 2023 04:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167332321583.31727.12746775760763108962.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Jan 2023 04:00:15 +0000
References: <20230106154400.74211-1-paul@paul-moore.com>
In-Reply-To: <20230106154400.74211-1-paul@paul-moore.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        burn.alting@iinet.net.au, sdf@google.com, ast@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Jan 2023 10:43:59 -0500 you wrote:
> When changing the ebpf program put() routines to support being called
> from within IRQ context the program ID was reset to zero prior to
> calling the perf event and audit UNLOAD record generators, which
> resulted in problems as the ebpf program ID was bogus (always zero).
> This patch addresses this problem by removing an unnecessary call to
> bpf_prog_free_id() in __bpf_prog_offload_destroy() and adjusting
> __bpf_prog_put() to only call bpf_prog_free_id() after audit and perf
> have finished their bpf program unload tasks in
> bpf_prog_put_deferred().  For the record, no one can determine, or
> remember, why it was necessary to free the program ID, and remove it
> from the IDR, prior to executing bpf_prog_put_deferred();
> regardless, both Stanislav and Alexei agree that the approach in this
> patch should be safe.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
    https://git.kernel.org/bpf/bpf/c/ef01f4e25c17
  - [v3,2/2] bpf: remove the do_idr_lock parameter from bpf_prog_free_id()
    https://git.kernel.org/bpf/bpf/c/e7895f017b79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


