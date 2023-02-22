Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8D69FE5C
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBVWSb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjBVWSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:18:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFDE43463
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:17:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so36122359edb.1
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAfUMCxe4rNQauuInH4IBisrMgh8aNSjcoGMMPP+KLw=;
        b=GIwKQwfvB7Ti8N3njDYWhCeJTzzkexoh/rPjX4CGZ5DtyEu0+zG1IKujJwpEk9ALwx
         wN8yVdVbGzu8+MJ00T9ca6sb8Lq6ZMTI+m8CDCXGvxHP7k3D0Mf+5YnIlOfwlvBp5NDH
         bOt0wafbaZLTNQuiEJStUP+93tZF2ut3tVVH/csTGnZRcZ6fPWqT3DSDciOO8AXvCr6a
         RdE8n6Ou6opnr9Xj0R93BqPXhnjx646GzR+xD8UTurp9xNYJ4al0qtIGjQAShl6ZSZBq
         Ifbit0KY4elDRZp5dLVB0mCwSVx/RJeVmYiJI0o7UrtkqGnx9nh0s2y5SDEgT/4LTFA5
         EQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAfUMCxe4rNQauuInH4IBisrMgh8aNSjcoGMMPP+KLw=;
        b=tZOPIyyz7nzfB64Cerd2VS6ebhiMGlgrcK8BDyXxM3xJ8PXkjp66spjtzL/YvCF7/a
         cefVfyc5qRqusa5yMQctlKW2b8wcPAIN1apsBhqBQ9CPahWjIyeZ7Fqb39i64bB3vMzi
         EpxmYGZS0bP46J1pKQIOKqePPfzXvTQ6BsYjXlg/69d9eCq7w6KPe88GFKduifK+O9cU
         bMfVeoEBNlMyLBDEu5FLWurFWyVLZnmvscCMDbMmfLtBtpk1YTa0F0w+r0LhVXFWfP5o
         o8EensA1Sx83cq0qnekHXOLkMpDj96PdHUYTOr1/rEnK4SlbGw0NP5DbAJGz+k3hhG07
         HJpQ==
X-Gm-Message-State: AO0yUKWvI6SynctyanutAFg4izB8VsjorJAqRWC2F2Te/yOvyCHBp4B7
        isR6pBfWRYaCUK3gDlH3mKnQ+1NXMV0Xn12VncI=
X-Google-Smtp-Source: AK7set9a9Ysz/526HakGVluml9As/Xyf+THyfOxQVIlfPk4EamUHXFlLcHp7JY4DXQmgT4bjRLdL9Btx0TqjI0QwA1M=
X-Received: by 2002:a17:906:dfe8:b0:895:58be:963 with SMTP id
 lc8-20020a170906dfe800b0089558be0963mr8598715ejc.3.1677104218037; Wed, 22 Feb
 2023 14:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20230220225228.2129-1-dthaler1968@googlemail.com>
In-Reply-To: <20230220225228.2129-1-dthaler1968@googlemail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 14:16:46 -0800
Message-ID: <CAADnVQJHvFCTq-fWiore4iL9MV7CicDt=Tn697ZU3QMu-wWxeA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Explain helper functions
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf <bpf@vger.kernel.org>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 2:52 PM Dave Thaler
<dthaler1968=40googlemail.com@dmarc.ietf.org> wrote:
>
> From: Dave Thaler <dthaler@microsoft.com>
>
> Add text explaining helper functions.
> Note that text about runtime functions (kfuncs) is part of a separate patch,
> not this one.
>
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
> V1 -> V2: addressed comments from Alexei and Stanislav
>
> V2 -> V3: addressed comments from David Vernet
> ---
>  Documentation/bpf/clang-notes.rst     |  6 ++++++
>  Documentation/bpf/instruction-set.rst | 19 ++++++++++++++++++-
>  Documentation/bpf/linux-notes.rst     |  8 ++++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
> index 528feddf2db..2c872a1ee08 100644
> --- a/Documentation/bpf/clang-notes.rst
> +++ b/Documentation/bpf/clang-notes.rst
> @@ -20,6 +20,12 @@ Arithmetic instructions
>  For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
>  ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
>
> +Jump instructions
> +=================
> +
> +If ``-O0`` is used, Clang will generate the ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
> +instruction, which is not supported by the Linux kernel verifier.

This is fine here.

> +
>  Atomic operations
>  =================
>
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index af515de5fc3..148dd2a2e39 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -239,7 +239,7 @@ BPF_JSET  0x40   PC += off if dst & src
>  BPF_JNE   0x50   PC += off if dst != src
>  BPF_JSGT  0x60   PC += off if dst > src     signed
>  BPF_JSGE  0x70   PC += off if dst >= src    signed
> -BPF_CALL  0x80   function call
> +BPF_CALL  0x80   function call              see `Helper functions`_
>  BPF_EXIT  0x90   function / program return  BPF_JMP only
>  BPF_JLT   0xa0   PC += off if dst < src     unsigned
>  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> @@ -250,6 +250,23 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
>
> +Helper functions
> +~~~~~~~~~~~~~~~~
> +
> +Helper functions are a concept whereby BPF programs can call into a
> +set of function calls exposed by the runtime.  Each helper
> +function is identified by an integer used in a ``BPF_CALL`` instruction.
> +The available helper functions may differ for each program type.
> +
> +Conceptually, each helper function is implemented with a commonly shared function
> +signature defined as:
> +
> +  u64 function(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> +
> +In actuality, each helper function is defined as taking between 0 and 5 arguments,
> +with the remaining registers being ignored.  The definition of a helper function
> +is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
> +the number of arguments, and the type of each argument.

Above is correct, but it aims to describe the calling convention
which should be done in a separate BPF psABI doc and not in
instruction-set.rst.
And if we start describing calling convention we should talk
about promotion rules, sign extensions, expectations for return values,
for passing structs by value, etc.

>  Load and store instructions
>  ===========================
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index 956b0c86699..f43b9c797bc 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -12,6 +12,14 @@ Byte swap instructions
>
>  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
>
> +Jump instructions
> +=================
> +
> +``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> +integer would be read from a specified register, is not currently supported
> +by the verifier.  Any programs with this instruction will fail to load
> +until such support is added.

This is fine here as well.
