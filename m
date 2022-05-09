Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5898B5207E6
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 00:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiEIWlc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEIWla (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 18:41:30 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB81F7E35
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 15:37:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r27so16879843iot.1
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27ex8LQ3dCBNS79SFP/kBVrO7B4h9ZYboVeHDe7c75s=;
        b=qOKfL6juWHxY7P5F5DUs1CksDzMBEXfCGeF5CfW0djipxhbfplTU3YXKXHWwFjPKW+
         YxAQc5TSyI44Yl0QKC5VsOWEP9cW56KK17U3ESqMk7J+j6GX6r4QPrzSXnHNmuS9JOnd
         arrto0rAN5IgFN7L6ZQwQ++Z4RYMlQUzoDjyNcpKawfZFhoxmJkLq6Y94mHrd7K9Q8UB
         RISPQ9dDEIm6GasD5Qo5zFSuwZ9uzxpwR6X2fO5pbfF4Nb5vyk8Q94htkW1iWvtebRm+
         vRNuMByxWPWgcWRRxnrqDid/sZbByPx33OK91SQn6RF0KXkACSgOUvA1iRfQ6aA+w8hj
         X73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27ex8LQ3dCBNS79SFP/kBVrO7B4h9ZYboVeHDe7c75s=;
        b=a8GnnzMxir51FoPXnRV+bEpw6Gf8ttTGKQDZgbjmUxTIYTrijJpubBRdWqFHjbBtvW
         bOpFyyFW9jPO3wD9dZO4Ll4rMVlLuBH3ayMqgJsi9FKqVZ39Po6pcOzw4xLEom3Y2jCo
         VvhGwLzhnHPwt1jNwinRQEuCsdPPbgwfmDzfnlKiG3kPnyxZ+bexVakMUejjUuyhykFa
         QEG9Ll8HR4CbsS35nUtdZ6lvwZ3EiY6CYhGFllTCEuq4dc6k0/94evIt1wgH7uhuSSxV
         TwzXBj9tnt4B8C2NZl2QJXVkbd6WedRToSPZhKH+PjbouuIV2/fueQT98jy0W7a9/fT3
         ZZ9g==
X-Gm-Message-State: AOAM532/f6WvUbkPNY2+pMlYCd3/84GQAFQas1nsJByMiLGAcROAIqRA
        2hShcQHV8ah3i/mYpIWzSwwNb1iTHA9OEYPJRMk=
X-Google-Smtp-Source: ABdhPJxohu53kjy/ownHag3DlkP4Zm9zD8HwlrHXnJfgDCfzzxaXGtGXVjWWZwk8Kb3eSeAiNBVLs1KAtJlefJ8PP3E=
X-Received: by 2002:a05:6602:1683:b0:64f:ba36:d3cf with SMTP id
 s3-20020a056602168300b0064fba36d3cfmr7286627iow.144.1652135855223; Mon, 09
 May 2022 15:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190017.2577688-1-yhs@fb.com>
In-Reply-To: <20220501190017.2577688-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 15:37:24 -0700
Message-ID: <CAEf4BzYYC_QDAM0BpErtmioLUu89t7qUUTVBi2YkBmQ0Lc_vkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/12] libbpf: Fix an error in 64bit relocation
 value computation
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

On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, the 64bit relocation value in the instruction
> is computed as follows:
>   __u64 imm = insn[0].imm + ((__u64)insn[1].imm << 32)
>
> Suppose insn[0].imm = -1 (0xffffffff) and insn[1].imm = 1.
> With the above computation, insn[0].imm will first sign-extend
> to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
> producing incorrect value 0xFFFFFFFF. The correct value
> should be 0x1FFFFFFFF.
>
> Changing insn[0].imm to __u32 first will prevent 64bit sign
> extension and fix the issue.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/relo_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 2ed94daabbe5..f25ffd03c3b1 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1024,7 +1024,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>                         return -EINVAL;
>                 }
>
> -               imm = insn[0].imm + ((__u64)insn[1].imm << 32);
> +               imm = (__u32)insn[0].imm + ((__u64)insn[1].imm << 32);

great catch, it should also probably be written as | instead of + operation?

>                 if (res->validate && imm != orig_val) {
>                         pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
>                                 prog_name, relo_idx,
> --
> 2.30.2
>
