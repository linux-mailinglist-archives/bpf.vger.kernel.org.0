Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3534A46439C
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 00:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbhK3Xxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 18:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhK3Xxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 18:53:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC129C061574
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 15:50:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E9D6CCE1D50
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 23:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AE05C53FCB;
        Tue, 30 Nov 2021 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638316209;
        bh=yJoS2p9UnRByrr2pMgjELg9RQEx/iQrLh4J59KvcaiM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UnL11+/bJ7PnMCDg0Anyi9sQaLFGhJARhnL04vJvVgLp9msci+fDygUWnTdILqxpR
         V3Oajc6FwvGSp4GoDXiKeXkW2eUFJHneAv4EtJZznm1o2EShdGeFsQpCJdWvQkeRld
         kCw8APC+gPaHeDwIZm/g2Hh3wddVGciT7dBaLCtIxSOnomlLDUArd12+H2xf2TWdT2
         TEFHfLlN0ffCgN3wjdmqJ4LkvTSA1z0Ks14/s/vr9t6z7T/ezlELHAmSiAxnRiPbl0
         BNN2cvIrJQ/kcOeMGPoS5efNr7B29BbBB19/r6PbcuOiPNOCgeKCeAdI7CWTGxgSxi
         h69REXTrJTuNA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DAB3D60A50;
        Tue, 30 Nov 2021 23:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] Apply suggestions for typeless/weak ksym
 series
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163831620889.12085.4220989783187969990.git-patchwork-notify@kernel.org>
Date:   Tue, 30 Nov 2021 23:50:08 +0000
References: <20211122235733.634914-1-memxor@gmail.com>
In-Reply-To: <20211122235733.634914-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 Nov 2021 05:27:30 +0530 you wrote:
> Three commits addressing comments for the typeless/weak ksym set. No functional
> change intended. Hopefully this is simpler to read for kfunc as well.
> 
> Kumar Kartikeya Dwivedi (3):
>   bpf: Change bpf_kallsyms_lookup_name size type to
>     ARG_CONST_SIZE_OR_ZERO
>   libbpf: Avoid double stores for success/failure case of ksym
>     relocations
>   libbpf: Avoid reload of imm for weak, unresolved, repeating ksym
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] bpf: Change bpf_kallsyms_lookup_name size type to ARG_CONST_SIZE_OR_ZERO
    https://git.kernel.org/bpf/bpf-next/c/d4efb1708618
  - [bpf-next,v1,2/3] libbpf: Avoid double stores for success/failure case of ksym relocations
    https://git.kernel.org/bpf/bpf-next/c/0270090d396a
  - [bpf-next,v1,3/3] libbpf: Avoid reload of imm for weak, unresolved, repeating ksym
    https://git.kernel.org/bpf/bpf-next/c/d995816b77eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


