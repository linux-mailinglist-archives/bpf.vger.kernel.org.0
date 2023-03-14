Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782076B87DD
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 02:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCNBvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 21:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCNBvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 21:51:16 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4BC7A917
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 18:51:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j6so3457764ilr.7
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678758673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=589d5gGFeTRFSWyqkY4bWEOUvz8ytn+1q0THemjgTjo=;
        b=sCoaYS53kX1FbnPJO069z9fN0xiunJwETCfuUF0U+/1RY4OSf2gZybXW3iq2NvZtxL
         N3xD1WDLzMneibZj8Q3LKDEfJFudxp9oIpmwf5eOXWyWx+wW0FJtOX7nLfzWWpK2+z94
         aJ5Xanx5/iUJnv4jg7mSaFCnACgXLQRGVkZAU0jGHhQpgDgZxawwuUPuUJRUCOccQwxu
         oOiq+OeNrEHYo37W1HQdW/+izUkV1CJSVNCCDgjq7JSkccc0HO7BvdXU+s2bsT8CUhMT
         elDT2/kflN9YtGfavs/UkIQ5Uo6goP5LKIO8AWva4YDcH2BjhLC0X0G8VMGzLVnfZfEF
         q91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678758673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=589d5gGFeTRFSWyqkY4bWEOUvz8ytn+1q0THemjgTjo=;
        b=R+Lxmgmr1aWoLOFKHZcywhAevx/gm5L7mZx0y56zS9c/Jjx70QQbJuw4gtJJGrUoL9
         dBE0zTpyxsXaA3sB1ObLf+m3jX+raH9EUkGaogYi43ETIHaDDv9+mlLLRSrJUCK6qn7t
         eUWEFEC75hCunJuF0O4VNVJZcQpZ+Wmaso+hpD1yy9aSgE4nZZ7A9hZ6nYegXa8YmLD+
         0wnZg5i4668mRhdmwDHSUp7oTLKbFg2W5OKx6eHJe6uZaTUaoXlrjUKJV1X9uD/QK875
         LL422H3Z6Uc3XtbmIwvEQK/3yyZ5UESQKiht1NUlOOLdaVTuSDQs2/lBecGrF7lCJ9kq
         R/DA==
X-Gm-Message-State: AO0yUKVj0jvl+59L/CFEIkmbmGQUrlRNuLI32YR1MjgvxoymE3yDm0oG
        90FRQEN6YZaew8TZQyfpacUXmas5+B0ePlFyu5hzmw==
X-Google-Smtp-Source: AK7set8+Dh8f7H+Wetyv5sOVdRcPFSdXasKPH4Ttdqkf4wP3Sdu73sgx2P46Ghc94F6DQroovlvQv8Ld0rvKqSoUjYc=
X-Received: by 2002:a05:6e02:601:b0:311:1424:47f1 with SMTP id
 t1-20020a056e02060100b00311142447f1mr54396ils.0.1678758672482; Mon, 13 Mar
 2023 18:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <20230116010115.490713-3-irogers@google.com>
 <ZA+RUCE4vAgBlQRh@kernel.org> <ZA+X14KllWXrlr7C@kernel.org> <CAP-5=fWFYVyCCH19XrFSk0hwPoxGkWKJ=vyjrWNroFWzBZ-S2A@mail.gmail.com>
In-Reply-To: <CAP-5=fWFYVyCCH19XrFSk0hwPoxGkWKJ=vyjrWNroFWzBZ-S2A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 18:51:01 -0700
Message-ID: <CAP-5=fVAhoqE6E87FRnwHr6Em2eX9Rq++6HmHMcFqVjFGCitmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf build: Remove libbpf pre-1.0 feature tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 5:19=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Mar 13, 2023 at 2:38=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Mar 13, 2023 at 06:10:40PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Sun, Jan 15, 2023 at 05:01:14PM -0800, Ian Rogers escreveu:
> > > > The feature tests were necessary for libbpf pre-1.0, but as the lib=
bpf
> > > > implies at least 1.0 we can remove these now.
> > >
> > > So I added this:
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 8b0bd3aa018ef166..b715cd4f43f4a014 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -580,7 +580,7 @@ ifndef NO_LIBELF
> > >            EXTLIBS +=3D -lbpf
> > >            $(call detected,CONFIG_LIBBPF_DYNAMIC)
> > >          else
> > > -          dummy :=3D $(error Error: No libbpf devel library found, p=
lease install libbpf-devel);
> > > +          dummy :=3D $(error Error: No libbpf devel library found or=
 older than v1.0, please install/update libbpf-devel);
> > >          endif
> > >        else
> > >          # Libbpf will be built as a static library from tools/lib/bp=
f.
> > >
> > > To better reflect the failure reason:
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-ne=
xt/feature/test-libbpf.make.output
> > > test-libbpf.c:5:2: error: #error At least libbpf 1.0 is required for =
Linux tools.
> > >     5 | #error At least libbpf 1.0 is required for Linux tools.
> > >       |  ^~~~~
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ rpm -q libbpf-devel
> > > libbpf-devel-0.8.0-2.fc37.x86_64
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > > I'll see if I can make the build test conditional on libbpf being >=
=3D 1.0
> >
> > I'm trying with this:
> >
> > =E2=AC=A2[acme@toolbox libbpf]$ git log --oneline -1 9476dce6fe905a6bf1=
d4c483f7b2b8575c4ffb2d
> > 9476dce6fe905a6b libbpf: remove deprecated low-level APIs
> > =E2=AC=A2[acme@toolbox libbpf]$ git tag --contains 9476dce6fe905a6bf1d4=
c483f7b2b8575c4ffb2d
> > v1.0.0
> > v1.0.1
> > v1.1.0
> > =E2=AC=A2[acme@toolbox libbpf]$
> >
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 531324c3dab594e1..f866c58b916f4d7a 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -63,6 +63,7 @@ endif
> >
> >  has =3D $(shell which $1 2>/dev/null)
> >  python_perf_so :=3D $(shell $(MAKE) python_perf_target|grep "Target is=
:"|awk '{print $$3}')
> > +old_libbpf :=3D $(shell grep -q LIBBPF_DEPRECATED /usr/include/bpf/bpf=
.h)
>
> I think this could also be:
> old_libbpf :=3D $(shell grep MAJOR /usr/include/bpf/libbpf_version.h
> 2>&1 |grep -q  0)
> Which may be a bit more intention revealing and future proof.
>
> Thanks,
> Ian

To avoid /usr/include assumptions, there's also:
old_libbpf :=3D $(shell echo "#include <bpf/libbpf.h>" | $(CC) -E -dM -x
c -|grep "define LIBBPF_MAJOR_VERSION"|grep -q 0)
:-)

Ian

> >  # standard single make variable specified
> >  make_clean_all      :=3D clean all
> > @@ -151,7 +152,9 @@ run +=3D make_no_libaudit
> >  run +=3D make_no_libbionic
> >  run +=3D make_no_auxtrace
> >  run +=3D make_no_libbpf
> > +ifneq ($(old_libbpf),)
> >  run +=3D make_libbpf_dynamic
> > +endif
> >  run +=3D make_no_libbpf_DEBUG
> >  run +=3D make_no_libcrypto
> >  run +=3D make_no_sdt
