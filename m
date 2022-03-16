Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465FC4DBA9D
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiCPWVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 18:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiCPWV3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 18:21:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21E2DC5
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 15:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10B01B81D95
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 22:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89762C340EE;
        Wed, 16 Mar 2022 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647469211;
        bh=EwbVVjTZpawudrMrhlh2JbHVN0zZSTWWrGq+rCvTql8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vDmq2KeyDehWVCrbIzXSyKr5WCHKkIGAPWL8heSz0r6EOuQ647pVNm/MusIFXS4I6
         yo1/oTeC03ni2G9nZMaO6uCHTusnSe30fFHH2cCzU1jscZqm57pcZlfi6jFM2gPyy8
         fP2VQQfH1rY0dtRWbTBwaTbAzsZeoVOirgEcCLyqa3hDIjEx4FanCQ0F/ARBWhOzke
         EcLSZexktz+usNsStYPThwyXFYdiduwE9MFXVaQ3dv9izAo1QP2qO0emeSNu7A8+wV
         umj86ucjz0Y5j9DGfC/iQaLuL0Uyh0bEptn5kj8oaRc9LGgUk+gtshsBxs289srvEj
         FslnVbDbyv5UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AFF0E6BBCA;
        Wed, 16 Mar 2022 22:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Remove libcap dependency from bpf selftests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164746921143.11329.12401305118912926154.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Mar 2022 22:20:11 +0000
References: <20220316173816.2035581-1-kafai@fb.com>
In-Reply-To: <20220316173816.2035581-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kernel-team@fb.com,
        sdf@google.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Mar 2022 10:38:16 -0700 you wrote:
> After upgrading to the newer libcap (>= 2.60),
> the libcap commit aca076443591 ("Make cap_t operations thread safe.")
> added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
> shift that breaks the assumption made in the "struct libcap" definition
> in test_verifier.c.
> 
> This set is to remove the libcap dependency from the bpf selftests.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: selftests: Add helpers to directly use the capget and capset syscall
    https://git.kernel.org/bpf/bpf-next/c/663af70aabb7
  - [v2,bpf-next,2/3] bpf: selftests: Remove libcap usage from test_verifier
    https://git.kernel.org/bpf/bpf-next/c/b1c2768a82b9
  - [v2,bpf-next,3/3] bpf: selftests: Remove libcap usage from test_progs
    https://git.kernel.org/bpf/bpf-next/c/82cb2b30773e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


