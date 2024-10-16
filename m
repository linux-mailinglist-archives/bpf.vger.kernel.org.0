Return-Path: <bpf+bounces-42233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110C9A1374
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA101F22276
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058551C2324;
	Wed, 16 Oct 2024 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHM69OIO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC218CBFB
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109346; cv=none; b=TbnkjoTFXPaBFXss23BvsEPDIytVHdwbW0ijfezrbmzJkhix5Mhq0bdlQCYVKH0F3gFGX9xPQ68K2DQzoDpOAgbZ5iwJknuZfbz9JpqOoW3R1+DF/IxTJVTA2SJ9KiNTOYxjuZtlVpmI96QeOFmoCXjZtu+ITeN9NeTpDOGQAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109346; c=relaxed/simple;
	bh=Jym2imMaE6ts6zco9lw1NQocetvhk8vd7mDH17SSsCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lekf9WcusHTrincu/wyrIVaqRBHCmc7ZtwESGZOwzw7v6qwirBquxGjuw9rYd/xVyBmNR+hKoWh1Eh0rQxQmxAAmBP6HcWe9+kRuOYZIwiD9KFf/lcHBw6xTG0RNdO84bcGmK0JWHUEEvNDQsxZp/WjF2M+JzDwZuXrwe2css6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHM69OIO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e5a62031aso117408b3a.1
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109344; x=1729714144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh0wK/sKSvjxzG9F0DDDCwNHwzLzBY3TL8FBiQcl4bo=;
        b=fHM69OIOuP4n7LCOrPFfakcUaJfi0yHpbTvv61Wy9umtQtI0Nav2ImDu99RWAbkqnS
         itquKaI8AGx86dRdWgXiZ4ETo4Jpa7iq+OneIRhv3UZJggs94a8WxqqfVTEduGFYVwrL
         OUB2CDu1tJAClLgz7yKvW1uKdFwIOwO976VdtaQfgAD8qgJDHFTHvlyj/DF+iTFZVqdV
         ZOe2jDQFLh5ColBOXFASKYvm8tnGrVjodaEsEWL6JR6qNULfz6oR3r+OQ67OQR5FJPYd
         IgJZb4KV6UIjPCVWTR13O+/6e7Z1rWXQcypbHGYk1FAWKFpPxo/ZGUXymX5MDUovm+5W
         e6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109344; x=1729714144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh0wK/sKSvjxzG9F0DDDCwNHwzLzBY3TL8FBiQcl4bo=;
        b=ih0JWRm4hbRA2kEv0NBAGfwsgPb10tju4zyzBMYBKyh4jJjECetPbW7w9bAViLaDrd
         1PJbmp9XxJeWNj9UpV+GzHt1+OBJ5KV/d/D2sXaSqqKoFzgSNZDhKTLPxceHKoUSZe8c
         sOBqPo8NTtXuktRj+ke7H3b8XZdxWrqQAJZzObw2SCgyMG4ralajMq71+vkndkCmoTGv
         tAc6rePnmnhwZbeANa827b2yls8tyT02ICS/HwNacKHoGABSTS217fHj7UgTOUiZWmnO
         bo9Ps+smaI3/4nZ3cJ1vhNRFsqj2IMC/Y5qgVifsp/LITWL8ootIuyJnilKMOpY3L942
         OiHQ==
X-Gm-Message-State: AOJu0YxVs40HaRpz+JZPxvjHhtHJZihEmN0jRY4/1WGQn7oKPo3u2J37
	XOJw4zr4FVNNzSYhAm4eVyyubpLbocdsjAElxeSKqvF2KFsYhBP26wrWk2SPqzCUsdp9aMTBSW9
	xd/of8WcltmapBSA/oh6o3q5xCylLlDQg
