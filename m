Return-Path: <bpf+bounces-40537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C7989971
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 05:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057F72804E0
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C42D7B8;
	Mon, 30 Sep 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS0spes9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C43C466;
	Mon, 30 Sep 2024 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666708; cv=none; b=irbJFAE+YjwNeXCnOgkso3G7ozJE9dAU5vfBuVlc4LSALPMPUvfVdBw11gwx7hO5JN4IHBTxkt8A8SHGOQHCc3pVq8cuzxtZftpeLVDbSt2Cm5nuc6iD4XU2v269XSu64F+piNnSCs6w4mLZ6VrPeEfhdEqvFez+Xd+iWL57y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666708; c=relaxed/simple;
	bh=NJUlv1zpEIP1vA6lSu7qXConEljs/5Q0eKYJDcu+7LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTDfgNjjcoBhxN3V/kDGT63W577R419/MjdUsbHnrfWYROr/7PGiiytG3ShIoLM+rZKIgh/Y1kAz2FTFMX5YiukmrNl2IDDj+CsigxB/ZrxJ7IC3ocC6wyJ9KDEqQVFJubjbkKWBu3IP97M1Zp471D8At8I4HbcVCJ86lrMwwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS0spes9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398a26b64fso2012213e87.3;
        Sun, 29 Sep 2024 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727666704; x=1728271504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xptrEtzFtFOhGhhDu38fIaDiqDAME1wxUs6nvetbUTk=;
        b=bS0spes9dHFqDT60R+/WjXvVfeAuDXxP2GO0P8aMpP8zaYZsv45HqVDg6x0x5iM4Mv
         FJ0sAaMHNKrC/sSQaI9/yTLFxXIxtvxph884RCHY0wkrAwKjCGGJWXwIbYbcDfwYI8vh
         cWOoXU9MkeIl6R/bnf4clFnN2+t6sFclSAwLNecId3qudQw+/ZCUIAyYvVayIo8uPRVx
         51E+KfE23ti1zX3MNQBpX3st/3Y242ldWAu7voQ+e/mMb3oXlJwyHQ846bX3cqT73bv8
         32nQu+ttUWUmCkEdSUdC+rabuFW/qiOxZg55paFn9ZzLVC5ZvVgQvtsDIEuqPmMATPg+
         jWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727666704; x=1728271504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xptrEtzFtFOhGhhDu38fIaDiqDAME1wxUs6nvetbUTk=;
        b=klH+MT01Jfa+adNJIagkJ7HyM0gNyXGqne6V/wldKGJMVE60O3WrrvNwuTm23LQe3O
         68ds4DRLTfooxGjVNdHFabgMG4uUoeq1399ezQ9h7Jvu/BPwFcUMZZoC4EwWwH0SXCz4
         zfmSm2Rg7MZfNFdlEQb0QXXaT0lTCJBrCC+4ufwbGdlK7WzxGrCpIE/iqqBsp3lzDeNK
         rACVfDEdGHh6O9QlPzEFlP6TKQYeMdyOIqYwtxeN97nxKSDTsPXhBxaHQQlmpAvAW2IC
         g3VFPmUwuloHODXEVloxYCurCmLAscDYV2cCpFE6z1earrt63ChXynvjKuRQdlv7dOGH
         SR9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhZ8e363tlm+ngPvTuaMG6ZH0HyqfSBeLxq3N5q066dheekZd7cqyxPVPCuRa85Z0aIwKxVDTihp6+bIKq@vger.kernel.org, AJvYcCXxvrSJymNDQ1PJi2hKjD+iIzqhg+b3mi+LC0q7z+R4JXK6G5fivVxJvOTJIKaeqIfevTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZ9NEd/cKT6OxSsoFVOfK05mKKy4gTw/lnwseyYbF61IT6oPK
	Htftt7fngenNgFsvfQ5BCvwehIB633hF2G1XHsDJ3DFTgszIMNPJ/t9R+hbtVN8A9kvB/Thvf+D
	EtgJ3SZZKME0F9Z4Wl2WuQeKM0IA=
X-Google-Smtp-Source: AGHT+IELe+2NOBUdZEI+ghESbtr3V11lcC/22EdAwVAOqSICs5O2qdB8ektR+NGrKCr9D9/eubpAvuLCvbIyLZsdyYU=
X-Received: by 2002:a05:6512:1047:b0:537:a855:7d6f with SMTP id
 2adb3069b0e04-5389fc4bc4fmr4472211e87.34.1727666704290; Sun, 29 Sep 2024
 20:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927184133.968283-1-namhyung@kernel.org> <20240927184133.968283-4-namhyung@kernel.org>
 <ZvjwEH3QXkjUCu8Z@google.com> <CAB=+i9Sm4UEhGy-jzsZEs1Q6KQCVdbnu_eAiRzXz=sRC-3H6Uw@mail.gmail.com>
 <ZvoKYFEx9_h_6zyf@google.com>
