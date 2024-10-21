Return-Path: <bpf+bounces-42710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7FC9A943B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0522838F5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CACF1FF02E;
	Mon, 21 Oct 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8SvN1oR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738821E1027;
	Mon, 21 Oct 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553824; cv=none; b=uP55O3IdtB5dMNL5Px6q9r4lkMWewtK1BOL/h3fbDc82FrKkKbjWRcKO5DGPsZrKKFh8lFkpYfMdodH65un6udYClgsawiiWpGjRjV09ggTlZzWxHX0El4LgqO4YMzhjNwBfAZ1xUrN/4ImfCPayUsOsvnvjzOj2Fm74eieFMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553824; c=relaxed/simple;
	bh=XbeAmumm1Uc6TapNwNAPK1bkMMTYdmZP+q4xYRRqa1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSRoiElZAJJh7KKkaAOdWkU3P3Nf/5ik14EjNZsCqsVEr6BmoNx+S1VzsrT0lE6BU/dpUha2QDFoAaJ0NXTRBiDU7ilocVCLTYX8kPjAJj1MrGdp1rtB6zelCd3308vBBY/+mXIWI0EMhbhdPa4iuksPK+88IM8y8u8S74czIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8SvN1oR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so3877365b3a.3;
        Mon, 21 Oct 2024 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729553822; x=1730158622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiOuzXkFiktlFoeHEgqvfCbxiJVo+5LSZWaoo5OnMxc=;
        b=f8SvN1oRPcvCYqiEpRakRCa5bIt0cqPt6V+X6cvDfH22vHAjirZMS/ovXXDI6H4mYw
         5CPVeEjLn2gwbcWSnUjWIi26Tc9ESt/K/XYFBcAerElBryUZWljnNeLYYr07QVWC+DOE
         7s/XnFolF5BbCFPCNloiU3SX2HxiOFEL1fK04UJUIAjnQCZmg2HiOUKWTY26TRejQn+k
         rz7sSri5CIK6g91+nuWdoJmjr56ZoNSeNZ3UE1nrhtsRM6r+KMQXXp92JhKgiQO3/gv3
         sncEsBwU1WBQHYQRMS3YswRaklKagUawW9oeAnArJ0+DCVzDKjwfKDt3XH/PUVLbOQs2
         kbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553822; x=1730158622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiOuzXkFiktlFoeHEgqvfCbxiJVo+5LSZWaoo5OnMxc=;
        b=kZr035wxBlpIK4NJfkJCqZ5pZypU/K+vI3OVYOKE1sxZgRwSQr6GrSwWxyVN/yzZk5
         fj7fAa3BQqhgCGe3SI5veKMiLkh4H461GGhKkZTazDycN7b+lOFSwaWpbx1JLzYxUSAP
         cKFT0zlrva+G67JJajRsnrGpdMFVys/2CGoEW2cfIG2mTvIaFGygdcVX9DVsHbl99LPu
         ui9z2pAJBlwZCxgCj6iiX3yZCNOicQrxIgraHtHUyeOZW97K1fPTmf38MFGOHvi1rLWg
         jEvXvqZj5S+/PRWDvDLgqQQq+cGD14k3UqKrt/gAKFe0pUR9uLUC/WvGy7nw3YKp1zY4
         CTYA==
X-Forwarded-Encrypted: i=1; AJvYcCVM/Pt0wwiFlO4ABxgdiUHzzm2WZxiDnCwXVw2tB9DBjZfSXHRrDZVd/xGuEbznZhHiwMIov3rbLxeehC6j@vger.kernel.org, AJvYcCW5Sq0W8ILA2gLfzmzuE7/DMXlN1aPRAX6n0eTXTx67LF8XxjSkmkdaIrYToG1UCBmh7EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza77xo/0QOzYhldsxEwcnvDIt15D0icpPQ0njVGYqCjsV7XUOv
	dQd1qi8U8c+B3dTMSWfQDHtKNYL9ZRdk7dk4sQFOaTCY/QspvJwFnJq4GXZI7ivDw1EqyVkrqri
	6EQGvOQSN/JjN7XksDO7eieoHRxM=
X-Google-Smtp-Source: AGHT+IEtz0XEMk38cJDpNpWMEq5fgDFgJhTKmLnEjsUaLxZfm+96i43FnIAyYxNOpQoBhYf8U8Kjt7PD0o90frCtc28=
X-Received: by 2002:a05:6a00:2d28:b0:71e:5a6a:94ca with SMTP id
 d2e1a72fcca58-71ee5053fd0mr1287075b3a.19.1729553821544; Mon, 21 Oct 2024
 16:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017080604.541872-1-namhyung@kernel.org> <20241017080604.541872-2-namhyung@kernel.org>
In-Reply-To: <20241017080604.541872-2-namhyung@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:36:49 -0700
Message-ID: <CAEf4BzaipQcGFWQu+o5d+aXVMN17LDnHOv9MwrZis1wpiCWwCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for open coded
 kmem_cache iter
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:06=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
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
>  .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++
>  .../bpf/prog_tests/kmem_cache_iter.c          | 28 +++++++++++--------
>  .../selftests/bpf/progs/kmem_cache_iter.c     | 24 ++++++++++++++++
>  3 files changed, 46 insertions(+), 12 deletions(-)
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

we should be getting this from vmlinux.h nowadays, so this is probably
unnecessary

>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/t=
ools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> index 848d8fc9171fae45..a1fd3bc57c0b21bb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> @@ -68,12 +68,18 @@ static void subtest_kmem_cache_iter_check_slabinfo(st=
ruct kmem_cache_iter *skel)
>         fclose(fp);
>  }
>
> +static void subtest_kmem_cache_iter_open_coded(struct kmem_cache_iter *s=
kel)
> +{
> +       /* To trigger the open coded iterator attached to the syscall */
> +       syncfs(0);

what Martin said, you still need to filter by PID

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
> @@ -81,16 +87,12 @@ void test_kmem_cache_iter(void)
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
> +               goto detach;
>
>         memset(buf, 0, sizeof(buf));
>         while (read(iter_fd, buf, sizeof(buf) > 0)) {
> @@ -105,11 +107,13 @@ void test_kmem_cache_iter(void)
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
> +detach:
> +       kmem_cache_iter__detach(skel);
>  destroy:
>         kmem_cache_iter__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/=
testing/selftests/bpf/progs/kmem_cache_iter.c
> index 72c9dafecd98406b..4c44aa279a5328fe 100644
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
> @@ -33,6 +35,7 @@ extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) =
__ksym;
>  /* Result, will be checked by userspace */
>  int task_struct_found;
>  int kmem_cache_seen;
> +int open_coded_seen;
>
>  SEC("iter/kmem_cache")
>  int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> @@ -85,3 +88,24 @@ int BPF_PROG(check_task_struct)
>                 task_struct_found =3D -2;
>         return 0;
>  }
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_syncfs")
> +int open_coded_iter(const void *ctx)
> +{
> +       struct kmem_cache *s;
> +
> +       bpf_for_each(kmem_cache, s) {
> +               struct kmem_cache_result *r;
> +               int idx =3D open_coded_seen;
> +
> +               r =3D bpf_map_lookup_elem(&slab_result, &idx);

nit: you don't need idx, just `&open_coded_seen` should be fine, I think

> +               if (r =3D=3D NULL)

nit: !r

> +                       break;
> +
> +               open_coded_seen++;
> +
> +               if (r->obj_size !=3D s->size)
> +                       break;
> +       }
> +       return 0;
> +}
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

