Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65F69B52B
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 23:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBQWBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 17:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBQWA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 17:00:59 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30515CF16
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 14:00:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg30so9230160edb.7
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 14:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGtqIoGogWZne6JKcVs1GquDELfCR0Laul2YOAtpU4M=;
        b=cae4UH3h5ev9B55a4TvkDecpFTUBSFs8H6OZrQa7pKN9miPfCvX+ScN+8TOj16yvUJ
         BnF3C85sS7aG0VClbIgrRzhz3gmh5xQxAqJNPjtmsOEsKhiZAW+g/WYPDGfTcckRKSiG
         u7rdMxkdYcNBezlj+sM/rpev2zUKHwOh0yNVwOceDLU1UH2Ji9iJhdZNRUE676Umrf86
         oc2NJiahXet3tV6Smz4fx1hDzgQLuvjciaGAMaZmUCAmRBj2QMY023wiFzhzUm52rqNs
         4HRmI5UsHX1JpsJ7N29Tr5FLUdGEIV4V2FRFN0jLGDD90+1izIravXOIBvFqevRdeqZS
         IKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGtqIoGogWZne6JKcVs1GquDELfCR0Laul2YOAtpU4M=;
        b=0h9q4gYH3vant/xPfekZ4MhMg8l4d6Tk0rE+wgKwA+tlQettRQQd9yEV9HcZ6g46XE
         itx30O+r/9rrtGVC+fYCu1Hg7StofapZcpSN27bx2ow3cZTkeyabP3oAawyTIvUKiBkO
         1veRwdMRv2OHJMQLoW/T/zchsI7CLViU6kLPw/UeMlFJ9sR5ubkV/UTiFOxBA9nrBdgB
         GS2Z0rjL/i/tNbf9eVga4VzGErWBZe15ror0uOF34joXdUbF8ylTmLGiOgX4tXO0SC//
         JzMFFPOuFN2pm1TfITJa3MNmVLyim139t5aKnEa8eg+PohXTXKIGwaeqKyLWRU+ZIYaT
         Jg8w==
X-Gm-Message-State: AO0yUKWbYoHcZ6W1egawQQXDelhtTyEfXLFx8o5iaXMb+kG0QIxpI7x7
        KEZvVl1BFGWBwq4xYk7x6GMTYKAqLJXNBdVXFVo=
X-Google-Smtp-Source: AK7set9fwFFhvYp5xyEJb7w5Rx43Sacx74rT2hzFe4xcKtNqjY2R8FeHSJEszY6hCMNku0uODD2lxOQCJDDN4/Pa+O0=
X-Received: by 2002:a17:906:f88f:b0:8b0:7e1d:f6fa with SMTP id
 lg15-20020a170906f88f00b008b07e1df6famr999563ejb.15.1676671251282; Fri, 17
 Feb 2023 14:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20230216183606.2483834-1-eddyz87@gmail.com> <20230216183606.2483834-3-eddyz87@gmail.com>
 <CAEf4BzYPAE8EhgeGZWuUG5kjvxd8n5c1Qy_PCJveVYQ8=Fuipg@mail.gmail.com> <4a1aaff3c2f29485d0a47279bd8b6cc7f0f6c78f.camel@gmail.com>