In-Reply-To: <ZvoKYFEx9_h_6zyf@google.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Mon, 30 Sep 2024 12:24:52 +0900
Message-ID: <CAB=+i9TQGnKdt+5Cdg4kjE1AqHgo3MiSvDmr_TarLHw6xGZGog@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 3/3] selftests/bpf: Add a test for kmem_cache_iter
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
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:18=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello Hyeonggon,
>
> On Sun, Sep 29, 2024 at 11:27:25PM +0900, Hyeonggon Yoo wrote:
> > On Sun, Sep 29, 2024 at 3:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Fri, Sep 27, 2024 at 11:41:33AM -0700, Namhyung Kim wrote:
> > > > The test traverses all slab caches using the kmem_cache_iter and ch=
eck
> > > > if current task's pointer is from "task_struct" slab cache.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  .../bpf/prog_tests/kmem_cache_iter.c          | 64 +++++++++++++++=
+++
> > > >  tools/testing/selftests/bpf/progs/bpf_iter.h  |  7 ++
> > > >  .../selftests/bpf/progs/kmem_cache_iter.c     | 66 +++++++++++++++=
++++
> > > >  3 files changed, 137 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cac=
he_iter.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_it=
er.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter=
.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > > > new file mode 100644
> > > > index 0000000000000000..814bcc453e9f3ccd
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > > > @@ -0,0 +1,64 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2024 Google */
> > > > +
> > > > +#include <test_progs.h>
> > > > +#include <bpf/libbpf.h>
> > > > +#include <bpf/btf.h>
> > > > +#include "kmem_cache_iter.skel.h"
> > > > +
> > > > +static void test_kmem_cache_iter_check_task(struct kmem_cache_iter=
 *skel)
