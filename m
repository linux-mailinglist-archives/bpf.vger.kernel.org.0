Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3D6746CC
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjASXA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjASW7f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:35 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FF80880
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:49:42 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id p188so4568613yba.5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlAb+Zgh5/sk9ReAScRsbR41OhhLXHC48gJ1DzwtyJ4=;
        b=P70fMnEXAaQjoxMRk2gA1oNPnZK48a1pb/qrFC499rh0pq1Lqn2K8YI2KkD7G0BWX0
         LZFYTIQ2igbJuKZsplw5sx18lWCHpiLFkNvtfKRhPXhtygiV+4PCWC3Xo2vFrLD3BbUD
         q3654iZqcDlDduY8OkmEZU9V293ADcLk3ZpBS1vHv0WmXc5Hsvrjly5pOLZ1VQsPGK3M
         U8Xb97iMWs+OBx1wV4TGLVphcs8quyXUKJxFcZko10JAwIhACA4an5XIFeFJC49UmEiO
         UwKCR60wb4TsPnmuoKTaKyIAy/nvpmvplQEhJaIkSytfL+HyxzfEb4HU2voaGOGBppAE
         PqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlAb+Zgh5/sk9ReAScRsbR41OhhLXHC48gJ1DzwtyJ4=;
        b=s0BTlkzfKX+Bs9E/cGwocOWppR6HK1ytvPpZY5dg+cDfLSAcZm658USuBehAoo0dCj
         3zvD0Y/CFLdUFkcAsgmlBg1OCjDS9zpr3rm1HtW3ilahAoDHlPAfrA8PiDAQ3Ahf9PUu
         xZW37uWPB2VMoPqpJwwbptjOelNkWfVHG3UO7FKifc+hlcN7UiwalPoQmzB0nSchF2Jl
         T2loS6nE/LVgI03i7ulXMtlT3i61bIaK4Dwe+ZsWLQHD0Yv2BjwELLEJ9pdENEKBLfIg
         OetGC8T5JR58C3Ts8l2xROr6G861Qz7FnmutdkUJ0nPOPwe3KGykkYQu5njXMGT3F0Bn
         5mPQ==
X-Gm-Message-State: AFqh2kqsQCivaRUJTLKXi7Xht/vQC0+rTEfDVAkR9Yr90EvCUz24168v
        Rx7itjgrQF13hq2WAjMpaM6102YLSkkocRLjNgw=
X-Google-Smtp-Source: AMrXdXsevhVVWvEIiLRccAZHLM8M7a5kGfqgy80DgwavLLADT+ZNPOdX7pnJWwrvImG2cgupOqAFjnLPLEYYkUz3iSw=
X-Received: by 2002:a25:4dd7:0:b0:727:e539:452f with SMTP id
 a206-20020a254dd7000000b00727e539452fmr1462772ybb.552.1674168582212; Thu, 19
 Jan 2023 14:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-10-memxor@gmail.com>
In-Reply-To: <20230119021442.1465269-10-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 19 Jan 2023 14:49:31 -0800
Message-ID: <CAJnrk1a9wTzo+hbkY9ivb8xCU6NTvbum7XAnWhn2ugSOBqRnOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: Add dynptr var_off tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 18, 2023 at 6:15 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Ensure that variable offset is handled correctly, and verifier takes
> both fixed and variable part into account. Also ensures that only
> constant var_off is allowed.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 023b3c36bc78..063d351f327a 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -794,3 +794,43 @@ int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
>         );
>         return 0;
>  }
> +
> +SEC("?tc")
> +__failure __msg("dynptr has to be at the constant offset") __log_level(2)
> +int dynptr_var_off_overwrite(struct __sk_buff *ctx)
> +{
> +       asm volatile (
> +               "r9 = 16;"
> +               "*(u32 *)(r10 - 4) = r9;"
> +               "r8 = *(u32 *)(r10 - 4);"
> +               "if r8 >= 0 goto vjmp1;"
> +               "r0 = 1;"
> +               "exit;"
> +       "vjmp1:"
> +               "if r8 <= 16 goto vjmp2;"
> +               "r0 = 1;"
> +               "exit;"
> +       "vjmp2:"
> +               "r8 &= 16;"
> +               "r1 = %[ringbuf] ll;"
> +               "r2 = 8;"
> +               "r3 = 0;"
> +               "r4 = r10;"
> +               "r4 += -32;"
> +               "r4 += r8;"
> +               "call %[bpf_ringbuf_reserve_dynptr];"
> +               "r9 = 0xeB9F;"
> +               "*(u64 *)(r10 - 16) = r9;"
> +               "r1 = r10;"
> +               "r1 += -32;"
> +               "r1 += r8;"
> +               "r2 = 0;"
> +               "call %[bpf_ringbuf_discard_dynptr];"
> +               :
> +               : __imm(bpf_ringbuf_reserve_dynptr),
> +                 __imm(bpf_ringbuf_discard_dynptr),
> +                 __imm_addr(ringbuf)
> +               : __clobber_all
> +       );
> +       return 0;
> +}

Thanks for adding these series of tests. From a readibility
perspective, are we able to simulate these tests in C instead of
assembly?
> --
> 2.39.1
>
