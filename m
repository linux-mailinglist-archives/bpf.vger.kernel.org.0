Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89554653A1C
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLVAdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVAdb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:33:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007364E7
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:33:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x11so476094lfn.0
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QhkZyyFye5fYkhxtK1oxGBu/k6+lHkA3sF+m8Q0EEV0=;
        b=qxpjyy0XrPAfQ0gpYJ4c1G13WPwDYVkusZOChh9oifLqqFKAritKuOeMAUqKNed/Wo
         JossQQXsapp56zAGNTaneNAthHSNz1os6U24KRHxLzV0gBbAxoOQi0x/pci+ZWxLv9Lg
         J2QK0ZhyzIif4yRBPaaIe337h94HjHp579aX0G2fk1TKOSJpxYYDt72a03eq2uNIUY1N
         C7/KpmSETiBLPGUxvmK69BitrfVK9WmCk/I5Mx/kmReuAoZZmDTse3vMB9rzWNvQAdu9
         CWc9cq4GTGcBsZnxeJur3Yj9UYrCSJq9A+QiQbwAyIauReC78V9AJ4685ENopDTdlRYJ
         qQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhkZyyFye5fYkhxtK1oxGBu/k6+lHkA3sF+m8Q0EEV0=;
        b=DrFqgecC8/GkLLrjHuZdkN4p6N6Ijl3RaxD1OBczozw7Dclmr2UVJjh7SD0jIyzl5W
         RVchUwG/IiQ1NaikzZwfzqLz9tfi4VPkULD0vaC4d0YIVFljdq0ZqJE+YlIAMHVTqy+P
         P7tKkHP48NzJ10xBFWskjdh2wiNZ8oQ+euPhrzB28O8SMeD+V84HgUTqRaHkA5UpGmWs
         35Z0BxXXoKdQL4kl87kgmrcGnprQtpj6sBNJWRUwo6F8p7PQzuHVcwM8FIiiGSp7U8j3
         OLBBxNSLbYVcRvSW78GeJIwOffgnQPsqAeneUvdTzOskk2ZVBD9L7XoWyoMzkvnH9K7N
         4lOA==
X-Gm-Message-State: AFqh2koAcH2eQPj8bWlxsF1zCjA51BCUbR0y1HKHAljofmHkIc778y1w
        A1ylsIkjMFJOu2nQFcbyVhA=
X-Google-Smtp-Source: AMrXdXtZmC2jgPOCnTrIiropa8twqPhGGXBkuzfJZXBaap+aH9jsQTN5EwQwg+L8ZF4BSHHfghr+ZA==
X-Received: by 2002:a05:6512:3b87:b0:4a4:68b7:d623 with SMTP id g7-20020a0565123b8700b004a468b7d623mr1448943lfv.10.1671669208384;
        Wed, 21 Dec 2022 16:33:28 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512006c00b004b4fefacd89sm1988556lfo.139.2022.12.21.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 16:33:27 -0800 (PST)
Message-ID: <3765d248674583da9aa4c61b0eae1f195886d22f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: check if
 verifier.c:check_ids() handles 64+5 ids
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Thu, 22 Dec 2022 02:33:26 +0200
In-Reply-To: <CAEf4Bzb0foB6PQsSZsXrGEJo7eQK8UDRh+Pkr5wg259-QeXwaA@mail.gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
         <20221217021711.172247-5-eddyz87@gmail.com>
         <CAEf4Bzb0foB6PQsSZsXrGEJo7eQK8UDRh+Pkr5wg259-QeXwaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-12-20 at 13:18 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > A simple program that allocates a bunch of unique register ids than
> > branches. The goal is to confirm that idmap used in verifier.c:check_id=
s()
> > has sufficient capacity to verify that branches converge to a same stat=
e.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       | 12 +++
> >  .../selftests/bpf/progs/check_ids_limits.c    | 77 +++++++++++++++++++
> >  2 files changed, 89 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/check_ids_limits.=
c
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > new file mode 100644
> > index 000000000000..3933141928a7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <test_progs.h>
> > +
> > +#include "check_ids_limits.skel.h"
> > +
> > +#define TEST_SET(skel)                 \
> > +       void test_##skel(void)          \
> > +       {                               \
> > +               RUN_TESTS(skel);        \
> > +       }
>=20
> Let's not use such trivial macros, please. It makes grepping for tests
> much harder and saves 1 line of code only. Let's define funcs
> explicitly?
>=20
> I'm also surprised it works at all (it does, right?), because Makefile

