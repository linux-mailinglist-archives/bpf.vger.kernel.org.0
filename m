Return-Path: <bpf+bounces-1970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA017250A6
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93F528101C
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF934D60;
	Tue,  6 Jun 2023 23:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E547E4
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 23:18:26 +0000 (UTC)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C61FEF
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 16:18:25 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33dea7d5424so27295ab.1
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686093504; x=1688685504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LusODyImi6kShYo7SZgAczgtmkpNpRiKl/lmOqpWzfY=;
        b=bHLLRfURdxNvPqhE2bfaZQ8ll3eh6shs0txawB+xbLvB7SA+cWOK7VhX0QUN79LyYI
         lCnTvE7jFUQoWSifn5m0Lys+Y0Dm/RZ9FHkfeJl+BM6/6+5ayQbUXgmiqg3xQhBVEa/J
         d0iTjx6j5/szWelj86ck4UuNSFm3gb6L9AsDhijZu7qcK84dWa0Ab2F4oTHIwI9iN2Qs
         cGTtqyfmHiTrw87RP+8KCCyCWVQVRpK3VGKy96HHt6qMgFQd9ABAhrjTCMAUWrHtRSw0
         FED1Gj5DnAAcqhYaqiWxyvoLJMBl4bZjrI4SY1fRdAO+QCPEfM6xrRse1TkgacsnkBMw
         Y0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093504; x=1688685504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LusODyImi6kShYo7SZgAczgtmkpNpRiKl/lmOqpWzfY=;
        b=GV7Z/nCNWkOyZEYSoCATMTPdSpP3u+fpbcpRi8KsWIsVrgiJqj45jgOgViXuW6c7yO
         LL9XExNcYz6YqaOoXITJsta8LknB15i3ZbGiwo/BuNSc2ocrAGBy5beKzPS9tUWc+/EI
         GKqGhtUXXIyFhCwIzVHJQzAioTrKQR4HW5A8WjQcZImR78mI+f2dFiK60PH3p3hkq1ZW
         wk83RPcWikXMi4MmmVBylLuM7K1eg3ezbOXItX+Af4P/06GD/oZWtLBPuWYkKhrLyKb2
         n6J2T4hqdx4NyvbhA5FFrfj/R/bdNj4+3zMG5q4IFxGClx8qorcIm9bZPpqQyX+WB66I
         9zBQ==
X-Gm-Message-State: AC+VfDzL/OyDKncyS2JRzEfnd7ATnQx1qxD2teosDHGDLNbe33ngd/SB
	xArmIPWkObmsG54VRwRVXnDczi1T6hIEyc6E/HAR1A==
X-Google-Smtp-Source: ACHHUZ7jN0OEqtUnQoxqE/pZb1cT4FFdk/SorQIEprthyAmFz43w0VOL5ChrKbF0ApvtiecmOAmx0rjnyMt4BE2Js3E=
X-Received: by 2002:a05:6e02:214a:b0:33b:cea:ce70 with SMTP id
 d10-20020a056e02214a00b0033b0ceace70mr26326ilv.25.1686093504340; Tue, 06 Jun
 2023 16:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com> <20230605202712.1690876-2-irogers@google.com>
 <ZH6gZgcwAbDrEiqX@krava> <CAP-5=fWgQDrgDJ_UFuo_G5NaCzR5vWrRyvQ-_qpvFP0p0q18+w@mail.gmail.com>
 <ZH91mGxFpDPcCFKY@kernel.org>
