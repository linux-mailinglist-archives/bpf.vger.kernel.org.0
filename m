Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD2E6DB678
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDGWaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDGWaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 18:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEF3B454
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 15:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6118665443
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 22:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF4FFC433EF;
        Fri,  7 Apr 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680906618;
        bh=oQAVWJhsJFf4LM0r/hQYnZp1s+SdRiMBxwQOPkDMYfo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TrFbxxzyW47ZMeMPum/wUq36qywi26/FPFRCEJowobM2rgb8ym8clqC3MCoJ4KqJ+
         e3FyhYi7HZ1hmxKzizTswNq/+sHxEvlnPJ4zisxGZPktIUMc2usZ+od9r8SCnvbagF
         BN/lLqMPRnZIbTqq7Du2R/6WRANnFS/LN5/5csPQJ+XkLT/SiVdZZM51uLb3st9Xd0
         DIMQoNa7OCsiubNWX8leJi6srVfb8gNnefx48kdazyXQfSe1c06yMG4ZrKzNQm1cik
         dFa6LGLx5DC2UGZqXw+IHfWJMvLzPHNI5r3J3Quf5uNTNGUwkoFAX/+xe7sPw0ddAV
         OgbMaGl5YBhww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96020E4F0D0;
        Fri,  7 Apr 2023 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: set program type only if it differs from
 the desired one
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168090661861.32399.7422925241601882286.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Apr 2023 22:30:18 +0000
References: <20230407081427.2621590-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20230407081427.2621590-1-weiyongjun@huaweicloud.com>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     andrii@kernel.org, quentin@isovalent.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        weiyongjun1@huawei.com, bpf@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  7 Apr 2023 08:14:26 +0000 you wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> After commit d6e6286a12e7 ("libbpf: disassociate section handler on explicit
> bpf_program__set_type() call"), bpf_program__set_type() will force cleanup
> the program's SEC() definition, this commit fixed the test helper but missed
> the bpftool, which leads to bpftool prog autoattach broken as follows:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: set program type only if it differs from the desired one
    https://git.kernel.org/bpf/bpf-next/c/b24f0b049e70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


