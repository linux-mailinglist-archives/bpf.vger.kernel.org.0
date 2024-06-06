Return-Path: <bpf+bounces-31527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC58FF40A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9027B21F6C
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEE1991DA;
	Thu,  6 Jun 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlf66wzx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AA15253E
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696086; cv=none; b=OauN3Aj/YJa5fq+54+ykJhS26nEm7ciSQRexZQ5aJrBg9bQu4vbvAFHedHZZRW5b11zzkynbY+LEjohRFSR47z4Hre6itv9R0LYADIFbA+X6UOASiC8Cd7uMKJVfX16TGHokf6Vmo3JbukMbsX2VDbdOS5RGpoVYNvJ39mZrXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696086; c=relaxed/simple;
	bh=AMv03q2XlSXYgpPfMutx0F+InpT4oPd5yvXpK6s5MB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+YeCdtgNxneOoOJFqb6qIWrR5/I6K6AsS0EJU2Cg83PwQ/AN1xPn1xHPeawmoHBYOPn6giMOfB5jl/gu0sgbYZ4P9NE+4w5uWtSw/OpuHvQHkplRcp4g1BCe0Vgbahk4XMH38fsk3JFhj1Pw3lHJD/nIB/K7p+eZDkCQzTIfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlf66wzx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2865e2a68so971272a91.1
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717696083; x=1718300883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEQ/kMABWOs2iNJ/xVEP33wLuE2mhrpyIWqR9Vk3MXg=;
        b=Jlf66wzxo4nzLcn/bdiiZJ4QU9S4FGGnSnHbd+ctNvhrtcixxEs/qCFxy2lmHhlALr
         9tiWJc3P52y/eCDnHuv9uBmKKyCnZGbgKMm3dTvwoyIwQkE0M7lZS0RZ4abcCNKdXbOI
         9gxx/YMPWmHM3TPgcdICrwsGfdmDp8TAFdZp1zGayEBFy6ryvYGH7NfBqzbOXwNVIKKi
         XoX3nm9LKLUy0/fFzBabq8ksCm1aP8nsFThVL2HiMR351bgWdB5q5ZbzWppMVUqX9KQa
         B9ioUBe6ZA3pBBGks06TcBjublJQAij+hkDlCR27vy/N72Cb8E+3vX4RrxlLu20re0iv
         QA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717696083; x=1718300883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEQ/kMABWOs2iNJ/xVEP33wLuE2mhrpyIWqR9Vk3MXg=;
        b=ft9LyJPeoHO8ZlzT79hxvtZn0vVEiNeJYOe4NAZceitdkj0IYXWIckRzEKsQ0tWFPL
         QQue1SaiK7SlqOAW8bG1PbUGXMqje1fKJefeBL/CJSqCIBG6Uwv+68/Q6XogHqil/Srq
         jf92hPfQGoy0TPPW7nq5G6qkrTLzvtUPxVDxImiajMwdSNbBwmVMJ/o9ZPtOYkJ9Pe3N
         jb14UigtDy4qKyaerCyb8bjAzLut0BgSPxIxc6bl5sSgyoZjZ22q1eVBV2m4YeXUk5H+
         Ylt6X8TSc9w5Sln7WPw4WkVRoRTVt/aft+rxDuaz1J6QZMyT0SrddTxiXrTFHNwQUlrd
         GsyA==
X-Gm-Message-State: AOJu0YxdJvRQtAI1gCXpxbn1jIPfKC8TNLVwTTEjuA5nOba3XyXXuvfc
	Gl2DnEmtiGZbPapGzvna9YR1nDgwYXyf7i+4gYogCgc6xMzUKOnW+wLAFxiMH475xICdgtBp8Od
	basMNwKnlOahtSRysn2ndGFJ6g9A=
X-Google-Smtp-Source: AGHT+IHZD0Xa60TpZkzbxAxWAOIdMTtZiqcCUqhNHZz6jlVekkVpe9Y7QpCG2cu4ee/owBP+0/t7E4Ht04boHJA/vAo=
X-Received: by 2002:a17:90a:742:b0:2c2:3b32:a1b8 with SMTP id
 98e67ed59e1d1-2c2bcac9f74mr246830a91.17.1717696083502; Thu, 06 Jun 2024
 10:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606133032.265403-1-cupertino.miranda@oracle.com> <20240606133032.265403-2-cupertino.miranda@oracle.com>
In-Reply-To: <20240606133032.265403-2-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 10:47:51 -0700
Message-ID: <CAEf4BzbQORdeSyoh_sFbgpV-LB=in14uAKKfdQze6+wHQHN+uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Support checks against a
 regular expression.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:30=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Add support for __regex and __regex_unpriv macros to check the test
