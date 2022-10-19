Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA797605436
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJSXuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJSXuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E75105361
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B345B8263C
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 23:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBD92C433D7;
        Wed, 19 Oct 2022 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666223418;
        bh=9SB82+cEFnXTyP4dHvQ6cAX3i/97tWCD4cxiHKb10is=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ce4tm7VDIAhnaNlB95UNq802h9QKDISB0RaO+lUMb5lJGBnZpe32VRcKP4OHxb+Fg
         uLGTwrcO7dndh179vU173xOsQJ2QWdgHUhWjukvqQ1vzynKlPiD5y+/Lee8se5niKx
         O1/G2HC1QRTjGKSZiBpbOZQRhn5qmCMjUroA1bEYbJuvmFBh1srnVOk1gdEbbYX252
         DUyggaPDHxRKxdaEVyuBk4N3Z03KDfBdnd/I0ZOzd4mkT4ZWwSUp/lxv+U2PvS3wjw
         en1I5yRPVCguM4x2SNtEGt6xo3MrTJk+sHGAYHovlEzTjvuup2wEKW5x4se412p3ut
         g9LSRFKsMpBpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBA93E4D007;
        Wed, 19 Oct 2022 23:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] libbpf: support non-mmap()'able data sections
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166622341782.3888.5454485454762475290.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 23:50:17 +0000
References: <20221019002816.359650-1-andrii@kernel.org>
In-Reply-To: <20221019002816.359650-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Oct 2022 17:28:13 -0700 you wrote:
> Make libbpf more conservative in using BPF_F_MMAPABLE flag with internal BPF
> array maps that are backing global data sections. See patch #2 for full
> description and justification.
> 
> Changes in this dataset support having bpf_spinlock, kptr, rb_tree nodes and
> other "special" variables as global variables. Combining this with libbpf's
> existing support for multiple custom .data.* sections allows BPF programs to
> utilize multiple spinlock/rbtree_node/kptr variables in a pretty natural way
> by just putting all such variables into separate data sections (and thus ARRAY
> maps).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] libbpf: clean up and refactor BTF fixup step
    https://git.kernel.org/bpf/bpf-next/c/f33f742d5674
  - [v2,bpf-next,2/3] libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars
    https://git.kernel.org/bpf/bpf-next/c/4fcac46c7e10
  - [v2,bpf-next,3/3] libbpf: add non-mmapable data section selftest
    https://git.kernel.org/bpf/bpf-next/c/2f968e9f4a95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


