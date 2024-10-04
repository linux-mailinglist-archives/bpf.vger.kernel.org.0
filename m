Return-Path: <bpf+bounces-41036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33999134F
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04721F24335
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFD9154C0D;
	Fri,  4 Oct 2024 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbrKzbQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DA1798C;
	Fri,  4 Oct 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086050; cv=none; b=r/MO+SUrQpSIvo/ubusSUR/UzSrdcifj9DMrfc7zNzqXHPXnbkvHYB7Crfpb0ZdkqOzu+Hy20H/9mwC/wEzcBoakhqupw9qRjkMer19WyU6jQuAbTeqF4HL4DOF+og1rEQ232FM7+az2yWYehbKXdmK1NhR9ajZhaCdscUpwWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086050; c=relaxed/simple;
	bh=ukDAeTg+b0shyozyi17Fjs65GRabwRfpD8NvxmjWKoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmjPIhdz7v738pJAopczVtVycLsG7xjvak0NwgzyqLsYzU1dz+Gh6BdRtFyxVNlJsDn7jc+ObvsnBTjL1TV301CIT3Ew9/z1T3J5yQyZEX9thTZ6CUhvyda4ppKiK3hEuTbYJiyd9cm1ZcQom/5ZCrf5s/+u7QtWLv09zaczRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbrKzbQD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so21078935e9.1;
        Fri, 04 Oct 2024 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728086047; x=1728690847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey6Oq2lDKBRKaDTn8eG+GJF2iDyHBwlkWZp4+g4/Bto=;
        b=LbrKzbQDu87rzo9iAbXlTjjrJccfaVu6D6wEydjTJpPVHxWxp34dxJ+AirPPhfAIeg
         0Vbuhuu2s55e2nM9myR1pjzaWokpZyaB2PaRSQmSDJIdmEGFT2siK9lRq/Nz5vQZvHk1
         uS95PTbnegDuqQiMX+HWixuMvkfgd4HGiIBs3S8BpFTSJCVyzRmNlcKL5cdyI6b6EZzP
         8bDT/bkeEFvs8mC2n8aiFg9dbHFfxqGlUM9zxx1rBcEPAF7bZNr8RIvj823lNjncWHgw
         LPtipdqbe5+XEP8xB8ZeJzOiMMsSxjz+Du2H1NwrqO71zw64rNnTdZVag+UlmFaZYZZp
         Tb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728086047; x=1728690847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey6Oq2lDKBRKaDTn8eG+GJF2iDyHBwlkWZp4+g4/Bto=;
        b=JKjBGf8IdoMbXgmhbj4JU0rApbxgsRzPVics7bxBUZ9DS+CJJbHIU0IrWSyeesGdZK
         M7X3giKUK8cdRg5MTQ+YKiSI6j2ly9yXIqZH2CbME05zevjFMzclYcksFcH37ffzi7NE
         HnKU56mUOWZoWC7CmjJ8p4In7KpvKV4H+UcDIRk+ZORduyZuOv6VbW2t2lwVPso1OoWa
         0cy466B5FSiGWU5cXRkbL1vnc08oj9uH0UTWxxSzNy3n72jmVEVrllU34Flbcz+KHHb+
         9ACEVDDEEqUolSbikWGh2xQTPdmzbrE0WMBx9y/itsYn1fr4s9gi6yJ001mv0emnKooZ
         vRFg==
X-Forwarded-Encrypted: i=1; AJvYcCVffVQkjHKvG6s10b9xTI6p7Esx92Cd8rcQPixuhYS2HoQVBCvKddWI5XdHSu/UJBFcChQtdOJGoaZEmzW8@vger.kernel.org, AJvYcCW7WVnsqsl3HAN/mC0hc64ciUZg6Yu42NMl/NCp1hjRD2mKW1RwJjtbgfhHMNwYbP8Yj9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEXjfXS9bUepQo9d+xkfE8rhKYYF8SR+UmNS+ua0mgAQrygiz
	s+4kkLwzVapOwoiteiH67ZWeqSw9ZIT6cyXEqy7c9BJIC+fBvLsyzQkF6lg+OH2jBWYfxE7ZqYS
	KY+0unlDhgufHAiMwZ7VbClARXG0=
X-Google-Smtp-Source: AGHT+IFxohsGea7slx7Vahx8XGjG0DiWQjp0SC/7m33jdLrz+ta8T6ItKUN7x6l0F9O9fa+yoDaLRfLub8c8gZXkSQo=
X-Received: by 2002:a05:600c:3c8c:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-42f85abf4damr26751815e9.20.1728086047194; Fri, 04 Oct 2024
 16:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002065456.1580143-1-namhyung@kernel.org> <20241002065456.1580143-4-namhyung@kernel.org>
In-Reply-To: <20241002065456.1580143-4-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Oct 2024 16:53:56 -0700
Message-ID: <CAADnVQLOqSwm7Ve9g-XJ3HWY3=uBMy05wbDmRZdJvf0=gJkb2w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add a test for kmem_cache_iter
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
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> +++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google */
> +
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +#define SLAB_NAME_MAX  256
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(key_size, sizeof(void *));
> +       __uint(value_size, SLAB_NAME_MAX);
> +       __uint(max_entries, 1024);
> +} slab_hash SEC(".maps");
> +
> +extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
> +
> +/* result, will be checked by userspace */
> +int found;
> +
> +SEC("iter/kmem_cache")
> +int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> +{
> +       struct seq_file *seq =3D ctx->meta->seq;
> +       struct kmem_cache *s =3D ctx->s;
> +
> +       if (s) {
> +               char name[SLAB_NAME_MAX];
> +
> +               /*
> +                * To make sure if the slab_iter implements the seq inter=
face
> +                * properly and it's also useful for debugging.
> +                */
> +               BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->object_size);
> +
> +               bpf_probe_read_kernel_str(name, sizeof(name), s->name);
> +               bpf_map_update_elem(&slab_hash, &s, name, BPF_NOEXIST);
> +       }
> +
> +       return 0;
> +}
> +
> +SEC("raw_tp/bpf_test_finish")
> +int BPF_PROG(check_task_struct)
> +{
> +       __u64 curr =3D bpf_get_current_task();
> +       struct kmem_cache *s;
> +       char *name;
> +
> +       s =3D bpf_get_kmem_cache(curr);
> +       if (s =3D=3D NULL) {
> +               found =3D -1;
> +               return 0;
> +       }
> +
> +       name =3D bpf_map_lookup_elem(&slab_hash, &s);
> +       if (name && !bpf_strncmp(name, 11, "task_struct"))
> +               found =3D 1;
> +       else
> +               found =3D -2;
> +
> +       return 0;
> +}

The test is a bit too simple.

Could you add a more comprehensive test that also demonstrates
the power of such a slab iterator?

Like progs/bpf_iter_task_vmas.c provides output equivalent to
cat proc/pid/maps

and progs/bpf_iter_tcp6.c dumps equivalent output to
cat /proc/net/tcp6

Would be great to have a selftest that is equivalent to
cat /proc/slabinfo
(or at least close enough)

That will give more confidence that the interface works as intended.

