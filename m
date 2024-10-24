Return-Path: <bpf+bounces-43078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C789AEF2F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FEBB21174
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F981FF7B9;
	Thu, 24 Oct 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnGwSAx9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2891FBF50;
	Thu, 24 Oct 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793296; cv=none; b=W/n3pGGxm2ZDTh2xwUXKaU5LM2olsspBL/jIj24e3ZdIYzlzB26w8lquWIHi9flX7LNN4UiprQbeRnIM8gm69Jtq5jpoN/O6G2Lie6d1FnOginvGbSbikZZbeNjCFufkY0G1iWMlQjlbnsotnSgSjnPp9OwpIPg24c9m2Nf0Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793296; c=relaxed/simple;
	bh=Xh1R4GZ27pmUMbn74JvSoBUKIK0TU3ZXL4vL3T0uC7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2qGLw+BVCghtcWNHll/fTU1yU+8UVRU3jhSMHtWopmf2G9ht38Dpzkj2IjC1qrX6dBO/jgMadQ8pzydMwfzncWlHpxZPpyJ45xgswTm0l8cWJ1dj7omv43Oyth3Mn79Or+fxYwjWlvduu7jwwpmDduKHyJeElQnr2V/P6+xVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnGwSAx9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43158625112so12546195e9.3;
        Thu, 24 Oct 2024 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793292; x=1730398092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1JTd7ynOSs7lXi2zMkWgF6wBy5w0MWAsGS+BfHL1dU=;
        b=fnGwSAx9Bg9sXrDl6VbDpzoA/W1XtqDgDdRdVIi2MNS8yfLYeIytxx6EHuKGnNT/EM
         B/IGcfVMkWMPfsJvEb0/ENmw7q72lx1/8mvcmFsV82udjIuNwbRK0N/dgONZlG7lc8oB
         gUD03MTNoyel7Wc7P/iwW5MhZnGh3aBOqpjap5YtomNY5+4K/httKSIgdsM6nLBU5olo
         UYkHx0hlFqVZwr7qo0gOCx1ZlOrjlDtPWnP9M+5tQYVtlh0fBJnV2i7OCYlYrBEHme5C
         zsrUiut1WmKHzw1NDxgDNh48zJSEe1I0abJab2Ui2SO7ZwkYl1F/KK7oN2Jt8NpZchXi
         FJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793292; x=1730398092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1JTd7ynOSs7lXi2zMkWgF6wBy5w0MWAsGS+BfHL1dU=;
        b=VkWpNxKn6svB0Jbn1kFbmeegMOjsGjR+of4WCzRBgk/Ss5FrFpF5cEmXM/Ox3qD33S
         Il73zfTLhhjWRikuCxvA8QOGNt5PSXKsvBXQUxNE4GWG4nBGzg9r51kjC+ify1Lz9iB1
         uVJJLYAmvcnTqn2EMxF8ReegAF46LyAlE/5zWg2zh02qj4iuW8N0kUoRUHFj9Fp7wkAF
         PXd8WAANHKKDBRvMEDxqnwy4ZWRT6hcPtSxeNAfId0qmBEqpB+ajSi4TUUqvjEFOwCcI
         zyo/D26n0omgf8k05X81rI+iOlMvTW3urCKePJBlT8MKafB50hk3+shLT30W3pabbaEs
         E4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP1+oeYFLqtU6JBVX87qdFaRzX02UO84ruo65Pb4Fn7GyxREJiHJ0NZHxW/VpLDv9ciQbaqbvJMJaqrcKJ@vger.kernel.org, AJvYcCWUVRfcKsldDFzOvW9B9p27mjq/e1Fk4I+fqWVWoYP5ieyspm6elXg+Nr1G70h1Ye8MqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJ84W5yhXXbKj98SFOInAVFUHbVnnKSr2iHkH/ApT19Oj5SxC
	SG5/Lm79s0IYQCqnVfd1uP+ChXSA8Ez+XZla2pl+KDq6ZqLHhkZrYZ3W0Ng8APon1Z8lmk7y1UX
	TbtXTw1QCn20l2dE4LCi5FAExjkE=
X-Google-Smtp-Source: AGHT+IHtADTjFNUiOzcBVHGFK5fqjvzcuZ7N+Bfv/1XzpGRD1qXsWzbAsnucAxaxXvqPWA1Qj0dWpGn3l4Oxl/cKIyw=
X-Received: by 2002:a05:600c:1c12:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-4318422075dmr51336225e9.20.1729793291786; Thu, 24 Oct 2024
 11:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024074815.1255066-1-namhyung@kernel.org> <20241024074815.1255066-2-namhyung@kernel.org>
