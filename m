Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3A652834
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLTVGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTVGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:06:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723DD63C5
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:05:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fc4so32126409ejc.12
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PXR2O1ZJT76k2dVpPCg91zGXLudwaoD1FJ2AIg7scYs=;
        b=i2A0gjHDI2OUtcF7a0r27sBc7oJ1rrdxw/361xOIHo5NIieZobc6Gjmr8TP3efVHM1
         t9FnFqHmotHVQVa5R6gVAlAIYm38VQMJ57X+LT8cP9Ezvh7iOiXQBHBZFLbgJgUWy+aX
         NDCDt1lpDdCH+Fke6XGBEHMeE7uVDv1FHBFZ61OEZW0Isjv+QlFD1nfqqFDxUEil1H7g
         r8E3r2tfvpYWenQHTzvBoEv8IUz4c5gJ6ByiXkS7rOgdTP/JGbSNlpFB0Wu4YRcaFdel
         jF1mvJqIb6EnSRsbc8zewGGogyGrG3yP9jmSLIAzC33WP6Rl0OWL3insV8bv3KKJnwH2
         BjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXR2O1ZJT76k2dVpPCg91zGXLudwaoD1FJ2AIg7scYs=;
        b=GhTlX88ZVecjjq3sUrIp6kKCTTRQ+Yk0ngUaLnoNoBPqbrG716LCQUuDo9oim+AG5k
         p0/ipANbGaMnrGPxbDG+6J488AwQR3zinSquLc1ZcT1hNc7ULka66u3ZJrP2MjKszPCG
         XRsRhP1zDqXmHdiYmj0kXw0ZyiUa+5SicJdbsnoXg2cYDOZwhpTVtPlNiQLYabvJB5yj
         JNtX5O3FiZABPRhjQNdyAmrKJRrZlX1SkXM5ea5z5WqU//j2Ev0nsOkbjzHfw3CIrHB0
         TR8C370d45nTSn+IHUI0BkaunSxWowxa9yuALI02wnnNwLfMp+kP1z9CTkmL/zLc0+FB
         Ywcg==
X-Gm-Message-State: ANoB5pkulMXKhYzg6Ecb6ANS17KBy/5Fg8ZdSqkzvLlV0QW73l9Vmnug
        c3Kc+vmy/y3fyZEHq4XqcedgkeGACjsRtOh+Oqs=
X-Google-Smtp-Source: AA0mqf7coIntTxRl/CesUK8E9dr582JM697ktP5aVhQLWI6vS01tBRIyMkHc773Mr1hq6mpe7RKMuvBHeQQs+WV1r6Y=
X-Received: by 2002:a17:906:7116:b0:7c1:8450:f964 with SMTP id
 x22-20020a170906711600b007c18450f964mr3230106ejj.176.1671570356904; Tue, 20
 Dec 2022 13:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20221217021711.172247-1-eddyz87@gmail.com> <20221217021711.172247-3-eddyz87@gmail.com>
In-Reply-To: <20221217021711.172247-3-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 13:05:44 -0800
Message-ID: <CAEf4BzbbyYJHCF_YVPJdYQF7Mh-RwPkdpNCJPHvxb3MXKH2S=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: convenience macro for use
 with 'asm volatile' blocks
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A set of macros useful for writing naked BPF functions using inline
> assembly. E.g. as follows:
>
> struct map_struct {
>         ...
> } map SEC(".maps");
>
> SEC(...)
> __naked int foo_test(void)
> {
>         asm volatile(
>                 "r0 = 0;"
>                 "*(u64*)(r10 - 8) = r0;"
>                 "r1 = %[map] ll;"
>                 "r2 = r10;"
>                 "r2 += -8;"
>                 "call %[bpf_map_lookup_elem];"
>                 "r0 = 0;"
>                 "exit;"
>                 :
>                 : __imm(bpf_map_lookup_elem),
>                   __imm_addr(map)
>                 : __clobber_all);
> }
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index a42363a3fef1..bbf56ad95636 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -8,6 +8,12 @@
>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
>  #define __test_state_freq      __attribute__((btf_decl_tag("comment:test_state_freq")))
>
> +/* Convenience macro for use with 'asm volatile' blocks */
> +#define __naked __attribute__((naked))
> +#define __clobber_all "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "memory"

I found that this one doesn't work well when passing some inputs as
registers (e.g., for address of a variable on stack). Compiler
complains that it couldn't find any free registers to use. So I ended
up using

#define __asm_common_clobbers "r0", "r1", "r2", "r3", "r4", "r5", "memory"

and adding "r6", "r7", etc manually, depending on the test.

So maybe let's add it upfront as `__clobber_common` as well?

But changes look good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +#define __imm(name) [name]"i"(name)
> +#define __imm_addr(name) [name]"i"(&name)
> +
>  #if defined(__TARGET_ARCH_x86)
>  #define SYSCALL_WRAPPER 1
>  #define SYS_PREFIX "__x64_"
> --
> 2.38.2
>
