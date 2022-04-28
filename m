Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF687513E32
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbiD1Vzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352763AbiD1Vx4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4421B3
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5634361F19
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 21:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E101C385AE;
        Thu, 28 Apr 2022 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651182612;
        bh=F4muJr/fBwAgbz0vAAMShUnrVCAy/eIcyVZuNQmST3Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EAmr+/JusLwyeKFpvpS1vE675Fj4MWH9DBFgFRJk9jDMLL0K7rXNuvr50vO8QEJg3
         K2xZzXEWkG4XZbE6zlYberDN70l/OI7gIG5HkcKqCTtBJYKzrAGrZZWwVsEo8w6g5r
         fOxnNd0d3+pU2bBNleRURg0zScWE2icZvqLOhlmHEKixAwi/YYc+ycwWDakGyUabBh
         AkQnJ3h/upMGw/+n5nHVvYBsfAi3KytiV0wskOkCPMsF/C0/Dj8E4ZsCOleeDqHuD3
         o1iQxWfb74JX2fogiGNIaD4lhTQpbnC5MtaplonDYu9WG2NPnR5/lcuLdAcnDK8suO
         Wz/cox2Z5uykg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81150E85D90;
        Thu, 28 Apr 2022 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Add target-less tracing SEC() definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165118261252.31667.4038457683595407797.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Apr 2022 21:50:12 +0000
References: <20220428185349.3799599-1-andrii@kernel.org>
In-Reply-To: <20220428185349.3799599-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, delyank@fb.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 28 Apr 2022 11:53:46 -0700 you wrote:
> Allow specifying "target-less" SEC() definitions for tracing BPF programs,
> both non-BTF-backed (kprobes, tracepoints, raw tracepoints) and BTF-backed
> (fentry/fexit, iter, lsm, etc).
> 
> There are various situations where attach target cannot be known at
> compilation time, so libbpf's insistence on specifying something leads to
> users having to add random test like SEC("kprobe/whatever") and then
> specifying correct target at runtime using APIs like
> bpf_program__attach_kprobe().
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] libbpf: allow "incomplete" basic tracing SEC() definitions
    https://git.kernel.org/bpf/bpf-next/c/9af8efc45eb1
  - [v2,bpf-next,2/3] libbpf: support target-less SEC() definitions for BTF-backed programs
    https://git.kernel.org/bpf/bpf-next/c/cc7d8f2c8ecc
  - [v2,bpf-next,3/3] selftests/bpf: use target-less SEC() definitions in various tests
    https://git.kernel.org/bpf/bpf-next/c/32c03c4954a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


