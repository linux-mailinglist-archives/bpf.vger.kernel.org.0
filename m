Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8F6F31A2
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEANuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEANuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 09:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF96191
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 06:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E114860F03
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 13:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C78CC4339B;
        Mon,  1 May 2023 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682949020;
        bh=Lupj5T5XJVVBLQHWoR3pwqnkXrszoXpaK+peJ8QlPhs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gS8BD/DMkt00Y5QWRkjAuLzWCQ9CIB37su/qSdLg3itiqfoGIf0JdBuQ28BbwqnnM
         T6/+/CS2STut4EYqyJMSC11LWuDK6i9YIyfmdyiB4vlm/cI59Oti3LnzolqAww2szq
         PbZ/u3/zyXwuRwxoorMI8w2SNOKax2NwjQeB9A1GpKwR68/Pd/HC0MKebBgLmnG4F5
         Jgk0mvsHoIKeP2RLDArvsjT69ViP22VMVqLcMzECSrH8ZcCYrbes34N9cmgt7jP7DH
         2w3x8mNrBrcOCJSHm6iorkpuboWcJUPy741tIOjWdbmCH2rVar/QkSC6HaHisKQyU4
         9OYBRlwsGrstQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22EBBC395FD;
        Mon,  1 May 2023 13:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: btf_dump_type_data_check_overflow needs
 to consider BTF_MEMBER_BITFIELD_SIZE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168294902013.3340.3030217679252571442.git-patchwork-notify@kernel.org>
Date:   Mon, 01 May 2023 13:50:20 +0000
References: <20230428013638.1581263-1-martin.lau@linux.dev>
In-Reply-To: <20230428013638.1581263-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 27 Apr 2023 18:36:38 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The btf_dump/struct_data selftest is failing with:
> test_btf_dump_struct_data:FAIL:unexpected return value dumping fs_context unexpected unexpected return value dumping fs_context: actual -7 != expected 264
> 
> The reason is in btf_dump_type_data_check_overflow(). It does not use
> BTF_MEMBER_BITFIELD_SIZE from the struct's member (btf_member). Instead,
> it is using the enum size which is 4. It had been working till the recent
> commit 4e04143c869c ("fs_context: drop the unused lsm_flags member")
> removed an integer member which also removed the 4 bytes padding at the end
> of the fs_context. Missing this 4 bytes padding exposed this bug.
> In particular, when btf_dump_type_data_check_overflow() reaches
> the member 'phase', -E2BIG is returned.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE
    https://git.kernel.org/bpf/bpf-next/c/c39028b333f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


