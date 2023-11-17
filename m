Return-Path: <bpf+bounces-15238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683537EF681
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D9A1F26FD1
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BD374EA;
	Fri, 17 Nov 2023 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4D8Z0+A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C963CA4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d216597f64so303474966b.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239576; x=1700844376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhAs/r6u7iQ850C7a4FNhAq30w00ZIeYtuh2ZjH0nyk=;
        b=E4D8Z0+ANkLKB5PayxMvHc6SHW0xngEvDjPFLh3pCDA2yGZHZXVdj7ZUTqkmHSVqU9
         AP86+46qpUhStz1j/akt4ilKsp54LjsSHIBP1l1QWP2b0By2ThXU0qIpsjVROloFLN4F
         l0cTSM/FfE+FsJOrgj9AbgmShjY18mw+Q1rKd6fL6vsU5qNRJKbHos9/Vnk60TYxCC0X
         +507Da89zk7rZlmYp8ct/KmAV621ts9JmQOGn0zNK97HOCSOPiX36YD3bimiJnLjf0Yn
         PkLo9pcK7pSE7X3Goy3gDi+08FrVlhlGS8XrlHnsOYjGz184CvX0fueuUgn3LuX/hZIl
         1IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239576; x=1700844376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhAs/r6u7iQ850C7a4FNhAq30w00ZIeYtuh2ZjH0nyk=;
        b=E2u68Qaa/PUAdUu1QJICxEyvkd6P4PbPlpkbTdx/7t5ywB8mpm/cSKstMit7bO90HW
         4GnG+1U2akx4gQT5KvcDuGETS2UmrBK80xBXV3GPn6QhDMZ3mBOhwv1jgD1bkLtqPFDe
         YcRj/kna4c0iIq3YWeWVibpIbLCDdw7l6mlrCl/yGi8ng94Eq/fQCgXKForRiVI5R58b
         YhBH5Rul99pL9GJUqxfMpLbeUfJ5pRZFqmTq3djcHdsnFpYo+dORJ7nJHrGBNVEAQN4k
         2BMqOZuhSszP3GhyjzkSeVFhK81ezvTAYny+BZp7tb21DkvrTjXb89ZUBoq50YclQTWM
         kKqA==
X-Gm-Message-State: AOJu0YzHEboEHwHMXZugT6O6tgESxsX2nAkn+MWyTvPw2FHbSP9d0PTe
	zAqPR8yyZvtDOHOnjbZz9U6T4dr9WbNk+8WqGMY=
X-Google-Smtp-Source: AGHT+IEQ3qQm2C7gEXSrIIKPqE7dwqLf4pNRGlDhLBz0Lxl81IlKA22Xo21/IhC7dwutOSTJX1b3OsSM1ltGWUgLjxQ=
X-Received: by 2002:a17:906:2e8a:b0:9d0:2e6b:f47f with SMTP id
 o10-20020a1709062e8a00b009d02e6bf47fmr16251151eji.36.1700239575898; Fri, 17
 Nov 2023 08:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-12-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-12-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:45:29 -0500
Message-ID: <CAEf4BzZhEU-h0yfY2WCBfPDjmwOzxxw1a70J4c78Bix34W70QQ@mail.gmail.com>
Subject: Re: [PATCH bpf 11/12] selftests/bpf: add __not_msg annotation for
 test_loader based tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Add an ability to specify messages that should not be found in the
> test verifier log. Similar to LLVM's FileCheck tool for the following
> test specification:
>
>     __success
>     __msg("a")
>     __not_msg("b")
>     __msg("c")
>     void foo(...) { ... }
>
> - message "a" is expected to be in the log;
> - message "b" is not expected after message "a"
>   (but could be present before "a");
> - message "c" is expected to be in the log after message "a".

I think this implementation has an undesired surprising behavior.
Imagine you have a log like this:

A
C
D
B


And you specify

