Return-Path: <bpf+bounces-46428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742369EA1C9
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC4816547C
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75419DF4B;
	Mon,  9 Dec 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlO6SuTR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11305199239
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783043; cv=none; b=pOawQgbnDOWHgsyHQXSo4gY7dzLrSUfHtzx/gpJtI7tzJgrGv+3LgDB5I63BRy9tnzcNJit5ypLJGtegLwZI0a35D73WuMrKG/uc2Das0Tb9vWEpXWKYDLUcgI2+JvzOyJicP38jvpCE9a0p4UnkmgQ4laZPVyQeDRmk8ntz2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783043; c=relaxed/simple;
	bh=HuOdCZXfJVs/ZI8/bZXk5pcIuewTFQdfJssN+QjP6hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofiwiSRYQiOU8wPkfBU59GlLNmawECqAGdjkXA99lYIxHbTKSZghFfjBTungqfqSg74JuMuXmcFzMUenTuomB9bQZyMOW4eYyN0q8lwempt2lS5omVObugu3bdEYdytwztF0tTCdEDEfLwb7ZQ9XEPNRQNzWuDL59Hjz44ALDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlO6SuTR; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so725ab.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783041; x=1734387841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B+i5dL3xdxmRFat3jkYLVDftVP8cOdtQMKOkI13Mu8=;
        b=KlO6SuTRSxmBWwXA8kP/r/fnt4p67riAYCN0/ijzx8yhGUbiWAlvH+/CeRh15H4Ael
         H+AE+gW76kfeHqbuH0PusqK/5nrdRYycSxFxf5DCSl+iRBAnzk6HKb16hbtHXXVzjYp6
         VaJFM7UA8oBx64t4z/ctbvQPgz45H39UZvqpfPM9hGu7etUZ2eJPtBVH7JFllUlJ0gB5
         o/648SDLRXg0AFn33dzWrHM/JaVtdJUYCi3/ZCWGtbte2pgwouPx69tZKuzZ67oXNWse
         elWpopHvG4Ut7lbNskS4AnIhoBzOQu94LgYmzw5Zku3Anv1ELrv4mR08uRBKUL5w97sC
         rRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783041; x=1734387841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B+i5dL3xdxmRFat3jkYLVDftVP8cOdtQMKOkI13Mu8=;
        b=NtJg1kDlfXQi+1orQ+k+U+0NBgNBoJCJogD2PFszEr2hCbLrhGNYP3gWrrkeb3tjBX
         QSvnaMKUwMjlrYWVBmDxUabyxoq8b9UIJ7zzxxKEqMt4C4sKUU6gdZuzb3j0XpDCeeOc
         rJX/SgTn9HKhFVghk3jDHaISEa1JsHrw83gKCdoSFkUSd6BvFl2+Rk0CPyxACI+En9gn
         feJ3X76FCje1DboUKOwUrQFXlQGX9j/E9X4AnDt5A6QGq6LSM37fDaLZeiQVIe+aQzJ5
         bWTzPqkkU2HlCkRPt9leThokaSj48iMpbyHvJj7Sru5ZyAUrOZxU5oGpvNus5+WFn0Tz
         yc4g==
X-Forwarded-Encrypted: i=1; AJvYcCUqnBvqg85kauUx7Ie47PpGGg0DSPj/D/E8bEubRXuoyIXJ2rK3HXnP60KNC2uF6yS8ieA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr60ZwNyQVGIaQfMbTbeICDm7PNRQTugtaIkUlOg4d4nU2B++n
	LzwwaY4OMtyckYh81osiGHmhapZZYmk5JB8/e9ThFu1h3Vs0l5Bos9ADxZvIvl6neTfXoyN6pE5
	Xh+zO6khnu6NQ1+x/MFleBtCeMT/7Ro41YPzm
X-Gm-Gg: ASbGncuv1h6j+MO0Q7YtVA/ndTw4qUO5tcUQr8fwYhFX9iV76byaFyFLDMGVBQhU3hD
	Obrv1rKj83D81NC12hIhuaxXtZR5Ntk5mSPQM