In-Reply-To: <4a1aaff3c2f29485d0a47279bd8b6cc7f0f6c78f.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 14:00:38 -0800
Message-ID: <CAEf4BzbE7=NALGK4oJjx8U6rkVdJh91ykhw34UsQy9Rhy-FE7Q@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 5:25 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2023-02-16 at 16:55 -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 16, 2023 at 10:36 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > Two testcases to make sure that stack reads from uninitialized
> > > locations are accepted by verifier when executed in privileged mode:
> > > - read from a fixed offset;
> > > - read from a variable offset.
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/uninit_stack.c   |  9 +++
> > >  .../selftests/bpf/progs/uninit_stack.c        | 55 +++++++++++++++++++
> > >  2 files changed, 64 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uninit_stack.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uninit_stack.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/uninit_stack.c b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
> > > new file mode 100644
> > > index 000000000000..e64c71948491
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
> > > @@ -0,0 +1,9 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <test_progs.h>
> > > +#include "uninit_stack.skel.h"
> > > +
> > > +void test_uninit_stack(void)
> > > +{
> > > +       RUN_TESTS(uninit_stack);
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/uninit_stack.c b/tools/testing/selftests/bpf/progs/uninit_stack.c
> > > new file mode 100644
> > > index 000000000000..20ff6a22c906
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
> > > @@ -0,0 +1,55 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include "bpf_misc.h"
> > > +
> > > +/* Read an uninitialized value from stack at a fixed offset */
> > > +SEC("socket")
> > > +__naked int read_uninit_stack_fixed_off(void *ctx)
> > > +{
> > > +       asm volatile ("                         \
> > > +               // force stack depth to be 128  \
> > > +               *(u64*)(r10 - 128) = r1;        \
> > > +               r1 = *(u8 *)(r10 - 8 );         \
> > > +               r1 = *(u8 *)(r10 - 11);         \
> > > +               r1 = *(u8 *)(r10 - 13);         \
> > > +               r1 = *(u8 *)(r10 - 15);         \
> > > +               r1 = *(u16*)(r10 - 16);         \
> > > +               r1 = *(u32*)(r10 - 32);         \
> > > +               r1 = *(u64*)(r10 - 64);         \
> > > +               // read from a spill of a wrong size, it is a separate  \
> > > +               // branch in check_stack_read_fixed_off()               \
> > > +               *(u32*)(r10 - 72) = r1;         \
> > > +               r1 = *(u64*)(r10 - 72);         \
> > > +               r0 = 0;                         \
> > > +               exit;                           \
> >
> > would it be better to
> >
> > r0 = *(u64*)(r10 - 72);
> > exit;
> >
> > to make sure that in the future verifier doesn't smartly optimize out
> > unused reads?
>
> Are there plans for such optimizations? If there are, many tests might
> be in trouble. I thought that this is delegated to the C compiler.

I'm not aware of them, just hypothetical concern

>
> For this particular case the rewrite might look as:
>
>         asm volatile ("                                 \
>                 r0 = 0;                                 \
>                 /* force stack depth to be 128 */       \
>                 *(u64*)(r10 - 128) = r1;                \
>                 r1 = *(u8 *)(r10 - 8 );                 \
>                 r0 += r1;                               \
>                 r1 = *(u8 *)(r10 - 11);                 \
>                 r0 += r1;                               \
>                 r1 = *(u8 *)(r10 - 13);                 \
>                 r0 += r1;                               \
>                 r1 = *(u8 *)(r10 - 15);                 \
>                 r0 += r1;                               \
>                 r1 = *(u16*)(r10 - 16);                 \
>                 r0 += r1;                               \
>                 r1 = *(u32*)(r10 - 32);                 \
>                 r0 += r1;                               \
>                 r1 = *(u64*)(r10 - 64);                 \
>                 r0 += r1;                               \
>                 /* read from a spill of a wrong size, it is a separate  \
>                  * branch in check_stack_read_fixed_off()               \
>                  */                                     \
>                 *(u32*)(r10 - 72) = r1;                 \
>                 r1 = *(u64*)(r10 - 72);                 \
>                 r0 += r1;                               \
>                 exit;                                   \
> "
>                       ::: __clobber_all);
>
> It works but is kinda ugly.

nah, no need

>
>  ---
>
> Orthogonal to the above issue, I found that use of the '//' comments
> in the asm code w/o newlines is invalid, as it makes rest of the
> string a comment. I changed '\n\' line endings to '\' just before
> sending the patch and did not verify the change.
> => The patch-set would have to be resent.

I was wondering about that, but assumed you tested it ;) so yeah,
please fix and resend. (in that sense having each line separately
quoted allows much easier commenting, but we've decided on this style,
so let's stick to it

>
> >
> >
> > Either way, looks good to me:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > +"
> > > +                     ::: __clobber_all);
> > > +}
> > > +
> > > +/* Read an uninitialized value from stack at a variable offset */
> > > +SEC("socket")
> > > +__naked int read_uninit_stack_var_off(void *ctx)
> > > +{
> > > +       asm volatile ("                         \
> > > +               call %[bpf_get_prandom_u32];    \
> > > +               // force stack depth to be 64   \
> > > +               *(u64*)(r10 - 64) = r0;         \
> > > +               r0 = -r0;                       \
> > > +               // give r0 a range [-31, -1]    \
> > > +               if r0 s<= -32 goto exit_%=;     \
> > > +               if r0 s>= 0 goto exit_%=;       \
> > > +               // access stack using r0        \
> > > +               r1 = r10;                       \
> > > +               r1 += r0;                       \
> > > +               r2 = *(u8*)(r1 + 0);            \
> > > +exit_%=:       r0 = 0;                         \
> > > +               exit;                           \
> > > +"
> > > +                     :
> > > +                     : __imm(bpf_get_prandom_u32)
> > > +                     : __clobber_all);
> > > +}
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > --
> > > 2.39.1
> > >
>
