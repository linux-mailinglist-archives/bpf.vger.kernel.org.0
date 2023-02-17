Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B415769AC5C
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBQN0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQN0B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 08:26:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50364B1C
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 05:25:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec30so4490622edb.2
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 05:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q18eyApTxUTpeH3gSagVm/+HN2jaKet7SUh5yi9zYTk=;
        b=j2gDcVM0Pt+/vFdRWpVR8xMFzSAvmA6hID1vz+CjHEXrbxLLW66XucLX1PMaDOYD/Y
         mOjoU9cbqFgvHr6fmMKmIBY942uIkxvyWa5sx32NzQQATrLZPhPIhsB/qfCnRBKWJc2B
         IEw0ErkYIsWITtnUahpdWEEcT0bzBBmm6fuPZ+ucF5ooW8uSuZIXeo+jC4pAOm/DwbQv
         Jb3P2J5AaBKa6z48k+k3CRNv+5q3DwKRWm9Tki+hGEYaLT4rV9XKj/bHNMFb1dUDY7/r
         2b0hrh5g9FydHHRiMd3saWXOaN2W5mu62BdrSJmvmHMn7gdMo6K3cEov3pQXpyBrQkkE
         YFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q18eyApTxUTpeH3gSagVm/+HN2jaKet7SUh5yi9zYTk=;
        b=vJWISljM+tsoTNaAUjG1v8iek4EwHyoeilzeh/sHi0ZbEuq6z1sZiW7cDuYzHhaBmK
         Nov1l+klz0e2nST8ApZclhsYvjPRK6d51pYdf2apLOnTEQlUSwVEnz1EgUImGYJZLie2
         ac37Tk30fCyblZGEKuN6MGHM0gNMaK+oC/mso3epf0mIzmGqXMeO0Fmlsl2xO1t6V7T4
         IYBZrePW0iCc7NEzvM+4xKC+BCsIIwYiycJ804farkoSbkmE6PEb1vrVLnaZYNg55nZj
         QCZ3AKFGL4/p9LD/EtX9Wz4B/SDwgHM5yeRExjbUXX6qhVkqHZkwKeeAiLzrEFacPRU3
         HOIA==
X-Gm-Message-State: AO0yUKVn/s9roLZTgwrexKEzlSu6wrWuYdfJg6UdQ2RTTXO5ytR8AwCi
        AdlYn3igNnQMcDabzddZ+M8=
X-Google-Smtp-Source: AK7set/xMkA2oxLqI6YzOD1Xx6bLFLsKD9PTZMbXzInec36pj2WJn4deeqG1YgZQLr2iQ9YiCVFsMA==
X-Received: by 2002:a17:907:1dea:b0:873:393f:1bda with SMTP id og42-20020a1709071dea00b00873393f1bdamr8809319ejc.47.1676640357906;
        Fri, 17 Feb 2023 05:25:57 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a1709062c4c00b008b149e496e5sm2106689ejh.163.2023.02.17.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:25:57 -0800 (PST)
Message-ID: <4a1aaff3c2f29485d0a47279bd8b6cc7f0f6c78f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Tests for uninitialized
 stack reads
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Fri, 17 Feb 2023 15:25:56 +0200
In-Reply-To: <CAEf4BzYPAE8EhgeGZWuUG5kjvxd8n5c1Qy_PCJveVYQ8=Fuipg@mail.gmail.com>
References: <20230216183606.2483834-1-eddyz87@gmail.com>
         <20230216183606.2483834-3-eddyz87@gmail.com>
         <CAEf4BzYPAE8EhgeGZWuUG5kjvxd8n5c1Qy_PCJveVYQ8=Fuipg@mail.gmail.com>
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

