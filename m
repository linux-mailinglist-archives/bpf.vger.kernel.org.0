Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FE57A453
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiGSQuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiGSQuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8284BD37
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 09:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF21961A5A
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9EB4C341CF;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658249415;
        bh=nRF6UCJ0yLFLUCE+wrJ9RqCdLcs5zXd6HbIA9hDHluw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=doIkyrv8E+F1mP1fXHMs0K80cqh+v/t+lTz83PNyKA5mV8CHU6PFaH/C3z9TaI5Ds
         R1aSVDka2X3deCrx9tokv3Eh/iYDArEVBojitRaxomqlJ0p2AmJe8l6wYHAdewKxO6
         76ktpKyTA3UPwy3BJzZuV7udcdqFeQ7DNgNwNipeRuh3994EOrGdw67P12hmcc+nh/
         RP4RVcZeT+ocX/42rS15cH+xg64ASBTUNO9xf0cyh+OCQpVlnAse+yh+FGsSZ7QvRv
         3fqAqc7MFemygjMdPgqPDByIJC2r+/Mx1o+kYb+UbDUEemUc+chgblfvaAB3STnntW
         Fa0hEwu77iwEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBEC3E451BD;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] docs/bpf: Update documentation for BTF_KIND_FUNC
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165824941576.16633.6527542543231469903.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 16:50:15 +0000
References: <20220714223310.1140097-1-indu.bhagat@oracle.com>
In-Reply-To: <20220714223310.1140097-1-indu.bhagat@oracle.com>
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, andrii.nakryiko@gmail.com
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

On Thu, 14 Jul 2022 15:33:10 -0700 you wrote:
> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> linkage information for functions. The Linux kernel only supports
> linkage values of BTF_FUNC_STATIC and BTF_FUNC_GLOBAL at this time.
> 
> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
> ---
>  Documentation/bpf/btf.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,v3] docs/bpf: Update documentation for BTF_KIND_FUNC
    https://git.kernel.org/bpf/bpf-next/c/e5e23424e51e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


