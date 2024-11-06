Return-Path: <bpf+bounces-44141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD839BF75A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A890283C96
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48E20BB51;
	Wed,  6 Nov 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmQVIP+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEA209681;
	Wed,  6 Nov 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921793; cv=none; b=J7ETe7lhMy7fpTvjkabLCqUvnDo39m6HrJxdsTK6Os131gw4zyVOY4cR8U9dMkux1iUgpFJH/qz/cbTvl+LxRZaFG2d8Qh+01TIDqIrxw0Olw9zMDY5xxQl5I9fxfmiKgRNc6w/KUIG9lUS3bJ8enuHwXkEoNHgUeUsj0/gaTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921793; c=relaxed/simple;
	bh=FwD2AhzLym3tIs//QavLK91orPyfFO2s6FAPQCF7I6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rh0/VrqNuhoPRBaqpkL+TSdVIM0TFAJ/9kLCW9pcVzMs63v8Lr9nZB5IaEeGiA8AV9g8ytfCDnHjPEB7moPW1NvPpGym/Q5vn58G0kSf46gHrarOI2YRefhTgqA/2OWSaZRJ9clEdMnyOQfNwCiQ8wBfF7UV1deU5uTOvv6SmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmQVIP+E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdbe608b3so2131805ad.1;
        Wed, 06 Nov 2024 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730921791; x=1731526591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLMfViTBLhMu6Hmd6680gXcegnnfvf6VkiDpRB1s/bM=;
        b=mmQVIP+EUOc9J6n2HHwYaS1hqjm81U3L0Se9TE2dcA8z5cpn1Fu/Zh64cJbbssXTB+
         iKa5IOUCwNcHcTfUSSh2Y8hTYNPz3T+VvsPOpMr5XWaniGtwZ7CjDG86uHUwvS06jfAz
         OZSmX42hb9TxmLPCqFKGZXOZTWGlbOcgFzziz5MlCDOxZlXtWSBvmb8CgANvlsSYWjSg
         BRmCMMXeFDVPOUjiqqf/CrbyNmtsgbUC76iv+3pOu3L9xHsgrqyOp90sD2sdozPir7Jz
         P+Q+ZmWS9/nYbulGNFJzPYBGKReoSiGOzQpcnH2Xf+nD4tqEeISVRR4PWPiNj0uXZAM6
         bI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730921791; x=1731526591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLMfViTBLhMu6Hmd6680gXcegnnfvf6VkiDpRB1s/bM=;
        b=DEiiQLKLbAapWyji6gi5oXoQUCR1DANbZ932+sFwQJpYk/PPV1jVbGqa/Y2NeYzRGZ
         6lEvEpU0m2CEXcAUhVInPkigFdbmlikKmh60Yj+Q0E7r0l/X+3zhsUQRggjFTPrxHClJ
         etB1USU2jt/PlgfzEbYyFI1+xf4SkismWPPg/ezzuXTzW80nFYieqcC3V4ZOVibvsIFc
         b6qg5tDEW44m7t3ftU2E8etyRAWacLl6dXlvR37k/fxhYcmzsH+GkDCQ9Oc9Oxs8fLME
         FpD5ps2Tri6+kUQbDD3S1pTcEj2furt8lkoIUVjyEtADoWOt4QQG8UgzecfX+P+c3Bbl
         j/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpIsAHCsj+03GTiGQl95hY4dnXAZhUYfpoBxvi8fkwrqAAqSjih4uN228oRkBhaPd9RiLPb+OzaaPCn67U6TCPqg==@vger.kernel.org, AJvYcCWDvkX/7xRrUnHKS+oUrevlr02ciG4y36x/nayh3QHISeCbXpoPxqc2pIpuOQlUoSeaiMg=@vger.kernel.org, AJvYcCWhSj6QUcSm8cC0Dip82O5uPwqKARdd5JCd9BVHgPUdDCqMg+oAgPqC/FUgcnHA8Iektr10QeQmz/xI7guI@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJBXZEIv47TmU0UuVO0Xqxq6l5u+8+ocJdDXIZodDZQtIo4kd
	P1SXDK0DdukjmvpA4Ucbm6wqMwewex1wp8nP/fxtCq/bhL1EeY5KMG/Hjt65zyBhVgl8K7JdHTD
	6yik1ZDDFNjSh1ccuN+E8TKgME4s=
