Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4210C4EE1B6
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiCaTam (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiCaTae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 15:30:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8A5EBD1
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:28:45 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r11so516565ila.1
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jzkrWd9gPYEWT5K2gf+surzylUESA6RVxSjNqVTDkhc=;
        b=lyBC0VtZ7f3xhQKHwibR63wm/9uvMIsNQlCETRxJ4X1hdhFQFD59VaudZfH3J4ntdx
         m4+WA8Q+5p8jdJqhSv2cSGVB5DsoSnB7w/EdbIwzOfcOgI+QUJlqcVQTNBc7CY/oYagT
         cvquaoePUcTQwuVq00zb/y6j2DhQt7sxHkGlx39yC18+yyBVHym7iIe9GdqV5VgspE1/
         gAwkOZNR84JpMN4oBw6OfzWcvMmS8Kcs2JRlZlmWpjOPXega4RWJpssfe5On2tDnZdKD
         RR6NCylkN9SaoWtl9K11UtC0VnACjccP5KGM6muFEukNgDlvlcd9b58RK0YXUR3AWwiO
         JUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jzkrWd9gPYEWT5K2gf+surzylUESA6RVxSjNqVTDkhc=;
        b=ork5uGiNFZFD78XDoLlAb71Mjh1ZufeBlJtU0AMydIu5DsfaeN5rlVp4TpTQ8VmSHc
         U3l9YSkVVBzHEV9hbsGyAZZGvCq68l4SEymzrEjAAjpCOpsxPkiNqWcjC+N201Lerjkg
         VnVAPBsIE5Rwl3xNsInWUfFb6mXpGYC5AgNhk7B5Pl2QJdPGRNXeMfm2FzEtpn4SchmN
         DPReXJseWW8Zs/R0TVvX/a9NPNo9dHo/0oYrF3g8CG6ZdB0pxXwi4fg8x8z4O8cjCdnR
         yQEazjjXCK2/yacFJnOHfuI9lrmiA7jvmRIN4QW0mYcSBxllEuIRYiN2zDFVFffoJU1w
         Zjug==
X-Gm-Message-State: AOAM532Qz8wr1JHp54mqt09a6ThuNjFRcTjLfv/7DngaCs+GIsfSVARl
        +gGs6bkpTQsrRmU6Bj6n0F6YPaV8wY+VN3CF2Lf7FyT0ykE=
X-Google-Smtp-Source: ABdhPJxwuUrs22BKB04hrNck5ZPr82UZqTI0BR019Xtcg7GdW966I4hliBC0LwcPAdi3Uu6yWljkNB5R9sbUUgU+Z7E=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr14427612ilb.305.1648754924697; Thu, 31
 Mar 2022 12:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-7-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203311654230.29864@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2203311654230.29864@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 12:28:34 -0700
Message-ID: <CAEf4BzZ31A9reFX6_1NQppJ_rY3PTuVGSnqTpNt53QAJMJaDCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: add basic USDT selftests
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 31, 2022 at 8:55 AM Alan Maguire <alan.maguire@oracle.com> wrot=
e:
>
> cOn Fri, 25 Mar 2022, Andrii Nakryiko wrote:
>
> > Add semaphore-based USDT to test_progs itself and write basic tests to
> > valicate both auto-attachment and manual attachment logic, as well as
> > BPF-side functionality.
> >
> > Also add subtests to validate that libbpf properly deduplicates USDT
> > specs and handles spec overflow situations correctly, as well as proper
> > "rollback" of partially-attached multi-spec USDT.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> One compilation issue and minor nit below
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/testing/selftests/bpf/Makefile          |   1 +
> >  tools/testing/selftests/bpf/prog_tests/usdt.c | 314 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/test_usdt.c | 115 +++++++
> >  3 files changed, 430 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 3820608faf57..18e22def3bdb 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -400,6 +400,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:        =
                       \
> >                    $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
> >                    $$(INCLUDE_DIR)/vmlinux.h                          \
> >                    $(wildcard $(BPFDIR)/bpf_*.h)                      \
> > +                  $(wildcard $(BPFDIR)/*.bpf.h)                      \
> >                    | $(TRUNNER_OUTPUT) $$(BPFOBJ)
> >       $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
> >                                         $(TRUNNER_BPF_CFLAGS))
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/test=
ing/selftests/bpf/prog_tests/usdt.c
> > new file mode 100644
> > index 000000000000..44a20d8c45d7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +#include <test_progs.h>
> > +
> > +#define _SDT_HAS_SEMAPHORES 1
> > +#include <sys/sdt.h>
> > +
>
> Do we need to bracket with feature test for sdt.h? I think I had
> something rough for this in
>
> https://lore.kernel.org/bpf/1642004329-23514-5-git-send-email-alan.maguir=
e@oracle.com/
>
> might prevent selftest compilation failures if sdt.h isn't present,
> and IIRC that feature test is used in perf code.

Well, I was thinking to just specify in README that one needs to have
sys/sdt.h installed from the systemtap-sdt-devel package.
Alternatively, copy/pasting sdt.h locally and using it is also an
option, that header is quite well contained and has permissive
license. The latter is less hassle for everyone, but someone might
have concerns about checking in external header. So in v2 I'll go with
documenting dependency on systemtap-sdt-devel package, unless people
prefer sdt.h being checked in

>
> I just realized I got confused on the cookie logic. There's really two
> levels of cookies:
>
> - at the API level, the USDT cookie is associated with the USDT
>   attachment, and can span multiple sites; but under the hood
> - the uprobe cookie is used to associate the uprobe point of attachment
>   with the associated spec id.  If BPF cookie retrieval isn't supported,
>   we fall back to using the instruction pointer -> spec id mapping.
>
> To get the usdt cookie in BPF prog context, we first look up the uprobe
> cookie to get the spec id, and then get the spec entry.

Yep, it's all cookies around :) Not sure how to make the distinction
cleaner, tbh.

>
> I guess libbpf CI on older kernels will cover testing for the case where
> bpf cookies aren't supported and we need to do that ip -> spec id
> mapping? Perhaps we could have a test that #defines
> BPF_USDT_HAS_BPF_COOKIE to 0 to cover testing this on newer kernels?

Yes, you are right about CI, I plan to enable this test on 4.9 and 5.5
kernels we have in CI.

Just setting BPF_USDT_HAS_BPF_COOKIE to 0 won't work because
user-space part is doing it's own detection of BPF cookie support, and
doing it some other way is way too complicated for something that is
necessary for selftest. But we'll get coverage for old kernels in CI,
so that's good news.

>
> > +#include "test_usdt.skel.h"
> > +#include "test_urandom_usdt.skel.h"
> > +
> > +int lets_test_this(int);
> > +
> > +static volatile int idx =3D 2;
> > +static volatile __u64 bla =3D 0xFEDCBA9876543210ULL;
> > +static volatile short nums[] =3D {-1, -2, -3, };
> > +

[...]

> > +/* we shouldn't be able to attach to test:usdt2_300 USDT as we don't h=
ave as
> > + * many slots for specs. It's important that each STAP_PROBE2() invoca=
tion
> > + * (after untolling) gets different arg spec due to compiler inlining =
i as
> > + * a constant
> > + */
> > +static void __always_inline f300(int x)
> > +{
> > +     STAP_PROBE1(test, usdt_300, x);
> > +}
> > +
> > +__weak void trigger_300_usdts(void)
> > +{
> > +     R100(f300, 0);
> > +     R100(f300, 100);
> > +     R100(f300, 200);
> > +}
> > +
> > +static void __always_inline f400(int /*unused*/ )
>
> ...caused a compilation error on gcc-9 for me:
>
>   TEST-OBJ [test_progs] usdt.test.o
> /home/alan/kbuild/bpf-next/tools/testing/selftests/bpf/prog_tests/usdt.c:
> In function =E2=80=98f400=E2=80=99:
> /home/alan/kbuild/bpf-next/tools/testing/selftests/bpf/prog_tests/usdt.c:=
191:34:
> error: parameter name omitted
>   191 | static void __always_inline f400(int /*unused*/ )
>       |                                  ^~~
> make: ***
> [/home/alan/kbuild/bpf-next/tools/testing/selftests/bpf/usdt.test.o] Erro=
r
> 1
>  ...but with
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c
> b/tools/testing/selftests/bpf/prog_tests/
> index b4c070b..5d382c8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -188,7 +188,7 @@ __weak void trigger_300_usdts(void)
>         R100(f300, 200);
>  }
>
> -static void __always_inline f400(int /*unused*/ )
> +static void __always_inline f400(int u /*unused*/ )
>  {
>         static int x;
>
>
>
> ...tests passed cleanly.

oh, cool, thanks for the report. I'll name the argument and add
__attribute__((unused)) to prevent other compilers to complain

>
> > +{
> > +     static int x;
> > +
> > +     STAP_PROBE1(test, usdt_400, x++);
> > +}
> > +

[...]

> > +SEC("usdt//proc/self/exe:test:usdt_100")
> > +int BPF_USDT(usdt_100, int x)
> > +{
> > +     long tmp;
> > +
> > +     if (my_pid !=3D (bpf_get_current_pid_tgid() >> 32))
> > +             return 0;
> > +
> > +     __sync_fetch_and_add(&usdt_100_called, 1);
> > +     __sync_fetch_and_add(&usdt_100_sum, x);
> > +
> > +     bpf_printk("X is %d, sum is %d", x, usdt_100_sum);
> > +
>
> debugging, needed?

oops, yep, leftovers, will clean up.

>
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.30.2
> >
> >
