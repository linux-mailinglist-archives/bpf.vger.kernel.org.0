Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB706D7077
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 01:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDDXUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 19:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDXUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 19:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B433C06
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 16:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4271863A54
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 23:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A61C4339B;
        Tue,  4 Apr 2023 23:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680650416;
        bh=Pf8uoTf/VzYOcIWhfC5pIdbt0W5+9/nM0gvM0o7i+1I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DLxOY6H44DlU9KgL58D7+2vOrgQpUwhrgBYcSYGt/6EttaH77Ls2Za7tUSpHZ2Xuc
         c+i5Ris2yTe/pyxthqaHdi/9K4w2+0dFS6qnit2eWWqUYvaE2xS5sZJDNzXYPS6n15
         Xie7PtB2ui89n6wwUSMoWnlEdFL/eFveu1MTd5vhsjpnOwn03CJnyyWrJUz15xxaap
         gDVJBeeEGXrUjFmQdR0qwWFUsb491VZFfiX5zyIzIRxxRGFaUzvzMUmTJHsql9zcVp
         72prVPKIeR+VltlWMO/UonSBQOGFsVFwcyDfF0Yn7kTZQ3b8sM8cSVzmNPAma9oI99
         Z+Vejos5nzs+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DA3BC395D8;
        Tue,  4 Apr 2023 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add RESOLVE_BTFIDS dependency to
 bpf_testmod.ko
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168065041651.3814.372124093195611012.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Apr 2023 23:20:16 +0000
References: <20230403172935.1553022-1-iii@linux.ibm.com>
In-Reply-To: <20230403172935.1553022-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  3 Apr 2023 19:29:35 +0200 you wrote:
> bpf_testmod.ko sometimes fails to build from a clean checkout:
> 
>     BTF [M] linux/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko
>     /bin/sh: 1: linux-build//tools/build/resolve_btfids/resolve_btfids: not found
> 
> The reason is that RESOLVE_BTFIDS may not yet be built. Fix by adding a
> dependency.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add RESOLVE_BTFIDS dependency to bpf_testmod.ko
    https://git.kernel.org/bpf/bpf-next/c/8fc59c26d212

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


