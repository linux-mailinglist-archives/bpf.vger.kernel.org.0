Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17558C9BF
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiHHNuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiHHNuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 09:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4137EA0
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B375B80EA1
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E56AEC433B5;
        Mon,  8 Aug 2022 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659966613;
        bh=xAFOBvAHe5Etj7HSfZXMatiAqFMVhs1ksItff0QeWe4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R6BYIHwFP5/0ksO/S/gv8wl07QVBjjzU2gbTh/nb4N3C1FSvWP2Sr/d/0svKMQgQu
         nT567smN5maYs2bhAqDv3fRn7tAQ/huQicKteMq5+lCu0fbkpgxonlBJPaK5XgPUUk
         peald/HcwzOXR0leVRTdh1ZtSchmfOnV18idOb7Ftta2kakSmqFRMqLwIt2ifPG9Qk
         xh+tkTKh8uYAmMmg6GErvgJ9CxwJZ5jdDnBkMl3q5VXZdh3jBR5/sxc4FUp7nGnKhN
         2cWuSsHPqP4DRXWzXJ7QVIWzFHTJAG6xoviCPeT5tkV73qo5veK3+OM11OIhNIL2I5
         FKKQ3P2ReaHYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF420C43144;
        Mon,  8 Aug 2022 13:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: reject legacy 'maps' ELF section
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165996661384.25053.14283434785943423706.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 13:50:13 +0000
References: <20220803214202.23750-1-andrii@kernel.org>
In-Reply-To: <20220803214202.23750-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 3 Aug 2022 14:42:02 -0700 you wrote:
> Add explicit error message if BPF object file is still using legacy BPF
> map definitions in SEC("maps"). Before this change, if BPF object file
> is still using legacy map definition user will see a bit confusing:
> 
> libbpf: elf: skipping unrecognized data section(4) maps
> libbpf: prog 'handler': bad map relo against 'server_map' in section 'maps'
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: reject legacy 'maps' ELF section
    https://git.kernel.org/bpf/bpf-next/c/e19db6762c18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


