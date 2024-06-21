Return-Path: <bpf+bounces-32769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95980912F25
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A6C1C217F4
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D917A93E;
	Fri, 21 Jun 2024 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWLzpQ3f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A18374C3
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003880; cv=none; b=gAHD8vvy6NVEJJNIMMmZ0Of6J1etn/PAItbgJNnOC7TGIzOARQ0LiU9EYeN8WaGxqqGtM1nEahSBAwVYJzCbUNV7/7GKtx6B77+w19PYa0OCg0L2QdgVGQG4mbcbEWdpH70x42UxaQLuSHv1w8B+WYKmDskobiPo6MIkmVLrbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003880; c=relaxed/simple;
	bh=bOtokfPj1As25+w0lwxQD7bY3imPFfBrp//gOs8FCeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqwTu11kNtREH2OtnXoILKdoYLmBBih8UjYxR9FtZjhOcnqbFQAJ1M6O009fSlkQdYkB52sZX1rnDU73XAsc1I08WrzVjoEJvHXRVZQ06fDcXAY6UTZHn/BgMGXfADzLl68Z6EB0jOHbnEv856a7QowabExnc7An15n8s1sk0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWLzpQ3f; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1874361a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719003878; x=1719608678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwAIUOjgyWg57+5VYGeHh1JDMJrDQk6CVYjXp0pITkQ=;
        b=hWLzpQ3frE3Iv/gu+r/B26Aq9+RkGgPjWLuyElVg41NK2GfNho7jYwjK3rkhrpCk29
         qktoYbbUqXrblf2qMtzkmozCz5iMZz0GwCL7/IrwZR9O59U7FHPcyhD+TeFVT0LKfP+O
         8WUpf3j/bOIxv5KjEW+0bYf4TEA9EV8uHeUelqvUfOfUfoa2ofPMY1kRFK7rIHEAjhe3
         CoxqWSt5O+1JYQiVnA9gYeDl75Ck1S+dykvS4H/GY7rQEVXI69PttaIhFIDrkS4ECx3k
         3OYo1hlMfn4116XU94EjOHl+mrogK1oe+wPdYmqZiXwOojL8LSlIBPhPHvmDmQhLuxgy
         chwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003878; x=1719608678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwAIUOjgyWg57+5VYGeHh1JDMJrDQk6CVYjXp0pITkQ=;
        b=dNE4ZOnamcJt53RZ3uGk6Y+Ld1EejjdNU64etbc3HuCRQN3XkcwpXgnLV1SO7kVLyY
         BRD5jY45XyL9KGCGYb+SvY48oLK97l2I5ohJcDDTa5XSljBYe9bLzUbbvBxSnXobd4+U
         oVjRUYky0S3hVAgF4VJw4HZosLpJOfbmms+olCKvk1qCACzOGDMkG7x4hhIC4qzPE5JS
         sPKpSe8Zpo2hc9Iask8WJsMbvkKuq/PW8IZumF8revsGyR8YQBATZ4LRfzhFiENwSiSu
         /pgiF51HagTTQqtOyPO8BLWV2zCeBUgwYVO7IFtQNp6Ay88T0TV50JSa0+R8QSPI/9kG
         cFkQ==
X-Gm-Message-State: AOJu0YyYYm5pj8sBUI17SnBk9HYiB1qRZtZwVOVTiM25sPk633oa7gkq
	LEgQcUS5JIw1JgeRmpLXBr96onPSIPU75E1xc54e81bAdZC2+Z3wlGnscbIE1UoCX+ty3ujqJUq
	E035X5f3CZBIn2U5VzJaLmOmtiiU=
X-Google-Smtp-Source: AGHT+IG5lg2eJs2WnKAswUg0cvHwlYDmZfqkcON85pzr4LMNi26RLFgdRfzBgaqRdLtgm/ojMVUMxEa9FzKdnlr16d0=
X-Received: by 2002:a17:90a:128e:b0:2c4:e333:35f3 with SMTP id
 98e67ed59e1d1-2c7b57f202amr9466265a91.6.1719003877853; Fri, 21 Jun 2024
 14:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617141458.471620-1-cupertino.miranda@oracle.com> <20240617141458.471620-2-cupertino.miranda@oracle.com>
In-Reply-To: <20240617141458.471620-2-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Jun 2024 14:04:25 -0700
Message-ID: <CAEf4BzZzyC2oP2OYVgdSAkZViHss7v3Fi4ALW7A7R8kfQNC1OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] selftests/bpf: Support checks against a
 regular expression
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, jose.marchesi@oracle.com, 
	david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:15=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Add support for __regex and __regex_unpriv macros to check the test
> execution output against a regular expression. This is similar to __msg
> and __msg_unpriv, however those expect do substring matching.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
>  tools/testing/selftests/bpf/test_loader.c    | 117 ++++++++++++++-----
>  2 files changed, 98 insertions(+), 30 deletions(-)
>

[...]

> -static int push_msg(const char *msg, struct test_subspec *subspec)
> +static int push_msg(const char *substr, const char *regex_str, struct te=
st_subspec *subspec)
>  {
>         void *tmp;
> +       int regcomp_res;
> +       char error_msg[100];
> +       struct expect_msg *msg;
>
> -       tmp =3D realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cn=
t) * sizeof(void *));
> +       tmp =3D realloc(subspec->expect_msgs,
> +                     (1 + subspec->expect_msg_cnt) * sizeof(struct expec=
t_msg));
>         if (!tmp) {
>                 ASSERT_FAIL("failed to realloc memory for messages\n");
>                 return -ENOMEM;
>         }
>         subspec->expect_msgs =3D tmp;
> -       subspec->expect_msgs[subspec->expect_msg_cnt++] =3D msg;
> +       msg =3D &subspec->expect_msgs[subspec->expect_msg_cnt];
> +       subspec->expect_msg_cnt +=3D 1;

we should update expect_msg_cnt only on success, otherwise we can run
regfree() on an instance that actually failed to regcomp(). I moved
this down while applying.

> +
> +       if (substr) {
> +               msg->substr =3D substr;
> +               msg->regex_str =3D NULL;

[...]

> +                       err =3D regexec(&msg->regex,
> +                                           tester->log_buf + tester->nex=
t_match_pos,
> +                                           1, reg_match, 0);
> +                       if (err =3D=3D 0) {
> +                               match =3D tester->log_buf + tester->next_=
match_pos
> +                                       + reg_match[0].rm_so;
> +                               tester->next_match_pos +=3D reg_match[0].=
rm_eo;
> +                       } else
> +                               match =3D NULL;

{} should be balanced for if/else, fixed it up as well


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
> +                               msg =3D &subspec->expect_msgs[j];
> +                               fprintf(stderr, "%s %s: '%s'\n",
> +                                       j < i ? "MATCHED " : "EXPECTED",
> +                                       msg->substr ? "SUBSTR" : " REGEX"=
,
> +                                       msg->substr ?: msg->regex_str);
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

