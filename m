Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A657A476
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGSRAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiGSRAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690472F014
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 10:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2073B81A58
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 17:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C4E7C341CA;
        Tue, 19 Jul 2022 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658250014;
        bh=i/a/yedxd9WvJ0aVqDIYn+1Dctlbm1F9kJ6Ko5yiwxc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BfbSfJ2oiSBYydN/115mCbaHD3fQ00rk0EiJg64q7DagitjFhWZuCuCY4O+c3f2aW
         XSMsLY+MwowsoDhGvg3R/vNVHLcyJ3QSgiZUU15IJ0SoV/PymqeuTjwZp4eH6+/AiR
         tLhZXcvLJIRq8ncq0nDpnvzVZEFNWc2CtJGMdx7UYztkpME5xMV27KMdUdxXBbXQeH
         X/6hPMjFL5ZtP9CZMhslYjKJnlpSfrfLMG3d/aD1BTKc+V/r7iWY4j2hQm/dodAO6N
         P1hyES/W89R9Rtz0emomdo923j4f7KJiJtHN+MdT4Uq//djbIoMib0+DfotCjTPVxX
         nAu67F6eabUZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E623E451B7;
        Tue, 19 Jul 2022 17:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: fallback to tracefs mount point if
 debugfs is not mounted
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165825001418.21239.13241678785744373891.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 17:00:14 +0000
References: <20220715185736.898848-1-andrii@kernel.org>
In-Reply-To: <20220715185736.898848-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, connoro@google.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 Jul 2022 11:57:36 -0700 you wrote:
> Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
> debugfs (/sys/kernel/debug/tracing) isn't mounted.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> Suggested-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: fallback to tracefs mount point if debugfs is not mounted
    https://git.kernel.org/bpf/bpf-next/c/a1ac9fd6c650

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