> execution output against a regular expression. This is similar to __msg
> and __msg_unpriv, however those expect full text matching.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
>  tools/testing/selftests/bpf/test_loader.c    | 143 +++++++++++++++----
>  2 files changed, 121 insertions(+), 33 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index fb2f5513e29e..c0280bd2f340 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -7,9 +7,9 @@
>   *
>   * The test_loader sequentially loads each program in a skeleton.
>   * Programs could be loaded in privileged and unprivileged modes.
> - * - __success, __failure, __msg imply privileged mode;
> - * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
> - *   unprivileged mode.
> + * - __success, __failure, __msg, __regex imply privileged mode;
> + * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
> + *   imply unprivileged mode.
>   * If combination of privileged and unprivileged attributes is present
>   * both modes are used. If none are present privileged mode is implied.
>   *
> @@ -24,6 +24,9 @@
>   *                   Multiple __msg attributes could be specified.
>   * __msg_unpriv      Same as __msg but for unprivileged mode.
>   *
> + * __regex           Same as __msg, but using a regular expression.
> + * __regex_unpriv    Same as __msg_unpriv but using a regular expression=
.
> + *
>   * __success         Expect program load success in privileged mode.
>   * __success_unpriv  Expect program load success in unprivileged mode.
>   *
> @@ -59,10 +62,12 @@
>   * __auxiliary_unpriv  Same, but load program in unprivileged mode.
>   */
>  #define __msg(msg)             __attribute__((btf_decl_tag("comment:test=
_expect_msg=3D" msg)))
> +#define __regex(regex)         __attribute__((btf_decl_tag("comment:test=
_expect_regex=3D" regex)))
>  #define __failure              __attribute__((btf_decl_tag("comment:test=
_expect_failure")))
>  #define __success              __attribute__((btf_decl_tag("comment:test=
_expect_success")))
>  #define __description(desc)    __attribute__((btf_decl_tag("comment:test=
_description=3D" desc)))
>  #define __msg_unpriv(msg)      __attribute__((btf_decl_tag("comment:test=
_expect_msg_unpriv=3D" msg)))
> +#define __regex_unpriv(regex)  __attribute__((btf_decl_tag("comment:test=
_expect_regex_unpriv=3D" regex)))
>  #define __failure_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_failure_unpriv")))
>  #define __success_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_success_unpriv")))
>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test=
_log_level=3D"#lvl)))
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 524c38e9cde4..a9a7f5f55855 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>  #include <linux/capability.h>
>  #include <stdlib.h>
> +#include <regex.h>
>  #include <test_progs.h>
>  #include <bpf/btf.h>
>
> @@ -17,9 +18,11 @@
>  #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
>  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
>  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
> +#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex=3D"
>  #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpr=
iv"
>  #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpr=
iv"
>  #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv=
=3D"
> +#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpr=
iv=3D"
>  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
>  #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags=3D"
>  #define TEST_TAG_DESCRIPTION_PFX "comment:test_description=3D"
> @@ -46,10 +49,26 @@ enum mode {
>         UNPRIV =3D 2
>  };
>
> +enum message_type {
> +       SUBSTRING =3D 0,
> +       REGEX
> +};
> +struct expect_msg {
> +       union {
> +               const char *substring;
> +               struct {
> +                       const char *expr;
> +                       regex_t regex;
> +                       bool failed_to_compile;

you are not even using this field

> +               } regex;
> +       };
> +       enum message_type type;

I think this is an overkill. We are unlikely to have third type of
"match message" spec, so let's do just simple:

struct expect_msg {
    const char *substr; /* substring match */

    const char *regex_str; /* regex-based match */
    regex_t regex;
};

No unions, no nesting. substr is NULL for regex, otherwise regex_str
is NULL (for substring case). Simple.


> +};
> +
>  struct test_subspec {
>         char *name;
>         bool expect_failure;
> -       const char **expect_msgs;
> +       struct expect_msg *expect_msg;

it's still messages (plural), why renaming the field?

>         size_t expect_msg_cnt;
>         int retval;
>         bool execute;
> @@ -89,28 +108,58 @@ void test_loader_fini(struct test_loader *tester)
>
>  static void free_test_spec(struct test_spec *spec)
>  {
> +       int i;
> +
> +       /* Delalocate regex from expect_msg array. */

typo: deallocate

> +       for (i =3D 0; i < spec->priv.expect_msg_cnt; i++)
> +               if (spec->priv.expect_msg[i].type =3D=3D REGEX)
> +                       regfree(&spec->priv.expect_msg[i].regex.regex);

and then:

if (spec->priv.expect_msg[i].regex_str)
    regfree(...);


Also, where is unpriv handling?

> +
>         free(spec->priv.name);
>         free(spec->unpriv.name);
> -       free(spec->priv.expect_msgs);
> -       free(spec->unpriv.expect_msgs);
> +       free(spec->priv.expect_msg);
> +       free(spec->unpriv.expect_msg);
>
>         spec->priv.name =3D NULL;
>         spec->unpriv.name =3D NULL;
> -       spec->priv.expect_msgs =3D NULL;
> -       spec->unpriv.expect_msgs =3D NULL;
> +       spec->priv.expect_msg =3D NULL;
> +       spec->unpriv.expect_msg =3D NULL;
>  }
>
> -static int push_msg(const char *msg, struct test_subspec *subspec)
> +static int push_msg(const char *match, enum message_type msg_type, struc=
t test_subspec *subspec)

here we can just pass two mutually exclusive strings to specify what case i=
t is:

static int push_msg(const char *substr, const char *regex_str, struct
test_subspec *subspec)

>  {
>         void *tmp;
> +       int regcomp_res;
> +       char error_msg[100];
> +       struct expect_msg *em;

we don't need both tmp and em, let's keep just

struct expect_msg *msg;

>
> -       tmp =3D realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cn=
t) * sizeof(void *));
> +       tmp =3D realloc(subspec->expect_msg,
> +                     (1 + subspec->expect_msg_cnt) * sizeof(struct expec=
t_msg));

