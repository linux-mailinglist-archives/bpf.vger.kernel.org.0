Return-Path: <bpf+bounces-40501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366639895F5
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 16:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C071F224CE
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54F217BEC5;
	Sun, 29 Sep 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDHzV+cZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FE2AE69;
	Sun, 29 Sep 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620061; cv=none; b=aPFyUxWA6dk5CdgTYcP0KZsBdqxYvHu4DmOF6SCRC4opWN8D1ZXIEu57cF6iE8hfMeuxRoM+Jrg2+MHKyRNv7JQ36zkzZf4jhqsLFwDOYciZaRMgFCoVVxB48BtXmSWJOfFGa7h9qarI23xsgbajvkN9SxpYn6S769ZI6/bDcx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620061; c=relaxed/simple;
	bh=wfsaGTv/cYcMQG4W/chhN05/LY2CiveBskbyCN3nrfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciUZpvgkyXCjWhBaCKUAOO+ouGNrk6MwI6D6gq6UADTSUS4cayUky9dEGZVR7kvqGq52EeWHTCWVOXAHY7Pg8g8wVVoLYSgWhtTpb5nlQ8zwVxYIxo+g6Acq03jHthWK61L0prFWnBX6noo7QKqa9UeellMs15/bIhWXYmaB16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDHzV+cZ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53659867cbdso5138508e87.3;
        Sun, 29 Sep 2024 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727620057; x=1728224857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtbvtThMcLfZP33DpBG5SmDf+10l0U9/1PhI2Q2GmeY=;
        b=BDHzV+cZewLvDoLGTfaiREt8cePCBySkBtKtd2AWv+kZOzv40Ss37kyNJn5aQPDkHl
         ofNokvwTwtacLytnyKyeNjboVHbkne0VXrQq+k0wix5VS4kCLJG/ua0fFyhm1jzNQ3AT
         sTduqKPcY6B8SNhmM7aVcvwwWxtJu9e2yp1u+e7WuOiDszgdTDLY/1DnDhcfRb5SKt/N
         o6oMK9IQ8aWd+l30xS7Pf4SakiSMJepgfdCuiqd/Ufi69fTUEG/Dq2fVNZLOt9JFKoNJ
         asqRA1ZqS9v4cFuUJ187bMJ+phoo3Mv9INU914VJgd7tKzcabgkUJRY/nm713MGlAeD7
         RdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727620057; x=1728224857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtbvtThMcLfZP33DpBG5SmDf+10l0U9/1PhI2Q2GmeY=;
        b=Pcdt2X9VIR0K+N0VnmC6P1+KY0D0lpVMlTSCQpczk6aOYB5+BEatO8Ug1f8GmBV9qi
         UT8LpNt40Lnis8bXw/H8UNDbUS/0WWAd0e8WFW62Ldl+mBuw2AcPUK9FBj5i315zjru8
         86UV1UdWeSr8B3LHRgNH6Rs+xYWt1Vp9IjRYOTHtRh9P3Dpr1LIfyOJ+EVtKdnPFUdhA
         2uYnS5gShfu4lREWitjJFso/lxJf0Y54DDauqOccqDY34j8hTDw89oweK6FQD1CsfVCz
         5F+xZ7wz9rovbtqZ4H0PG/KZzqyCusBzQYPnk7j3KuWSk7B1A3si3mrbcTCU0ennLLq+
         rO0A==
X-Forwarded-Encrypted: i=1; AJvYcCUo5T849QbgRjFQtFdc/KtkcjqWJTdjK+pHAJpIjrR71vwd0NUEtY1HSUEyKBbW8U8JJb3q/tPxFswWYnUb@vger.kernel.org, AJvYcCW8b6qgkb000yxHcto2H0BXhSjHPJ3qr4O4QDpMeG0mbbanY5cVj4qp4Hb1aPckiCr6imk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Nn4LtyLwRhxYBKpf5r9jwBTBm4DypoYaHoZt/1AG8e4kwBGN
	0WTcUWbyMgnDyKJl74FIIZ1PaUGH6qsTKMxLjJrRRpX1FL9UwJtq4aaVlN4RpDEoSq68i7FckcV
	zTRjWPX1Xfgm9vydQDRKroi47+es=
X-Google-Smtp-Source: AGHT+IE4HXL1kMylcq8xlFLuKWk1AaVJJnQaLup27Jz1RzB4cQGJRzdsAibNxQ6jhUjn45Faqm6I6zWP+QcmF9XJ9G8=
X-Received: by 2002:a05:6512:220a:b0:539:9155:e8c1 with SMTP id
 2adb3069b0e04-5399155ebcbmr836865e87.8.1727620057141; Sun, 29 Sep 2024
 07:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927184133.968283-1-namhyung@kernel.org> <20240927184133.968283-4-namhyung@kernel.org>
 <ZvjwEH3QXkjUCu8Z@google.com>