X-Google-Smtp-Source: AGHT+IGZbL/lCpky6rvDjMtuy2WDIu07ywFy2CNg4s10xa+f8MjMBP3d2X5Jni86xXxZn1D0ckiC3C+ICedb4sP6mKs=
X-Received: by 2002:a05:6e02:32c6:b0:3a7:e0d0:7cf6 with SMTP id
 e9e14a558f8ab-3a9df5337bdmr168305ab.21.1733783040936; Mon, 09 Dec 2024
 14:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108061500.2698340-1-namhyung@kernel.org> <20241108061500.2698340-3-namhyung@kernel.org>
 <Z1ccoNOl4Z8c5DCz@x1> <Z1cdDzXe4QNJe8jL@x1> <Z1dsRk-3RrZra39w@google.com>
In-Reply-To: <Z1dsRk-3RrZra39w@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 14:23:49 -0800
Message-ID: <CAP-5=fU7pVjaabBq4xuPsDw9oYk9Cf2kWF+x58uRYCY2XX13Nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf lock contention: Run BPF slab cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Dec 09, 2024 at 01:38:39PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 09, 2024 at 01:36:52PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Thu, Nov 07, 2024 at 10:14:57PM -0800, Namhyung Kim wrote:
> > > > Recently the kernel got the kmem_cache iterator to traverse metadat=
a of
> > > > slab objects.  This can be used to symbolize dynamic locks in a sla=
b.
> > > >
> > > > The new slab_caches hash map will have the pointer of the kmem_cach=
e as
> > > > a key and save the name and a id.  The id will be saved in the flag=
s
> > > > part of the lock.
> > >
> > > Trying to fix this
> >
> > So you have that struct in tools/perf/util/bpf_skel/vmlinux/vmlinux.h,
> > but then, this kernel is old and doesn't have the kmem_cache iterator,
> > so using the generated vmlinux.h will fail the build.
>
> Thanks for checking this.  I think we handle compatibility issues by
> checking BTF at runtime but this is a build-time issue. :(
>
> I wonder if it's really needed to generate vmlinux.h for perf.  Can we
> simply use the minimal vmlinux.h always?

Agreed, it shouldn't be necessary. There are certain compilation
errors that will happen with a generated one that can't happen with
the minimal. They could be indicative of bugs, like a renamed struct.

Thanks,
Ian

> >
> > > cd . && make GEN_VMLINUX_H=3D1 FEATURES_DUMP=3D/home/acme/git/perf-to=
ols-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=3D/tmp/tmp.DWo9tIFvWU DE=
STDIR=3D/tmp/tmp.ex3iljqLBT
> > >   BUILD:   Doing 'make -j28' parallel build
> [...]
> > >   GEN     /tmp/tmp.DWo9tIFvWU/util/bpf_skel/vmlinux.h
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bpf_prog_profiler.bp=
f.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_leader.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_follower.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/func_latency.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/off_cpu.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/lock_contention.bpf.=
o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/kwork_trace.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/sample_filter.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/kwork_top.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bench_uprobe.bpf.o
> > >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/augmented_raw_syscal=
ls.bpf.o
> > >   GENSKEL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/bench_uprobe.skel.h
> > >   GENSKEL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/func_latency.skel.h
> > > util/bpf_skel/lock_contention.bpf.c:612:28: error: declaration of 'st=
ruct bpf_iter__kmem_cache' will not be visible outside of this function [-W=
error,-Wvisibility]
> > >   612 | int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> > >       |                            ^
> > > util/bpf_skel/lock_contention.bpf.c:614:28: error: incomplete definit=
ion of type 'struct bpf_iter__kmem_cache'
> > >   614 |         struct kmem_cache *s =3D ctx->s;
> > >       |                                ~~~^
> > > util/bpf_skel/lock_contention.bpf.c:612:28: note: forward declaration=
 of 'struct bpf_iter__kmem_cache'