then `msg =3D realloc(..)` here

>         if (!tmp) {
>                 ASSERT_FAIL("failed to realloc memory for messages\n");
>                 return -ENOMEM;
>         }
> -       subspec->expect_msgs =3D tmp;
> -       subspec->expect_msgs[subspec->expect_msg_cnt++] =3D msg;
> +       subspec->expect_msg =3D tmp;
> +       em =3D &subspec->expect_msg[subspec->expect_msg_cnt];

and reuse msg =3D &subspec->... here after assigning `subspec->expected_msg=
 =3D msg`

> +       subspec->expect_msg_cnt +=3D 1;
> +
> +       em->type =3D msg_type;
> +       switch (msg_type) {
> +       case SUBSTRING:
> +               em->substring =3D match;
> +               break;
> +       case REGEX:
> +               em->regex.expr =3D match;
> +               regcomp_res =3D regcomp(&em->regex.regex, match, REG_EXTE=
NDED|REG_NEWLINE);
> +               if (regcomp_res !=3D 0) {
> +                       regerror(regcomp_res, &em->regex.regex, error_msg=
, 100);
> +                       fprintf(stderr, "Regexp compilation error in '%s'=
: '%s'\n",
> +                               match, error_msg);
> +                       ASSERT_FAIL("failed to compile regex\n");
> +                       return -EINVAL;
> +               }
> +               break;
> +       }

and then

if (substr) {
    msg->substr =3D substr;
} else {
    char err_msg[100];
    int err;

    err =3D regcomp(...);
    if (err) {
        ...
    }
}

Note I moved err_msg/err closer to the only place where they are being
used (and kept names less verbose).

