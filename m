Return-Path: <bpf+bounces-69762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9263BA0F78
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DC07A90AA
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722643128BA;
	Thu, 25 Sep 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKACaJY+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD731282B
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823241; cv=none; b=TeQLrXqUmclVE6KNfnLxti3ux7zshVxjTuh7HXQrqnkPwJm2m0Z4F2W9eC/xiWS288weUZbwHnEoplmBNAE1V89ckttq4e1G5Oc9kV320EQ6Ove4s7RDhkzS9gDN8SYaB0bmxvaqRUJS43oXaDvIb6WOJeFw7H17uss7BpoGOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823241; c=relaxed/simple;
	bh=zgousIFHsm7YM2sujxAF/BohzGFVs4nE13AEzu8il3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0ae0g4O74d5Vdcmxq7yp0FzzVrnRJYYVtwdbbUl7v0WrCOomxpWcRXX1A5/JxISjglejg8cacN8Eohv0ctxvfwqB5QgQVAUYRz5mujOsmZDvJZIANjt+X35PoE6JziONkMA3acvTJ493LUyr5vGbb1AcjgNxpzRyAYGygCxBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKACaJY+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2570bf6058aso18231725ad.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823239; x=1759428039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpAqyn/WTz/w/4Q4JZnk9KyirJXLyIHJK8SIwvRk4Ug=;
        b=mKACaJY+tV7WTXeKXOqorSYDWtr2ErBVtNgYGHFSOCAPyTtlJciDucJ0pDjv/zByTk
         UmABxKyOes9K9MqTNXRvntNlMbZbKbRN8Lhh80N7rW1VNEvtEffw6WP01pjHDLTWJBGP
         A7oaY6oQyLshOG8PVtMmzvgIAluEtKHNC9Q7WzYi7QDv7MTyPQE5WuKGoXsdU3gqxzq3
         RdncxZlJtEntJ+ug93e6FK90+i2eeIhLZTQfpFn3Bemj6aSYQKYkuIoaSD/XaCxd3/2Y
         DU387zY4lz4n5inLVUkgXIiPhjLeke30OJQq6t/UTnZFIHyflYiUGBpKMcYWkIfF38MO
         qBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823239; x=1759428039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpAqyn/WTz/w/4Q4JZnk9KyirJXLyIHJK8SIwvRk4Ug=;
        b=bY/tHK0r/gOzjoNogGQPWM76jO50gCPj49Ya2vsm0vUyREXZFnd0kZe9HX+u3D57zV
         JtWKYiUZgoYCcwWtI31+2OCslXfOg7D2LpsMval1mxs5PywDILwE2zsVcZmk6aajFK2j
         1xRKr4BDeg7LIrTDrGNmf/PU2uO8EsvZmsnxxW9hwQqBnXc/BfUm0gpzmTrXwXODVX6x
         cLCAsgBnFEr05IVueCAUMAQNbyqwahFetx95cOhdwnQDzbP+t1xzaL8xhEPNk/pAXdfl
         RZqQ/qcgyN0xuzPHdUxC7vqAV8opyjWK6xR1YaPZ+9tmRHm6dXh8mUR/h0HPRnkXriMB
         agWg==
X-Gm-Message-State: AOJu0YwDDK4RjSnrZMhJiEXBuf4F+rFo//NM/wbRzmW2l4JHXb3yZxzP
	Kc0aDrOb3vHeqH52tP1ZCNLSwCzR84bLP83OuxPg/ogL0OrWKl3zL7mVPBWuysOb1HI0t0+WD42
	ievLF1zStiKX9LJUcYMqQEfRPsVXVRhY=