On Thu, 2023-02-16 at 16:55 -0800, Andrii Nakryiko wrote:
> On Thu, Feb 16, 2023 at 10:36 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> >=20
> > Two testcases to make sure that stack reads from uninitialized
> > locations are accepted by verifier when executed in privileged mode:
> > - read from a fixed offset;
> > - read from a variable offset.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/uninit_stack.c   |  9 +++
> >  .../selftests/bpf/progs/uninit_stack.c        | 55 +++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uninit_stack=
.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uninit_stack.c
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uninit_stack.c b/to=
ols/testing/selftests/bpf/prog_tests/uninit_stack.c
> > new file mode 100644
> > index 000000000000..e64c71948491
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "uninit_stack.skel.h"
> > +
> > +void test_uninit_stack(void)
> > +{
> > +       RUN_TESTS(uninit_stack);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/uninit_stack.c b/tools/t=
esting/selftests/bpf/progs/uninit_stack.c
> > new file mode 100644
> > index 000000000000..20ff6a22c906
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +/* Read an uninitialized value from stack at a fixed offset */
> > +SEC("socket")
> > +__naked int read_uninit_stack_fixed_off(void *ctx)
> > +{
> > +       asm volatile ("                         \
> > +               // force stack depth to be 128  \
> > +               *(u64*)(r10 - 128) =3D r1;        \
> > +               r1 =3D *(u8 *)(r10 - 8 );         \
> > +               r1 =3D *(u8 *)(r10 - 11);         \
> > +               r1 =3D *(u8 *)(r10 - 13);         \
> > +               r1 =3D *(u8 *)(r10 - 15);         \
> > +               r1 =3D *(u16*)(r10 - 16);         \
> > +               r1 =3D *(u32*)(r10 - 32);         \
> > +               r1 =3D *(u64*)(r10 - 64);         \
> > +               // read from a spill of a wrong size, it is a separate =
 \
> > +               // branch in check_stack_read_fixed_off()              =
 \
> > +               *(u32*)(r10 - 72) =3D r1;         \
> > +               r1 =3D *(u64*)(r10 - 72);         \
> > +               r0 =3D 0;                         \
> > +               exit;                           \
>=20
> would it be better to
>=20
> r0 =3D *(u64*)(r10 - 72);
> exit;
>=20
> to make sure that in the future verifier doesn't smartly optimize out
> unused reads?

Are there plans for such optimizations? If there are, many tests might
be in trouble. I thought that this is delegated to the C compiler.

For this particular case the rewrite might look as:

	asm volatile ("					\
		r0 =3D 0;					\
		/* force stack depth to be 128 */	\
		*(u64*)(r10 - 128) =3D r1;		\
		r1 =3D *(u8 *)(r10 - 8 );			\
		r0 +=3D r1;				\
		r1 =3D *(u8 *)(r10 - 11);			\
		r0 +=3D r1;				\
		r1 =3D *(u8 *)(r10 - 13);			\
		r0 +=3D r1;				\
		r1 =3D *(u8 *)(r10 - 15);			\
		r0 +=3D r1;				\
		r1 =3D *(u16*)(r10 - 16);			\
		r0 +=3D r1;				\
		r1 =3D *(u32*)(r10 - 32);			\
		r0 +=3D r1;				\
		r1 =3D *(u64*)(r10 - 64);			\
		r0 +=3D r1;				\
		/* read from a spill of a wrong size, it is a separate	\
		 * branch in check_stack_read_fixed_off()		\
		 */					\
		*(u32*)(r10 - 72) =3D r1;			\
		r1 =3D *(u64*)(r10 - 72);			\
		r0 +=3D r1;				\
		exit;					\
"
		      ::: __clobber_all);
             =20
It works but is kinda ugly.

 ---

Orthogonal to the above issue, I found that use of the '//' comments
in the asm code w/o newlines is invalid, as it makes rest of the
string a comment. I changed '\n\' line endings to '\' just before
sending the patch and did not verify the change.
=3D> The patch-set would have to be resent.

>=20
>=20
> Either way, looks good to me:
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> > +"
> > +                     ::: __clobber_all);
> > +}
> > +
> > +/* Read an uninitialized value from stack at a variable offset */
> > +SEC("socket")
> > +__naked int read_uninit_stack_var_off(void *ctx)
> > +{
> > +       asm volatile ("                         \
> > +               call %[bpf_get_prandom_u32];    \
> > +               // force stack depth to be 64   \
> > +               *(u64*)(r10 - 64) =3D r0;         \
> > +               r0 =3D -r0;                       \
> > +               // give r0 a range [-31, -1]    \
> > +               if r0 s<=3D -32 goto exit_%=3D;     \
> > +               if r0 s>=3D 0 goto exit_%=3D;       \
> > +               // access stack using r0        \
> > +               r1 =3D r10;                       \
> > +               r1 +=3D r0;                       \
> > +               r2 =3D *(u8*)(r1 + 0);            \
> > +exit_%=3D:       r0 =3D 0;                         \
> > +               exit;                           \
> > +"
> > +                     :
> > +                     : __imm(bpf_get_prandom_u32)
> > +                     : __clobber_all);
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.39.1
> >=20