In-Reply-To: <20241024074815.1255066-2-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Oct 2024 11:08:00 -0700
Message-ID: <CAADnVQLA=QE9HwH+9tA+G8uppXK0-yk-hbiBHaOmjkjVENYCsA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add a test for open coded
 kmem_cache iter
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:48=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The new subtest is attached to sleepable fentry of syncfs() syscall.
> It iterates the kmem_cache using bpf_for_each loop and count the number
> of entries.  Finally it checks it with the number of entries from the
> regular iterator.
>
>   $ ./vmtest.sh -- ./test_progs -t kmem_cache_iter
>   ...
>   #130/1   kmem_cache_iter/check_task_struct:OK
>   #130/2   kmem_cache_iter/check_slabinfo:OK
>   #130/3   kmem_cache_iter/open_coded_iter:OK
>   #130     kmem_cache_iter:OK
>   Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Also simplify the code by using attach routine of the skeleton.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2)
>  * remove unnecessary detach  (Martin)
>  * check pid in syncfs to prevent surprise  (Martin)
>  * remove unnecessary local variable  (Andrii)
>
>  .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++
>  .../bpf/prog_tests/kmem_cache_iter.c          | 28 +++++++++++--------
>  .../selftests/bpf/progs/kmem_cache_iter.c     | 28 +++++++++++++++++++
>  3 files changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index b0668f29f7b394eb..cd8ecd39c3f3c68d 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -582,4 +582,10 @@ extern int bpf_wq_set_callback_impl(struct bpf_wq *w=
q,
>                 unsigned int flags__k, void *aux__ign) __ksym;
>  #define bpf_wq_set_callback(timer, cb, flags) \
>         bpf_wq_set_callback_impl(timer, cb, flags, NULL)
> +
> +struct bpf_iter_kmem_cache;
> +extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __wea=
k __ksym;
> +extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_=
cache *it) __weak __ksym;
> +extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) =
__weak __ksym;
> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/t=
ools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> index 848d8fc9171fae45..778b55bc1f912b98 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> @@ -68,12 +68,20 @@ static void subtest_kmem_cache_iter_check_slabinfo(st=
ruct kmem_cache_iter *skel)
>         fclose(fp);
>  }
>
> +static void subtest_kmem_cache_iter_open_coded(struct kmem_cache_iter *s=
kel)
> +{
> +       skel->bss->tgid =3D getpid();
> +
> +       /* To trigger the open coded iterator attached to the syscall */
> +       syncfs(0);
> +
> +       /* It should be same as we've seen from the explicit iterator */
> +       ASSERT_EQ(skel->bss->open_coded_seen, skel->bss->kmem_cache_seen,=
 "open_code_seen_eq");
> +}
> +
>  void test_kmem_cache_iter(void)
>  {
> -       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>         struct kmem_cache_iter *skel =3D NULL;
> -       union bpf_iter_link_info linfo =3D {};
> -       struct bpf_link *link;
>         char buf[256];
>         int iter_fd;
>
> @@ -81,16 +89,12 @@ void test_kmem_cache_iter(void)
>         if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
>                 return;
>
> -       opts.link_info =3D &linfo;
> -       opts.link_info_len =3D sizeof(linfo);
> -
> -       link =3D bpf_program__attach_iter(skel->progs.slab_info_collector=
, &opts);
> -       if (!ASSERT_OK_PTR(link, "attach_iter"))
> +       if (!ASSERT_OK(kmem_cache_iter__attach(skel), "skel_attach"))
>                 goto destroy;
>
> -       iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.slab_info_co=
llector));
>         if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> -               goto free_link;
> +               goto destroy;
>
>         memset(buf, 0, sizeof(buf));
>         while (read(iter_fd, buf, sizeof(buf) > 0)) {
> @@ -105,11 +109,11 @@ void test_kmem_cache_iter(void)
>                 subtest_kmem_cache_iter_check_task_struct(skel);
>         if (test__start_subtest("check_slabinfo"))
>                 subtest_kmem_cache_iter_check_slabinfo(skel);
> +       if (test__start_subtest("open_coded_iter"))
> +               subtest_kmem_cache_iter_open_coded(skel);
>
>         close(iter_fd);
>
> -free_link:
> -       bpf_link__destroy(link);
>  destroy:
>         kmem_cache_iter__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/=
testing/selftests/bpf/progs/kmem_cache_iter.c
> index 72c9dafecd98406b..e62807caa7593604 100644
> --- a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> +++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> @@ -2,6 +2,8 @@
>  /* Copyright (c) 2024 Google */
>
>  #include "bpf_iter.h"
> +#include "bpf_experimental.h"
> +#include "bpf_misc.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> @@ -30,9 +32,12 @@ struct {
>
>  extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
>
> +unsigned int tgid;
> +
>  /* Result, will be checked by userspace */
>  int task_struct_found;
>  int kmem_cache_seen;
> +int open_coded_seen;
>
>  SEC("iter/kmem_cache")
>  int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> @@ -85,3 +90,26 @@ int BPF_PROG(check_task_struct)
>                 task_struct_found =3D -2;
>         return 0;
>  }
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_syncfs")
> +int open_coded_iter(const void *ctx)
> +{
> +       struct kmem_cache *s;
> +
> +       if (tgid !=3D bpf_get_current_pid_tgid() >> 32)
> +               return 0;

Pls use syscall prog type and prog_run() it.
No need to attach to exotic syscalls and filter by pid.

> +
> +       bpf_for_each(kmem_cache, s) {
> +               struct kmem_cache_result *r;
> +
> +               r =3D bpf_map_lookup_elem(&slab_result, &open_coded_seen)=
;
> +               if (!r)
> +                       break;
> +
> +               open_coded_seen++;
> +
> +               if (r->obj_size !=3D s->size)
> +                       break;

The order of 'if' and ++ should probably be changed ?
Otherwise the last object isn't sufficiently checked.

pw-bot: cr

