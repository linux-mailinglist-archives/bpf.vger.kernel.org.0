Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D413568FBE9
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 01:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBIAU2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 19:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBIAU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 19:20:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE620D39
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 16:20:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m8so640126edd.10
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 16:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9QxIZOdM5v4f5MQJbtjugxxZb2quKjgGH/S1rMvPhs=;
        b=YS/Csto797754c60tpNBifjucoqoSgYUt8vIPgIZ2pE0uT2fLBIzGZexV0ta59q0gQ
         nRuRiCje+BUhbz49vmCM1aXCyyYgCHjyA7tr7zsW5/4mop2qr8iy2laR4jqNyS4evQzH
         y5SJ6AH73yU4UeBbLC+2UzIJZ65d1oyWRk8azNN04ISyxH9DfAXKeaedg/awd/HEnZkp
         wTv6MwMk+HECnhvMoRu2kJKoKPUmTCjMH6Y/CLsotMHzb4Vja4wwGoMNXbfuod4ZXMlx
         GxH/ysCpwvoMcUauh5A4HQNijPNagwQVzNJA1jrgaAxkdzualWZT0IaP9Dlul/A7uRfQ
         lNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9QxIZOdM5v4f5MQJbtjugxxZb2quKjgGH/S1rMvPhs=;
        b=aWiW0jL0u+m/PTDlH8C/xKDMbz6M8B7r7/Z5aguq0hTaMZX5AePsD0TOCC8UuULyXF
         QDiXiENRAcux6+ABGt3VcSF9dHjxRJrqwSuIAnCIpECBT8ndgd1RQmjJvrNxuklj2nrk
         mLbtfNbzimDoFve1E5hzKa5sQ0kNzCg3Uw7q6yVXXmh0xUwzjBo+lvit/SCg6TIt77wm
         et1T4gk5jZE0EEeKG6+mqKxp2QeOQMLyOQm9/nlFtxcbwq9HeNBakTK+F5kNwIHJEYOU
         ICAGPUYL0xKKZJRCkwdPd3/0+U7zEouItmXVVeEpXelxoCns967MW712kpZIX/1KQCYu
         fn2Q==
X-Gm-Message-State: AO0yUKXgeOTmlGd/n/lha/RZFtdiF17FopuDfLeoS7KkbK6aaPI1vLFf
        xn0kERfhk3v0vQu55/wxVVF6yaXoX1zYU+zHn54=
X-Google-Smtp-Source: AK7set+soAVQR+sd55FJon6mYyj4acpgCIPZeNdwDpCkxJRtpxUYjqkkt/PY4i6ebKCG2MU0ltOR0shh/ROhLzYewz8=
X-Received: by 2002:a50:875d:0:b0:49e:1638:1071 with SMTP id
 29-20020a50875d000000b0049e16381071mr2115506edv.5.1675902025218; Wed, 08 Feb
 2023 16:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20230203162336.608323-1-jolsa@kernel.org> <20230203162336.608323-2-jolsa@kernel.org>
 <Y+JgEIwzW7+UkCj9@maniforge.lan>
In-Reply-To: <Y+JgEIwzW7+UkCj9@maniforge.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 16:20:13 -0800
Message-ID: <CAEf4BzbQdpgkBjqK2eO53ZkLb5Zy0n3oVj9en10kO8JH2ANYHA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/9] selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
To:     David Vernet <void@manifault.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
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

On Tue, Feb 7, 2023 at 6:28 AM David Vernet <void@manifault.com> wrote:
>
> On Fri, Feb 03, 2023 at 05:23:28PM +0100, Jiri Olsa wrote:
> > Move all kfunc exports into separate bpf_testmod_kfunc.h header file
> > and include it in tests that need it.
> >
> > We will move all test kfuncs into bpf_testmod in following change,
> > so it's convenient to have declarations in single place.
> >
> > The bpf_testmod_kfunc.h is included by both bpf_testmod and bpf
> > programs that use test kfuncs.
> >
> > As suggested by David, the bpf_testmod_kfunc.h includes vmlinux.h
> > and bpf/bpf_helpers.h for bpf programs build, so the declarations
> > have proper __ksym attribute and we can resolve all the structs.
> >
> > Note in kfunc_call_test_subprog.c we can no longer use the sk_state
> > define from bpf_tcp_helpers.h (because it clashed with vmlinux.h)
> > and we need to address __sk_common.skc_state field directly.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 41 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/cb_refs.c   |  4 +-
> >  .../selftests/bpf/progs/jit_probe_mem.c       |  4 +-
> >  .../bpf/progs/kfunc_call_destructive.c        |  3 +-
> >  .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +---
> >  .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
> >  .../selftests/bpf/progs/kfunc_call_test.c     | 17 +-------
> >  .../bpf/progs/kfunc_call_test_subprog.c       |  9 +---
> >  tools/testing/selftests/bpf/progs/map_kptr.c  |  6 +--
> >  .../selftests/bpf/progs/map_kptr_fail.c       |  5 +--
> >  10 files changed, 51 insertions(+), 50 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > new file mode 100644
> > index 000000000000..86d94257716a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _BPF_TESTMOD_KFUNC_H
> > +#define _BPF_TESTMOD_KFUNC_H
> > +
> > +#ifndef __KERNEL__
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#else
> > +#define __ksym
> > +#endif
> > +
> > +extern struct prog_test_ref_kfunc *
> > +bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
> > +extern struct prog_test_ref_kfunc *
> > +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> > +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> > +extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> > +extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> > +extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> > +extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
> > +extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
> > +
> > +extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
> > +
> > +extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> > +                             __u32 c, __u64 d) __ksym;
> > +extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
> > +extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
> > +extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> > +extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> > +extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> > +extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_destructive(void) __ksym;
> > +
> > +#endif /* _BPF_TESTMOD_KFUNC_H */
> > diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
> > index 7653df1bc787..823901c1b839 100644
> > --- a/tools/testing/selftests/bpf/progs/cb_refs.c
> > +++ b/tools/testing/selftests/bpf/progs/cb_refs.c
> > @@ -2,6 +2,7 @@
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include "bpf_testmod/bpf_testmod_kfunc.h"
>
> Feel free to ignore if you disagree, but here and elsewhere, should we
> do this:
>
> #include <bpf_testmod/bpf_testmod_kfunc.h>
>
> rather than using #include "bpf_testmod/bpf_testmod_kfunc.h". Doesn't
> matter much, but IMO it's just slightly more readable to use the <> to
> show that we're relying on -I rather than expecting
> bpf_testmod/bpf_testmod_kfunc.h to be found at a path relative to the
> progs. #include "bpf_misc.h" makes more sense because it really is
> located in the progs/ directory.

We do <> for headers that are expected to be installed in the system
(even if we cheat with -I sometimes). But in this case it's a local
header, so using "" makes more sense to me. But shouldn't it be
"../bpf_testmod/bpf_testmod_kfunc.h"?

>
> Either way:
>
> Acked-by: David Vernet <void@manifault.com>
>
> >

[...]
