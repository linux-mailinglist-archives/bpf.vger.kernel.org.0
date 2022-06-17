Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150E854FDE6
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 21:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiFQTuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiFQTuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 15:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921B33350
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 12:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D360B82B8A
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 19:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25835C3411D;
        Fri, 17 Jun 2022 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655495413;
        bh=SrzaWjR9Q0Ix81rYxINc2TtnH06Oh+Y827HrpTpQJjg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aupQpyWKDPwGLpLczE3v8pcqNFidTlIMeYp8GnO5q6p/gvJ242gLpavr65RETZPe5
         8R5G4n7RQH060ulaBTPphXkBVcPgVa52VNOFwz4lHnNw46MCAhL/bLOm6tbZp10ise
         Vd+HNLHG9gVfLMfIT2CiSV+jFrMjqfN4fyH3DXnFnkQ9ZoTZ+fM6SfJogzvQzvxOZD
         UPP+41Mezl15Lphmi6SrmAt2oTD6z+8vbOD9klEahe6p87Dc2uMv3q6KH7v1i9BUHT
         arq+9IthhuhhfPLvVF+vPyBvVRvNQIBzNqMjJgiZ4grZKjpe9ueR+AZlRAusK+XOXm
         IIkMzi6XTTUrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0967EE73877;
        Fri, 17 Jun 2022 19:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, docs: Update some of the JIT/maintenance entries
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165549541303.30132.12312177417355175803.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 19:50:13 +0000
References: <f9b8a63a0b48dc764bd4c50f87632889f5813f69.1655494758.git.daniel@iogearbox.net>
In-Reply-To: <f9b8a63a0b48dc764bd4c50f87632889f5813f69.1655494758.git.daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com
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

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Jun 2022 21:42:33 +0200 you wrote:
> Various minor updates around some of the BPF-related entries:
> 
> JITs for ARM32/NFP/SPARC/X86-32 haven't seen updates in quite a while, thus
> for now, mark them as 'Odd Fixes' until they become more actively developed.
> 
> JITs for POWERPC/S390 are in good shape and receive active development and
> review, thus bump to 'Supported' similar as we have with X86-64/ARM64.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, docs: Update some of the JIT/maintenance entries
    https://git.kernel.org/bpf/bpf/c/63ce81d1c404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


