Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCE4B1BC6
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbiBKCAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 21:00:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiBKCAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 21:00:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D49E5F48
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 18:00:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF4860C8F
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 02:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35A07C004E1;
        Fri, 11 Feb 2022 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644544809;
        bh=H/czrBuPB8YBw5j96F5rQump9w7Nk0qeYqM/O+B6FnQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f7qLY6uG8DTKrtWFe6HgsOqU8HeqiNBcWb6Vg0uxGcEgN7Pmi77rFqNVNWrZYm/5F
         ywuFt89PlvGfnypi9ZhBSIRx0omWgZC9yeva8m7b0mSDTBWRcQ4AS0ZD42dJ8Yoq1e
         UNZlvKuBMh88hwNHneZGm/4CNxO74EIYly1stYwTvtKDDVNXILrYTvroQl2T9Nb9f4
         7xcRnSjToo0nNTrcHV1Xd3enmNTCd1V2Yn3aR1ga1FuPohS60mc/wKX9DS9ssUI3jD
         TzOxLmCMDk4DlDp6QrcQgoYJA75OTMsPRazK2y0t7ldTKlveFRqSfLKwhPsK/Wwkot
         TgAclSPadPUig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B1D4E6D447;
        Fri, 11 Feb 2022 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftest/bpf: check invalid length in
 test_xdp_update_frags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164454480910.21694.8490323897002968960.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 02:00:09 +0000
References: <3e4afa0ee4976854b2f0296998fe6754a80b62e5.1644366736.git.lorenzo@kernel.org>
In-Reply-To: <3e4afa0ee4976854b2f0296998fe6754a80b62e5.1644366736.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, yhs@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed,  9 Feb 2022 01:35:12 +0100 you wrote:
> Update test_xdp_update_frags adding a test for a buffer size
> set to (MAX_SKB_FRAGS + 2) * PAGE_SIZE. The kernel is supposed
> to return -ENOMEM.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - updated ASSERT log message
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftest/bpf: check invalid length in test_xdp_update_frags
    https://git.kernel.org/bpf/bpf-next/c/a5a358abbc39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


