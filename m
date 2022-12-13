Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4A64BE64
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiLMV2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 16:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMV2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 16:28:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71175240A0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 13:28:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o15so9563783wmr.4
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPxCch+SuJX/czcKg/x1jS3wKYQ1yhbWpMuG4i9oUWw=;
        b=E+lkNW/vnitIH25/YnSrt7TWGivM29tl8AVsANwFHEc9rH5JKyJW7bRkbD1EqRGDfF
         IbaXcj4hTp85nDZepnLtVL1fCB8FwovIslVrrUOWGStxH1cRsyNfYQaKraZfjbTx8zDG
         Y6Uyb/fFOIDJ4Z+FwL4DHITXdbRlNIYY/kRFDet4bzICjNllgNH3NtqFshl1QoSaHf36
         Cva9GMrwVGDI6RgldilFEV1lVZqc+2BDZ8j7owZX73X4ghABa3KeKjezgLW2oP653Mgu
         MGnc51UtYncxknfwWT6Snyzc/1+oIN53DpcB/JL6LDj4IT6Sk8xxh80ao+ILw+aBlkwp
         qcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPxCch+SuJX/czcKg/x1jS3wKYQ1yhbWpMuG4i9oUWw=;
        b=YS79V9JYcYvd95HcbyVmJblNhWd+t1vRr6Y6dLza/cIamkFRqTXw/IfgI27XYdv3xg
         sqFDV4zo1+R/Yr72AvD0KIlAFjX6VVSybHrbvyXJ02/t+BMcrlhfp4XeyXdZ1hetWAwi
         AwIwM6kW9Nq+6u69dKgZD37HKgpxG2SLc5EX5CWcP7aM0fe9XODd0TkT0vCCx/s8MdUg
         9wUcXzcOvcxMwvms0Ut3Sung7Tg1yvUmDLSFZipJW94xBi8gcb68Rh6IFNQ4ZjxHQgQL
         o0ImcCDHSKqh7Do9RAg4QjKkca0y340Mnf7cd4RAK9vFoZkrGXgCv4Z7Y8Xi7FJ0IPsD
         rn4g==
X-Gm-Message-State: ANoB5pkXCVMCf4saxulGyqmlYsK+UZTAhB3NhIrbVX1XS+YqLekTIwVN
        JLSridum+OMloIidLob5oRb4cUeYU0QiXL9TM1B5Ug==
X-Google-Smtp-Source: AA0mqf4mbRN9RO70+dP+17nvXwqHWyjSQsBIhtnZWLOuogyyAtbhcJWpE11dGgYAj5QrifRpofLF7t15nrzEa0jLA+w=
X-Received: by 2002:a1c:7203:0:b0:3c6:c109:2d9 with SMTP id
 n3-20020a1c7203000000b003c6c10902d9mr13324wmc.149.1670966913709; Tue, 13 Dec
 2022 13:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com> <20221202045743.2639466-4-irogers@google.com>
 <Y5eVwlId2A2/pN40@fjasle.eu>
In-Reply-To: <Y5eVwlId2A2/pN40@fjasle.eu>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Dec 2022 13:28:21 -0800
Message-ID: <CAP-5=fXeYsOs-YJH+hx=haGwJ_eqDNXYQQ30AiyDDfc5P2o84Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] tools lib subcmd: Add dependency test to install_headers
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
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

On Mon, Dec 12, 2022 at 12:57 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu, Dec 01, 2022 at 08:57:41PM -0800 Ian Rogers wrote:
> > Compute the headers to be installed from their source headers and make
> > each have its own build target to install it. Using dependencies
> > avoids headers being reinstalled and getting a new timestamp which
> > then causes files that depend on the header to be rebuilt.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/subcmd/Makefile | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> > index 9a316d8b89df..b87213263a5e 100644
> > --- a/tools/lib/subcmd/Makefile
> > +++ b/tools/lib/subcmd/Makefile
> > @@ -89,10 +89,10 @@ define do_install_mkdir
> >  endef
> >
> >  define do_install
> > -     if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> > -             $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> > +     if [ ! -d '$2' ]; then             \
> > +             $(INSTALL) -d -m 755 '$2'; \
> >       fi;                                             \
> > -     $(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> > +     $(INSTALL) $1 $(if $3,-m $3,) '$2'
>
> What about using '$(INSTALL) -D ...' instead of the if-mkdir-block above?
> (E.g. as in tools/debugging/Makefile.)
>
> Kind regards,
> Nicolas

Thanks Nicolas, the reason was to keep the code consistent. That's not
to say this is the best approach. For example, here is the same thing
for tools/lib/api:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/l=
ib/api/Makefile?h=3Dperf/core&id=3Df43368371888694a2eceaaad8f5e9775c092009a=
#n84

If you'd like to improve this in all the versions and send patches I'd
be happy to take a look.

Thanks,
Ian

> >  endef
> >
> >  install_lib: $(LIBFILE)
> > @@ -100,13 +100,16 @@ install_lib: $(LIBFILE)
> >               $(call do_install_mkdir,$(libdir_SQ)); \
> >               cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> >
> > -install_headers:
> > -     $(call QUIET_INSTALL, libsubcmd_headers) \
> > -             $(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644=
); \
> > -             $(call do_install,help.h,$(prefix)/include/subcmd,644); \
> > -             $(call do_install,pager.h,$(prefix)/include/subcmd,644); =
\
> > -             $(call do_install,parse-options.h,$(prefix)/include/subcm=
d,644); \
> > -             $(call do_install,run-command.h,$(prefix)/include/subcmd,=
644);
> > +HDRS :=3D exec-cmd.h help.h pager.h parse-options.h run-command.h
> > +INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/subcmd
> > +INSTALL_HDRS :=3D $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
> > +
> > +$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
> > +     $(call QUIET_INSTALL, $@) \
> > +             $(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
> > +
> > +install_headers: $(INSTALL_HDRS)
> > +     $(call QUIET_INSTALL, libsubcmd_headers)
> >
> >  install: install_lib install_headers
> >
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --
