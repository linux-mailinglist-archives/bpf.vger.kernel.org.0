Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9258DD59
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbiHIRkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245101AbiHIRkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D7F1B
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 10:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939F260FE9
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 17:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8D49C433D6;
        Tue,  9 Aug 2022 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660066815;
        bh=YQf11a4RRVMMyIyByfjo2aITp/qLAACC9LENA0ygrRA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qL0l4iCcku0bi25Sjd8do7b/twZQ9XsbYLS9r/qJYTl1rcfXzLYMwhWFEqIolHvXE
         yE+shSBpQw86jITNLnEKEiZttvLpiPLOGPF1NuFuZ7dDOERVhntMO1/dv6oIzRq152
         KCTJkLWZSU+kh7ZJGUe2gpwDGb9kkOaxQGySY+60iW4R/MzyR10vosItUYXcH5aut/
         /f2ZSv7M2QhNh5bTef+xCfoJnGpIUu+DmENuuB1J9IRikq8Wd5Puky5BeWWceZ67e4
         Ej/U/0HcRfPWgNTMpOaP4sUizq1nQDI7lkFeCQ5S/BiDvQAs6rZ7iqpOY1bdRfDSm/
         CqZhwAlaiUczw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC011C43140;
        Tue,  9 Aug 2022 17:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpf: Perform necessary sign/zero extension for
 kfunc return values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166006681483.22099.2794348194868728464.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 17:40:14 +0000
References: <20220807175111.4178812-1-yhs@fb.com>
In-Reply-To: <20220807175111.4178812-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, tj@kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 7 Aug 2022 10:51:11 -0700 you wrote:
> Tejun reported a bpf program kfunc return value mis-handling which
> may cause incorrect result. If the kfunc return value is boolean
> or u8, the bpf program produce incorrect results.
> 
> The main reason is due to mismatch of return value expectation between
> native architecture and bpf. For example, for x86_64, if a kfunc
> returns a u8, the kfunc returns 64-bit %rax, the top 56 bits might
> be garbage. This is okay if the caller is x86_64 as the caller can
> use special instruction to access lower 8-bit register %al. But this
> will cause a problem for bpf program since bpf program assumes
> the whole r0 register should contain correct value.
> This patch set fixed the issue by doing necessary zero/sign extension
> for the kfunc return value to meet bpf requirement.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Always return corresponding btf_type in __get_type_size()
    https://git.kernel.org/bpf/bpf-next/c/a00ed8430199
  - [bpf-next,2/3] bpf: Perform necessary sign/zero extension for kfunc return values
    (no matching commit)
  - [bpf-next,3/3] selftests/bpf: Add tests with u8/s16 kfunc return types
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


