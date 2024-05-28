Return-Path: <bpf+bounces-30791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC208D27D5
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815042885AD
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D013DDB7;
	Tue, 28 May 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsjCOnaV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EA28DC7
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934730; cv=none; b=TvrszYSQYRdxAoie3l6YfKHmb2MpVqfk6dCC738JhDycf/Q5Nze0DBtib8U7a9Sgty2WSmkvZxYM6B71UpVF7Nc5ZrXKu58yF7w/yE5Di0YULWKfsB8FLN+U2yMzd7rmGkoVdqCz/znQq2LcheTYsyr45qWX7cTR2EpZlQ7cWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934730; c=relaxed/simple;
	bh=qmpQID16hxQivc9sveXsWeK2U1I0yDGqJjX/J6c/flw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syP/TFd9vZvFK3N25ofWsCG95OXK0/4w/8YtkjX7ovWOw7kc+hvSiuRZOkTViSLdv358G/kAmtp0Z/1tKBgJOuWFLcDzm69zan9pUeG1LbgrJI7eQ/GKQjWcJo0jCD0MmsDD/flvhwZuApsK7QwPfqSr5WQomXPo9LUQkhsxvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsjCOnaV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681adefa33fso1206922a12.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716934728; x=1717539528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUBBKVYO3eUREmGaQmC1dg52J0K+GI15Bybb9kKBipc=;
        b=gsjCOnaVHk7FDuMI9KggR2EsJLpjxpmhMI0o9iNCD6fU5+bfRgU1hi9fEE4cxFsgY6
         +rVBuG4gsrmy+SRHriVe4h017Rl7ywjsP9uTx9IjY31I8oZTResbIhwhhkRRl/wWjtyd
         VX+phx14ANDhmtO1+XsFdzCHbRCvNNQtS785LyldCPIxwlZd3pmEjqjHiuYpm1c31coO
         IrXcojfK88hmgxRT/nNRNuhnoDDhEaG11cMzFeVVRGI0kPEW9zHVIX56ZO5kGXC3WFV/
         NhhIuqHtegmvygOL+T53kDyQteTeqRrRzk+UU6/LH+1bRnUAuczpTlmC7ekHUrRJSNqH
         QreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716934728; x=1717539528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUBBKVYO3eUREmGaQmC1dg52J0K+GI15Bybb9kKBipc=;
        b=C3TnwyZWWSOQNLiZv5m+Pjs/1+7srJD7y8vfAgEbVJswoweWcj5PiqCUsik6bvDBrZ
         ISftxM98vjYxh//vs9xN8jwXgB2LbEQBrf6c0j6n4vSaYcyPaLZ8Qkyd1fW6QB3tKISN
         /+dV4i1ZRXY01hbsxzYdwn6QC94hJZFkcVkK2N6OpfIOLdkrTcTYml2a3RX8hZ0BeRQ9
         uo+7R6/0Zdf+Xo2DWJ7SxEsgUxSNZHk1vcksy44/ddUHUQAtKm909xqugN+jPnGD8G6g
         i1mGrRgxo9WmtXVcvQWlee6745tcVX7fWcVUP3cm19lMMaLER9IHH1KBPoQLOGZqJx29
         puLQ==
X-Gm-Message-State: AOJu0YzciuhFOS5I9D73gvp/yXymPduw6qJeDGXLbVUZwgfSX+lhwEWB
	av8vFtm7LBnd3krzXLfxkiYzVBuZ4dwciV7baNWaNa2e9HbvgCC1OZM3hpP99V9uGltqhp9mWKl
	/Sia5yXpZUhUWx0Q5NKpaaVJQTCE=
X-Google-Smtp-Source: AGHT+IHzzm0iDoec5szPY2gWH2YtShBoJQSbc597DVUVvvadIl/XzDgfisqLrG4OA8UO/9IRiJsS5FsNG4a1e5IN9KM=
X-Received: by 2002:a17:90a:bc83:b0:2bd:d877:cf7a with SMTP id
 98e67ed59e1d1-2bf5ed202eamr14431212a91.14.1716934728092; Tue, 28 May 2024
 15:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517190555.4032078-1-eddyz87@gmail.com> <20240517190555.4032078-3-eddyz87@gmail.com>