Nope, it doesn't work and it is embarrassing. I've tested w/o this
macro and only added it before final tests run. And didn't check the log.
Thank you for catching it. Will remove this macro.

> is grepping explicitly for `void (serial_)test_xxx` pattern when
> generating a list of tests. So this shouldn't have worked, unless I'm
> missing something.
>=20
> > +
> > +TEST_SET(check_ids_limits)
> > diff --git a/tools/testing/selftests/bpf/progs/check_ids_limits.c b/too=
ls/testing/selftests/bpf/progs/check_ids_limits.c
> > new file mode 100644
> > index 000000000000..36c4a8bbe8ca
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/check_ids_limits.c
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +struct map_struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 1);
> > +       __type(key, int);
> > +       __type(value, int);
> > +} map SEC(".maps");
> > +
> > +/* Make sure that verifier.c:check_ids() can handle (almost) maximal
> > + * number of ids.
> > + */
> > +SEC("?raw_tp")
> > +__naked __test_state_freq __log_level(2) __msg("43 to 45: safe")
>=20
> it's not clear what's special about 43 -> 45 jump?
>=20
> can we also validate that id=3D69 was somewhere in verifier output?
> which would require multiple __msg support, of course.
>=20
> > +int allocate_many_ids(void)
> > +{
> > +       /* Use bpf_map_lookup_elem() as a way to get a bunch of values
> > +        * with unique ids.
> > +        */
> > +#define __lookup(dst)                          \
> > +               "r1 =3D %[map] ll;"               \
> > +               "r2 =3D r10;"                     \
> > +               "r2 +=3D -8;"                     \
> > +               "call %[bpf_map_lookup_elem];"  \
> > +               dst " =3D r0;"
> > +       asm volatile(
> > +               "r0 =3D 0;"
> > +               "*(u64*)(r10 - 8) =3D r0;"
> > +               "r7 =3D r10;"
> > +               "r8 =3D 0;"
> > +               /* Spill 64 bpf_map_lookup_elem() results to stack,
> > +                * each lookup gets its own unique id.
> > +                */
> > +       "write_loop:"
> > +               "r7 +=3D -8;"
> > +               "r8 +=3D -8;"
> > +               __lookup("*(u64*)(r7 + 0)")
> > +               "if r8 !=3D -512 goto write_loop;"
> > +               /* No way to source unique ids for r1-r5 as these
> > +                * would be clobbered by bpf_map_lookup_elem call,
> > +                * so make do with 64+5 unique ids.
> > +                */
> > +               __lookup("r6")
> > +               __lookup("r7")
> > +               __lookup("r8")
> > +               __lookup("r9")
> > +               __lookup("r0")
> > +               /* Create a branching point for states comparison. */
> > +/* 43: */      "if r0 !=3D 0 goto skip_one;"
> > +               /* Read all registers and stack spills to make these
> > +                * persist in the checkpoint state.
> > +                */
> > +               "r0 =3D r0;"
> > +       "skip_one:"
>=20
> where you trying to just create a checkpoint here? given
> __test_state_freq the simplest way would be just
>=20
> goto +0;
>=20
> no?
>=20
> > +/* 45: */      "r0 =3D r6;"
> > +               "r0 =3D r7;"
> > +               "r0 =3D r8;"
> > +               "r0 =3D r9;"
> > +               "r0 =3D r10;"
> > +               "r1 =3D 0;"
> > +       "read_loop:"
> > +               "r0 +=3D -8;"
> > +               "r1 +=3D -8;"
> > +               "r2 =3D *(u64*)(r0 + 0);"
> > +               "if r1 !=3D -512 goto read_loop;"
> > +               "r0 =3D 0;"
> > +               "exit;"
> > +               :
> > +               : __imm(bpf_map_lookup_elem),
> > +                 __imm_addr(map)
> > +               : __clobber_all);
> > +#undef __lookup
> > +}
> > --
> > 2.38.2
> >=20

