Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610046B53DA
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 23:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCJWIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 17:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCJWHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 17:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C3520A37
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 14:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 611BEB8240F
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 22:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CCBC433A7
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678485992;
        bh=N9aHt9sxD+NNlh7IW6KfQ3IxapaUbKGJbqaYoa8yrcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RCCxkqU8YZ6hS/jMFoVCDR4Zn2NDpsXhdyJ4ilFe8r/gEacLYvpkfvLVyiy1NIoZD
         uQQ0kXbhobIUWP8WXRmX4Gu8sPOE1twIqu8xQ2LzCaGA7GINkeI3WKxb7jYNmlED9Y
         6OwDOUiHsAqh0ccFVaa5UwK5iOHNA21CNoQLsf09PKiEvaeIvoeMIcOVB95RdT99/T
         wdfmqzYQzV8pi05qa9/PEobvJJcTKh3PIYu/mdPWeFdZdMsZU4nDBpsyhM1QSWO4/d
         v8eBtt4tDtACFjmgP9ZAQn9qBQRsy6HW6ruWeNs8XA+Grnyxw6YM7vc6Em2nW3eaSg
         0VtQTVjahzARw==
Received: by mail-lj1-f178.google.com with SMTP id h9so6843936ljq.2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 14:06:32 -0800 (PST)
X-Gm-Message-State: AO0yUKU8DF1RDdOUAcN5Oh6KVseDkBB09ziRgk75iF3ZzGQ6x2AAwz1X
        Ex5ezufWfi15uCFDaHi0/1uWvBbhjuHAGOjD3SU=
X-Google-Smtp-Source: AK7set8CSSl6Jn60lqJ3BwRCi1XAuwD9uNxFpvCfRGoNCsAfjI4WNjPTLPj8UV4+BLLitZF/4q2nQ1s1uHeqdl3lfrU=
X-Received: by 2002:a05:651c:124e:b0:295:c458:da98 with SMTP id
 h14-20020a05651c124e00b00295c458da98mr8444428ljh.5.1678485990139; Fri, 10 Mar
 2023 14:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20230309180213.180263-1-hbathini@linux.ibm.com> <20230309180213.180263-4-hbathini@linux.ibm.com>
In-Reply-To: <20230309180213.180263-4-hbathini@linux.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Mar 2023 14:06:17 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7ChFn8Q38-Y76NBDVAoP=WnWOmZEyBN76ifnriTbF1tQ@mail.gmail.com>
Message-ID: <CAPhsuW7ChFn8Q38-Y76NBDVAoP=WnWOmZEyBN76ifnriTbF1tQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] powerpc/bpf: implement bpf_arch_text_invalidate
 for bpf_prog_pack
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 9, 2023 at 10:02=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> Implement bpf_arch_text_invalidate and use it to fill unused part of
> the bpf_prog_pack with trap instructions when a BPF program is freed.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 0a70319116d1..d1794d9f0154 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -293,3 +293,18 @@ void *bpf_arch_text_copy(void *dst, void *src, size_=
t len)
>
>         return ret;
>  }
> +
> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +       u32 inst =3D BREAKPOINT_INSTRUCTION;
> +       int ret =3D -EINVAL;

No need to set to -EINVAL here.

> +
> +       if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
> +               return ret;

Just return -EINVAL instead.

> +
> +       mutex_lock(&text_mutex);
> +       ret =3D patch_instructions(dst, &inst, true, len);
> +       mutex_unlock(&text_mutex);
> +
> +       return ret;
> +}
> --
> 2.39.2
>