X-Google-Smtp-Source: AGHT+IGbxusoEznnEA5Rn9lqSQ8l2811obJCIECsVRNP1dvG/8eQSbkqOUKXou3V6w+eP5kl/pGMnp2dzh8eOcDraSM=
X-Received: by 2002:a17:902:f546:b0:211:18bf:e91d with SMTP id
 d9443c01a7336-21118bfe962mr320862175ad.27.1730921791072; Wed, 06 Nov 2024
 11:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105172635.2463800-1-namhyung@kernel.org> <20241105172635.2463800-3-namhyung@kernel.org>
In-Reply-To: <20241105172635.2463800-3-namhyung@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 11:36:19 -0800
Message-ID: <CAEf4BzaL71O-odNtE88OwwZcVkRPw2uRaBgRAZYcoVo+G+38Mg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf lock contention: Run BPF slab cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Recently the kernel got the kmem_cache iterator to traverse metadata of
> slab objects.  This can be used to symbolize dynamic locks in a slab.
>
> The new slab_caches hash map will have the pointer of the kmem_cache as
> a key and save the name and a id.  The id will be saved in the flags
> part of the lock.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_lock_contention.c         | 51 +++++++++++++++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 28 ++++++++++
>  tools/perf/util/bpf_skel/lock_data.h          | 12 +++++
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  8 +++
>  4 files changed, 99 insertions(+)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index 41a1ad08789511c3..a2efd40897bad316 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -12,12 +12,60 @@
>  #include <linux/zalloc.h>
>  #include <linux/string.h>
>  #include <bpf/bpf.h>
> +#include <bpf/btf.h>
>  #include <inttypes.h>
>
>  #include "bpf_skel/lock_contention.skel.h"
>  #include "bpf_skel/lock_data.h"
>
>  static struct lock_contention_bpf *skel;
> +static bool has_slab_iter;
> +
> +static void check_slab_cache_iter(struct lock_contention *con)
> +{
> +       struct btf *btf =3D btf__load_vmlinux_btf();
> +       s32 ret;
> +
> +       ret =3D libbpf_get_error(btf);

please don't use libbpf_get_error() in new code. I left that API for
cases when user might want to support both per-1.0 libbpf and 1.0+,
but by now I don't think you should be caring about <1.0 versions. And
in 1.0+, you'll get btf =3D=3D NULL on error, and errno will be set to
error. So just check errno directly.

> +       if (ret) {
> +               pr_debug("BTF loading failed: %d\n", ret);
> +               return;
> +       }
> +
> +       ret =3D btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_K=
IND_STRUCT);
> +       if (ret < 0) {
> +               bpf_program__set_autoload(skel->progs.slab_cache_iter, fa=
lse);
> +               pr_debug("slab cache iterator is not available: %d\n", re=
t);
> +               goto out;
> +       }
> +
> +       has_slab_iter =3D true;
> +
> +       bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entr=
ies);
> +out:
> +       btf__free(btf);
> +}
> +
> +static void run_slab_cache_iter(void)
> +{
> +       int fd;
> +       char buf[256];
> +
> +       if (!has_slab_iter)
> +               return;
> +
> +       fd =3D bpf_iter_create(bpf_link__fd(skel->links.slab_cache_iter))=
;
> +       if (fd < 0) {
> +               pr_debug("cannot create slab cache iter: %d\n", fd);
> +               return;
> +       }
> +
> +       /* This will run the bpf program */
> +       while (read(fd, buf, sizeof(buf)) > 0)
> +               continue;
> +
> +       close(fd);
> +}
>
>  int lock_contention_prepare(struct lock_contention *con)
>  {
> @@ -109,6 +157,8 @@ int lock_contention_prepare(struct lock_contention *c=
on)
>                         skel->rodata->use_cgroup_v2 =3D 1;
>         }
>
> +       check_slab_cache_iter(con);
> +
>         if (lock_contention_bpf__load(skel) < 0) {
>                 pr_err("Failed to load lock-contention BPF skeleton\n");
>                 return -1;
> @@ -304,6 +354,7 @@ static void account_end_timestamp(struct lock_content=
ion *con)
>
>  int lock_contention_start(void)
>  {
> +       run_slab_cache_iter();
>         skel->bss->enabled =3D 1;
>         return 0;
>  }
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 1069bda5d733887f..fd24ccb00faec0ba 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -100,6 +100,13 @@ struct {
>         __uint(max_entries, 1);
>  } cgroup_filter SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(key_size, sizeof(long));
> +       __uint(value_size, sizeof(struct slab_cache_data));
> +       __uint(max_entries, 1);
> +} slab_caches SEC(".maps");
> +
>  struct rw_semaphore___old {
>         struct task_struct *owner;
>  } __attribute__((preserve_access_index));
> @@ -136,6 +143,8 @@ int perf_subsys_id =3D -1;
>
>  __u64 end_ts;
>
> +__u32 slab_cache_id;
> +
>  /* error stat */
>  int task_fail;
>  int stack_fail;
> @@ -563,4 +572,23 @@ int BPF_PROG(end_timestamp)
>         return 0;
>  }
>
> +SEC("iter/kmem_cache")
> +int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> +{
> +       struct kmem_cache *s =3D ctx->s;
> +       struct slab_cache_data d;
> +
> +       if (s =3D=3D NULL)
> +               return 0;
> +
> +       d.id =3D ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;
> +       bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name);
> +
> +       if (d.id >=3D LCB_F_SLAB_ID_END)
> +               return 0;
> +
> +       bpf_map_update_elem(&slab_caches, &s, &d, BPF_NOEXIST);
> +       return 0;
> +}
> +
>  char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_s=
kel/lock_data.h
> index 4f0aae5483745dfa..c15f734d7fc4aecb 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -32,9 +32,16 @@ struct contention_task_data {
>  #define LCD_F_MMAP_LOCK                (1U << 31)
>  #define LCD_F_SIGHAND_LOCK     (1U << 30)
>
> +#define LCB_F_SLAB_ID_SHIFT    16
> +#define LCB_F_SLAB_ID_START    (1U << 16)
> +#define LCB_F_SLAB_ID_END      (1U << 26)
> +#define LCB_F_SLAB_ID_MASK     0x03FF0000U
> +
>  #define LCB_F_TYPE_MAX         (1U << 7)
>  #define LCB_F_TYPE_MASK                0x0000007FU
>
> +#define SLAB_NAME_MAX  28
> +
>  struct contention_data {
>         u64 total_time;
>         u64 min_time;
> @@ -55,4 +62,9 @@ enum lock_class_sym {
>         LOCK_CLASS_RQLOCK,
>  };
>
> +struct slab_cache_data {
> +       u32 id;
> +       char name[SLAB_NAME_MAX];
> +};
> +
>  #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
> diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util=
/bpf_skel/vmlinux/vmlinux.h
> index 4dcad7b682bdee9c..7b81d3173917fdb5 100644
> --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> @@ -195,4 +195,12 @@ struct bpf_perf_event_data_kern {
>   */
>  struct rq {};
>
> +struct kmem_cache {
> +       const char *name;
> +} __attribute__((preserve_access_index));
> +
> +struct bpf_iter__kmem_cache {
> +       struct kmem_cache *s;
> +} __attribute__((preserve_access_index));
> +
>  #endif // __VMLINUX_H
> --
> 2.47.0.199.ga7371fff76-goog
>
>

