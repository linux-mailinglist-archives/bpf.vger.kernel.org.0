Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF576C5961
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCVWUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 18:20:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8A86B6
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0CDEB81E2F
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 889ABC4339C;
        Wed, 22 Mar 2023 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679523619;
        bh=i7rNq3s2kjFEhiPFt8DGcS9osqAXSTiG07Jc/8B9Mi4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P5rsC+5uzjAw2FuXzdKuNlg1i0PMZ0vcPyJt83qriRdP8NCvY5wRaCbQ8rErwz1Nj
         eYXMcHItFDDa0NfuiCzUWdSBhQVn9o2r1oGnGohgugbaZTG9h+46ESx8SFqfnUhPCv
         ypSXXu2rIhH0Uyu4THnbFh0bQ9Y41IRMxkxHABnYvAieS8xFjVMlk2yRZXevzP6io8
         lfrsKDtGRykci58JoD/esfGMWLTJz+dkBZH51Eku8qIi7KBkdGOJ0ZAQbN18nh+O0q
         JCdmmV3IgiKhcH/0W/LZVO3aVv4Yys8NJgZhkpAwdLTFp5vEe+hgkLfLpHQfCEe1jJ
         ggVAzfXegr7vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53ABBE66C8D;
        Wed, 22 Mar 2023 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] error checking where helpers call bpf_map_ops
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167952361933.28284.6508431809533336142.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Mar 2023 22:20:19 +0000
References: <20230322194754.185781-1-inwardvessel@gmail.com>
In-Reply-To: <20230322194754.185781-1-inwardvessel@gmail.com>
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org, kernel-team@meta.com
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

On Wed, 22 Mar 2023 12:47:52 -0700 you wrote:
> Within bpf programs, the bpf helper functions can make inline calls to
> kernel functions. In this scenario there can be a disconnect between the
> register the kernel function writes a return value to and the register the
> bpf program uses to evaluate that return value.
> 
> As an example, this bpf code:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf/selftests: coverage for bpf_map_ops errors
    https://git.kernel.org/bpf/bpf-next/c/830154cdc579
  - [v2,bpf-next,2/2] bpf: return long from bpf_map_ops funcs
    https://git.kernel.org/bpf/bpf-next/c/d7ba4cc900bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