__msg("A")
__nomsg("B")
__msg("C")
__msg("D")
__msg("B")

Log matches the spec, right? But your implementation will eagerly reject it=
.

I think you can implement more coherent behavior if you only strstr()
__msg() specs, skipping __nomsg() first. But on each __msg one, if
successful, you go back and validate that there are no matches for all
__nomsg() specs that you skipped, taking into account matched
positions for current __msg() and last __msg() (or the start of the
log, of course).

Not sure if I explained clearly, but the idea is to postpone __nomsg()
until we anchor ourselves between two __msg()s. And beginning/end of
verifier log are two other anchoring positions.

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  9 +++
>  tools/testing/selftests/bpf/test_loader.c    | 82 ++++++++++++++------
>  2 files changed, 68 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index 799fff4995d8..f24fcda6fc0b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -22,7 +22,13 @@
>   *
>   * __msg             Message expected to be found in the verifier log.
>   *                   Multiple __msg attributes could be specified.
> + *                   When multiple messages are specified they are
> + *                   matched one after another.
> + * __not_msg        Message not expected to be found in the verifier log=
.
> + *                   Matched from the end of the last checked __msg or
> + *                   from log start, if no __msg had been matched yet.
>   * __msg_unpriv      Same as __msg but for unprivileged mode.
> + * __not_msg_unpriv  Same as __not_msg but for unprivileged mode.

ok, it's bikeshedding, but __nomsg and __nomsg_unpriv seems a bit
nicer names for this (very subjective, of course)

>   *
>   * __success         Expect program load success in privileged mode.
>   * __success_unpriv  Expect program load success in unprivileged mode.
> @@ -59,10 +65,13 @@
>   * __auxiliary_unpriv  Same, but load program in unprivileged mode.
>   */
>  #define __msg(msg)             __attribute__((btf_decl_tag("comment:test=
_expect_msg=3D" msg)))
> +#define __not_msg(msg)         __attribute__((btf_decl_tag("comment:test=
_dont_expect_msg=3D" msg)))
>  #define __failure              __attribute__((btf_decl_tag("comment:test=
_expect_failure")))
>  #define __success              __attribute__((btf_decl_tag("comment:test=
_expect_success")))
>  #define __description(desc)    __attribute__((btf_decl_tag("comment:test=
_description=3D" desc)))
>  #define __msg_unpriv(msg)      __attribute__((btf_decl_tag("comment:test=
_expect_msg_unpriv=3D" msg)))
> +#define __not_msg_unpriv(msg)                                          \
> +       __attribute__((btf_decl_tag("comment:test_dont_expect_msg_unpriv=
=3D" msg)))

test_expect_no_msg ?

>  #define __failure_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_failure_unpriv")))
>  #define __success_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_success_unpriv")))
>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test=
_log_level=3D"#lvl)))
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 37ffa57f28a1..def16d9aeae2 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[...]

> -static int push_msg(const char *msg, struct test_subspec *subspec)
> +static int push_msg(const char *msg, struct test_subspec *subspec, bool =
expected)
>  {
> +       size_t cnt =3D subspec->expect_msg_cnt;
>         void *tmp;
>
> -       tmp =3D realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cn=
t) * sizeof(void *));
> +       tmp =3D realloc(subspec->expect_msgs,
> +                     (1 + subspec->expect_msg_cnt) * sizeof(*subspec->ex=
pect_msgs));

nit: 1 + cnt ?

>         if (!tmp) {
>                 ASSERT_FAIL("failed to realloc memory for messages\n");
>                 return -ENOMEM;
>         }
>         subspec->expect_msgs =3D tmp;
> -       subspec->expect_msgs[subspec->expect_msg_cnt++] =3D msg;
> +       subspec->expect_msgs[cnt].str =3D msg;
> +       subspec->expect_msgs[cnt].expected =3D expected;
> +       subspec->expect_msg_cnt++;
>
>         return 0;
>  }

[...]