X-Google-Smtp-Source: AGHT+IFtkrljreWVsIiw/SOy2GN1TRhUzmma1ju5nqTrQxeX6RhX4a4m9tfD5qIVNKkrf7Z30Qu76o2CUrp9ykZ+hEk=
X-Received: by 2002:a05:6a00:3e03:b0:71e:cb:e7bf with SMTP id
 d2e1a72fcca58-71e4c1bfb45mr22812051b3a.18.1729109344401; Wed, 16 Oct 2024
 13:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015182707.1746074-1-linux@jordanrome.com> <20241015182707.1746074-2-linux@jordanrome.com>
In-Reply-To: <20241015182707.1746074-2-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 13:08:51 -0700
Message-ID: <CAEf4Bza9Y9Qjym4Vf-_ifQ83WQNQaQ9M4wD=LhYiiXX1TBO5Dw@mail.gmail.com>
Subject: Re: [bpf-next v1 2/2] bpf: properly test iter/task tid filtering
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:41=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> Previously test_task_tid was setting `linfo.task.tid`
> to `getpid()` which is the same as `gettid()` for the
> parent process. Instead create a new child thread
> and set `linfo.task.tid` to `gettid()` to make sure
> the tid filtering logic is working as expected.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 52e6f7570475..5b056eb5d166 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_=
attach_opts *opts,
>         ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL=
),
>                   "pthread_create");
>
> -       skel->bss->tid =3D getpid();
> +       skel->bss->tid =3D gettid();
>
>         do_dummy_read_opts(skel->progs.dump_task, opts);
>
> @@ -249,25 +249,41 @@ static void test_task_common(struct bpf_iter_attach=
_opts *opts, int num_unknown,
>         ASSERT_EQ(num_known_tid, num_known, "check_num_known_tid");
>  }
>
> -static void test_task_tid(void)
> +static void *run_test_task_tid(void *arg)
>  {
> +       ASSERT_NEQ(getpid(), gettid(), "check_new_thread_id");

this is variable declaration block, move assertion after it (and empty line=
)

>         LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>         union bpf_iter_link_info linfo;
>         int num_unknown_tid, num_known_tid;
>

here

>         memset(&linfo, 0, sizeof(linfo));
> -       linfo.task.tid =3D getpid();
> +       linfo.task.tid =3D gettid();
>         opts.link_info =3D &linfo;
>         opts.link_info_len =3D sizeof(linfo);
>         test_task_common(&opts, 0, 1);
>
>         linfo.task.tid =3D 0;
>         linfo.task.pid =3D getpid();
> -       test_task_common(&opts, 1, 1);
> +       // This includes the parent thread, this thread, and the do_nothi=
ng_wait thread

we don't use C++-style comments in C code base, please use /* */

> +       test_task_common(&opts, 2, 1);
>
>         test_task_common_nocheck(NULL, &num_unknown_tid, &num_known_tid);
> -       ASSERT_GT(num_unknown_tid, 1, "check_num_unknown_tid");
> +       ASSERT_GT(num_unknown_tid, 2, "check_num_unknown_tid");
>         ASSERT_EQ(num_known_tid, 1, "check_num_known_tid");
> +
> +       pthread_exit(arg);

nit: wouldn't `return arg;` do the same?

> +}
> +
> +static void test_task_tid(void)
> +{
> +       pthread_t thread_id;
> +       void *ret;
> +
> +       // Create a new thread so pid and tid aren't the same

C++ comment

> +       ASSERT_OK(pthread_create(&thread_id, NULL, &run_test_task_tid, NU=
LL),
> +                 "pthread_create");
> +       ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,

it's best to avoid combining two check in single ASSERT_*(), so

ASSERT_OK(pthread_join(...), ...);
ASSERT_NULL(ret, ...);

is way easier to follow and debug, if something breaks

But also, why do we check ret? Do we ever return non-NULL?

pw-bot: cr

> +                    "pthread_join");
>  }
>
>  static void test_task_pid(void)
> --
> 2.43.5
>

