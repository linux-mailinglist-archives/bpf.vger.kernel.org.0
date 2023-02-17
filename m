Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1E69A330
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 01:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBQAzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 19:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBQAzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 19:55:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4F658F
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 16:55:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id n20so9785688edy.0
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzoZgRnKchj+jGPOZqz411qiXWXQ0hOZqxeGhxmQMLU=;
        b=h2RSzojhViGDd2QAWIQSJCqt4PJnr2JxIdfp1Wb4ka868dQVmgaDVtBcZR6oqbMMd+
         lrLwsuhWd9NQAWc94UTr8mgQhUFSpN/EmVx0UiXC/N+PWAs22g2HdgQSgLnd3NOe1O/E
         LuMDJeCIksFjBMz+faEIbwg5gh3ipFDsMOAOYV9P4bqF9YTAWjX9aNiydb1Xl9HvQpGA
         pmMVXx8U16haDAaZCF34DRGXLmUpto6gmKcq1IrMDMIM4Pg4TGi7+Zre0vnfCn2ePrui
         sJMBU374MJ/tmAcBVzddkEDiw4Za9GTo01yqIE09rrh6v+obUGHu5wLGYC11lX/Dq7tK
         G2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzoZgRnKchj+jGPOZqz411qiXWXQ0hOZqxeGhxmQMLU=;
        b=XJUxltk0tBznPTcB0SzULy2+ZZnXG6Wjh9dVXELogYR8R+XJ0TpsDf4eA+p3JVsagC
         QI/kJP+MT2ulN7La9qsY2QwtRA8ZYjJRdN4NXbWlTEpBXgOTKdnrJpNubbY/l0KJ/U58
         Uu2O7/nEuhTeOpoBlo6AeSsT/l0wJsyl4nlwQ/6hRsoDX1xrinEmfYn1cG/QVo8e+Ky4
         ZWWGl2Ezw6xlGNP9t0IwFK0TiKps8TT+5SS6W/y0HEBvU3fYc0OzH0vycB077j0/9w5Q
         njd1vByJPHU5iQIk38nwFBGChrT+FmQlHBLzxOF+JAoBdikUoVLTgpqQSKHjZpVllRJA
         9aZA==
X-Gm-Message-State: AO0yUKVe+GOQyzeWbI9Quidqfr5UMRwTPiL/VS5/O21NgaY/gUZ4pGvT
        VDokJHiomNnB4QJiJOrJS9s7tvhP5gcv2/ywXGc=
X-Google-Smtp-Source: AK7set9TjHzm32C4LhaH/wZ2d+zSNFxsfvoXsY7qepvOoqQ7E+fj334ge3fw/POlCzMGY+4Dxmo/5LWSeCECV7q8ZEQ=
X-Received: by 2002:a50:a695:0:b0:4ac:b626:378e with SMTP id
 e21-20020a50a695000000b004acb626378emr4043728edc.5.1676595341026; Thu, 16 Feb
 2023 16:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20230216183606.2483834-1-eddyz87@gmail.com> <20230216183606.2483834-3-eddyz87@gmail.com>
In-Reply-To: <20230216183606.2483834-3-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 16:55:29 -0800
Message-ID: <CAEf4BzYPAE8EhgeGZWuUG5kjvxd8n5c1Qy_PCJveVYQ8=Fuipg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Tests for uninitialized stack reads
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
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

On Thu, Feb 16, 2023 at 10:36 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Two testcases to make sure that stack reads from uninitialized
> locations are accepted by verifier when executed in privileged mode:
> - read from a fixed offset;
> - read from a variable offset.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/uninit_stack.c   |  9 +++
>  .../selftests/bpf/progs/uninit_stack.c        | 55 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uninit_stack.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uninit_stack.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uninit_stack.c b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
> new file mode 100644
> index 000000000000..e64c71948491
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "uninit_stack.skel.h"
> +
> +void test_uninit_stack(void)
> +{
> +       RUN_TESTS(uninit_stack);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/uninit_stack.c b/tools/testing/selftests/bpf/progs/uninit_stack.c
> new file mode 100644
> index 000000000000..20ff6a22c906
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/* Read an uninitialized value from stack at a fixed offset */
> +SEC("socket")
> +__naked int read_uninit_stack_fixed_off(void *ctx)
> +{
> +       asm volatile ("                         \
> +               // force stack depth to be 128  \
> +               *(u64*)(r10 - 128) = r1;        \
> +               r1 = *(u8 *)(r10 - 8 );         \
> +               r1 = *(u8 *)(r10 - 11);         \
> +               r1 = *(u8 *)(r10 - 13);         \
> +               r1 = *(u8 *)(r10 - 15);         \
> +               r1 = *(u16*)(r10 - 16);         \
> +               r1 = *(u32*)(r10 - 32);         \
> +               r1 = *(u64*)(r10 - 64);         \
> +               // read from a spill of a wrong size, it is a separate  \
> +               // branch in check_stack_read_fixed_off()               \
> +               *(u32*)(r10 - 72) = r1;         \
> +               r1 = *(u64*)(r10 - 72);         \
> +               r0 = 0;                         \
> +               exit;                           \

would it be better to

r0 = *(u64*)(r10 - 72);
exit;

to make sure that in the future verifier doesn't smartly optimize out
unused reads?


Either way, looks good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +"
> +                     ::: __clobber_all);
> +}
> +
> +/* Read an uninitialized value from stack at a variable offset */
> +SEC("socket")
> +__naked int read_uninit_stack_var_off(void *ctx)
> +{
> +       asm volatile ("                         \
> +               call %[bpf_get_prandom_u32];    \
> +               // force stack depth to be 64   \
> +               *(u64*)(r10 - 64) = r0;         \
> +               r0 = -r0;                       \
> +               // give r0 a range [-31, -1]    \
> +               if r0 s<= -32 goto exit_%=;     \
> +               if r0 s>= 0 goto exit_%=;       \
> +               // access stack using r0        \
> +               r1 = r10;                       \
> +               r1 += r0;                       \
> +               r2 = *(u8*)(r1 + 0);            \
> +exit_%=:       r0 = 0;                         \
> +               exit;                           \
> +"
> +                     :
> +                     : __imm(bpf_get_prandom_u32)
> +                     : __clobber_all);
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.39.1
>
