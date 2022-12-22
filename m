Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D5653A00
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLVALe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVALd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:11:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5DF1659C
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:11:32 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so379773lfv.2
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UXvn22EVVouYXh2/dzDGQYlQVAy/+8RKN3c/JGHnGfc=;
        b=SHJz25b6f4pBBHmUcIkPe90K8C3BePdmoK61OwP0yl9tkNT+uUwhbK9zNA3VTiE7pV
         FDugsmzzam2BL4JiL7l/xVHNkTDRO0NdRUPpOIlY0xjhqSQE3Fg16Njhj5p/BP2Yy/RG
         8ZbXLvHvmwEYxOm0oO+vh8bn5paXEebpNqRQrcuyi9mB/MoFgfwsZt2qf/faArEU39ll
         hv7AA4HKFkavzEZjni9uFgFQLjBPzCum9MOvaTOQ0qcXT4SVPIqM7eRAtSic8RUhjvl3
         lg4OWMDAjx7uQeUDd4ITbSsHReejgaEJRuVltGFJncCzBqbzuffIcXXRFClc5phBq+j7
         Jcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXvn22EVVouYXh2/dzDGQYlQVAy/+8RKN3c/JGHnGfc=;
        b=QYxt8b6BN//rVSQP1oQJnXbpUijh8ltelhxnvzXQDIVn/nrvjU6aBqpIsFTE6GSSJS
         K1cIaQ0j/JzElYcwcRFU2hBe1rf6OOEccihxtPOT+mmgLuEHZzc0DUQ1fc/0u4JjBq/8
         cnho+P5+ehEmMUR902yUl056RNapgye3miG6+Uy1ArQEKp0i+NFlX1pgThD+siZfWC5n
         aqI791H0Du2akpeJQ3R3j7lVT9fwLFqdnw2ZSFWy25Ci8/zJ5/FKsKjws6sMxu9l/Adk
         D+nrjwrTfcwWelHBF+n/zugDfSKQoFBQlsCoAk71pDYEOuiMCK4wmdVJhGVLkM2umZ/d
         qG0A==
X-Gm-Message-State: AFqh2kr8cpJwJ2hf7mLjcJaVLd29UooRhwxwguCBAoxETFr9gjTwXnIa
        xOl8wpVedW6HZeYyqvvC/fk=
X-Google-Smtp-Source: AMrXdXvoOVDfAMKsLJTn62Qsg/nYK/KlLP0VStnVwGkUtkkFs80BdrCUkOvIC9bWKi0dmlj0/r38Aw==
X-Received: by 2002:a05:6512:3a8f:b0:4c8:5f19:ccb8 with SMTP id q15-20020a0565123a8f00b004c85f19ccb8mr1333488lfu.48.1671667890540;
        Wed, 21 Dec 2022 16:11:30 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o27-20020ac25e3b000000b004a27d2ea029sm1985420lfg.172.2022.12.21.16.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 16:11:30 -0800 (PST)
Message-ID: <8492d922b7b2d1829e286ed48e8b0b44974500e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: support for
 BPF_F_TEST_STATE_FREQ in test_loader
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Thu, 22 Dec 2022 02:11:29 +0200
In-Reply-To: <CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
         <20221217021711.172247-2-eddyz87@gmail.com>
         <CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com>
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

On Tue, 2022-12-20 at 13:03 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > Adds a macro __test_state_freq, the macro expands as a btf_decl_tag of =
a
> > special form that instructs test_loader that the flag BPF_F_TEST_STATE_=
FREQ
> > has to be passed to BPF verifier when program is loaded.
> >=20
>=20
> I needed similar capabilities locally, but I went a slightly different
> direction. Instead of defining custom macros and logic, I define just
> __flags(X) macro and then parse flags either by their symbolic name
> (or just integer value, which might be useful sometimes for
> development purposes). I've also added support for matching multiple
> messages sequentially which locally is in the same commit. Feel free
> to ignore that part, but I think it's useful as well. So WDYT about
> the below?

Makes total sense. I can replace my patch with your patch in the
patchset, or just wait until your changes land.

