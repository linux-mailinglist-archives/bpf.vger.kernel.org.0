Return-Path: <bpf+bounces-31366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD48FBB60
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B6B1C226FB
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97927149DED;
	Tue,  4 Jun 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUTFer+h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20F12E1CE
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524993; cv=none; b=MYI86LrUtX5oZNDt8kJ0Rma1UqBW7tFZji90H3I+xixCXDg5ZhCdHQCNbefXfRuGSiY+B+BN9Lj44IW7pI22K+RK5mBU7CgPZUzv2DrmNyuiiN/uvwXdPG0RGJ4nmYqN2udjB6kX3fSXPOmkoHVHE2hUJlCd9dJmiBGkeRlj06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524993; c=relaxed/simple;
	bh=n64DU2OCi+IE4UHjy95QNo6uN2dTf8ymLkx8CqKhXdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmYWjQ2KhEOf1oxyMdkLwN5DSHpEKQyHYFx9cQLPTQC84AdbzOQ8EBCYf9Vf03U6MQiJIVCd9f+/fi/9WeGOwws9vmRpF6oaw/LJG4rDSb14pC4yudxMhBuXRL3Z4LVdWvjoIzq+jRQtrrVagOu1TzZr5KqrIF1D6cIx9fDYTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUTFer+h; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c24115469bso81331a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717524991; x=1718129791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K49Klm7iIz0biN2bctJExjLvOUoR/lEbMdUCiIAjR8g=;
        b=HUTFer+hg3Z7ATk+QKUCieLT+5mNzl7HzWTODQ9GvbrXlAwEeEPPsf/hwDj49QOaeC
         wQnUC/CVOkNO+Za1qd11fnf07vwiizoDOuomNsiMThQrjZi4R1KPgISToDxSe9C8IjUS
         YQaHwKClmRXq0l1+fZoFjU6HdYY3JpSMLsOlEyznb722inPnUqEqHZWZKxMGCHRykvci
         2MjJoQhxvep7wa9m/Z0t2vHBDrDsHmp/KcqebJM5x9qzy7E7Y6EqcTZRCfaRqsOAgg7x
         LyAlmVr5xREutRelgWOyzxKNw1j9bPIqL8tu/nCxbQu0GNi2VR/NMyzvwJh/uvt2tqkV
         Ojqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524991; x=1718129791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K49Klm7iIz0biN2bctJExjLvOUoR/lEbMdUCiIAjR8g=;
        b=iUY/8zGf0jfuFWdvuOhU06NlFZAwB4c9TBk6but1ErkPFyBUSxzSN8MufLqeV832ti
         M/yESMob6kFN3zd7rnROwMV/pP7m1nz6fimqakiXfmA9xn/mcvlJ3NHOubde2BZRZO9W
         KwTfHWo3frKLvV17+oPPTpb9bSN8GTblt2ze2OnrT36KoMtt2zfQGzcADI4qacvfdEK4
         wczMwuwtxHOt0sBjGmNfKEg/caUWAhOmovwo+HmQgASzwU2ThwXs6xyIwCU09AM4YZ/M
         AGpEv961Z+iuxG0lSwYGZtHUbPkJ7tqsTSKSa/tZY3Dh6Sn5sO/6uK7/0I9Hw9+1QbHd
         bfeA==
X-Gm-Message-State: AOJu0YzqOf5WhK4iWPhcmK961jiD5nIRSgByFwcgH1o5p4QsFHgKJzTl
	oJyJ4dUY+LGX/7LZ6HiLaiDZXox1UM21Cl+qYelQpqxd5GkOurXK7cmIdiAr9aWxoA47SHaZOyM
	bBAnIAmHrXDDi6zWp4zmtxLVPGm4=
X-Google-Smtp-Source: AGHT+IF1TF6DnP5HAHr3pzirLZylX/Z3+l5+jhW+GAmYksT72/2TR68vgT7D68rpclPCAsegVFb8u3hNQbsSjZ+oXcA=
X-Received: by 2002:a17:90b:2e87:b0:2c1:af9f:a934 with SMTP id
 98e67ed59e1d1-2c27cc3ec90mr534740a91.16.1717524990831; Tue, 04 Jun 2024
 11:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603155308.199254-1-cupertino.miranda@oracle.com> <20240603155308.199254-2-cupertino.miranda@oracle.com>
In-Reply-To: <20240603155308.199254-2-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 11:16:18 -0700
Message-ID: <CAEf4BzYm7wF3F5s3h6Wa6ObPCo6pzZBEcziRuAELHpO-0ndStA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Support checks against a
 regular expression.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:53=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Add support for __regex and __regex_unpriv macros to check the test
> execution output against a regular expression. This is similar to __msg
> and __msg_unpriv, however those only allow to do full text matching.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
>  tools/testing/selftests/bpf/test_loader.c    | 126 ++++++++++++++-----
>  2 files changed, 105 insertions(+), 32 deletions(-)
>

