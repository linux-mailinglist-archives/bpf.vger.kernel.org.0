Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD96E0327
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDMAXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDMAXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:23:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B006E86;
        Wed, 12 Apr 2023 17:23:34 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e10so4680256ybp.4;
        Wed, 12 Apr 2023 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkJbxz/rx3LkE5iVVFcRLvjr8BVPXloxofNBD6GpIwU=;
        b=S6jAUU3dev32j4+L0u63oQHokRTsmSx8MkTX9mypek2gt9tV6PqlMktxOIAACPobkH
         rrDZUc2JXFQ8jKcC335QKfQJ/FCJXutTjTEnbYbZeWAMvCz31o9JaF/aBlls9bOgqplf
         I26UYX+C9oYfuBcF9pnMcv57ESEtKBAoJWAAeVJ/xUpyQ1p7nhQyvZGlV9NgdYg+RPcR
         b3qQKzrIIFzTQRev22vcwqCSGNPyks7C6uG71xBl99AUy7QEqFAnNNDzs4q+E5MQvCvB
         ZXLT4FlSGr7CMFSZs8SldOFQNVpP6pqvwRAXDp7cxUXcF5C6dVdStkFe05ZBoUd4MSqp
         1BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkJbxz/rx3LkE5iVVFcRLvjr8BVPXloxofNBD6GpIwU=;
        b=DgsNvhRd/tllI11y/JzS2XbRTpBIzaMzUfG0xB879YG/wB2XmEyxvxFO0+mn9Ss0Np
         uGuIF19/ifnsicuCG0LJNTnSlcGX5/kmIOOujGLB48GH7ZL82Ck83hdJqMSS0/WskdYE
         wjddlyu8slZnPxNkU2pQloEMNkc+E0Llao7ymEI7925MRahrZ4ul0KeQ9m6iaalGgZ4U
         22sfNsxPg9/zVypRtVyMCSQSi7aeEu2eu+CUpCdGLFPqVU1cdjgmBqcKXA9JyzN/ipp/
         fHBh+4GXa0COHEEISNjzHM3/PvB37RRuiiHvLcoPC09WkekiyWWJRsusutHvQQWw2g4B
         cjRw==
X-Gm-Message-State: AAQBX9c/yo/6RkOO5Xc0vHBdT82gi7DHwUiPsjMwHZT/A2Hh85Gcz8s+
        aHlpq+45azr2xc+2KLxOgT1j8byRGpfWhgWOQdY=
X-Google-Smtp-Source: AKy350ZJ4fnpGicjECv77SpcMYRfn5cN8NQQ9FTjoGq53Lky+pXDWcL+4uPtQ2DXR0QcQkKsQtV6G9nYOaetLMB/mVU=
X-Received: by 2002:a25:72d6:0:b0:b8f:55f6:e50f with SMTP id
 n205-20020a2572d6000000b00b8f55f6e50fmr300765ybc.1.1681345413679; Wed, 12 Apr
 2023 17:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-6-andrii@kernel.org>
 <6436f71e.170a0220.75de.385b@mx.google.com>
In-Reply-To: <6436f71e.170a0220.75de.385b@mx.google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 17:23:19 -0700
Message-ID: <CAEf4Bzbq0ZD=0W4-4fn-be20DkU9HgFLyebKJC9zay3NW5KG1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: validate new
 bpf_map_create_security LSM hook
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 11:23=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 11, 2023 at 09:32:57PM -0700, Andrii Nakryiko wrote:
> > Add selftests that goes over every known map type and validates that
> > a combination of privileged/unprivileged modes and allow/reject/pass-th=
rough
> > LSM policy decisions behave as expected.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/lsm_map_create.c | 143 ++++++++++++++++++
> >  .../selftests/bpf/progs/lsm_map_create.c      |  32 ++++
> >  tools/testing/selftests/bpf/test_progs.h      |   6 +
> >  3 files changed, 181 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_map_crea=
te.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/lsm_map_create.c
> >

