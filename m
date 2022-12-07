Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9F645061
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLGAem (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGAel (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:34:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F76A479
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:34:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d14so17793786edj.11
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 16:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5WMMPlY1VguVJm7GA8zMJIbuh985N5KujVU6QfaRpvU=;
        b=IN4LMHw7iEwiKnuATmmHUzGNrJJQRhzX45L1I5liHueHI798fYg4d+TIXAMkKgXqR5
         p6gIY0/3gxWIttYTPNHRUwiLSNOiOo+smnm7ocUxwoYuJ4P6FIjq8auuDUV2usvy2G48
         oJ1tte1WgA9u7bCwSUhI0n7bkiYcMUamsME71+F1UT1/moE5/YvKJWpobDei3OgQlB6b
         T8aQLaIaELf+2uXFN9JyJUNZiSbrs5kMC0A44LvT0tfkVgEZPlpjprrFXcO14f7Q/JwF
         a5Eq2myqyOIkl4Kg9a2gkI3eaptdjiLrphcyMa2SC/DqD+oXv2B62WYckx3ewmlV98wr
         3gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WMMPlY1VguVJm7GA8zMJIbuh985N5KujVU6QfaRpvU=;
        b=r0kuiIR2fi03klD6p8UXWOJSascLv5+2kHJe+pC2lTUt20oFtbJRZsFEonm/QW4TLu
         EY9SgUh+TYC1b20zhhqZo0YbK7XdA14U0PM35cv+LMpWmfVmBPnePxb863S8uVOBrszW
         4d5oLL+bTNAx6A2tT5cxP73z6cpA0nE0P69twGXoatPsf5bVGV/P/IBcUUp/SR9YhmO2
         4qwgKC951H7n2ZuGErN0yp8ZgdlDx2PSs5AfYfMx3/uDqrw5znZPDPaKmyCmQq/Hex59
         eVZdUEgIhEwrumnNDQYr9KvTRXPqFW6JO5XX3VTmCE3TVDcWc/tvXaiif2m2a4X7g4SC
         hHgg==
X-Gm-Message-State: ANoB5pmqmsGybdHbsW5JiMl3sWEaaJFFRbP7tpkrBW4j2Xbpcb3jiKjn
        LxL3t419Zdz/na+vWd0IRts6jWBqYA6z1ZloYdQ=
X-Google-Smtp-Source: AA0mqf6uUKMKD4kMD3HuGNl0aWyK3//N3TtSWrPistXkJb5sEeb1cDJ7F2dFJ5q6WaSJMhRiY7BAPTcYjNVzmnK5isQ=
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id
 t33-20020a056402242100b00461524fa8f4mr79886667eda.260.1670373278903; Tue, 06
 Dec 2022 16:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
 <20221205131618.1524337-2-daan.j.demeyer@gmail.com> <CAEf4BzYgFUS+Tqq72r5RgrMF6nHEp-zk7sc3jY1x19eS4wWXSQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYgFUS+Tqq72r5RgrMF6nHEp-zk7sc3jY1x19eS4wWXSQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 16:34:26 -0800
Message-ID: <CAEf4Bzaw4jZFG8Bv-9oNNnKmMsCPyom5atN5Mq=P7BZ4hYzawA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Install all required files to
 run selftests
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org
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

On Tue, Dec 6, 2022 at 4:29 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 5:25 AM Daan De Meyer <daan.j.demeyer@gmail.com> wrote:
> >
> > When installing the selftests using
> > "make -C tools/testing/selftests install", we need to make sure
> > all the required files to run the selftests are installed. Let's
> > make sure this is the case.
> >
> > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 6a0f043dc410..f6b8ffdde16f 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -532,8 +532,10 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko     \
> >                        $(OUTPUT)/liburandom_read.so                     \
> >                        $(OUTPUT)/xdp_synproxy                           \
> >                        $(OUTPUT)/sign-file                              \
> > -                      ima_setup.sh verify_sig_setup.sh                 \
> > -                      $(wildcard progs/btf_dump_test_case_*.c)
> > +                      $(realpath ima_setup.sh)                         \
> > +                      $(realpath verify_sig_setup.sh)                  \
>
> why do we need realpath for these scripts, but it's ok to not do that
> for *.bpf.o and btf_dump_test_case_*.c below?
>

I dropped the $(realpath) change for now and applied the series.
Please let me know if I'm missing something.

>
> > +                      $(wildcard progs/btf_dump_test_case_*.c)         \
> > +                      $(wildcard progs/*.bpf.o)
> >  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> >  TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> >  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> > --
> > 2.38.1
> >