In-Reply-To: <20240517190555.4032078-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 15:18:36 -0700
Message-ID: <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit queue
 and print single type
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 12:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Add several API functions to allow more flexibility with btf dump:
> - int btf_dump__order_type(struct btf_dump *d, __u32 id);
>   adds a type and all it's dependencies to the emit queue
>   in topological order;
> - struct btf_dump_emit_queue_item *btf_dump__emit_queue(struct btf_dump *=
d);
>   __u32 btf_dump__emit_queue_cnt(struct btf_dump *d);
>   provide access to the emit queue owned by btf_dump object;
> - int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd);
>   prints a given type in C format (skipping any dependencies).
>
> This API should allow to do the following on the libbpf client side:
> - filter printed types using arbitrary criteria;
> - add arbitrary type attributes or pre-processor statements for
>   selected types.
>
> This is a follow-up to the following discussion:
> https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.c=
om/
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf.h      | 33 ++++++++++++++++++++++
>  tools/lib/bpf/btf_dump.c | 61 ++++++++++++++++++++++------------------
>  tools/lib/bpf/libbpf.map |  4 +++
>  3 files changed, 71 insertions(+), 27 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 8e6880d91c84..81d70ac35562 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -249,6 +249,39 @@ LIBBPF_API void btf_dump__free(struct btf_dump *d);
>
>  LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
>
> +/* Dumps C language definition or forward declaration for type **id**:
> + * - returns 1 if type is printable;
> + * - returns 0 if type is non-printable.

does it also return <0 on error?

> + */

let's follow the format of doc comments, see other APIs. There is
@brief, @param, @return and so on.

pw-bot: cr


> +LIBBPF_API int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, boo=
l fwd);

not a fan of a name, how about we do `btf_dump__emit_type(struct
btf_dump *d, __u32 id, struct btf_dump_emit_type_opts *opts)` and have
forward declaration flag as options? We have
btf_dump__emit_type_decl(), this one could be called
btf_dump__emit_type_def() as well. WDYT?

> +
> +/* **struct btf_dump** tracks a list of types that should be dumped,
> + * these types are sorted in the topological order satisfying C language=
 semantics:
> + * - if type A includes type B (e.g. A is a struct with a field of type =
B),
> + *   then B comes before A;
> + * - if type A references type B via a pointer
> + *   (e.g. A is a struct with a field of type pointer to B),
> + *   then B's forward declaration comes before A.
> + *
> + * **struct btf_dump_emit_queue_item** represents a single entry of the =
emit queue.
> + */
> +struct btf_dump_emit_queue_item {
> +       __u32 id:31;
> +       __u32 fwd:1;
> +};

as mentioned on patch #1, I'd add this type in patch #1 (and just move
it to public API header here). And instead of bit fields, let's use
two fields. Those few bytes extra doesn't really matter much in
practice.
> +
> +/* Adds type **id** and it's dependencies to the emit queue. */

typo: its

> +LIBBPF_API int btf_dump__order_type(struct btf_dump *d, __u32 id);
> +
> +/* Provides access to currently accumulated emit queue,
> + * returned pointer is owned by **struct btf_dump** and should not be
> + * freed explicitly.
> + */
> +LIBBPF_API struct btf_dump_emit_queue_item *btf_dump__emit_queue(struct =
btf_dump *d);
> +
> +/* Returns the size of currently accumulated emit queue */
> +LIBBPF_API __u32 btf_dump__emit_queue_cnt(struct btf_dump *d);
> +

I'm a bit on the fence here. But I feel like having just one access to
the queue which returns size as out parameter is probably a bit
better. Having queue pointer + size returned in one API communicates
them being both tied together and sort of ephemeral.

