Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDA5F3AE9
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 03:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJDBE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 21:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJDBEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 21:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7821E5
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 18:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072E261215
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 01:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5D0C433C1
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664845473;
        bh=pEVQhCo+b7sjjK3ZV2xH6y94lyJIutK1LbqNRfu+vfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q8qtRAJRWr+E8gpm12D1dQegq+aCXEXS/pXGzpp7aCSeCBM9n6YAmlIIUqcCzB2kw
         JQdifq7DWwtQIxvKJmXZqYFxt0AVdmC5N1AImSo1ZlKd1+eShGdD3CkxIEYlQIoOD0
         n7T+usXXzcTXVGBpWQVVPA8muqZHDSvys/cMLoVDNvvnhO6sE0nh4HCwm7JMPL+bBA
         MtjIvDXYodhNTL3lQLcf0P+BIFL9uZn8r15yuEtOdbmpX/uouiEjqhxtVL1t31DkGM
         fCIlk6uT7fzOjpZIbW6q3TxkKfb4NW8pHKujFxDpISbUxqsyhvvHojLFE8re/rvKDE
         ZWU0wlINx0miQ==
Received: by mail-lf1-f45.google.com with SMTP id bp15so5500254lfb.13
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 18:04:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Zg9L7xK/AMvbu/vPz4KMNlh/e4kSuEcx3fYPaId6qizhWe5sV
        9EWmSGL63X1kyNkO2Ly63onn8kddv2+gISvKz0Y8iA==
X-Google-Smtp-Source: AMsMyM7pbQVs3Sf9YBuER3XSR8BrL7jIquvse1sVv1bxcPF5E+FnldPa4t2rclt+ZO957LGVvAfq7egD7MSAzqfD0wU=
X-Received: by 2002:ac2:50da:0:b0:4a2:44dc:b719 with SMTP id
 h26-20020ac250da000000b004a244dcb719mr1857148lfm.652.1664845471456; Mon, 03
 Oct 2022 18:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221003011727.1192900-1-jmeng@fb.com>
In-Reply-To: <20221003011727.1192900-1-jmeng@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 4 Oct 2022 03:04:20 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7_ZNKsE5b9ECqf7+U9qs8E2hbx4GXvAhrnG3iVApqLjg@mail.gmail.com>
Message-ID: <CACYkzJ7_ZNKsE5b9ECqf7+U9qs8E2hbx4GXvAhrnG3iVApqLjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x64: Remove unnecessary check on existence
 of SSE2
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 3, 2022 at 3:17 AM Jie Meng <jmeng@fb.com> wrote:
>
> SSE2 and hence lfence are architectural in x86-64 and no need to check
> whether they're supported in CPU.

Why do you say this?

The Instruction set reference does mention that:

Exceptions:

#UD If CPUID.01H:EDX.SSE2[bit 26] = 0

(undefined instruction when the CPUID.SSE2 bit is unset)

and also that the CPUID feature flag is SSE2

>
> Signed-off-by: Jie Meng <jmeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d09c54f3d2e0..b2124521305e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1289,8 +1289,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>
>                         /* speculation barrier */
>                 case BPF_ST | BPF_NOSPEC:
> -                       if (boot_cpu_has(X86_FEATURE_XMM2))
> -                               EMIT_LFENCE();
> +                       EMIT_LFENCE();
>                         break;
>
>                         /* ST: *(u8*)(dst_reg + off) = imm */
> --
> 2.30.2
>