>=20
>=20
> commit 936bb5d21d717d54c85e74047e082ca3216a7a40
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Mon Dec 19 15:57:26 2022 -0800
>=20
>     selftests/bpf: support custom per-test flags and multiple expected me=
ssages
>=20
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> diff --git a/tools/testing/selftests/bpf/test_loader.c
> b/tools/testing/selftests/bpf/test_loader.c
> index 679efb3aa785..b0dab5dee38c 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -13,12 +13,15 @@
>  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
>  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
>  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
> +#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags=3D"
>=20
>  struct test_spec {
>      const char *name;
>      bool expect_failure;
> -    const char *expect_msg;
> +    const char **expect_msgs;
> +    size_t expect_msg_cnt;
>      int log_level;
> +    int prog_flags;
>  };
>=20
>  static int tester_init(struct test_loader *tester)
> @@ -67,7 +70,8 @@ static int parse_test_spec(struct test_loader *tester,
>=20
>      for (i =3D 1; i < btf__type_cnt(btf); i++) {
>          const struct btf_type *t;
> -        const char *s;
> +        const char *s, *val;
> +        char *e;
>=20
>          t =3D btf__type_by_id(btf, i);
>          if (!btf_is_decl_tag(t))
> @@ -82,14 +86,47 @@ static int parse_test_spec(struct test_loader *tester=
,
>          } else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) =3D=3D 0) {
>              spec->expect_failure =3D false;
>          } else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
> -            spec->expect_msg =3D s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1=
;
> +            void *tmp;
> +            const char **msg;
> +
> +            tmp =3D realloc(spec->expect_msgs, (1 +
> spec->expect_msg_cnt) * sizeof(void *));
> +            if (!tmp) {
> +                ASSERT_FAIL("failed to realloc memory for messages\n");
> +                return -ENOMEM;
> +            }
> +            spec->expect_msgs =3D tmp;
> +            msg =3D &spec->expect_msgs[spec->expect_msg_cnt++];
> +            *msg =3D s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
>          } else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
> +            val =3D s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
>              errno =3D 0;
> -            spec->log_level =3D strtol(s +
> sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1, NULL, 0);
> -            if (errno) {
> +            spec->log_level =3D strtol(val, &e, 0);
> +            if (errno || e[0] !=3D '\0') {
>                  ASSERT_FAIL("failed to parse test log level from '%s'", =
s);
>                  return -EINVAL;
>              }
> +        } else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
> +            val =3D s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
> +            if (strcmp(val, "BPF_F_STRICT_ALIGNMENT") =3D=3D 0) {
> +                spec->prog_flags |=3D BPF_F_STRICT_ALIGNMENT;
> +            } else if (strcmp(val, "BPF_F_ANY_ALIGNMENT") =3D=3D 0) {
> +                spec->prog_flags |=3D BPF_F_ANY_ALIGNMENT;
> +            } else if (strcmp(val, "BPF_F_TEST_RND_HI32") =3D=3D 0) {
> +                spec->prog_flags |=3D BPF_F_TEST_RND_HI32;
> +            } else if (strcmp(val, "BPF_F_TEST_STATE_FREQ") =3D=3D 0) {
> +                spec->prog_flags |=3D BPF_F_TEST_STATE_FREQ;
> +            } else if (strcmp(val, "BPF_F_SLEEPABLE") =3D=3D 0) {
> +                spec->prog_flags |=3D BPF_F_SLEEPABLE;
> +            } else if (strcmp(val, "BPF_F_XDP_HAS_FRAGS") =3D=3D 0) {
> +                spec->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> +            } else /* assume numeric value */ {
> +                errno =3D 0;
> +                spec->prog_flags |=3D strtol(val, &e, 0);
> +                if (errno || e[0] !=3D '\0') {
> +                    ASSERT_FAIL("failed to parse test prog flags from
> '%s'", s);
> +                    return -EINVAL;
> +                }
> +            }
>          }
>      }
>=20
> @@ -101,7 +138,7 @@ static void prepare_case(struct test_loader *tester,
>               struct bpf_object *obj,
>               struct bpf_program *prog)
>  {
> -    int min_log_level =3D 0;
> +    int min_log_level =3D 0, prog_flags;
>=20
>      if (env.verbosity > VERBOSE_NONE)
>          min_log_level =3D 1;
> @@ -119,7 +156,11 @@ static void prepare_case(struct test_loader *tester,
>      else
>          bpf_program__set_log_level(prog, spec->log_level);
>=20
> +    prog_flags =3D bpf_program__flags(prog);
> +    bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
> +
>      tester->log_buf[0] =3D '\0';
> +    tester->next_match_pos =3D 0;
>  }
>=20
>  static void emit_verifier_log(const char *log_buf, bool force)
> @@ -135,17 +176,26 @@ static void validate_case(struct test_loader *teste=
r,
>                struct bpf_program *prog,
>                int load_err)
>  {
> -    if (spec->expect_msg) {
> +    int i, j;
> +
> +    for (i =3D 0; i < spec->expect_msg_cnt; i++) {
>          char *match;
> +        const char *expect_msg;
> +
> +        expect_msg =3D spec->expect_msgs[i];
>=20
> -        match =3D strstr(tester->log_buf, spec->expect_msg);
> +        match =3D strstr(tester->log_buf + tester->next_match_pos, expec=
t_msg);
>          if (!ASSERT_OK_PTR(match, "expect_msg")) {
>              /* if we are in verbose mode, we've already emitted log */
>              if (env.verbosity =3D=3D VERBOSE_NONE)
>                  emit_verifier_log(tester->log_buf, true /*force*/);
> -            fprintf(stderr, "EXPECTED MSG: '%s'\n", spec->expect_msg);
> +            for (j =3D 0; j < i; j++)
> +                fprintf(stderr, "MATCHED  MSG: '%s'\n", spec->expect_msg=
s[j]);
> +            fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
>              return;
>          }
> +
> +        tester->next_match_pos =3D match - tester->log_buf + strlen(expe=
ct_msg);
>      }
>  }
>=20
> diff --git a/tools/testing/selftests/bpf/test_progs.h
> b/tools/testing/selftests/bpf/test_progs.h
> index 3f058dfadbaf..9af80704f20a 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -410,6 +410,7 @@ int write_sysctl(const char *sysctl, const char *valu=
e);
>  struct test_loader {
>      char *log_buf;
>      size_t log_buf_sz;
> +    size_t next_match_pos;
>=20
>      struct bpf_object *obj;
>  };
>=20
>=20
>=20
>=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/bpf_misc.h |  1 +
> >  tools/testing/selftests/bpf/test_loader.c    | 10 ++++++++++
> >  2 files changed, 11 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testi=
ng/selftests/bpf/progs/bpf_misc.h
> > index 4a01ea9113bf..a42363a3fef1 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > @@ -6,6 +6,7 @@
> >  #define __failure              __attribute__((btf_decl_tag("comment:te=
st_expect_failure")))
> >  #define __success              __attribute__((btf_decl_tag("comment:te=
st_expect_success")))
> >  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:te=
st_log_level=3D"#lvl)))
> > +#define __test_state_freq      __attribute__((btf_decl_tag("comment:te=
st_state_freq")))
> >=20
> >  #if defined(__TARGET_ARCH_x86)
> >  #define SYSCALL_WRAPPER 1
> > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/=
selftests/bpf/test_loader.c
> > index 679efb3aa785..ac8517a77161 100644
> > --- a/tools/testing/selftests/bpf/test_loader.c
> > +++ b/tools/testing/selftests/bpf/test_loader.c
> > @@ -11,6 +11,7 @@
> >=20
> >  #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
> >  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
> > +#define TEST_TAG_TEST_STATE_FREQ "comment:test_state_freq"
> >  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
> >  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
> >=20
> > @@ -19,6 +20,7 @@ struct test_spec {
> >         bool expect_failure;
> >         const char *expect_msg;
> >         int log_level;
> > +       bool test_state_freq;
> >  };
> >=20
> >  static int tester_init(struct test_loader *tester)
> > @@ -81,6 +83,8 @@ static int parse_test_spec(struct test_loader *tester=
,
> >                         spec->expect_failure =3D true;
> >                 } else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) =3D=3D 0)=
 {
> >                         spec->expect_failure =3D false;
> > +               } else if (strcmp(s, TEST_TAG_TEST_STATE_FREQ) =3D=3D 0=
) {
> > +                       spec->test_state_freq =3D true;
> >                 } else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
> >                         spec->expect_msg =3D s + sizeof(TEST_TAG_EXPECT=
_MSG_PFX) - 1;
> >                 } else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
> > @@ -102,6 +106,7 @@ static void prepare_case(struct test_loader *tester=
,
> >                          struct bpf_program *prog)
> >  {
> >         int min_log_level =3D 0;
> > +       __u32 flags =3D 0;
> >=20
> >         if (env.verbosity > VERBOSE_NONE)
> >                 min_log_level =3D 1;
> > @@ -120,6 +125,11 @@ static void prepare_case(struct test_loader *teste=
r,
> >                 bpf_program__set_log_level(prog, spec->log_level);
> >=20
> >         tester->log_buf[0] =3D '\0';
> > +
> > +       if (spec->test_state_freq)
> > +               flags |=3D BPF_F_TEST_STATE_FREQ;
> > +
> > +       bpf_program__set_flags(prog, flags);
>=20
> see my example above, it's safer to fetch current prog flags to not
> override stuff like BPF_F_SLEEPABLE
>=20
> >  }
> >=20
> >  static void emit_verifier_log(const char *log_buf, bool force)
> > --
> > 2.38.2
> >=20

