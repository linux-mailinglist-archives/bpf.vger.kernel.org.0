Return-Path: <bpf+bounces-41014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C29910EE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B438AB227A0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319D231CB1;
	Fri,  4 Oct 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuc+VHDc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82A22067;
	Fri,  4 Oct 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074011; cv=none; b=RNuc2s1W/5E0bTYMXJwgpM6dgOsxgoyZW8EDjy4J/1vtupDiYAAFjhEjP438TbwA1KcTbOlkF+H+F+1zC4yIJIA7EJZH2Tbxn1WOPtTxWbaZVXlfeEz5jZsocQwvd8OZ1Emirv2gGQRABK1ZPVkW8IRjuwgGeQIXR1nZznUhXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074011; c=relaxed/simple;
	bh=dgu2VTGNBz0Q3vaF2UYNqERBE89cxhqUTRShhpNWnp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucsB+2+MLtgEbJDgsty9mpokGAvTVIbj6j8aonGshyJ1eAbEnPoCaf2atW5sYDgkYOYLIDWM6ORMf7x1LkJB8ADfJ7lQVI0+RrjZiaew5cQO+ts2r/BiOmgFZKfjV+2VNwrKfqFLnGgcU6TfuIlJWsIZoW6xpXIATV+NnLOpevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuc+VHDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10140C4CECE;
	Fri,  4 Oct 2024 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728074011;
	bh=dgu2VTGNBz0Q3vaF2UYNqERBE89cxhqUTRShhpNWnp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tuc+VHDccH39CXrTezK0z2rbgd7J0q7dlmwsAy5dKNHgSYcKWuroaqSstMCjRJGKj
	 GoUXDiv3QuvVYH7tGzSefGkkl0hCBVAroujlYjJI2CEw1kxtNxtIppLExKoXxf6XzR
	 vWzRQOBaPh5Yp3Zj62ndrGyW2DwIKxhIoKx3IcolAe0vymm82NLtHDqp3kr9n+AZw+
	 V6fXqz0jM4s6BtLx5B6gqHoGMPKMJpY9CdRb8HJpxY0dieJrAyJtKaMWxdDNr/tpcl
	 oFfCtQznBihdAnN39VinI/Z2erzEZz5nRdl/z1q4nE4qI9/y42HhXba+Uf3KkQ83Py
	 LZ+8CVk8j8Uug==
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so120174839f.3;
        Fri, 04 Oct 2024 13:33:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6rAe04mtZgi6pZLiU/TjWvg67RFEkuHelOtG2afllAyskGh2aD2ZtaT3ioj5AFgsNtO4CQ9E0RAVrm/vH@vger.kernel.org, AJvYcCWe2nlSHwlhKtjAQMLGSAqT1ld+YFDswIbPvJdQlYjoYANpRjS2LHGX0LDAv1GW86uwQps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fkY5LSf/s8PXPT1eYlcJJ0gIFqsDqKGHo3l42h6jHKA79y7E
	t7KX9U4pX9G9Q33BOjudToibmZ3l8VFGBiibCqYXxQxNi9oTfRIKnYyTi2TfFEY40+1WWkZOjPn
	bjQk7REt8v4YhNnfhq3qncDG3h4U=
X-Google-Smtp-Source: AGHT+IHKcUX7A7EqBxhx0p8LA2IErluMnPnMlNw7uAMVTmuO7e0uQR4F1tGjJKCmJfYI5Lh+nTutnwcr1eMdldwatRU=
X-Received: by 2002:a05:6e02:144d:b0:3a3:3e1f:1168 with SMTP id
 e9e14a558f8ab-3a375bb6c76mr40195255ab.17.1728074010416; Fri, 04 Oct 2024
 13:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-2-namhyung@kernel.org>
In-Reply-To: <20241002180956.1781008-2-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 13:33:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4HLM=v=eGyT5F7epEKc_tfh=Y643wvkDOJRLdow-RWpg@mail.gmail.com>
Message-ID: <CAPhsuW4HLM=v=eGyT5F7epEKc_tfh=Y643wvkDOJRLdow-RWpg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:09=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
[...]
> +
> +       mutex_lock(&slab_mutex);
> +
> +       /*
> +        * Find an entry at the given position in the slab_caches list in=
stead

Nit: style of multi-line comment: "/* Find ...".

> +        * of keeping a reference (of the last visited entry, if any) out=
 of
> +        * slab_mutex. It might miss something if one is deleted in the m=
iddle
> +        * while it releases the lock.  But it should be rare and there's=
 not
> +        * much we can do about it.
> +        */
> +       list_for_each_entry(s, &slab_caches, list) {
> +               if (cnt =3D=3D *pos) {
> +                       /*
> +                        * Make sure this entry remains in the list by ge=
tting
> +                        * a new reference count.  Note that boot_cache e=
ntries
> +                        * have a negative refcount, so don't touch them.
> +                        */
> +                       if (s->refcount > 0)
> +                               s->refcount++;
> +                       found =3D true;
> +                       break;
> +               }
> +               cnt++;
> +       }
> +       mutex_unlock(&slab_mutex);
> +
> +       if (!found)
> +               return NULL;
> +
> +       ++*pos;
> +       return s;
> +}
> +
> +static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +       struct bpf_iter_meta meta;
> +       struct bpf_iter__kmem_cache ctx =3D {
> +               .meta =3D &meta,
> +               .s =3D v,
> +       };
> +       struct bpf_prog *prog;
> +       bool destroy =3D false;
> +
> +       meta.seq =3D seq;
> +       prog =3D bpf_iter_get_info(&meta, true);
> +       if (prog)
> +               bpf_iter_run_prog(prog, &ctx);
> +
> +       if (ctx.s =3D=3D NULL)
> +               return;
> +
> +       mutex_lock(&slab_mutex);
> +
> +       /* Skip kmem_cache_destroy() for active entries */
> +       if (ctx.s->refcount > 1)
> +               ctx.s->refcount--;
> +       else if (ctx.s->refcount =3D=3D 1)
> +               destroy =3D true;
> +
> +       mutex_unlock(&slab_mutex);
> +
> +       if (destroy)
> +               kmem_cache_destroy(ctx.s);
> +}
> +
> +static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v, lof=
f_t *pos)
> +{
> +       struct kmem_cache *s =3D v;
> +       struct kmem_cache *next =3D NULL;
> +       bool destroy =3D false;
> +
> +       ++*pos;
> +
> +       mutex_lock(&slab_mutex);
> +
> +       if (list_last_entry(&slab_caches, struct kmem_cache, list) !=3D s=
) {
> +               next =3D list_next_entry(s, list);
> +               if (next->refcount > 0)
> +                       next->refcount++;

What if next->refcount <=3D0? Shall we find next of next?

> +       }
> +
> +       /* Skip kmem_cache_destroy() for active entries */
> +       if (s->refcount > 1)
> +               s->refcount--;
> +       else if (s->refcount =3D=3D 1)
> +               destroy =3D true;
> +
> +       mutex_unlock(&slab_mutex);
> +
> +       if (destroy)
> +               kmem_cache_destroy(s);
> +
> +       return next;
> +}
[...]

