Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D054D637
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 02:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiFPAnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 20:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFPAnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 20:43:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3F17A9C
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 17:43:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g25so26327395ejh.9
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 17:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cos7i+/nuqHOuUAtWVYeQHKdx91no25N0fxClWQLeCU=;
        b=FW54tsWvPHJlvVcdYoVPC1mCgyC+FENrbmiPWc4N/X9WG2dAVzAHemWg4TT+zoxiSi
         x6xx/TaBPO+qI0ZxhmY8+UHqHwDzhCHfXpUx8JFlLzSPIY8LFJOBFdqiFQ9zY7vXVkR1
         9L6kTLYIM2eXtP+kMcpBL+6UdyYq8WahH+fh8LK9WpnqvKm3MhI8neSZKQkuv1oyoWsu
         6X0Lf1ryFSj0ZKmOdWPl5oMMbW/vqdsqc+9wvGc5Sy0xVb51Sb1uUe6tSdkDMfiPYUVF
         oODq4MXuCCYpBryoCA4ehHwaXmreDPsMzQj4RoucnVBcNhyh6JLbONDzKMxNRgS8TyM0
         W+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cos7i+/nuqHOuUAtWVYeQHKdx91no25N0fxClWQLeCU=;
        b=M4pY37aILxcTln9pHKTCR7yN3kZ1OfZOBsps+E+rmLJUqo//UzJJmgbFmqW+/FJDxz
         2/WrNQwjB5xDjK6YxeBLKik4kzJnahryiA/4jL65yqPBId3+54ifnEtQ2VbGTMT7aR9+
         NK6Lbj1Y0Ko70jQL3pNQPgERdWXOJSCChoK1ZGqyxtkZdgGYFBtpnjqKY97AsWRymdaR
         tnLmDII6ylHy7UDtshaZN0jt5XzRh5JsQiGPGL3zNYDyMIQuOOq1DpgM20QnwDdfsiiQ
         bA/7ARJ6+erRWAskNii211lm4eSD8uupKpUyooebfqRs5AqqdxOsHEwEu7+cbULSyf7G
         85ng==
X-Gm-Message-State: AJIora8EDYmwbZl6nWgr9mECbOJW+iKrUL4Qw4A2amFJbQLeet+QzLrL
        SYzoQaLQ2HX2eoLdaglxl4fZx2chcd9mTnR81do=
X-Google-Smtp-Source: AGRyM1vIrhGTQG2yb/QT5zZe0nMTk3bsPZhSUaAJ1IoqK2kq6Andb6WsDiN6PFT8R2IsKvE/ypItWJ79CZB492PED4k=
X-Received: by 2002:a17:906:eb54:b0:708:99d6:83e with SMTP id
 mc20-20020a170906eb5400b0070899d6083emr2131362ejb.745.1655340184282; Wed, 15
 Jun 2022 17:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613233449.2860753-1-yhs@fb.com>