> > > > +{
> > > > +     LIBBPF_OPTS(bpf_test_run_opts, opts,
> > > > +             .flags =3D BPF_F_TEST_RUN_ON_CPU,
> > > > +     );
> > > > +     int prog_fd =3D bpf_program__fd(skel->progs.check_task_struct=
);
> > > > +
> > > > +     /* get task_struct and check it if's from a slab cache */
> > > > +     bpf_prog_test_run_opts(prog_fd, &opts);
> > > > +
> > > > +     /* the BPF program should set 'found' variable */
> > > > +     ASSERT_EQ(skel->bss->found, 1, "found task_struct");
> > >
> > > Hmm.. I'm seeing a failure with found being -1, which means ...
> > >
> > > > +}
> > > > +
> > > > +void test_kmem_cache_iter(void)
> > > > +{
> > > > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > > > +     struct kmem_cache_iter *skel =3D NULL;
> > > > +     union bpf_iter_link_info linfo =3D {};
> > > > +     struct bpf_link *link;
> > > > +     char buf[1024];
> > > > +     int iter_fd;
> > > > +
> > > > +     skel =3D kmem_cache_iter__open_and_load();
> > > > +     if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
> > > > +             return;
> > > > +
> > > > +     opts.link_info =3D &linfo;
> > > > +     opts.link_info_len =3D sizeof(linfo);
> > > > +
> > > > +     link =3D bpf_program__attach_iter(skel->progs.slab_info_colle=
ctor, &opts);
> > > > +     if (!ASSERT_OK_PTR(link, "attach_iter"))
> > > > +             goto destroy;
> > > > +
> > > > +     iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> > > > +     if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> > > > +             goto free_link;
> > > > +
> > > > +     memset(buf, 0, sizeof(buf));
> > > > +     while (read(iter_fd, buf, sizeof(buf) > 0)) {
> > > > +             /* read out all contents */
> > > > +             printf("%s", buf);
> > > > +     }
> > > > +
> > > > +     /* next reads should return 0 */
> > > > +     ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
> > > > +
> > > > +     test_kmem_cache_iter_check_task(skel);
> > > > +
> > > > +     close(iter_fd);
> > > > +
> > > > +free_link:
> > > > +     bpf_link__destroy(link);
> > > > +destroy:
> > > > +     kmem_cache_iter__destroy(skel);
> > > > +}
> > > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/t=
esting/selftests/bpf/progs/bpf_iter.h
> > > > index c41ee80533ca219a..3305dc3a74b32481 100644
> > > > --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> > > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> > > > @@ -24,6 +24,7 @@
> > > >  #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
> > > >  #define BTF_F_ZERO BTF_F_ZERO___not_used
> > > >  #define bpf_iter__ksym bpf_iter__ksym___not_used
> > > > +#define bpf_iter__kmem_cache bpf_iter__kmem_cache___not_used
> > > >  #include "vmlinux.h"
> > > >  #undef bpf_iter_meta
> > > >  #undef bpf_iter__bpf_map
> > > > @@ -48,6 +49,7 @@
> > > >  #undef BTF_F_PTR_RAW
> > > >  #undef BTF_F_ZERO
> > > >  #undef bpf_iter__ksym
> > > > +#undef bpf_iter__kmem_cache
> > > >
> > > >  struct bpf_iter_meta {
> > > >       struct seq_file *seq;
> > > > @@ -165,3 +167,8 @@ struct bpf_iter__ksym {
> > > >       struct bpf_iter_meta *meta;
> > > >       struct kallsym_iter *ksym;
> > > >  };
> > > > +
> > > > +struct bpf_iter__kmem_cache {
> > > > +     struct bpf_iter_meta *meta;
> > > > +     struct kmem_cache *s;
> > > > +} __attribute__((preserve_access_index));
> > > > diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/=
tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> > > > new file mode 100644
> > > > index 0000000000000000..3f6ec15a1bf6344c
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> > > > @@ -0,0 +1,66 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2024 Google */
> > > > +
> > > > +#include "bpf_iter.h"
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +
> > > > +char _license[] SEC("license") =3D "GPL";
> > > > +
> > > > +#define SLAB_NAME_MAX  256
> > > > +
> > > > +struct {
> > > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > > +     __uint(key_size, sizeof(void *));
> > > > +     __uint(value_size, SLAB_NAME_MAX);
> > > > +     __uint(max_entries, 1024);
> > > > +} slab_hash SEC(".maps");
> > > > +
> > > > +extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
> > > > +
> > > > +/* result, will be checked by userspace */
> > > > +int found;
> > > > +
> > > > +SEC("iter/kmem_cache")
> > > > +int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> > > > +{
> > > > +     struct seq_file *seq =3D ctx->meta->seq;
> > > > +     struct kmem_cache *s =3D ctx->s;
> > > > +
> > > > +     if (s) {
> > > > +             char name[SLAB_NAME_MAX];
> > > > +
> > > > +             /*
> > > > +              * To make sure if the slab_iter implements the seq i=
nterface
> > > > +              * properly and it's also useful for debugging.
> > > > +              */
> > > > +             BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->object_si=
ze);
> > > > +
> > > > +             bpf_probe_read_kernel_str(name, sizeof(name), s->name=
);
> > > > +             bpf_map_update_elem(&slab_hash, &s, name, BPF_NOEXIST=
);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +SEC("raw_tp/bpf_test_finish")
> > > > +int BPF_PROG(check_task_struct)
> > > > +{
> > > > +     __u64 curr =3D bpf_get_current_task();
> > > > +     struct kmem_cache *s;
> > > > +     char *name;
> > > > +
> > > > +     s =3D bpf_get_kmem_cache(curr);
> > > > +     if (s =3D=3D NULL) {
> > > > +             found =3D -1;
> > > > +             return 0;
> > >
> > > ... it cannot find a kmem_cache for the current task.  This program i=
s
> > > run by bpf_prog_test_run_opts() with BPF_F_TEST_RUN_ON_CPU.  So I thi=
nk
> > > the curr should point a task_struct in a slab cache.
> > >
> > > Am I missing something?
> >
> > Hi Namhyung,
> >
> > Out of curiosity I've been investigating this issue on my machine and
> > running some experiments.
>
> Thanks a lot for looking at this!
>
> >
> > When the test fails, calling dump_page() for the page the task_struct
> > belongs to,
> > shows that the page does not have the PGTY_slab flag set which is why
> > virt_to_slab(current) returns NULL.
> >
> > Does the test always fails on your environment? On my machine, the
> > test passed sometimes but failed some times.
>
> I'm using vmtest.sh but it succeeded mostly.  I thought I couldn't
> reproduce it locally, but I also see the failure sometimes.  I'll take a
> deeper look.
>
> >
> > Maybe sometimes the value returned by 'current' macro belongs to a
> > slab, but sometimes it does not.
> > But that doesn't really make sense to me as IIUC task_struct
> > descriptors are allocated from slab.
>
> AFAIK the notable exception is the init_task which lives in the kernel
> data.  I'm not sure the if the test is running by PID 1.

I checked that the test is running under PID 0 (swapper) when it fails and
non-0 PID when it succeeds. This makes sense as the task_struct for PID 0
should be in the kernel image area, not in a slab.

Phew, fortunately, it's not a bug! :)

Any plans on how to adjust the test program?

Best,
Hyeonggon