We should also document what's the lifetime of this pointer and when
it can be invalidated.

Speaking of which, for the next revision, can you also integrate all
these new APIs into bpftool to handle the problem that Jose tried to
solve? This might also expose any of the potential issues with API
usage.


>  struct btf_dump_emit_type_decl_opts {
>         /* size of this struct, for forward/backward compatiblity */
>         size_t sz;
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 10532ae9ff14..c3af6bb606a0 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -85,10 +85,7 @@ struct btf_dump {
>         size_t cached_names_cap;
>
>         /* topo-sorted list of dependent type definitions */
> -       struct {
> -               __u32 id:31;
> -               __u32 fwd:1;
> -       } *emit_queue;
> +       struct btf_dump_emit_queue_item *emit_queue;
>         int emit_queue_cap;
>         int emit_queue_cnt;
>
> @@ -250,7 +247,6 @@ void btf_dump__free(struct btf_dump *d)
>  }
>
>  static int btf_dump_order_type(struct btf_dump *d, __u32 id, __u32 cont_=
id, bool through_ptr);
> -static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd);
>
>  /*
>   * Dump BTF type in a compilable C syntax, including all the necessary
> @@ -296,12 +292,32 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 i=
d)
>                 break;
>         };
>
> -       for (i =3D 0; i < d->emit_queue_cnt; i++)
> -               btf_dump_emit_type(d, d->emit_queue[i].id, d->emit_queue[=
i].fwd);
> +       for (i =3D 0; i < d->emit_queue_cnt; i++) {
> +               err =3D btf_dump__dump_one_type(d, d->emit_queue[i].id, d=
->emit_queue[i].fwd);
> +               if (err < 0)
> +                       return libbpf_err(err);
> +               if (err > 0)
> +                       btf_dump_printf(d, ";\n\n");
> +       }
>
>         return 0;
>  }
>
> +int btf_dump__order_type(struct btf_dump *d, __u32 id)
> +{
> +       return btf_dump_order_type(d, id, id, false);

make sure that btf_dump_order_type() either sets errno, or use
libbpf_err() helpers here

> +}
> +
> +struct btf_dump_emit_queue_item *btf_dump__emit_queue(struct btf_dump *d=
)
> +{
> +       return d->emit_queue;
> +}
> +
> +__u32 btf_dump__emit_queue_cnt(struct btf_dump *d)
> +{
> +       return d->emit_queue_cnt;
> +}
> +
>  /*
>   * Mark all types that are referenced from any other type. This is used =
to
>   * determine top-level anonymous enums that need to be emitted as an
> @@ -382,7 +398,7 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
>
>  static int __btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id, bo=
ol fwd)
>  {
> -       typeof(d->emit_queue[0]) *new_queue =3D NULL;
> +       struct btf_dump_emit_queue_item *new_queue =3D NULL;
>         size_t new_cap;
>
>         if (d->emit_queue_cnt >=3D d->emit_queue_cap) {
> @@ -733,7 +749,7 @@ static size_t btf_dump_name_dups(struct btf_dump *d, =
struct hashmap *name_map,
>   * that doesn't comply to C rules completely), algorithm will try to pro=
ceed
>   * and produce as much meaningful output as possible.
>   */
> -static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
> +int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd)

double check libbpf_err(), libbpf promises to set errno properly for
all public APIs

>  {
>         const struct btf_type *t;
>         __u16 kind;

[...]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c1ce8aa3520b..137e4cbaa7a7 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -422,4 +422,8 @@ LIBBPF_1.5.0 {
>                 bpf_program__attach_sockmap;
>                 ring__consume_n;
>                 ring_buffer__consume_n;
> +               btf_dump__emit_queue;
> +               btf_dump__emit_queue_cnt;
> +               btf_dump__order_type;
> +               btf_dump__dump_one_type;

this has to be ordered

>  } LIBBPF_1.4.0;
> --
> 2.34.1
>

