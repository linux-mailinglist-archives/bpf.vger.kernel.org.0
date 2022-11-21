Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C7632577
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 15:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKUOUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKUOUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 09:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709038A6;
        Mon, 21 Nov 2022 06:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C5F6126C;
        Mon, 21 Nov 2022 14:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32C17C433C1;
        Mon, 21 Nov 2022 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669040416;
        bh=X9ahzx6QOLG7vlYDgeNpixkQvDQMZlf4eg6Lylxp+SA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BD3cb/mtADpfWvoUqv7DaMRW3jScXHegfyNfkCHKLKH55leaK2X5/qxF4UZkQnYL9
         bqdUZnShGytI5xUIekIGpFakVT/YkanSMTAX+4Yc2wI3wCAI9J7WPGOAhoUuoUd7pT
         kDhlImfi7mItcmqaafYdPtdKpJK7GG20HX/pAeVN98siPmzXXBqZO9uox2b1Sl/Pd9
         nwbUoaw4cf34d2ateBL685cNeccLU0hJZAInxTZJQzYYW0nn1AsZnlwhSvEvVQTZQe
         U/WkBo4SmIlIiX2XqyzLRgiovzedTTu1AT/XO5uFZSwsZ2n/Apo7GZ2k1DB/drj+O+
         dOjWTv6460d1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14089C395FF;
        Mon, 21 Nov 2022 14:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf/verifier: Use kmalloc_size_roundup() to match
 ksize() usage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166904041607.17586.16719074912703775400.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 14:20:16 +0000
References: <20221118183409.give.387-kees@kernel.org>
In-Reply-To: <20221118183409.give.387-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 18 Nov 2022 10:34:14 -0800 you wrote:
> Most allocation sites in the kernel want an explicitly sized allocation
> (and not "more"), and that dynamic runtime analysis tools (e.g. KASAN,
> UBSAN_BOUNDS, FORTIFY_SOURCE, etc) are looking for precise bounds checking
> (i.e. not something that is rounded up). A tiny handful of allocations
> were doing an implicit alloc/realloc loop that actually depended on
> ksize(), and didn't actually always call realloc. This has created a
> long series of bugs and problems over many years related to the runtime
> bounds checking, so these callers are finally being adjusted to _not_
> depend on the ksize() side-effect, by doing one of several things:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage
    https://git.kernel.org/bpf/bpf-next/c/ceb35b666d42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


