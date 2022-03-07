Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9C4CFFAD
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 14:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiCGNLs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 08:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCGNLs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 08:11:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17D6E54F
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 05:10:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC5D611E6
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 13:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A558C36AE2
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646658653;
        bh=fCInmiuvlc/GQdKOrA2zZo3Bi20L9F6QJcn0+RVCAiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIf5sIiBy2gGYb9/yhohwJ3t7ysj/+O/6V2mgdX0dllBjKZKcK/3kIxV0bZy33shm
         QJMe3yhvnNG23dx9mve7th7TdUjzMr/ShojO46oEYW/I6Dk9a8GJngL+v1NOv2yU2I
         Pt/Evjp94cM4mDAMxGFP/agvJNiIs558PS5gFvZBKqb6dcp9lRflnhl4QBt+qYJ3UA
         RrJAITZZtsH56fi4wPO6N/Mbkkx6Ya8rsjWKV9bztUfxIAb587yL0YmqWmeV3OJujV
         s6nGIgJNTYrMGjQO3+Ct0DVXUtZZJ5c+KZY915+7CUbCDZ8oW117+KD9H1YkxuXA/j
         Ssh4pH0S5P+bA==
Received: by mail-ej1-f45.google.com with SMTP id dr20so31760721ejc.6
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 05:10:53 -0800 (PST)
X-Gm-Message-State: AOAM5321SnldlTILV/Sn+cdz8YASB0Gpv9KhCQUovK+Aal+JiZz8Dfoh
        dpJg756vkvWsNMUkWEbP/JvTdfDTRwv+SzJhBL3R3g==
X-Google-Smtp-Source: ABdhPJzIYeKSoVRpZIOmRbz2rLVRFbAjEmzy4/bKOWzDhUnEUHbTPKAwd0X55sDOq2ux4CoXTgJfbSa7wHtSa03AP5k=
X-Received: by 2002:a17:906:a1c8:b0:6da:a635:e402 with SMTP id
 bx8-20020a170906a1c800b006daa635e402mr9412960ejb.598.1646658649659; Mon, 07
 Mar 2022 05:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20220304150402.729127-1-kpsingh@kernel.org> <CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com>
 <CACYkzJ547orpP-9qoq7vqtJSwxanW8FyVuhAdGVOtm8fgh3DuA@mail.gmail.com> <CAEf4BzaUp_i_K4ieyac0_Z620RXyrmWcvjKny37qT9qK6=Dvfg@mail.gmail.com>
In-Reply-To: <CAEf4BzaUp_i_K4ieyac0_Z620RXyrmWcvjKny37qT9qK6=Dvfg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 7 Mar 2022 14:10:38 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7cme-Dxo6dGS1RwPZFVq5=sdqWmkRtmYbA5JoavoFoQw@mail.gmail.com>
Message-ID: <CACYkzJ7cme-Dxo6dGS1RwPZFVq5=sdqWmkRtmYbA5JoavoFoQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Allow vmtest.sh to build
 statically linked test_progs.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "sunyucong@gmail.com" <sunyucong@gmail.com>,
        bpf <bpf@vger.kernel.org>, "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 5, 2022 at 1:38 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 4, 2022 at 9:18 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Fri, Mar 4, 2022 at 5:57 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> > >
> > > On Fri, Mar 4, 2022 at 8:48 AM KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > Dynamic linking when compiling on the host can cause issues when the
> > > > libc version does not match the one in the VM image.
> > > > Allow the user to use static compilation when this issue arises:
> > > >
> > > > Before:
> > > >   ./vmtest.sh -- ./test_progs -t test_ima
> > > >   ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
> > > >
> > > > After:
> > > >
> > > >   TRUNNER_LDFLAGS=-static ./vmtest.sh -- ./test_progs -t test_ima
> > > >   test_ima:OK
> > > >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > > Not using static as the default as some distros may not have dependent
> > > > static libraries.
> > > >
> > > > Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  tools/testing/selftests/bpf/Makefile  | 4 ++--
> > > >  tools/testing/selftests/bpf/vmtest.sh | 2 +-
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > > index fe12b4f5fe20..2473c9b0cb2e 100644
> > > > --- a/tools/testing/selftests/bpf/Makefile
> > > > +++ b/tools/testing/selftests/bpf/Makefile
> > > > @@ -162,7 +162,7 @@ $(MAKE_DIRS):
> > > >
> > > >  $(OUTPUT)/%.o: %.c
> > > >         $(call msg,CC,,$@)
> > > > -       $(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> > > > +       $(Q)$(CC) $(CFLAGS) $(TRUNNER_LDFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> > > >
> > > >  $(OUTPUT)/%:%.c
> > > >         $(call msg,BINARY,,$@)
> > > > @@ -468,7 +468,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                   \
> > > >                              $(RESOLVE_BTFIDS)                          \
> > > >                              | $(TRUNNER_BINARY)-extras
> > > >         $$(call msg,BINARY,,$$@)
> > > > -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> > > > +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> > > >         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
> > > >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> > > > index e0bb04a97e10..a8bf6ceb3d06 100755
> > > > --- a/tools/testing/selftests/bpf/vmtest.sh
> > > > +++ b/tools/testing/selftests/bpf/vmtest.sh
> > > > @@ -155,7 +155,7 @@ update_selftests()
> > > >         local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
> > > >
> > > >         cd "${selftests_dir}"
> > > > -       ${make_command}
> > > > +       ${make_command} TRUNNER_LDFLAGS=-static
> > >
> > > In the commit message you mentioned we are not making it default for
> > > everyone, Yet here making it default?
> >
> > I have already sent a v2, maybe you missed that
> >
> > https://lore.kernel.org/bpf/20220304150708.729904-1-kpsingh@kernel.org/T/#u
> >
> > after noticing my mistake
> >
> > https://lore.kernel.org/bpf/CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com/T/#m1a3eedc831d8b27e5639b1d57e3af36a2b20f449
> >
> > > Also, do we need to add a new TRUNNER_LDFLAGS ? Why not just LDFLAGS,
> > > we also use CFLAGS.  Thinking ahead if we want add ASAN support later,
> >
> > Simple LDFLAGS and CFLAGS (not TRUNNER_*) did not work for me for some reason.
>
> I think LDFLAGS are not wired properly everywhere. But have you tried
>
> LDLIBS=-static ./vmtest.sh ?

LDLIBS=-static ./vmtest.sh -j 72 -- ./test_progs -t test_ima

works for me. Sending a docs patch instead.

>
> In my case I can't get libcap.a to be installed in my system, so
> compilation never completely succeeds, but I think it should get you
> what you want
>
> >
> > > maybe add a switch to vmtest.sh for choosing flavor to run would be
> > > better.
> >
> > I am not sure if we want to add a switch for everything. But I don't
> > mind if folks think it would be useful.
> >
> > >
> > >
> > > >
> > > >         # Mount the image and copy the selftests to the image.
> > > >         mount_image
> > > > --
> > > > 2.35.1.616.g0bdcbb4464-goog
> > > >
