Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9C58DC72
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbiHIQuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiHIQuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6A9587
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 09:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62364B81636
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 16:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BA88C433C1;
        Tue,  9 Aug 2022 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660063814;
        bh=hUZc2bB5mu9OXfnDi+3WJFAkvhAJZ1OsqZKG7rENiKQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tYnKjfwIY+1Lu/kk2s4GqQNIl9Ao3y5chmHAXRz4Vcx6Rh8E2yCuWGf3+hj4XDQ44
         Pu9N++awROp/nvPHxN8WSoIiae4Hv7OjB7L8Fds6a7qlr61vkQ1BDmUNXhm+bb+r4Q
         TQnxP+cxO1TZYH6uUZcYMtlzP4UfkZzgWo4lGxciWMl+/+r+YZT0VqQ0yRaq9qqx3W
         5lw8xle/Z0B4yQ6hNpmQ86e02up+/EoHhzZMutCt3fxbIo0K3lzOM6ZQn6NmI26JQt
         aXlbzxE8M3xpKdhtG7NuefYVTkeyWyuLh1VoMrgaU2IMNdvZUpXhQ7x+OvvrgB+ruP
         0g2vQpiloM9pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01512C43143;
        Tue,  9 Aug 2022 16:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2 bpf-next] bpf: Cleanup check_refcount_ok
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166006381399.15335.6790319554919261050.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 16:50:13 +0000
References: <20220808171559.3251090-1-davemarchevsky@fb.com>
In-Reply-To: <20220808171559.3251090-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, memxor@gmail.com,
        joannelkoong@gmail.com, kafai@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 8 Aug 2022 10:15:59 -0700 you wrote:
> Discussion around a recently-submitted patch provided historical
> context for check_refcount_ok [0]. Specifically, the function and its
> helpers - may_be_acquire_function and arg_type_may_be_refcounted -
> predate the OBJ_RELEASE type flag and the addition of many more helpers
> with acquire/release semantics.
> 
> The purpose of check_refcount_ok is to ensure:
>   1) Helper doesn't have multiple uses of return reg's ref_obj_id
>   2) Helper with release semantics only has one arg needing to be
>   released, since that's tracked using meta->ref_obj_id
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,bpf-next] bpf: Cleanup check_refcount_ok
    https://git.kernel.org/bpf/bpf-next/c/b2d8ef19c6e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