This is useful, I have a few implementation/stylistical nits below.

pw-bot: cr


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
> index 524c38e9cde4..c73fa04bca1b 100644
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
> @@ -46,10 +49,15 @@ enum mode {
>         UNPRIV =3D 2
>  };
>
> +struct expect_msg {
> +       const char *msg;

let's call this "str"? In both cases we match "message", it's just
whether it's a substring match or regex match that matters

> +       regex_t *regex;

let's just have `regex_t regex` here, and avoid some more malloc/free dance=
.

I wouldn't reuse `msg` field to store original regex string, just add
another field, we are not concerned with saving a few bytes on this,
but keeping "regex_str" vs "str" separate makes everything simpler

> +};
> +
>  struct test_subspec {
>         char *name;
>         bool expect_failure;
> -       const char **expect_msgs;
> +       struct expect_msg *expect;

I'd keep the name as expect_msgs (you can expect other things, potentially)

>         size_t expect_msg_cnt;
>         int retval;
>         bool execute;
> @@ -91,27 +99,57 @@ static void free_test_spec(struct test_spec *spec)
>  {
>         free(spec->priv.name);
>         free(spec->unpriv.name);
> -       free(spec->priv.expect_msgs);
> -       free(spec->unpriv.expect_msgs);
> +       free(spec->priv.expect);
> +       free(spec->unpriv.expect);

who's going to free regex instances? there has to be regfree() somewhere

>
>         spec->priv.name =3D NULL;
>         spec->unpriv.name =3D NULL;
> -       spec->priv.expect_msgs =3D NULL;
> -       spec->unpriv.expect_msgs =3D NULL;
> +       spec->priv.expect =3D NULL;
> +       spec->unpriv.expect =3D NULL;
>  }
>
>  static int push_msg(const char *msg, struct test_subspec *subspec)

let's have a single `push_exp_msg(struct test_subspec *subspec, const
char *str, const char *regex)` helper that will handle both substr and
regexp cases in one function. Let's not duplicate realloc logic so
much

>  {
>         void *tmp;
>
> -       tmp =3D realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cn=
t) * sizeof(void *));
> +       tmp =3D realloc(subspec->expect,
> +                     (1 + subspec->expect_msg_cnt) * sizeof(struct expec=
t_msg));
>         if (!tmp) {
>                 ASSERT_FAIL("failed to realloc memory for messages\n");
>                 return -ENOMEM;
>         }
> -       subspec->expect_msgs =3D tmp;
> -       subspec->expect_msgs[subspec->expect_msg_cnt++] =3D msg;
>
> +       subspec->expect =3D tmp;
> +       subspec->expect[subspec->expect_msg_cnt].msg =3D msg;
> +       subspec->expect[subspec->expect_msg_cnt].regex =3D NULL;
> +       subspec->expect_msg_cnt +=3D 1;

we have named type now, let's have `struct expect_msg *tmp`, and then do

tmp =3D &subspec->expect[subspec->expect_msg_cnt];
tmp->msg =3D ...
tmp->regex =3D ...

> +       return 0;
> +}
> +
> +static int push_regex(const char *regex_str, struct test_subspec *subspe=
c)
> +{
> +       void *tmp;
> +       int regcomp_res;
> +
> +       tmp =3D realloc(subspec->expect,
> +                     (1 + subspec->expect_msg_cnt) * sizeof(struct expec=
t_msg));
> +       if (!tmp) {
> +               ASSERT_FAIL("failed to realloc memory for messages\n");
> +               return -ENOMEM;
> +       }
> +       subspec->expect =3D tmp;
> +
> +       subspec->expect[subspec->expect_msg_cnt].regex =3D (regex_t *) ma=
lloc(sizeof(regex_t));
> +       regcomp_res =3D regcomp (subspec->expect[subspec->expect_msg_cnt]=
.regex,
> +                              regex_str, REG_EXTENDED|REG_NEWLINE);

see above about tmp, we should shorten this (and combine with the above hel=
per)

> +       if (regcomp_res !=3D 0) {
> +               fprintf(stderr, "Regexp: '%s'\n", regex_str);
> +               ASSERT_FAIL("failed to compile regex\n");
> +               return -EINVAL;
> +       }
> +
> +       subspec->expect[subspec->expect_msg_cnt].msg =3D regex_str;
> +       subspec->expect_msg_cnt +=3D 1;
>         return 0;
>  }
>
> @@ -243,6 +281,18 @@ static int parse_test_spec(struct test_loader *teste=
r,
>                         if (err)
>                                 goto cleanup;
>                         spec->mode_mask |=3D UNPRIV;
> +               } else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
> +                       msg =3D s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1=
;
> +                       err =3D push_regex(msg, &spec->priv);
> +                       if (err)
> +                               goto cleanup;
> +                       spec->mode_mask |=3D PRIV;
> +               } else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRI=
V)) {
> +                       msg =3D s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPR=
IV) - 1;
> +                       err =3D push_regex(msg, &spec->unpriv);
> +                       if (err)
> +                               goto cleanup;
> +                       spec->mode_mask |=3D UNPRIV;
>                 } else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
>                         val =3D s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
>                         err =3D parse_retval(val, &spec->priv.retval, "__=
retval");
> @@ -336,16 +386,16 @@ static int parse_test_spec(struct test_loader *test=
er,
>                         spec->unpriv.execute =3D spec->priv.execute;
>                 }
>
> -               if (!spec->unpriv.expect_msgs) {
> -                       size_t sz =3D spec->priv.expect_msg_cnt * sizeof(=
void *);
> +               if (!spec->unpriv.expect) {
> +                       size_t sz =3D spec->priv.expect_msg_cnt * sizeof(=
struct expect_msg);
>
> -                       spec->unpriv.expect_msgs =3D malloc(sz);
> -                       if (!spec->unpriv.expect_msgs) {
> -                               PRINT_FAIL("failed to allocate memory for=
 unpriv.expect_msgs\n");
> +                       spec->unpriv.expect =3D malloc(sz);
> +                       if (!spec->unpriv.expect) {
> +                               PRINT_FAIL("failed to allocate memory for=
 unpriv.expect\n");
>                                 err =3D -ENOMEM;
>                                 goto cleanup;
>                         }
> -                       memcpy(spec->unpriv.expect_msgs, spec->priv.expec=
t_msgs, sz);
> +                       memcpy(spec->unpriv.expect, spec->priv.expect, sz=
);
>                         spec->unpriv.expect_msg_cnt =3D spec->priv.expect=
_msg_cnt;
>                 }
>         }
> @@ -403,26 +453,44 @@ static void validate_case(struct test_loader *teste=
r,
>                           int load_err)
>  {
>         int i, j;
> +       const char *match;
>
>         for (i =3D 0; i < subspec->expect_msg_cnt; i++) {
> -               char *match;
>                 const char *expect_msg;
> +               regex_t *regex;
> +               regmatch_t reg_match[1];
> +
> +               expect_msg =3D subspec->expect[i].msg;
> +               regex =3D subspec->expect[i].regex;
> +
> +               if (regex =3D=3D NULL) {

if (!regex)

> +                       match =3D strstr(tester->log_buf + tester->next_m=
atch_pos, expect_msg);
> +                       if (!ASSERT_OK_PTR (match, "expect_msg")) {
> +                               /* if we are in verbose mode, we've alrea=
dy emitted log */
> +                               if (env.verbosity =3D=3D VERBOSE_NONE)
> +                                       emit_verifier_log(tester->log_buf=
, true /*force*/);
> +                               for (j =3D 0; j < i; j++)
> +                                       fprintf(stderr,
> +                                               "MATCHED  MSG: '%s'\n", s=
ubspec->expect[j].msg);
> +                               fprintf(stderr, "EXPECTED MSG: '%s'\n", e=
xpect_msg);
> +                               return;
> +                       }
> +                       tester->next_match_pos =3D match - tester->log_bu=
f + strlen(expect_msg);
> +               } else {
> +                       int match_size =3D regexec (regex, tester->log_bu=
f + tester->next_match_pos, 1, reg_match, 0);
> +                       if (match_size !=3D 1) {

ASSERT_EQ(match_size, 1) to stay similar to the substring case above
with ASSERT_OK_PTR?

> +                               /* if we are in verbose mode, we've alrea=
dy emitted log */
> +                               if (env.verbosity =3D=3D VERBOSE_NONE)
> +                                       emit_verifier_log(tester->log_buf=
, true /*force*/);
> +                               for (j =3D 0; j < i; j++)
> +                                       fprintf(stderr,
> +                                               "MATCHED  REGEX: '%s'\n",=
 subspec->expect[j].msg);
> +                               fprintf(stderr, "EXPECTED REGEX: '%s'\n",=
 expect_msg);
> +                               return;
> +                       }

let's try to combine substring and regex case and keep verbosity and
error message output in one place?

>
> -               expect_msg =3D subspec->expect_msgs[i];
> -
> -               match =3D strstr(tester->log_buf + tester->next_match_pos=
, expect_msg);
> -               if (!ASSERT_OK_PTR(match, "expect_msg")) {
> -                       /* if we are in verbose mode, we've already emitt=
ed log */
> -                       if (env.verbosity =3D=3D VERBOSE_NONE)
> -                               emit_verifier_log(tester->log_buf, true /=
*force*/);
> -                       for (j =3D 0; j < i; j++)
> -                               fprintf(stderr,
> -                                       "MATCHED  MSG: '%s'\n", subspec->=
expect_msgs[j]);
> -                       fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_ms=
g);
> -                       return;
> +                       tester->next_match_pos +=3D reg_match[0].rm_eo;
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