>
>         return 0;
>  }
> @@ -233,13 +282,25 @@ static int parse_test_spec(struct test_loader *test=
er,
>                         spec->mode_mask |=3D UNPRIV;
>                 } else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
>                         msg =3D s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
> -                       err =3D push_msg(msg, &spec->priv);
> +                       err =3D push_msg(msg, SUBSTRING, &spec->priv);
>                         if (err)
>                                 goto cleanup;
>                         spec->mode_mask |=3D PRIV;
>                 } else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)=
) {
>                         msg =3D s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV=
) - 1;
> -                       err =3D push_msg(msg, &spec->unpriv);
> +                       err =3D push_msg(msg, SUBSTRING, &spec->unpriv);
> +                       if (err)
> +                               goto cleanup;
> +                       spec->mode_mask |=3D UNPRIV;
> +               } else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
> +                       msg =3D s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1=
;
> +                       err =3D push_msg(msg, REGEX, &spec->priv);
> +                       if (err)
> +                               goto cleanup;
> +                       spec->mode_mask |=3D PRIV;
> +               } else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRI=
V)) {
> +                       msg =3D s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPR=
IV) - 1;
> +                       err =3D push_msg(msg, REGEX, &spec->unpriv);
>                         if (err)
>                                 goto cleanup;
>                         spec->mode_mask |=3D UNPRIV;
> @@ -336,16 +397,16 @@ static int parse_test_spec(struct test_loader *test=
er,
>                         spec->unpriv.execute =3D spec->priv.execute;
>                 }
>
> -               if (!spec->unpriv.expect_msgs) {
> -                       size_t sz =3D spec->priv.expect_msg_cnt * sizeof(=
void *);
> +               if (!spec->unpriv.expect_msg) {
> +                       size_t sz =3D spec->priv.expect_msg_cnt * sizeof(=
struct expect_msg);
>
> -                       spec->unpriv.expect_msgs =3D malloc(sz);
> -                       if (!spec->unpriv.expect_msgs) {
> -                               PRINT_FAIL("failed to allocate memory for=
 unpriv.expect_msgs\n");
> +                       spec->unpriv.expect_msg =3D malloc(sz);
> +                       if (!spec->unpriv.expect_msg) {
> +                               PRINT_FAIL("failed to allocate memory for=
 unpriv.expect\n");
>                                 err =3D -ENOMEM;
>                                 goto cleanup;
>                         }
> -                       memcpy(spec->unpriv.expect_msgs, spec->priv.expec=
t_msgs, sz);
> +                       memcpy(spec->unpriv.expect_msg, spec->priv.expect=
_msg, sz);

hmm.. this is problematic given regcomp() and regfree(). We don't know
what sort of internal state libc will maintain in regex_t, so it's
unsafe to just memcpy() priv into unpriv like this. We probably need
to refactor this into an explicit push_msg() calls for spec->unpriv,
which is, luckily, trivial to do.

>                         spec->unpriv.expect_msg_cnt =3D spec->priv.expect=
_msg_cnt;
>                 }
>         }
> @@ -402,27 +463,49 @@ static void validate_case(struct test_loader *teste=
r,
>                           struct bpf_program *prog,
>                           int load_err)
>  {
> -       int i, j;
> +       int i, j, reg_error;

"err" is totally fine, no need to be so verbose here


> +       char *match;
> +       regmatch_t reg_match[1];
>
>         for (i =3D 0; i < subspec->expect_msg_cnt; i++) {
> -               char *match;
> -               const char *expect_msg;
> -
> -               expect_msg =3D subspec->expect_msgs[i];
> +               struct expect_msg *em =3D &subspec->expect_msg[i];

msg to say consistent?

> +
> +               match =3D NULL;
> +               switch (em->type) {
> +               case SUBSTRING:
> +                       match =3D strstr(tester->log_buf + tester->next_m=
atch_pos, em->substring);
> +                       tester->next_match_pos =3D match - tester->log_bu=
f + strlen(em->substring);

match will be NULL if strstr() doesn't find substring

> +                       break;
> +               case REGEX:
> +                       reg_error =3D regexec(&em->regex.regex,
> +                                           tester->log_buf + tester->nex=
t_match_pos,
> +                                           1, reg_match, 0);
> +                       if (reg_error =3D=3D 0)
> +                               match =3D tester->log_buf + tester->next_=
match_pos + reg_match[0].rm_so;
> +                       tester->next_match_pos +=3D reg_match[0].rm_eo;

Similarly, if we didn't find a match, we should not update position

> +                       break;
> +               }
>
> -               match =3D strstr(tester->log_buf + tester->next_match_pos=
, expect_msg);
>                 if (!ASSERT_OK_PTR(match, "expect_msg")) {
> -                       /* if we are in verbose mode, we've already emitt=
ed log */
>                         if (env.verbosity =3D=3D VERBOSE_NONE)
>                                 emit_verifier_log(tester->log_buf, true /=
*force*/);
> -                       for (j =3D 0; j < i; j++)
> -                               fprintf(stderr,
> -                                       "MATCHED  MSG: '%s'\n", subspec->=
expect_msgs[j]);
> -                       fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_ms=
g);
> +                       for (j =3D 0; j <=3D i; j++) {
> +                               const char *header =3D (j < i) ? "MATCHED=
" : "EXPECTED";
> +                               struct expect_msg *tmp =3D &subspec->expe=
ct_msg[j];

reuse msg variable?

> +
> +                               switch (tmp->type) {
> +                               case SUBSTRING:
> +                                       fprintf(stderr,
> +                                               "%s  MSG: '%s'\n", header=
, tmp->substring);
> +                                       break;
> +                               case REGEX:
> +                                       fprintf(stderr,
> +                                               "%s  REGEX: '%s'\n", head=
er, tmp->regex.expr);
> +                                       break;
> +                               }

it's probably better to have just one fprintf handling everything, it
will be easier to follow

fprintf(stderr, "%s %s: '%s'\n",
        j < i ? "MATCHED " : "EXPECTED",
        msg->substr ? "SUBSTR" : " REGEX",
        msg->substr ?: msg->regex_str);


(note spaces for alignment)


pw-bot: cr

> +                       }
>                         return;
>                 }
> -
> -               tester->next_match_pos =3D match - tester->log_buf + strl=
en(expect_msg);
>         }
>  }
>
> --
> 2.39.2
>

