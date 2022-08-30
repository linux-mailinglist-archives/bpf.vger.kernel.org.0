Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C85A6690
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH3Oqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH3Oqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 10:46:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22046B1BBB
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 07:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7185B81C28
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 14:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B21C4347C
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661870809;
        bh=N2Kd4RIu5KJsSz3YgD3aAOyOltYesRLjncK1uecGVQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWel4NULvqsDD1ERRvcl1+CjG4s+kW7CJB1SgryQwZ4PA9ftQ7xFZQpwU/g98qbDt
         ZiQ0h+ZtdR9P/PxPzUWNIxo3OuYy2A904RCbMqKM1AIGziU0QtNrp0WtGgsUoDmw7f
         s46xUafL/x9robtyPBHbAUUmJtLSYIwmfeppadtZ1iXWpGGX0mjbUqRWxeMxGj/CmK
         0O2TiE4NtexQNw8RJeC9vM0uD9dPyqm0DpPI7op4xpZ+2kfNYqiMOQZ2usz7tygcWv
         nP24B39Hu/EJ48k3XzR5uTHpAQyEYKBWrhJi6Z28z2oaI68Eibh2fB4aT2VrvnxDcO
         MfvOJqnA4hnNQ==
Received: by mail-vk1-f171.google.com with SMTP id j11so3375353vkl.12
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 07:46:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo1mi3LWt9hXSFAGpx+9ybU6hNkJJoGIZILtQKG3emCJMBzW9mfp
        qkj6dYCiHpnO2yJ9dTz+wn7yUvX2nsm6kLr+du4=
X-Google-Smtp-Source: AA6agR6oM7G1MLmcYASfcAuFn7liigOP7I4nrX6IQ9x9bzVgCGvWfPevTXzq95IHagahQP0fQ5nI311cq0tIuYwSQZY=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr5230063vkf.37.1661870808667; Tue, 30
 Aug 2022 07:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn> <1661857809-10828-5-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1661857809-10828-5-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 30 Aug 2022 22:46:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
Message-ID: <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] LoongArch: Enable BPF_JIT and TEST_BPF in
 default config
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Tiezhu,

On Tue, Aug 30, 2022 at 7:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> For now, BPF JIT for LoongArch is supported, update loongson3_defconfig to
> enable BPF_JIT to allow the kernel to generate native code when a program
> is loaded into the kernel, and also enable TEST_BPF to test BPF JIT.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/configs/loongson3_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 3712552..93dc072 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_BPF_SYSCALL=y
> +CONFIG_BPF_JIT=y
>  CONFIG_PREEMPT=y
>  CONFIG_BSD_PROCESS_ACCT=y
>  CONFIG_BSD_PROCESS_ACCT_V3=y
> @@ -801,3 +802,4 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_SCHEDSTATS=y
>  # CONFIG_DEBUG_PREEMPT is not set
>  # CONFIG_FTRACE is not set
> +CONFIG_TEST_BPF=m
I don't want the test module be built by default, but I don't insist
if you have a strong requirement.

Huacai
> --
> 2.1.0
>