> > >   612 | int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> > >       |                            ^
> > > 2 errors generated.
> > > make[4]: *** [Makefile.perf:1248: /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.=
tmp/lock_contention.bpf.o] Error 1
> > > make[4]: *** Waiting for unfinished jobs....
> > > make[3]: *** [Makefile.perf:292: sub-make] Error 2
> > > make[2]: *** [Makefile:76: all] Error 2
> > > make[1]: *** [tests/make:344: make_gen_vmlinux_h_O] Error 1
> > > make: *** [Makefile:109: build-test] Error 2
> > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > >
> > > real        3m43.896s
> > > user        29m30.716s
> > > sys 6m36.609s
> > > =E2=AC=A2 [acme@toolbox perf-tools-next]$
> > >
> > >
> > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/bpf_lock_contention.c         | 50 +++++++++++++++=
++++
> > > >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 28 +++++++++++
> > > >  tools/perf/util/bpf_skel/lock_data.h          | 12 +++++
> > > >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  8 +++
> > > >  4 files changed, 98 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/uti=
l/bpf_lock_contention.c
> > > > index 41a1ad08789511c3..558590c3111390fc 100644
> > > > --- a/tools/perf/util/bpf_lock_contention.c
> > > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > > @@ -12,12 +12,59 @@
> > > >  #include <linux/zalloc.h>
> > > >  #include <linux/string.h>
> > > >  #include <bpf/bpf.h>
> > > > +#include <bpf/btf.h>
> > > >  #include <inttypes.h>
> > > >
> > > >  #include "bpf_skel/lock_contention.skel.h"
> > > >  #include "bpf_skel/lock_data.h"
> > > >
> > > >  static struct lock_contention_bpf *skel;
> > > > +static bool has_slab_iter;
> > > > +
> > > > +static void check_slab_cache_iter(struct lock_contention *con)
> > > > +{
> > > > + struct btf *btf =3D btf__load_vmlinux_btf();
> > > > + s32 ret;
> > > > +
> > > > + if (btf =3D=3D NULL) {
> > > > +         pr_debug("BTF loading failed: %s\n", strerror(errno));
> > > > +         return;
> > > > + }
> > > > +
> > > > + ret =3D btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_K=
IND_STRUCT);
> > > > + if (ret < 0) {
> > > > +         bpf_program__set_autoload(skel->progs.slab_cache_iter, fa=
lse);
> > > > +         pr_debug("slab cache iterator is not available: %d\n", re=
t);
> > > > +         goto out;
> > > > + }
> > > > +
> > > > + has_slab_iter =3D true;
> > > > +
> > > > + bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entr=
ies);
> > > > +out:
> > > > + btf__free(btf);
> > > > +}
> > > > +
> > > > +static void run_slab_cache_iter(void)
> > > > +{
> > > > + int fd;
> > > > + char buf[256];
> > > > +
> > > > + if (!has_slab_iter)
> > > > +         return;
> > > > +
> > > > + fd =3D bpf_iter_create(bpf_link__fd(skel->links.slab_cache_iter))=
;
> > > > + if (fd < 0) {
> > > > +         pr_debug("cannot create slab cache iter: %d\n", fd);
> > > > +         return;
> > > > + }
> > > > +
> > > > + /* This will run the bpf program */
> > > > + while (read(fd, buf, sizeof(buf)) > 0)
> > > > +         continue;
> > > > +
> > > > + close(fd);
> > > > +}
> > > >
> > > >  int lock_contention_prepare(struct lock_contention *con)
> > > >  {
> > > > @@ -109,6 +156,8 @@ int lock_contention_prepare(struct lock_content=
ion *con)
> > > >                   skel->rodata->use_cgroup_v2 =3D 1;
> > > >   }
> > > >
> > > > + check_slab_cache_iter(con);
> > > > +
> > > >   if (lock_contention_bpf__load(skel) < 0) {
> > > >           pr_err("Failed to load lock-contention BPF skeleton\n");
> > > >           return -1;
> > > > @@ -304,6 +353,7 @@ static void account_end_timestamp(struct lock_c=
ontention *con)
> > > >
> > > >  int lock_contention_start(void)
> > > >  {
> > > > + run_slab_cache_iter();
> > > >   skel->bss->enabled =3D 1;
> > > >   return 0;
> > > >  }
> > > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools=
/perf/util/bpf_skel/lock_contention.bpf.c
> > > > index 1069bda5d733887f..fd24ccb00faec0ba 100644
> > > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > > @@ -100,6 +100,13 @@ struct {
> > > >   __uint(max_entries, 1);
> > > >  } cgroup_filter SEC(".maps");
> > > >
> > > > +struct {
> > > > + __uint(type, BPF_MAP_TYPE_HASH);
> > > > + __uint(key_size, sizeof(long));
> > > > + __uint(value_size, sizeof(struct slab_cache_data));
> > > > + __uint(max_entries, 1);
> > > > +} slab_caches SEC(".maps");
> > > > +
> > > >  struct rw_semaphore___old {
> > > >   struct task_struct *owner;
> > > >  } __attribute__((preserve_access_index));
> > > > @@ -136,6 +143,8 @@ int perf_subsys_id =3D -1;
> > > >
> > > >  __u64 end_ts;
> > > >
> > > > +__u32 slab_cache_id;
> > > > +
> > > >  /* error stat */
> > > >  int task_fail;
> > > >  int stack_fail;
> > > > @@ -563,4 +572,23 @@ int BPF_PROG(end_timestamp)
> > > >   return 0;
> > > >  }
> > > >
> > > > +SEC("iter/kmem_cache")
> > > > +int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> > > > +{
> > > > + struct kmem_cache *s =3D ctx->s;
> > > > + struct slab_cache_data d;
> > > > +
> > > > + if (s =3D=3D NULL)
> > > > +         return 0;
> > > > +
> > > > + d.id =3D ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;
> > > > + bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name);
> > > > +
> > > > + if (d.id >=3D LCB_F_SLAB_ID_END)
> > > > +         return 0;
> > > > +
> > > > + bpf_map_update_elem(&slab_caches, &s, &d, BPF_NOEXIST);
> > > > + return 0;
> > > > +}
> > > > +
> > > >  char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> > > > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util=
/bpf_skel/lock_data.h
> > > > index 4f0aae5483745dfa..c15f734d7fc4aecb 100644
> > > > --- a/tools/perf/util/bpf_skel/lock_data.h
> > > > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > > > @@ -32,9 +32,16 @@ struct contention_task_data {
> > > >  #define LCD_F_MMAP_LOCK          (1U << 31)
> > > >  #define LCD_F_SIGHAND_LOCK       (1U << 30)
> > > >
> > > > +#define LCB_F_SLAB_ID_SHIFT      16
> > > > +#define LCB_F_SLAB_ID_START      (1U << 16)
> > > > +#define LCB_F_SLAB_ID_END        (1U << 26)
> > > > +#define LCB_F_SLAB_ID_MASK       0x03FF0000U
> > > > +
> > > >  #define LCB_F_TYPE_MAX           (1U << 7)
> > > >  #define LCB_F_TYPE_MASK          0x0000007FU
> > > >
> > > > +#define SLAB_NAME_MAX  28
> > > > +
> > > >  struct contention_data {
> > > >   u64 total_time;
> > > >   u64 min_time;
> > > > @@ -55,4 +62,9 @@ enum lock_class_sym {
> > > >   LOCK_CLASS_RQLOCK,
> > > >  };
> > > >
> > > > +struct slab_cache_data {
> > > > + u32 id;
> > > > + char name[SLAB_NAME_MAX];
> > > > +};
> > > > +
> > > >  #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
> > > > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/per=
f/util/bpf_skel/vmlinux/vmlinux.h
> > > > index 4dcad7b682bdee9c..7b81d3173917fdb5 100644
> > > > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > > @@ -195,4 +195,12 @@ struct bpf_perf_event_data_kern {
> > > >   */
> > > >  struct rq {};
> > > >
> > > > +struct kmem_cache {
> > > > + const char *name;
> > > > +} __attribute__((preserve_access_index));
> > > > +
> > > > +struct bpf_iter__kmem_cache {
> > > > + struct kmem_cache *s;
> > > > +} __attribute__((preserve_access_index));
> > > > +
> > > >  #endif // __VMLINUX_H
> > > > --
> > > > 2.47.0.277.g8800431eea-goog