In-Reply-To: <ZH91mGxFpDPcCFKY@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Jun 2023 16:18:13 -0700
Message-ID: <CAP-5=fUscgwO-G0FSZeM6SyPZVe=Kg+t-s+2txjUrc_qbP+cDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf build: Add ability to build with a generated vmlinux.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 11:06=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 05, 2023 at 09:25:54PM -0700, Ian Rogers escreveu:
> > On Mon, Jun 5, 2023 at 7:57=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Mon, Jun 05, 2023 at 01:27:09PM -0700, Ian Rogers wrote:
> > > > Commit a887466562b4 ("perf bpf skels: Stop using vmlinux.h generate=
d
> > > > from BTF, use subset of used structs + CO-RE") made it so that
> > > > vmlinux.h was uncondtionally included from
> > > > tools/perf/util/vmlinux.h. This change reverts part of that change =
(so
> > > > that vmlinux.h is once again generated) and makes it so that the
> > > > vmlinux.h used at build time is selected from the VMLINUX_H
> > > > variable. By default the VMLINUX_H variable is set to the vmlinux.h
> > > > added in change a887466562b4, but if GEN_VMLINUX_H=3D1 is passed on=
 the
> > > > build command line then the previous generation behavior kicks in.
> > > >
> > > > The build with GEN_VMLINUX_H=3D1 currently fails with:
> > > > ```
> > > > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of '=
rq'
> > > > struct rq {};
> > > >        ^
> > > > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous d=
efinition is here
> > > > struct rq {
> > > >        ^
> > > > 1 error generated.
> > > > ```
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  tools/perf/Makefile.config                       |  4 ++++
> > > >  tools/perf/Makefile.perf                         | 16 ++++++++++++=
+++-
> > > >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> > > >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h |  0
> > > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > > >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (100%)
> > >
> > > looks good, but I don't understand why you moved the vmlinux.h
> > >
> > > jirka
> >
> > Dumb reason, as headers in the same directory take priority, I had to
> > move the vmlinux.h out of the directory with the C code for skeletons
> > so that it could be selected via a -I.
>
> Can this be in a separate patch, i.e. moving vmlinux to a separate
> directory? I was going to cherry pick the 'struct rq' fix but then it
> touches the vmlinux/vmlinux.h file that is in this first patch that has
> review comments.

I think the comments were more of a question of why the move?
Hopefully I answered that, the move is necessary to defeat the include
path order preferring files in the same directory. We need the move,
we could vary the directory name.

Thanks,
Ian

> - Arnaldo
>
> > Thanks,
> > Ian
> >
> > > >
> > > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.confi=
g
> > > > index a794d9eca93d..08d4e7eaa721 100644
> > > > --- a/tools/perf/Makefile.config
> > > > +++ b/tools/perf/Makefile.config
> > > > @@ -680,6 +680,10 @@ ifdef BUILD_BPF_SKEL
> > > >    CFLAGS +=3D -DHAVE_BPF_SKEL
> > > >  endif
> > > >
> > > > +ifndef GEN_VMLINUX_H
> > > > +  VMLINUX_H=3D$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
> > > > +endif
> > > > +
> > > >  dwarf-post-unwind :=3D 1
> > > >  dwarf-post-unwind-text :=3D BUG
> > > >
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index f48794816d82..f1840af195c0 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -1080,7 +1080,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
> > > >       $(Q)CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
> > > >               OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
> > > >
> > > > -$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_=
TMP_OUT)
> > > > +VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                    =
     \
> > > > +                  $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) =
   \
> > > > +                  ../../vmlinux                                   =
   \
> > > > +                  /sys/kernel/btf/vmlinux                         =
   \
> > > > +                  /boot/vmlinux-$(shell uname -r)
> > > > +VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PA=
THS))))
> > > > +
> > > > +$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> > > > +ifeq ($(VMLINUX_H),)
> > > > +     $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> > > > +else
> > > > +     $(Q)cp "$(VMLINUX_H)" $@
> > > > +endif
> > > > +
> > > > +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OU=
T)/vmlinux.h | $(SKEL_TMP_OUT)
> > > >       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF=
_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> > > >         -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> > > >
> > > > diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/=
bpf_skel/.gitignore
> > > > index 7a1c832825de..cd01455e1b53 100644
> > > > --- a/tools/perf/util/bpf_skel/.gitignore
> > > > +++ b/tools/perf/util/bpf_skel/.gitignore
> > > > @@ -1,3 +1,4 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  .tmp
> > > >  *.skel.h
> > > > +vmlinux.h
> > > > diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/b=
pf_skel/vmlinux/vmlinux.h
> > > > similarity index 100%
> > > > rename from tools/perf/util/bpf_skel/vmlinux.h
> > > > rename to tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > > --
> > > > 2.41.0.rc0.172.g3f132b7071-goog
> > > >
>
> --
>
> - Arnaldo