In-Reply-To: <20220613233449.2860753-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Jun 2022 17:42:53 -0700
Message-ID: <CAEf4BzYDNFd3NyNcz6iU8rCC-BqYihvXFFAC4fzy4sxiWtsdhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_varlen verification
 failure with latest llvm
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 13, 2022 at 4:34 PM Yonghong Song <yhs@fb.com> wrote:
>
> With latest llvm15, test_varlen failed with the following verifier log:
>
>   17: (85) call bpf_probe_read_kernel_str#115   ; R0_w=scalar(smin=-4095,smax=256)
>   18: (bf) r1 = r0                      ; R0_w=scalar(id=1,smin=-4095,smax=256) R1_w=scalar(id=1,smin=-4095,smax=256)
>   19: (67) r1 <<= 32                    ; R1_w=scalar(smax=1099511627776,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=)
>   20: (bf) r2 = r1                      ; R1_w=scalar(id=2,smax=1099511627776,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32)
>   21: (c7) r2 s>>= 32                   ; R2=scalar(smin=-2147483648,smax=256)
>   ; if (len >= 0) {
>   22: (c5) if r2 s< 0x0 goto pc+7       ; R2=scalar(umax=256,var_off=(0x0; 0x1ff))
>   ; payload4_len1 = len;
>   23: (18) r2 = 0xffffc90000167418      ; R2_w=map_value(off=1048,ks=4,vs=1572,imm=0)
>   25: (63) *(u32 *)(r2 +0) = r0         ; R0=scalar(id=1,smin=-4095,smax=256) R2_w=map_value(off=1048,ks=4,vs=1572,imm=0)
>   26: (77) r1 >>= 32                    ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; payload += len;
>   27: (18) r6 = 0xffffc90000167424      ; R6_w=map_value(off=1060,ks=4,vs=1572,imm=0)
>   29: (0f) r6 += r1                     ; R1_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=map_value(off=1060,ks=4,vs=1572,umax=4294967295,var_off=(0)
>   ; len = bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
>   30: (bf) r1 = r6                      ; R1_w=map_value(off=1060,ks=4,vs=1572,umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=map_value(off=1060,ks=4,vs=1572,um)
>   31: (b7) r2 = 256                     ; R2_w=256
>   32: (18) r3 = 0xffffc90000164100      ; R3_w=map_value(off=256,ks=4,vs=1056,imm=0)
>   34: (85) call bpf_probe_read_kernel_str#115
>   R1 unbounded memory access, make sure to bounds check any such access
>   processed 27 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1
>   -- END PROG LOAD LOG --
>   libbpf: failed to load program 'handler32_signed'
>
> The failure is due to
>   20: (bf) r2 = r1                      ; R1_w=scalar(id=2,smax=1099511627776,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32)
>   21: (c7) r2 s>>= 32                   ; R2=scalar(smin=-2147483648,smax=256)
>   22: (c5) if r2 s< 0x0 goto pc+7       ; R2=scalar(umax=256,var_off=(0x0; 0x1ff))
>   26: (77) r1 >>= 32                    ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   29: (0f) r6 += r1                     ; R1_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=map_value(off=1060,ks=4,vs=1572,umax=4294967295,var_off=(0)
> where r1 has conservative value range compared to r2 and r1 is used later.
>
> In llvm, commit [1] triggered the above code generation and caused
> verification failure.
>
> It may take a while for llvm to address this issue. In the main time,
> let us change the variable 'len' type to 'long' and adjust condition properly.
> Tested with llvm14 and latest llvm15, both worked fine.
>
>  [1] https://reviews.llvm.org/D126647
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/progs/test_varlen.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_varlen.c b/tools/testing/selftests/bpf/progs/test_varlen.c
> index 913acdffd90f..3987ff174f1f 100644
> --- a/tools/testing/selftests/bpf/progs/test_varlen.c
> +++ b/tools/testing/selftests/bpf/progs/test_varlen.c
> @@ -41,20 +41,20 @@ int handler64_unsigned(void *regs)
>  {
>         int pid = bpf_get_current_pid_tgid() >> 32;
>         void *payload = payload1;
> -       u64 len;
> +       long len;
>
>         /* ignore irrelevant invocations */
>         if (test_pid != pid || !capture)
>                 return 0;
>
>         len = bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in1[0]);
> -       if (len <= MAX_LEN) {
> +       if (len >= 0) {
>                 payload += len;
>                 payload1_len1 = len;
>         }
>
>         len = bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
> -       if (len <= MAX_LEN) {
> +       if (len >= 0) {
>                 payload += len;
>                 payload1_len2 = len;
>         }
> @@ -123,7 +123,7 @@ int handler32_signed(void *regs)
>  {
>         int pid = bpf_get_current_pid_tgid() >> 32;
>         void *payload = payload4;
> -       int len;
> +       long len;


The whole point of handler32_signed and handler64_unsigned was to test
that this code patterns works for signed 32-bit and unsigned 64-bit
variables. By the time clang is fixed we might forget to undo these
changes in test_varlen.c. Maybe it's better to leave code as is? We
already blacklisted this test for CI anyways, so it doesn't affect
kernel-patches CI runs.

>
>         /* ignore irrelevant invocations */
>         if (test_pid != pid || !capture)
> --
> 2.30.2
>
