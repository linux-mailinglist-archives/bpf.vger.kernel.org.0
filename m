Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B7457CADB
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiGUMpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiGUMpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 08:45:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BBB32DBD;
        Thu, 21 Jul 2022 05:45:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so2979271ejr.5;
        Thu, 21 Jul 2022 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SF6PL+9u/rWTvGFnN3y5cs77lAmi9XzrDEhj4k0QMec=;
        b=hRUA5VukzV+cxLpP4an3+Kxq60Q1V3UATiWvA4aHCoLz/H7MyK8opnRFn40TPS8XSc
         arMzN10oZ1r71fBI2vBh8N3ALxuUBaTWW/+wrR4tDQbOYY9DoGLQQ4QIsIKkHTPBFGvn
         FuN2M6pAgnTvOuECZtBHkW2bU2+DRtgLi+3qPngZt5Uv46xi6VW3eXCi3E+R94XvjmUI
         FXpSSNBFXt95eGkLzKO6wgcp0Y1bDtS4pbdwI2E6ejg/G/7PDEemz3AqMwFyY/4GH+W2
         DQLh7pzmeksKneyB3q1LhsoG4AriogNHqKdPSAhknLSult4hulnZGGd7iY2cnPNg78vh
         DwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SF6PL+9u/rWTvGFnN3y5cs77lAmi9XzrDEhj4k0QMec=;
        b=tdgjTeW/En2CuWOqO/qwVDqW7CRNGV3xalLGeNe9XodjTi7FD6yfIfaYcVO2gN5HQj
         0sPlzQfl9sCCPdkvx5mSG1g2j6AhFsEJeqiSEc0ZtmbO0ZMJXQ7k4XZa5e4eCvk2W4PP
         fyhZqLhZGtanx6Rr+h4BjP4gOGBmToj62ATeUOkf8coUEtaszmuknxP4Cs9mvFkeygTa
         MMxB8Hg2OScSXORjqxjvQnAv3qlJYVyAduULu79lfka3TvT0JV8+sBlUdQ+1syY4Ad8E
         3hR89SbWuOxLb1qBAGar1XSrGH7tOpHmsGysEX9HmtbTSuleN4DLtXQCJvz88a/crEYX
         5IUA==
X-Gm-Message-State: AJIora90f4hGmT76TwSBleVLxx4WJxgtO9gsZxKfXnYGcPwfYL/U1HDT
        OijN1Td5V+jT5hJvaU+4NcM=
X-Google-Smtp-Source: AGRyM1v1wMIO6eOgjaSlIbNT/CZKAMn4rrstcY4XHB01MyAXyU4DHf7Ls3PxG8QhieA1PNW6DtWrKA==
X-Received: by 2002:a17:906:5d0d:b0:72f:4782:2219 with SMTP id g13-20020a1709065d0d00b0072f47822219mr14732150ejt.498.1658407528202;
        Thu, 21 Jul 2022 05:45:28 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id rn9-20020a170906d92900b0072abb95eaa4sm794288ejb.215.2022.07.21.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:45:27 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 21 Jul 2022 14:45:25 +0200
To:     Xu Kuohai <xukuohai@huaweicloud.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Will Deacon <will@kernel.org>, Yonghong Song <yhs@fb.com>,
        Zi Shen Lim <zlim.lnx@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix compile error in dummy_tramp()
Message-ID: <YtlKZbc8D7S20BX9@krava>
References: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 21, 2022 at 08:13:19AM -0400, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> dummy_tramp() uses "lr" to refer to the x30 register, but some assembler
> does not recognize "lr" and reports a build failure:
> 
> /tmp/cc52xO0c.s: Assembler messages:
> /tmp/cc52xO0c.s:8: Error: operand 1 should be an integer register -- `mov lr,x9'
> /tmp/cc52xO0c.s:7: Error: undefined symbol lr used as an immediate value
> make[2]: *** [scripts/Makefile.build:250: arch/arm64/net/bpf_jit_comp.o] Error 1
> make[1]: *** [scripts/Makefile.build:525: arch/arm64/net] Error 2
> 
> So replace "lr" with "x30" to fix it.
> 
> Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Jean-Philippe, could you please take a look?

thanks,
jirka

> ---
>  arch/arm64/net/bpf_jit_comp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index dcc572b7d4da..7ca8779ae34f 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -610,8 +610,8 @@ asm (
>  #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
>  "	bti j\n" /* dummy_tramp is called via "br x10" */
>  #endif
> -"	mov x10, lr\n"
> -"	mov lr, x9\n"
> +"	mov x10, x30\n"
> +"	mov x30, x9\n"
>  "	ret x10\n"
>  "	.size dummy_tramp, .-dummy_tramp\n"
>  "	.popsection\n"
> -- 
> 2.30.2
> 
