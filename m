Return-Path: <bpf+bounces-33582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5691EBE3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085AE283615
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F715523D;
	Tue,  2 Jul 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4FM+rJp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8CC79CC
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880931; cv=none; b=ZmSoCdYJ22R2A5nZWbwVWCC4D+Oi37SY5jPG6OjHqH/PYwahmDyGBOKSEGbgH4XsuG4ScjBeXAr/4ApI7ke1tFkSFfBdw8bzGv74VHwCbO/Tv7xdzYw34uk0h5DgfhC6XHnSN1zFLrkPDIu+0sTIdwwcmDMdUILI62MaXX1ULc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880931; c=relaxed/simple;
	bh=DNxsLZexWqOfenhSP38m2WXbNj2ztisd8R1TyUPMK+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvPtbf/9ZGLAvFBUdoRJbePYizkEhh2zQC/zIFdWqoZkAZpT1e0s5s1JrzV19jhwGksbkt/j8X5jsghvi1bgkC9YBpSGWpB9VMEW6eJPrZtdNpK9RXGgvnExkTADPgb+56bqZEdUlAK3Vg7QrDEF6EIvOjkEh7bqMuLZgqxUewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4FM+rJp; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701f397e8ffso2044331a34.0
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880929; x=1720485729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSygy/6D5WFKbOkKLlt9V4IRBrTYcYhS1FdmQnD9soc=;
        b=I4FM+rJpGisPiRqAs/YrtwdSXLouSma3GFvaIbfYj38a/Ch9R9rbNAeoQ0Eh/fiPyi
         LjxBzh1NeCPjEeoNTfBOpTAFVsPfaA1DNgZX+0gCLBLRdIEQ9dsodVgHoFRaoWxEHMG5
         3WginzUrcSPoh1UZ5nmnkhH3120l/OP9Johf4pbHnLMKO2kquP9Z/pij7e2olLi6S9lw
         /0/FaaN4LssA1XCQ2N5X1E3CrCvaoU1Uh3DgVN4tpMvJXa12lix7/Ki1nNNOZ6yFhuyu
         rQKsfjhf7bunkWok2wHJKKhWC49RX/TgOk04+Z1mzEBgQurukbaD++XcLp3aHy7GKdyz
         CILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880929; x=1720485729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSygy/6D5WFKbOkKLlt9V4IRBrTYcYhS1FdmQnD9soc=;
        b=mp/YN8I0IqNZBpTIqD1sCRmJA+BRy5fSeRIiOkj924CCctAvP9YG9mkX+MU2EC62Cm
         WGA22Wfj5XadNnGxUibzUDFL0wZ6RWvWelgooqHJP0n0K25r+fu6/V7AkMqQqWFdruoO
         k3W5NafSUzBQpQ/77lkq8wzV5EqDrrFU+qQe2nAx/WSVxeAAfhYXOWMg9jg9od0AxGTU
         S5YikUZVeUdZIc4zxQJCh9KQtxNwL2wKDBzPQoZIhzkWdCLT3diHqNuVGQ95tfhPGRUc
         FCetto0Shf3H25Cs+wt/6R3iBbz9i4V5H90FcgkdVj/rbzLEmwQ5MTwGQCb/DJCxwe1C
         dJKg==
X-Gm-Message-State: AOJu0YzbbWEfxoSXv5Xr8hdtBbOkNVFBj1ljxtqY5PPn1NLJCw7V/Jje
	Yvj37PT/q7zES+Ph+uJ6aeVp7Li9HZ04Zrn57YSCUm/oReKm73W9ywm0zeI3M/Vpk7nbMfrDBLC
	BnXHyJaw5BgDFxXQPiER8mkdyDeOZtQ==
X-Google-Smtp-Source: AGHT+IGRyfOcmbiF+r+rbp7sOJtMiHry5uWJ9xmICknD911fOPB1xJlN/0+/leQB8VIUek37BlzPvTWBqFXOjmxIAeg=
X-Received: by 2002:a05:6808:1b0e:b0:3d6:3000:9ab3 with SMTP id
 5614622812f47-3d6b4de2cfcmr8325217b6e.40.1719880928847; Mon, 01 Jul 2024
 17:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-6-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-6-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:41:53 -0700
Message-ID: <CAEf4BzYeAG7SFschgypp3WHcQ2B4uxY4-euiU_pXM4s9dfHKNA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 5/8] selftests/bpf: no need to track
 next_match_pos in struct test_loader
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> The call stack for validate_case() function looks as follows:
> - test_loader__run_subtests()
>   - process_subtest()
>     - run_subtest()
>       - prepare_case(), which does 'tester->next_match_pos =3D 0';
>       - validate_case(), which increments tester->next_match_pos.
>
> Hence, each subtest is run with next_match_pos freshly set to zero.
> Meaning that there is no need to persist this variable in the
> struct test_loader, use local variable instead.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_loader.c | 17 ++++++++---------
>  tools/testing/selftests/bpf/test_progs.h  |  1 -
>  2 files changed, 8 insertions(+), 10 deletions(-)
>

Nice cleanup:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index f14e10b0de96..ac9d3e81abdb 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -434,7 +434,6 @@ static void prepare_case(struct test_loader *tester,
>         bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
>
>         tester->log_buf[0] =3D '\0';
> -       tester->next_match_pos =3D 0;
>  }
>
>  static void emit_verifier_log(const char *log_buf, bool force)
> @@ -450,23 +449,23 @@ static void validate_case(struct test_loader *teste=
r,
>                           struct bpf_program *prog,
>                           int load_err)
>  {
> -       int i, j, err;
> -       char *match;
>         regmatch_t reg_match[1];
> +       const char *match;
> +       const char *log =3D tester->log_buf;
> +       int i, j, err;
>
>         for (i =3D 0; i < subspec->expect_msg_cnt; i++) {
>                 struct expect_msg *msg =3D &subspec->expect_msgs[i];
>
>                 if (msg->substr) {
> -                       match =3D strstr(tester->log_buf + tester->next_m=
atch_pos, msg->substr);
> +                       match =3D strstr(log, msg->substr);
>                         if (match)
> -                               tester->next_match_pos =3D match - tester=
->log_buf + strlen(msg->substr);
> +                               log +=3D strlen(msg->substr);
>                 } else {
> -                       err =3D regexec(&msg->regex,
> -                                     tester->log_buf + tester->next_matc=
h_pos, 1, reg_match, 0);
> +                       err =3D regexec(&msg->regex, log, 1, reg_match, 0=
);
>                         if (err =3D=3D 0) {
> -                               match =3D tester->log_buf + tester->next_=
match_pos + reg_match[0].rm_so;
> -                               tester->next_match_pos +=3D reg_match[0].=
rm_eo;
> +                               match =3D log + reg_match[0].rm_so;
> +                               log +=3D reg_match[0].rm_eo;

invert and simplify:

log +=3D reg_match[0].rm_eo;
match =3D log;

?

>                         } else {
>                                 match =3D NULL;
>                         }

how about we move this to the beginning of iteration (before `if
(msg->substr)`) and so we'll assume the match is NULL on regexec
failing?


> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 0ba5a20b19ba..8e997de596db 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -438,7 +438,6 @@ typedef int (*pre_execution_cb)(struct bpf_object *ob=
j);
>  struct test_loader {
>         char *log_buf;
>         size_t log_buf_sz;
> -       size_t next_match_pos;
>         pre_execution_cb pre_execution_cb;
>
>         struct bpf_object *obj;
> --
> 2.45.2
>