[...]

> > +             ret =3D libbpf_probe_bpf_map_type(map_type, NULL);
> > +             ASSERT_EQ(ret, is_map_priv ? 0 : 1,  "default_unpriv_mode=
");
> > +
> > +             /* allow any map creation for our thread */
> > +             skel->bss->decision =3D 1;
> > +             ret =3D libbpf_probe_bpf_map_type(map_type, NULL);
> > +             ASSERT_EQ(ret, 1, "lsm_allow_unpriv_mode");
> > +
> > +             /* reject any map creation for our thread */
> > +             skel->bss->decision =3D -1;
> > +             ret =3D libbpf_probe_bpf_map_type(map_type, NULL);
> > +             ASSERT_EQ(ret, 0, "lsm_reject_unpriv_mode");
> > +
> > +             /* restore privileges, but keep reject LSM policy */
> > +             if (!ASSERT_OK(restore_priv_caps(orig_caps), "restore_cap=
s"))
> > +                     goto cleanup;
> > +
> > +skip_if_needs_btf:
> > +             /* even with all caps map create will fail */
> > +             skel->bss->decision =3D -1;
> > +             ret =3D libbpf_probe_bpf_map_type(map_type, NULL);
> > +             ASSERT_EQ(ret, 0, "lsm_reject_priv_mode");
> > +     }
> > +
> > +cleanup:
> > +     btf__free(btf);
> > +     lsm_map_create__destroy(skel);
> > +}
>
> This test looks good! One meta-comment about testing would be: are you
> sure each needs to be ASSERT instead of EXPECT? (i.e. should forward
> progress through this test always be aborted when a check fails?)
>

it's our custom BPF selftests ASSERTs, they don't really do assert()
and panic, they really are just a check (so I'm guessing they have
EXPECT semantics you are referring to). And if check doesn't pass, we
just set a flag notifying our own custom test runner that test failed
and proceed.

So in short, it already behaves like you would want with EXPECT. We
just don't use kselftests's ASSERTs and EXPECTs.


> > diff --git a/tools/testing/selftests/bpf/progs/lsm_map_create.c b/tools=
/testing/selftests/bpf/progs/lsm_map_create.c
> > new file mode 100644
> > index 000000000000..093825c68459
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lsm_map_create.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <errno.h>
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +int my_tid;
> > +/* LSM enforcement:
> > + *   - 0, delegate to kernel;
> > + *   - 1, allow;
> > + *   - -1, reject.
> > + */
> > +int decision;
> > +
> > +SEC("lsm/bpf_map_create_security")
> > +int BPF_PROG(allow_unpriv_maps, union bpf_attr *attr)
> > +{
> > +     if (!my_tid || (u32)bpf_get_current_pid_tgid() !=3D my_tid)
> > +             return 0; /* keep processing LSM hooks */
> > +
> > +     if (decision =3D=3D 0)
> > +             return 0;
> > +
> > +     if (decision > 0)
> > +             return 1; /* allow */
> > +
> > +     return -EPERM;
> > +}
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/s=
elftests/bpf/test_progs.h
> > index 10ba43250668..12f9c6652d40 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -23,6 +23,7 @@ typedef __u16 __sum16;
> >  #include <linux/perf_event.h>
> >  #include <linux/socket.h>
> >  #include <linux/unistd.h>
> > +#include <sys/syscall.h>
> >
> >  #include <sys/ioctl.h>
> >  #include <sys/wait.h>
> > @@ -176,6 +177,11 @@ void test__skip(void);
> >  void test__fail(void);
> >  int test__join_cgroup(const char *path);
> >
> > +static inline int gettid(void)
> > +{
> > +     return syscall(SYS_gettid);
> > +}
> > +
> >  #define PRINT_FAIL(format...)                                         =
         \
> >       ({                                                               =
      \
> >               test__fail();                                            =
      \
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