In-Reply-To: <ZvjwEH3QXkjUCu8Z@google.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 29 Sep 2024 23:27:25 +0900
Message-ID: <CAB=+i9Sm4UEhGy-jzsZEs1Q6KQCVdbnu_eAiRzXz=sRC-3H6Uw@mail.gmail.com>
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

On Sun, Sep 29, 2024 at 3:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Sep 27, 2024 at 11:41:33AM -0700, Namhyung Kim wrote:
> > The test traverses all slab caches using the kmem_cache_iter and check
> > if current task's pointer is from "task_struct" slab cache.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  .../bpf/prog_tests/kmem_cache_iter.c          | 64 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_iter.h  |  7 ++
> >  .../selftests/bpf/progs/kmem_cache_iter.c     | 66 +++++++++++++++++++
> >  3 files changed, 137 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_i=
ter.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b=
/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > new file mode 100644
> > index 0000000000000000..814bcc453e9f3ccd
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Google */
> > +
> > +#include <test_progs.h>
> > +#include <bpf/libbpf.h>
> > +#include <bpf/btf.h>
> > +#include "kmem_cache_iter.skel.h"
> > +
> > +static void test_kmem_cache_iter_check_task(struct kmem_cache_iter *sk=
el)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, opts,
> > +             .flags =3D BPF_F_TEST_RUN_ON_CPU,
> > +     );
> > +     int prog_fd =3D bpf_program__fd(skel->progs.check_task_struct);
> > +
> > +     /* get task_struct and check it if's from a slab cache */
> > +     bpf_prog_test_run_opts(prog_fd, &opts);
> > +
> > +     /* the BPF program should set 'found' variable */
> > +     ASSERT_EQ(skel->bss->found, 1, "found task_struct");
>
> Hmm.. I'm seeing a failure with found being -1, which means ...
>
> > +}
> > +
> > +void test_kmem_cache_iter(void)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > +     struct kmem_cache_iter *skel =3D NULL;
> > +     union bpf_iter_link_info linfo =3D {};
> > +     struct bpf_link *link;
> > +     char buf[1024];
> > +     int iter_fd;
> > +
> > +     skel =3D kmem_cache_iter__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
> > +             return;
> > +
> > +     opts.link_info =3D &linfo;
> > +     opts.link_info_len =3D sizeof(linfo);
> > +
> > +     link =3D bpf_program__attach_iter(skel->progs.slab_info_collector=
, &opts);
> > +     if (!ASSERT_OK_PTR(link, "attach_iter"))
> > +             goto destroy;
> > +
> > +     iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> > +     if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> > +             goto free_link;
> > +
> > +     memset(buf, 0, sizeof(buf));
> > +     while (read(iter_fd, buf, sizeof(buf) > 0)) {
> > +             /* read out all contents */
> > +             printf("%s", buf);
> > +     }
> > +
> > +     /* next reads should return 0 */
> > +     ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
> > +
> > +     test_kmem_cache_iter_check_task(skel);
> > +
> > +     close(iter_fd);
> > +
> > +free_link:
> > +     bpf_link__destroy(link);
> > +destroy:
> > +     kmem_cache_iter__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testi=
ng/selftests/bpf/progs/bpf_iter.h
> > index c41ee80533ca219a..3305dc3a74b32481 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> > @@ -24,6 +24,7 @@
> >  #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
> >  #define BTF_F_ZERO BTF_F_ZERO___not_used
> >  #define bpf_iter__ksym bpf_iter__ksym___not_used
> > +#define bpf_iter__kmem_cache bpf_iter__kmem_cache___not_used
> >  #include "vmlinux.h"
> >  #undef bpf_iter_meta
> >  #undef bpf_iter__bpf_map
> > @@ -48,6 +49,7 @@
> >  #undef BTF_F_PTR_RAW
> >  #undef BTF_F_ZERO
> >  #undef bpf_iter__ksym
> > +#undef bpf_iter__kmem_cache
> >
> >  struct bpf_iter_meta {
> >       struct seq_file *seq;
> > @@ -165,3 +167,8 @@ struct bpf_iter__ksym {
> >       struct bpf_iter_meta *meta;
> >       struct kallsym_iter *ksym;
> >  };
> > +
> > +struct bpf_iter__kmem_cache {
> > +     struct bpf_iter_meta *meta;
> > +     struct kmem_cache *s;
> > +} __attribute__((preserve_access_index));
> > diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tool=
s/testing/selftests/bpf/progs/kmem_cache_iter.c
> > new file mode 100644
> > index 0000000000000000..3f6ec15a1bf6344c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Google */
> > +
> > +#include "bpf_iter.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +#define SLAB_NAME_MAX  256
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(void *));
> > +     __uint(value_size, SLAB_NAME_MAX);
> > +     __uint(max_entries, 1024);
> > +} slab_hash SEC(".maps");
> > +
> > +extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
> > +
> > +/* result, will be checked by userspace */
> > +int found;
> > +
> > +SEC("iter/kmem_cache")
> > +int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> > +{
> > +     struct seq_file *seq =3D ctx->meta->seq;
> > +     struct kmem_cache *s =3D ctx->s;
> > +
> > +     if (s) {
> > +             char name[SLAB_NAME_MAX];
> > +
> > +             /*
> > +              * To make sure if the slab_iter implements the seq inter=
face
> > +              * properly and it's also useful for debugging.
> > +              */
> > +             BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->object_size);
> > +
> > +             bpf_probe_read_kernel_str(name, sizeof(name), s->name);
> > +             bpf_map_update_elem(&slab_hash, &s, name, BPF_NOEXIST);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("raw_tp/bpf_test_finish")
> > +int BPF_PROG(check_task_struct)
> > +{
> > +     __u64 curr =3D bpf_get_current_task();
> > +     struct kmem_cache *s;
> > +     char *name;
> > +
> > +     s =3D bpf_get_kmem_cache(curr);
> > +     if (s =3D=3D NULL) {
> > +             found =3D -1;
> > +             return 0;
>
> ... it cannot find a kmem_cache for the current task.  This program is
> run by bpf_prog_test_run_opts() with BPF_F_TEST_RUN_ON_CPU.  So I think
> the curr should point a task_struct in a slab cache.
>
> Am I missing something?

Hi Namhyung,

Out of curiosity I've been investigating this issue on my machine and
running some experiments.

When the test fails, calling dump_page() for the page the task_struct
belongs to,
shows that the page does not have the PGTY_slab flag set which is why
virt_to_slab(current) returns NULL.

Does the test always fails on your environment? On my machine, the
test passed sometimes but failed some times.

Maybe sometimes the value returned by 'current' macro belongs to a
slab, but sometimes it does not.
But that doesn't really make sense to me as IIUC task_struct
descriptors are allocated from slab.

....Or maybe some code can overwrote the page_type field of a slab?
Hmm, it seems we need more information to identify what's gone wrong.

Just FYI, adding the output of the following code snippet in
bpf_get_kmem_cache():

pr_info("current =3D %llx\n", (unsigned long long)current);
dump_page(virt_to_head_page(current), "virt_to_head_page()");

# When the test passes
[  232.755028] current =3D ffff8ff5b9ebd200
[  232.755031] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x139eb8
[  232.755033] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[  232.755035] memcg:ffff8ff5b3ee0c01
[  232.755037] ksm flags:
0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
[  232.755040] page_type: f5(slab)
[  232.755042] raw: 0017ffffc0000040 ffff8ff58028ab00 ffffdaba05b8fc00
dead000000000003
[  232.755045] raw: 0000000000000000 0000000000030003 00000001f5000000
ffff8ff5b3ee0c01
[  232.755047] head: 0017ffffc0000040 ffff8ff58028ab00
ffffdaba05b8fc00 dead000000000003
[  232.755048] head: 0000000000000000 0000000000030003
00000001f5000000 ffff8ff5b3ee0c01
[  232.755050] head: 0017ffffc0000003 ffffdaba04e7ae01
ffffffffffffffff 0000000000000000
[  232.755052] head: 0000000000000008 0000000000000000
00000000ffffffff 0000000000000000
[  232.755053] page dumped because: virt_to_head_page()

# When the test fails
[  130.811626] current =3D ffffffff884110c0
[  130.811628] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x8a9411
[  130.811632] flags:
0x17ffffc0002000(reserved|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
[  130.811636] raw: 0017ffffc0002000 ffffdaba22a50448 ffffdaba22a50448
0000000000000000
[  130.811639] raw: 0000000000000000 0000000000000000 00000001ffffffff
0000000000000000
[  130.811641] page dumped because: virt_to_head_page()

Best,
Hyeonggon

>
> Thanks,
> Namhyung
>
> > +     }
> > +
> > +     name =3D bpf_map_lookup_elem(&slab_hash, &s);
> > +     if (name && !bpf_strncmp(name, 11, "task_struct"))
> > +             found =3D 1;
> > +     else
> > +             found =3D -2;
> > +
> > +     return 0;
> > +}
> > --
> > 2.46.1.824.gd892dcdcdd-goog
> >

