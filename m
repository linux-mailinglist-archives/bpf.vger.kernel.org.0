Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BB645084
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLGAmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLGAmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:42:35 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A8BFD
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:42:34 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i2so15869496vsc.1
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 16:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo+CX+X5wMktZpQkqDS/axbJSfLFLlIJzd/BRRuMzTo=;
        b=NqYFAK1HMbLJtDn454sxCHLC3w30Qlp14OkWUhp9aTEFkJZS4JuhsyRYLE8ekEw2/I
         P1ugKxQOuRyf4Rfvv3vkAE9aAzjhBkK7b+IDrOglEvX0k3e2aZOZrHkUYcVFuwxJVjVq
         UUD5DZA7JZqzbQ9aEQQ+KPQlRrg2KKx5/lL+K/UbN2tOdm5MfYhJb793mgwlkAVnO/zV
         zdyIq/Oid0jVoaZoecpA/mdAaCsRFUiwKlveD5unPR9Gm899jMYk+VciY1MGA+ZU9FMb
         wLFIzeOGnhqvLmM6yV8gZkp78QUVeT0sQ3NfPwny6MMUN+Q1XSyQntVoZIVm3KRv2W/3
         TyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo+CX+X5wMktZpQkqDS/axbJSfLFLlIJzd/BRRuMzTo=;
        b=A6LZSk+grKwiF8WPtGrXFC5gz0U9oAAdLRl4xrr/epCc08b6TNu8415FfFf1nvvQxo
         9O6/S7W8hSR0GZywOtBLeHDsustImO6SPj/tmqb4FxbWxs8UWgTBEIzej9aKaDZOpIvV
         /2GTB+oyqNqgOCgcNJQrXxMg5ko9fbvmkyo4WE3aQe9P41+YpWiyYpcQwqAZXiIrEDzA
         R0eYvG010YhAuXU/2ztYF3C4zyEgS7e2DK7JFOaIuoi0U0ZuRDLqhlx4TW5VUDWve7LI
         v3Mdp+DMTGakfUNu6WtFBjR5/zISNPWOznQ4avfhRtnGrPK7C8g2cUn4jjt7Z5txv7XW
         HLTA==
X-Gm-Message-State: ANoB5pnbOHyWkEvq/vq98b33Ppby4EeZrzn8rffyzTDK1Bzg18oO++7w
        leniELbOCtCkFFn2zNOMa1htIAhw5DGZoboZnbeidg==
X-Google-Smtp-Source: AA0mqf7bMoXLOQehmSt88/WTYvWiHXa+NkdSxATJexOliqavBiLsDewK98DovJOzzd3PecSn8RSFSvIPnycPP9EaUks=
X-Received: by 2002:a05:6102:243a:b0:3b1:13ee:4bf7 with SMTP id
 l26-20020a056102243a00b003b113ee4bf7mr11064225vsi.62.1670373753451; Tue, 06
 Dec 2022 16:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20221201011135.1589838-1-pnaduthota@google.com>
 <20221201011135.1589838-3-pnaduthota@google.com> <55bc0068-880d-4715-0fb5-a2b384951c1d@iogearbox.net>
In-Reply-To: <55bc0068-880d-4715-0fb5-a2b384951c1d@iogearbox.net>
From:   Pramukh Naduthota <pnaduthota@google.com>
Date:   Tue, 6 Dec 2022 16:42:07 -0800
Message-ID: <CAEeqUsrLqtxvQeKLdDe0xAc_zTM__0wuJ4Vqta+cUzQe5fuNew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] Add a selftest for devmap pinning.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry, looks like I didn't run the tests again after fixing my
checkpatch errors. Still new to this, and am quite mortified.

Is there a better way to fix this than sending out a v3 of my patch?

On Mon, Dec 5, 2022 at 2:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote=
:
>
> On 12/1/22 2:11 AM, Pramukh Naduthota wrote:
> > Add a selftest
> >
> > Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
> > ---
> >   .../testing/selftests/bpf/prog_tests/devmap.c | 20 ++++++++++++++++++=
+
> >   .../selftests/bpf/progs/test_pinned_devmap.c  | 17 ++++++++++++++++
> >   2 files changed, 37 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devm=
ap.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/devmap.c b/tools/te=
sting/selftests/bpf/prog_tests/devmap.c
> > new file mode 100644
> > index 000000000000..50c5006c1416
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/devmap.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Google */
> > +#include "testing_helpers.h"
> > +#include "test_progs.h"
> > +#include "test_pinned_devmap.skel.h"
> > +
> > +void test_devmap_pinning(void)
> > +{
> > +     struct test_pinned_devmap *ptr;
> > +
> > +     ptr =3D test_pinned_devmap__open_and_load()
> > +     ASSERT_OK_PTR(ptr, "first load");
>
> Looks like you never actually compiled your selftest? :(
>
>      [...]
>      TEST-OBJ [test_progs] rcu_read_lock.test.o
>      TEST-OBJ [test_progs] btf_dump.test.o
>    In file included from /tmp/work/bpf/bpf/tools/testing/selftests/bpf/pr=
og_tests/devmap.c:4:
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c: In =
function =E2=80=98test_devmap_pinning=E2=80=99:
>    ./test_progs.h:352:35: error: expected expression before =E2=80=98{=E2=
=80=99 token
>      352 | #define ASSERT_OK_PTR(ptr, name) ({     \
>          |                                   ^
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c:12:2=
: note: in expansion of macro =E2=80=98ASSERT_OK_PTR=E2=80=99
>       12 |  ASSERT_OK_PTR(ptr, "first load");
>          |  ^~~~~~~~~~~~~
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c:11:8=
: error: called object is not a function or function pointer
>       11 |  ptr =3D test_pinned_devmap__open_and_load()
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    make: *** [Makefile:539: /tmp/work/bpf/bpf/tools/testing/selftests/bpf=
/devmap.test.o] Error 1
>    make: *** Waiting for unfinished jobs....
>    make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf=
'
>    Error: Process completed with exit code 2.
>
> > +     test_pinned_devmap__destroy(ptr);
> > +     ASSERT_OK_PTR(test_pinned_devmap__open_and_load(), "re-load");
> > +}
> > +
> > +void test_devmap(void)
> > +{
> > +     test_devmap_pinning();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_pinned_devmap.c b/t=
ools/testing/selftests/bpf/progs/test_pinned_devmap.c
> > new file mode 100644
> > index 000000000000..2e9b25fe657c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Google */
> > +#include <stddef.h>
> > +#include <linux/bpf.h>
> > +#include <linux/types.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
> > +     __uint(max_entries, 32);
> > +     __type(key, int);
> > +     __type(value, int);
> > +     __uint(pinning, LIBBPF_PIN_BY_NAME);
> > +} repinned_dev_map SEC(".maps");
> > +
> > +
> > +char _license[] SEC("license") =3D "GPL";
> >
>
