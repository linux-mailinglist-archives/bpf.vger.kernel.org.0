Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C384CD9F6
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiCDRTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 12:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiCDRTF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 12:19:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91688F982
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 09:18:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 690FEB82A7C
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 17:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFCEC340F1
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646414294;
        bh=ZIxqKWKtxcz7RBw3gOkE7ECVdfsr9aJbzGzvyRYoaB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cg3c8QkBmOOCIfSPo15pd8zxkckRE1HsOG/rL2LcwU51mwkGked+xD0pjwGwKzCKI
         LwX5V610/BUtW4/u26v7vCWUEYa9Nd1iq2M2AcfsDWU09xZ2yxTvlB4NRwFcD9LSSV
         SrdHzbbYbFi8gUQQ2HDoXyQTJWcwE/dITK0DrR7mkFEB7ZPExILznDkFqQi1BFxKrK
         yJ/gWbGXGpRoGX3LQLpRSY/Tc3YGqdUFPxO7+L42+KR5CWNcS2/3C2nyrjlZlChzeP
         KgeDSqLQ4J7SHFt+OaS5hn1Dfah5fEjjmENVjMMctSXH6MRmGRLH5r/omwXotrFP4y
         R3eVR3/8c8rsQ==
Received: by mail-ej1-f49.google.com with SMTP id dr20so18818675ejc.6
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 09:18:13 -0800 (PST)
X-Gm-Message-State: AOAM533K9jA/c+fwbykK2MkyQ7TiEiYUiedJKLBAURtPXZxDjKzdCyAQ
        xUKLMUvxi+q6hXJovxprNqYtAW8n8mPJ7qPW0YGoJA==
X-Google-Smtp-Source: ABdhPJzfX6w6HaBXNoBSa9C3R30223d3CkiWTHWvaTXnvCmagYGf4fn4rpRggXVSMAH4npaun9YGYxHWs5I/zxHR9hE=
X-Received: by 2002:a17:906:9814:b0:6da:a60b:f99b with SMTP id
 lm20-20020a170906981400b006daa60bf99bmr5173203ejb.496.1646414292247; Fri, 04
 Mar 2022 09:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20220304150402.729127-1-kpsingh@kernel.org> <CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com>
In-Reply-To: <CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Mar 2022 18:18:01 +0100
X-Gmail-Original-Message-ID: <CACYkzJ547orpP-9qoq7vqtJSwxanW8FyVuhAdGVOtm8fgh3DuA@mail.gmail.com>
Message-ID: <CACYkzJ547orpP-9qoq7vqtJSwxanW8FyVuhAdGVOtm8fgh3DuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Allow vmtest.sh to build
 statically linked test_progs.
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 4, 2022 at 5:57 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Fri, Mar 4, 2022 at 8:48 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > Dynamic linking when compiling on the host can cause issues when the
> > libc version does not match the one in the VM image.
> > Allow the user to use static compilation when this issue arises:
> >
> > Before:
> >   ./vmtest.sh -- ./test_progs -t test_ima
> >   ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
> >
> > After:
> >
> >   TRUNNER_LDFLAGS=-static ./vmtest.sh -- ./test_progs -t test_ima
> >   test_ima:OK
> >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Not using static as the default as some distros may not have dependent
> > static libraries.
> >
> > Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile  | 4 ++--
> >  tools/testing/selftests/bpf/vmtest.sh | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index fe12b4f5fe20..2473c9b0cb2e 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -162,7 +162,7 @@ $(MAKE_DIRS):
> >
> >  $(OUTPUT)/%.o: %.c
> >         $(call msg,CC,,$@)
> > -       $(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> > +       $(Q)$(CC) $(CFLAGS) $(TRUNNER_LDFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> >
> >  $(OUTPUT)/%:%.c
> >         $(call msg,BINARY,,$@)
> > @@ -468,7 +468,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                   \
> >                              $(RESOLVE_BTFIDS)                          \
> >                              | $(TRUNNER_BINARY)-extras
> >         $$(call msg,BINARY,,$$@)
> > -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> > +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> >         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
> >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
> >
> > diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> > index e0bb04a97e10..a8bf6ceb3d06 100755
> > --- a/tools/testing/selftests/bpf/vmtest.sh
> > +++ b/tools/testing/selftests/bpf/vmtest.sh
> > @@ -155,7 +155,7 @@ update_selftests()
> >         local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
> >
> >         cd "${selftests_dir}"
> > -       ${make_command}
> > +       ${make_command} TRUNNER_LDFLAGS=-static
>
> In the commit message you mentioned we are not making it default for
> everyone, Yet here making it default?

I have already sent a v2, maybe you missed that

https://lore.kernel.org/bpf/20220304150708.729904-1-kpsingh@kernel.org/T/#u

after noticing my mistake

https://lore.kernel.org/bpf/CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com/T/#m1a3eedc831d8b27e5639b1d57e3af36a2b20f449

> Also, do we need to add a new TRUNNER_LDFLAGS ? Why not just LDFLAGS,
> we also use CFLAGS.  Thinking ahead if we want add ASAN support later,

Simple LDFLAGS and CFLAGS (not TRUNNER_*) did not work for me for some reason.

> maybe add a switch to vmtest.sh for choosing flavor to run would be
> better.

I am not sure if we want to add a switch for everything. But I don't
mind if folks think it would be useful.

>
>
> >
> >         # Mount the image and copy the selftests to the image.
> >         mount_image
> > --
> > 2.35.1.616.g0bdcbb4464-goog
> >