X-Gm-Gg: ASbGncs00k2eG24V9ZsTTOgUH/woiGY6/hXWG095SzXH6HSMzbjcP4nEUbFRVF2787H
	BLweIT5J24kxLJkKA4W6k+rnfM4L5VQ9xnGST77pfW4vWk5qCwOjDbUAfp4aXaK9tLT/9odHrms
	u+B7nxZlOvhJ1Q9IkOYlDZsa2oypOZgjMKXF3saIUoW7Ebtef4Ns56CiGWjA9nlrcL4BEnBRhbx
	ztk2GRxMVBINNlMk0UMNTI=
X-Google-Smtp-Source: AGHT+IFtRMrUoxusWGWzCT1W9qpVQpZ8JV6K2ogrNZgzGnu3UvGE+1xRfoYa6ByQkbEerVUWadOj4V78j9uQ+DgKUF0=
X-Received: by 2002:a17:902:ced2:b0:267:16ec:390 with SMTP id
 d9443c01a7336-27ed49d2c07mr56745235ad.17.1758823238074; Thu, 25 Sep 2025
 11:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924142954.129519-1-mykyta.yatsenko5@gmail.com> <20250924142954.129519-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250924142954.129519-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 11:00:22 -0700
X-Gm-Features: AS18NWApcVAjKEjUN5zVr4X3v7wTaUUS89M-6Btdzzoy8QJc1HX5dhp6dLEmsIM
Message-ID: <CAEf4Bzbu8wfJ81_nYCJtvJoFxYYLxV-nt-mgQDC_K8JUM9dTpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: task_work selftest cleanup fixes
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:30=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> task_work selftest does not properly handle cleanup during failures:
>  * destroy bpf_link
>  * perf event fd is passed to bpf_link, no need to close it if link was
>  created successfully
>  * goto cleanup if fork() failed, close pipe.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_task_work.c | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/to=
ols/testing/selftests/bpf/prog_tests/test_task_work.c
> index 666585270fbf..08d24c16e359 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> @@ -55,8 +55,8 @@ static void task_work_run(const char *prog_name, const =
char *map_name)
>         struct task_work *skel;
>         struct bpf_program *prog;
>         struct bpf_map *map;
> -       struct bpf_link *link;
> -       int err, pe_fd =3D 0, pid, status, pipefd[2];
> +       struct bpf_link *link =3D NULL;
> +       int err, pe_fd =3D -1, pid, status, pipefd[2];
>         char user_string[] =3D "hello world";
>
>         if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
> @@ -77,7 +77,11 @@ static void task_work_run(const char *prog_name, const=
 char *map_name)
>                 (void)num;
>                 exit(0);
>         }
> -       ASSERT_GT(pid, 0, "fork() failed");
> +       if (!ASSERT_GT(pid, 0, "fork() failed")) {
> +               close(pipefd[0]);
> +               close(pipefd[1]);
> +               return;
> +       }
>
>         skel =3D task_work__open();
>         if (!ASSERT_OK_PTR(skel, "task_work__open"))
> @@ -109,9 +113,12 @@ static void task_work_run(const char *prog_name, con=
st char *map_name)
>         }
>
>         link =3D bpf_program__attach_perf_event(prog, pe_fd);
> -       if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +       if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
> +               link =3D NULL;

no need, removed, link will be NULL on error

>                 goto cleanup;
> -
> +       }
> +       /* perf event fd ownership is passed to bpf_link */
> +       pe_fd =3D -1;
>         close(pipefd[0]);
>         write(pipefd[1], user_string, 1);
>         close(pipefd[1]);
> @@ -126,8 +133,10 @@ static void task_work_run(const char *prog_name, con=
st char *map_name)
>  cleanup:
>         if (pe_fd >=3D 0)
>                 close(pe_fd);
> +       if (link)

no need to check, bpf_link__destroy() handles NULLs just fine, removed

applied to bpf-next, thanks


> +               bpf_link__destroy(link);
>         task_work__destroy(skel);
> -       if (pid) {
> +       if (pid > 0) {
>                 close(pipefd[0]);
>                 write(pipefd[1], user_string, 1);
>                 close(pipefd[1]);
> --
> 2.51.0
>

