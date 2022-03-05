Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A464CE1AA
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 01:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiCEAjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 19:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCEAjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 19:39:23 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824231909
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 16:38:35 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id c4so5118991vkq.9
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjvwoFkyovSKdpvjEdY14Nzx1HldOoC/H67jv63zs/k=;
        b=cG25T5JWQL8vNV/4/LySTymMg8/8J6QleEB3tihVz1/RW3TcOK8Fkp/CPpZIHuwb2s
         nWUI+N9WNdlaTESV9zMhB2gw/yBqYyYQASkeD6wu5AE8A6XcRhJ8NZU69UbMDe4B9iQ0
         6gJy9vFUvj58OFJ+pJAfzS4fKX6Psyuc1fQPWXw5KjZmhEWPmHiHVo6OMi1aKKXXwdxG
         8L1yC70AciernjZeb/Nb90ajoAyMqdQtdvI9hTkZqnbwWMULNcsMtIBFLeDv3N3HZXJx
         c2DnOL04MjfF2xYDOwGB07EXGL5Z1xVBOgbN0vsCY2K9yfvGlcgUR8Pgh6D0WLwkHCDm
         U3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjvwoFkyovSKdpvjEdY14Nzx1HldOoC/H67jv63zs/k=;
        b=WiTsNEfq0m88NgIr5F5vcuLi1KKMAQ+AIHThrJNZDKwr5pP1qlIFgTlfs1q9g0ZKp+
         7mmlU3r+EjNEFZXuN/oikUR5h3qM04tWkB5VWS2w/a8nhbxMkuVr0mdfJvGGxvAR4gfH
         Hw+QL6Detu0ipHDba7e5IPder576YAQIXpOEiDUOsp85kF6ltdVf9sXJsPsx8/MpBJ+q
         VrXdfeLvmHRVTLo2ObNwAG2/h1sKxamcsm75V9d3z6zHHPVwb99aTfIxx4/dH5ZegdHh
         f/muBN8ShZKY2sLQX5LZXuqsmkwz8xEzhwwevDR3NngGCanCUjseN1n9SJrOhYxdfaSX
         Gqng==
X-Gm-Message-State: AOAM532BmkT5dTU3WP44STf8SGXqy5fjiv5wprulnZPLGEPjECWW/mKW
        3bfVeti+qO766W3CMNCKEx83gOy80pWTn9hKhnQ=
X-Google-Smtp-Source: ABdhPJwuLjid17qmuGRqxwBkKs+lkBMAErGO+DW7xgjqvHNXyRqKrTMF7OFQMY5PbmNyOyn9z2hHBw6qBvu7Z2RDBEw=
X-Received: by 2002:a1f:cb85:0:b0:336:563b:7dd4 with SMTP id
 b127-20020a1fcb85000000b00336563b7dd4mr514431vkg.36.1646440714161; Fri, 04
 Mar 2022 16:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20220304150402.729127-1-kpsingh@kernel.org> <CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com>
 <CACYkzJ547orpP-9qoq7vqtJSwxanW8FyVuhAdGVOtm8fgh3DuA@mail.gmail.com>
In-Reply-To: <CACYkzJ547orpP-9qoq7vqtJSwxanW8FyVuhAdGVOtm8fgh3DuA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Mar 2022 16:38:23 -0800
Message-ID: <CAEf4BzaUp_i_K4ieyac0_Z620RXyrmWcvjKny37qT9qK6=Dvfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Allow vmtest.sh to build
 statically linked test_progs.
To:     KP Singh <kpsingh@kernel.org>
Cc:     "sunyucong@gmail.com" <sunyucong@gmail.com>,
        bpf <bpf@vger.kernel.org>, "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 4, 2022 at 9:18 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Mar 4, 2022 at 5:57 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> >
> > On Fri, Mar 4, 2022 at 8:48 AM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > Dynamic linking when compiling on the host can cause issues when the
> > > libc version does not match the one in the VM image.
> > > Allow the user to use static compilation when this issue arises:
> > >
> > > Before:
> > >   ./vmtest.sh -- ./test_progs -t test_ima
> > >   ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
> > >
> > > After:
> > >
> > >   TRUNNER_LDFLAGS=-static ./vmtest.sh -- ./test_progs -t test_ima
> > >   test_ima:OK
> > >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Not using static as the default as some distros may not have dependent
> > > static libraries.
> > >
> > > Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile  | 4 ++--
> > >  tools/testing/selftests/bpf/vmtest.sh | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index fe12b4f5fe20..2473c9b0cb2e 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -162,7 +162,7 @@ $(MAKE_DIRS):
> > >
> > >  $(OUTPUT)/%.o: %.c
> > >         $(call msg,CC,,$@)
> > > -       $(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> > > +       $(Q)$(CC) $(CFLAGS) $(TRUNNER_LDFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> > >
> > >  $(OUTPUT)/%:%.c
> > >         $(call msg,BINARY,,$@)
> > > @@ -468,7 +468,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                   \
> > >                              $(RESOLVE_BTFIDS)                          \
> > >                              | $(TRUNNER_BINARY)-extras
> > >         $$(call msg,BINARY,,$$@)
> > > -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> > > +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> > >         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
> > >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
> > >
> > > diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> > > index e0bb04a97e10..a8bf6ceb3d06 100755
> > > --- a/tools/testing/selftests/bpf/vmtest.sh
> > > +++ b/tools/testing/selftests/bpf/vmtest.sh
> > > @@ -155,7 +155,7 @@ update_selftests()
> > >         local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
> > >
> > >         cd "${selftests_dir}"
> > > -       ${make_command}
> > > +       ${make_command} TRUNNER_LDFLAGS=-static
> >
> > In the commit message you mentioned we are not making it default for
> > everyone, Yet here making it default?
>
> I have already sent a v2, maybe you missed that
>
> https://lore.kernel.org/bpf/20220304150708.729904-1-kpsingh@kernel.org/T/#u
>
> after noticing my mistake
>
> https://lore.kernel.org/bpf/CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com/T/#m1a3eedc831d8b27e5639b1d57e3af36a2b20f449
>
> > Also, do we need to add a new TRUNNER_LDFLAGS ? Why not just LDFLAGS,
> > we also use CFLAGS.  Thinking ahead if we want add ASAN support later,
>
> Simple LDFLAGS and CFLAGS (not TRUNNER_*) did not work for me for some reason.

I think LDFLAGS are not wired properly everywhere. But have you tried

LDLIBS=-static ./vmtest.sh ?

In my case I can't get libcap.a to be installed in my system, so
compilation never completely succeeds, but I think it should get you
what you want

>
> > maybe add a switch to vmtest.sh for choosing flavor to run would be
> > better.
>
> I am not sure if we want to add a switch for everything. But I don't
> mind if folks think it would be useful.
>
> >
> >
> > >
> > >         # Mount the image and copy the selftests to the image.
> > >         mount_image
> > > --
> > > 2.35.1.616.g0bdcbb4464-goog
> > >
