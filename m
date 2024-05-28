Return-Path: <bpf+bounces-30789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB48D27B9
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF281C228A8
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EC13DBBC;
	Tue, 28 May 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxZX7zNP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696101DFD2
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933961; cv=none; b=CREbCpn7SODek4VJUUm0URbEGWtKjGsfLfhHiULuctk6VPEM42c3vCjnu9PQ3/GC1ULLw2vFZrdNoe1LYZlZuc0cYTsm4VWYLDe4ubLeQ3jcd7Z127V8KHlRu2IX/An3gpfbyWOBKPYU2z6uGNouXGHzTqTWOHhbLspAKjQGT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933961; c=relaxed/simple;
	bh=NcAARaJgA9+ybkBFeDgPqqP6LaXshbRQorXVPsx6b3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jG2Z1b+POly+EShmwZiXlpr4AjkjyqIZZJYx+rp7VN2GxUNlvPSAdPvMvsy/y8Cs0HI/ZSEDyDb42xd02B/qqCDB30u0R+VtaUqKYWANISXKFtF8DO+4FOOou6gQJ7hbUBHDW9Rz3ZMwFLy4lsyjtxFMGYbKIJVWKhqlNZAbwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxZX7zNP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bde0e3cd6aso1125039a91.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716933959; x=1717538759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4KmKjbu0QxqliBoh9ki8QdE/nEyQo6BOvMTobnSUAI=;
        b=SxZX7zNPKVjHQisbd4IybJfevbmMrCyYdG6F1mfUh6lBeMTLQNxPvKwIRu5kZjSZIk
         Feo6tV5Mvpr3vN0ZBQI8QtDPpAKUTAdwWpM2hZwRcBtY5hiQBiKVJ6eHo/+1zGsdoKSe
         Nm5k23IUWMJlXjB/MKlTJXLd99svOVR0+EUsIx0fsy/44OY1FxDtNWoLn5LqoEoEKdUm
         ceDiQnUsPi2pJrfD7VleK/awEpY7MQAgW5uVNDd76GkvkqBrWVaDgw2h2ec6+Ii4E3yW
         qQigu6JxbNDaSRntO7XIiIHYLIXbaTTtbuk2ID6/z0Xcewb8dPCHn4aHJ7RUc6NIoyCy
         Y4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933959; x=1717538759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4KmKjbu0QxqliBoh9ki8QdE/nEyQo6BOvMTobnSUAI=;
        b=SlN8bwMOz0REwnMGeDCAzrPNSKUnEkudD+751KmSLyvu3zQ6Hvb9HNhZSVLCYoUPcW
         WJFL+qOyFDRtKazUk/unB3P0n5OllY/vBcUzJNx9WQMI+hbyiCM4Ti5H8zVWcExJ/24e
         PwtzmNQWi0fRveQWyjSXrXJpe7ImpxxW5PZl3rr9wmgRAxJVhBR4TmazRnh7VfUV2wwA
         Q23g3UZotwVufz3Xw9q9xD3C3/geafuWHwyW/1AWzUEk6YzXCVNMyyCS9MtrNpH7KhBm
         ndWmL+7J9j2cPFQDnovWVZCuSl7pMwsUDpSVwu/5g6XG3rHrF6O1miEPsW0pf0dpN3bL
         rDhg==
X-Gm-Message-State: AOJu0YwSOPvzW0F9j8XKdGa0ELVLFL5DPoypekFPVmzaNnISwCY9l8y7
	ew6su4Atwktz9zHuKRW9TWxE7mwkHOs40345CHSRQoOXgq4CnvtDTXMRtrZ7HOj6vS2ONATLJwT
	frPUUAuG9YxhOxc5/S92xC2ntaBU=
X-Google-Smtp-Source: AGHT+IFixA481vbAnhUcHWCvA5wUNKVYx3Y7tr0QmpHs5pgAnO3jOM/PfDPT3QXwWh42Obco8xnO0YOPYrDMz2cKw/s=
X-Received: by 2002:a17:90b:2287:b0:2bf:ba54:4660 with SMTP id
 98e67ed59e1d1-2bfba5446b6mr6549521a91.17.1716933958377; Tue, 28 May 2024
 15:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517190555.4032078-1-eddyz87@gmail.com> <20240517190555.4032078-2-eddyz87@gmail.com>
In-Reply-To: <20240517190555.4032078-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 15:05:46 -0700
Message-ID: <CAEf4BzbZVteBuTMGUowBjQqF2iR8FqQBxZ3_oBtLB4+nhAGYSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: put forward declarations to btf_dump->emit_queue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 12:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> As a preparatory step for introducing public API for BTF topological
> ordering / single type printing, this commit removes ordering logic
> from btf_dump_emit_type() and moves parts necessary to compute forward
> declarations to btf_dump_order_type().
>
> Before this commit the topological ordering of types was effectively
> done twice:
> - first time in btf_dump_order_type(), which ordered types using only
>   "strong" links (one structure embedded in another);
> - second time in btf_dump_emit_type() to emit forward declarations.
>
> After this commit:
> - btf_dump_emit_type() is responsible only for printing
>   declaration / forward declaration of a single type;
> - btf_dump->emit_queue now contains pairs of form
>   {id, forward declaration flag};
> - btf_dump->emit_state is no longer necessary,
>   as EMITTED state is effectively replaced by ORDERED state
>   in btf_dump->order_state;
>
> Notable changes to btf_dump_order_type() logic:
> - no need to return strong / weak result, emit forward declaration to
>   the queue for weak links instead;
> - track containing type id ('cont_id'), as btf_dump_emit_type() did,
>   to avoid unnecessary forward declarations in recursive structs;
> - PTRs can no longer be marked ORDERED (see comment in the code);
> - incorporate btf_dump_emit_missing_aliases() and
>   btf_dump_is_blacklisted() checks from btf_dump_emit_type().
>
> When called for e.g. PTR type pointing to a struct
> btf_dump__dump_type() would previously result in an empty emit queue:
> btf_dump_order_type() would have reached struct with
> 'through_ptr' =3D=3D true, thus not adding it to the queue.
> To mimic such behavior this patch adds a type filter to
> btf_dump__dump_type(): only STRUCT, UNION, TYPEDEF, ENUM, ENUM64, FWD
> types are ordered.
>
> The downside of a single pass algorithm is that for the following
> situation old logic would have avoided extra forward declaration:
>
>         struct bar {};
>
>         struct foo {            /* Suppose btf_dump__dump_type(foo) */
>             struct bar *a;      /* is called first.                 */
>             struct bar b;
>         };
>
> The btf_dump_order_type() would have ordered 'bar' before 'foo',
> btf_dump_emit_type() would have been first called for 'bar' thus
> avoiding forward declaration for 'sturct bar' when processing 'foo'.
>
> In contrast, new logic would act as follows:
> - when processing foo->a forward declaration for 'bar' would be enqueued;
> - when processing foo->b full declaration for 'bar' would be enqueued;
>
> In practice this does not seem to be a big issue, number of forward
> declarations in vmlinux.h (for BPF selftests config) compared:
>                      llvm  gcc
> - before this patch: 1772  1235
> - after  this patch: 1786  1249
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 351 ++++++++++++++++++---------------------
>  1 file changed, 161 insertions(+), 190 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 5dbca76b953f..10532ae9ff14 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -36,24 +36,16 @@ enum btf_dump_type_order_state {
>         ORDERED,
>  };
>
> -enum btf_dump_type_emit_state {
> -       NOT_EMITTED,
> -       EMITTING,
> -       EMITTED,
> -};
> -
>  /* per-type auxiliary state */
>  struct btf_dump_type_aux_state {
>         /* topological sorting state */
>         enum btf_dump_type_order_state order_state: 2;
> -       /* emitting state used to determine the need for forward declarat=
ion */
> -       enum btf_dump_type_emit_state emit_state: 2;
> -       /* whether forward declaration was already emitted */
> -       __u8 fwd_emitted: 1;
>         /* whether unique non-duplicate name was already assigned */
>         __u8 name_resolved: 1;
>         /* whether type is referenced from any other type */
>         __u8 referenced: 1;
> +       /* whether forward declaration was already ordered */
> +       __u8 fwd_ordered: 1;
>  };
>
>  /* indent string length; one indent string is added for each indent leve=
l */
> @@ -93,7 +85,10 @@ struct btf_dump {
>         size_t cached_names_cap;
>
>         /* topo-sorted list of dependent type definitions */
> -       __u32 *emit_queue;
> +       struct {
> +               __u32 id:31;
> +               __u32 fwd:1;
> +       } *emit_queue;

let's define the named type right in this patch, no need to use
typeof() hack just to remove it later.

Also, let's maybe have

struct <whatever> {
    __u32 id;
    __u32 flags;
};

and define

enum btf_dump_emit_flags {
    BTF_DUMP_FWD_DECL =3D 0x1,
};

Or something along those lines? Having a few more flags available will
make it less like that we'll need to add a new set of APIs just to
accommodate one extra flag. (Though, if we add another field, we'll
end up adding another API anyways, but I really hope we will never
have to do this).

>         int emit_queue_cap;
>         int emit_queue_cnt;
>
> @@ -208,7 +203,6 @@ static int btf_dump_resize(struct btf_dump *d)
>         if (d->last_id =3D=3D 0) {
>                 /* VOID is special */
>                 d->type_states[0].order_state =3D ORDERED;
> -               d->type_states[0].emit_state =3D EMITTED;
>         }
>
>         /* eagerly determine referenced types for anon enums */
> @@ -255,8 +249,8 @@ void btf_dump__free(struct btf_dump *d)
>         free(d);
>  }
>
> -static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool throug=
h_ptr);
> -static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_=
id);
> +static int btf_dump_order_type(struct btf_dump *d, __u32 id, __u32 cont_=
id, bool through_ptr);
> +static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd);
>
>  /*
>   * Dump BTF type in a compilable C syntax, including all the necessary
> @@ -276,6 +270,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __=
u32 id, __u32 cont_id);
>   */
>  int btf_dump__dump_type(struct btf_dump *d, __u32 id)
>  {
> +       const struct btf_type *t;
>         int err, i;
>
>         if (id >=3D btf__type_cnt(d->btf))
> @@ -286,12 +281,23 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 i=
d)
>                 return libbpf_err(err);
>
>         d->emit_queue_cnt =3D 0;
> -       err =3D btf_dump_order_type(d, id, false);
> -       if (err < 0)
> -               return libbpf_err(err);
> +       t =3D btf_type_by_id(d->btf, id);
> +       switch (btf_kind(t)) {
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
> +       case BTF_KIND_FWD:
> +               err =3D btf_dump_order_type(d, id, id, false);
> +               if (err < 0)
> +                       return libbpf_err(err);
> +       default:
> +               break;
> +       };
>
>         for (i =3D 0; i < d->emit_queue_cnt; i++)
> -               btf_dump_emit_type(d, d->emit_queue[i], 0 /*top-level*/);
> +               btf_dump_emit_type(d, d->emit_queue[i].id, d->emit_queue[=
i].fwd);
>
>         return 0;
>  }
> @@ -374,9 +380,9 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
>         return 0;
>  }
>
> -static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
> +static int __btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id, bo=
ol fwd)

I don't like those underscored functions in libbpf code base, please
don't add them. But I'm also not sure we need to have it, there are
only a few calles of the original btf_dump_add_emit_queue_id(), so we
can just update them to pass true/false as appropriate.

>  {
> -       __u32 *new_queue;
> +       typeof(d->emit_queue[0]) *new_queue =3D NULL;
>         size_t new_cap;
>
>         if (d->emit_queue_cnt >=3D d->emit_queue_cap) {
> @@ -388,10 +394,45 @@ static int btf_dump_add_emit_queue_id(struct btf_du=
mp *d, __u32 id)
>                 d->emit_queue_cap =3D new_cap;
>         }
>
> -       d->emit_queue[d->emit_queue_cnt++] =3D id;
> +       d->emit_queue[d->emit_queue_cnt].id =3D id;
> +       d->emit_queue[d->emit_queue_cnt].fwd =3D fwd;
> +       d->emit_queue_cnt++;
>         return 0;
>  }
>
> +static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
> +{
> +       return __btf_dump_add_emit_queue_id(d, id, false);
> +}
> +
> +static int btf_dump_add_emit_queue_fwd(struct btf_dump *d, __u32 id)
> +{
> +       struct btf_dump_type_aux_state *tstate =3D &d->type_states[id];
> +
> +       if (tstate->fwd_ordered)
> +               return 0;
> +
> +       tstate->fwd_ordered =3D 1;
> +       return __btf_dump_add_emit_queue_id(d, id, true);
> +}
> +

see above, do we really need these wrappers, passing true/false in a
few places doesn't seem to be a big deal

> +static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id, =
bool dry_run);
> +
> +static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
> +{
> +       const struct btf_type *t =3D btf__type_by_id(d->btf, id);
> +
> +       /* __builtin_va_list is a compiler built-in, which causes compila=
tion
> +        * errors, when compiling w/ different compiler, then used to com=
pile
> +        * original code (e.g., GCC to compile kernel, Clang to use gener=
ated
> +        * C header from BTF). As it is built-in, it should be already de=
fined
> +        * properly internally in compiler.
> +        */
> +       if (t->name_off =3D=3D 0)
> +               return false;
> +       return strcmp(btf_name_of(d, t->name_off), "__builtin_va_list") =
=3D=3D 0;
> +}
> +

why moving btf_dump_is_blacklisted() but forward declaring
btf_dump_emit_missing_aliases()? Let's do the same to both, whichever
it is (forward declaring probably is least distracting here)

>  /*
>   * Determine order of emitting dependent types and specified type to sat=
isfy
>   * C compilation rules.  This is done through topological sorting with a=
n
> @@ -441,32 +482,33 @@ static int btf_dump_add_emit_queue_id(struct btf_du=
mp *d, __u32 id)
>   * The rule is as follows. Given a chain of BTF types from X to Y, if th=
ere is
>   * BTF_KIND_PTR type in the chain and at least one non-anonymous type
>   * Z (excluding X, including Y), then link is weak. Otherwise, it's stro=
ng.
> - * Weak/strong relationship is determined recursively during DFS travers=
al and
> - * is returned as a result from btf_dump_order_type().
> + * Weak/strong relationship is determined recursively during DFS travers=
al.
> + *
> + * When type id is reached via a weak link a forward declaration for
> + * that type is added to the emit queue, otherwise "full" declaration
> + * is added to the emit queue.
> + *
> + * We also keep track of "containing struct/union type ID" to determine =
when
> + * we reference it from inside and thus can avoid emitting unnecessary f=
orward
> + * declaration.
>   *
>   * btf_dump_order_type() is trying to avoid unnecessary forward declarat=
ions,
>   * but it is not guaranteeing that no extraneous forward declarations wi=
ll be
>   * emitted.
>   *
>   * To avoid extra work, algorithm marks some of BTF types as ORDERED, wh=
en
> - * it's done with them, but not for all (e.g., VOLATILE, CONST, RESTRICT=
,
> - * ARRAY, FUNC_PROTO), as weak/strong semantics for those depends on the
> + * it's done with them, but not for all (e.g., PTR, VOLATILE, CONST, RES=
TRICT,
> + * ARRAY, FUNC_PROTO, TYPEDEF), as weak/strong semantics for those depen=
ds on the
>   * entire graph path, so depending where from one came to that BTF type,=
 it
>   * might cause weak or strong ordering. For types like STRUCT/UNION/INT/=
ENUM,
>   * once they are processed, there is no need to do it again, so they are
> - * marked as ORDERED. We can mark PTR as ORDERED as well, as it semi-for=
ces
> - * weak link, unless subsequent referenced STRUCT/UNION/ENUM is anonymou=
s. But
> - * in any case, once those are processed, no need to do it again, as the
> - * result won't change.
> + * marked as ORDERED.
>   *
>   * Returns:
> - *   - 1, if type is part of strong link (so there is strong topological
> - *   ordering requirements);
> - *   - 0, if type is part of weak link (so can be satisfied through forw=
ard
> - *   declaration);
> + *   - 0, on success;
>   *   - <0, on error (e.g., unsatisfiable type loop detected).
>   */
> -static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool throug=
h_ptr)
> +static int btf_dump_order_type(struct btf_dump *d, __u32 id, __u32 cont_=
id, bool through_ptr)
>  {
>         /*
>          * Order state is used to detect strong link cycles, but only for=
 BTF
> @@ -486,48 +528,78 @@ static int btf_dump_order_type(struct btf_dump *d, =
__u32 id, bool through_ptr)
>
>         /* return true, letting typedefs know that it's ok to be emitted =
*/
>         if (tstate->order_state =3D=3D ORDERED)
> -               return 1;
> +               return 0;
>
>         t =3D btf__type_by_id(d->btf, id);
>
>         if (tstate->order_state =3D=3D ORDERING) {
>                 /* type loop, but resolvable through fwd declaration */
> -               if (btf_is_composite(t) && through_ptr && t->name_off !=
=3D 0)
> -                       return 0;
> +               if (btf_is_composite(t) && through_ptr && t->name_off !=
=3D 0) {
> +                       if (id !=3D cont_id)
> +                               return btf_dump_add_emit_queue_fwd(d, id)=
;
> +                       else
> +                               return 0;
> +               }
>                 pr_warn("unsatisfiable type cycle, id:[%u]\n", id);
>                 return -ELOOP;
>         }
>
>         switch (btf_kind(t)) {
>         case BTF_KIND_INT:
> +               tstate->order_state =3D ORDERED;
> +               if (btf_dump_emit_missing_aliases(d, id, true))
> +                       return btf_dump_add_emit_queue_id(d, id);
> +               else
> +                       return 0;
>         case BTF_KIND_FLOAT:
>                 tstate->order_state =3D ORDERED;
>                 return 0;
>
>         case BTF_KIND_PTR:
> -               err =3D btf_dump_order_type(d, t->type, true);
> -               tstate->order_state =3D ORDERED;
> +               /* Depending on whether pointer is a part of a recursive =
struct
> +                * declaration, it might not necessitate generation of a =
forward
> +                * declaration for the target type, e.g.:
> +                *
> +                * struct foo {
> +                *      struct foo *p; // no need for forward declaration
> +                * }
> +                *
> +                * struct bar {
> +                *      struct foo *p; // forward declaration is needed
> +                * }
> +                *
> +                * Hence, don't mark pointer as ORDERED, to allow travers=
al
> +                * to the target type and comparison with 'cont_id'.
> +                */
> +               err =3D btf_dump_order_type(d, t->type, cont_id, true);
>                 return err;
>
>         case BTF_KIND_ARRAY:
> -               return btf_dump_order_type(d, btf_array(t)->type, false);
> +               return btf_dump_order_type(d, btf_array(t)->type, cont_id=
, false);
>
>         case BTF_KIND_STRUCT:
>         case BTF_KIND_UNION: {
>                 const struct btf_member *m =3D btf_members(t);
> +               __u32 new_cont_id;
> +
>                 /*
>                  * struct/union is part of strong link, only if it's embe=
dded
>                  * (so no ptr in a path) or it's anonymous (so has to be
>                  * defined inline, even if declared through ptr)
>                  */
> -               if (through_ptr && t->name_off !=3D 0)
> -                       return 0;
> +               if (through_ptr && t->name_off !=3D 0) {
> +                       if (id !=3D cont_id)
> +                               return btf_dump_add_emit_queue_fwd(d, id)=
;
> +                       else
> +                               return 0;

very subjective nit, but this "else return 0;" just doesn't feel right
here. Let's do:

if (id =3D=3D cont_id)
    return 0;
return btf_dump_add_emit_queue_fwd();

It feels a bit more natural as "if it's a special nice case, we are
done (return 0); otherwise we need to emit extra fwd decl."


> +               }
>
>                 tstate->order_state =3D ORDERING;
>
> +               new_cont_id =3D t->name_off =3D=3D 0 ? cont_id : id;
>                 vlen =3D btf_vlen(t);
>                 for (i =3D 0; i < vlen; i++, m++) {
> -                       err =3D btf_dump_order_type(d, m->type, false);
> +                       err =3D btf_dump_order_type(d, m->type, new_cont_=
id, false);

just inline `t->name_off ? id : cont_id` here? It's short and
straightforward enough, I suppose (named type defines new containing
"scope", anonymous type continues existing scope)

>                         if (err < 0)
>                                 return err;
>                 }
> @@ -539,7 +611,7 @@ static int btf_dump_order_type(struct btf_dump *d, __=
u32 id, bool through_ptr)
>                 }
>
>                 tstate->order_state =3D ORDERED;
> -               return 1;
> +               return 0;
>         }
>         case BTF_KIND_ENUM:
>         case BTF_KIND_ENUM64:
> @@ -555,51 +627,53 @@ static int btf_dump_order_type(struct btf_dump *d, =
__u32 id, bool through_ptr)
>                                 return err;
>                 }
>                 tstate->order_state =3D ORDERED;
> -               return 1;
> -
> -       case BTF_KIND_TYPEDEF: {
> -               int is_strong;
> -
> -               is_strong =3D btf_dump_order_type(d, t->type, through_ptr=
);
> -               if (is_strong < 0)
> -                       return is_strong;
> +               return 0;
>
> -               /* typedef is similar to struct/union w.r.t. fwd-decls */
> -               if (through_ptr && !is_strong)
> +       case BTF_KIND_TYPEDEF:
> +               /* Do not mark typedef as ORDERED, always emit a forward =
declaration for
> +                * it instead. Otherwise the following situation would be=
 troublesome:
> +                *
> +                *   typedef struct foo foo_alias;
> +                *
> +                *   struct foo {};
> +                *
> +                *   struct root {
> +                *      foo_alias *a;
> +                *      foo_alias b;
> +                *   };
> +                *
> +                */
> +               if (btf_dump_is_blacklisted(d, id))
>                         return 0;
>
> -               /* typedef is always a named definition */
> -               err =3D btf_dump_add_emit_queue_id(d, id);
> -               if (err)
> +               err =3D btf_dump_order_type(d, t->type, t->type, through_=
ptr);
> +               if (err < 0)
>                         return err;
>
> -               d->type_states[id].order_state =3D ORDERED;
> -               return 1;
> -       }
> +               err =3D btf_dump_add_emit_queue_fwd(d, id);
> +               if (err)
> +                       return err;
> +               return 0;

return btf_dump_add_emit_queue_fwd(...); ? this is the last step, so
seems appropriate

>         case BTF_KIND_VOLATILE:
>         case BTF_KIND_CONST:
>         case BTF_KIND_RESTRICT:
>         case BTF_KIND_TYPE_TAG:
> -               return btf_dump_order_type(d, t->type, through_ptr);
> +               return btf_dump_order_type(d, t->type, cont_id, through_p=
tr);
>
>         case BTF_KIND_FUNC_PROTO: {
>                 const struct btf_param *p =3D btf_params(t);
> -               bool is_strong;
>
> -               err =3D btf_dump_order_type(d, t->type, through_ptr);
> +               err =3D btf_dump_order_type(d, t->type, cont_id, through_=
ptr);
>                 if (err < 0)
>                         return err;
> -               is_strong =3D err > 0;
>
>                 vlen =3D btf_vlen(t);
>                 for (i =3D 0; i < vlen; i++, p++) {
> -                       err =3D btf_dump_order_type(d, p->type, through_p=
tr);
> +                       err =3D btf_dump_order_type(d, p->type, cont_id, =
through_ptr);
>                         if (err < 0)
>                                 return err;
> -                       if (err > 0)
> -                               is_strong =3D true;
>                 }
> -               return is_strong;
> +               return err;

this should always be zero, right? Just return zero explicit, don't
make reader to guess

>         }
>         case BTF_KIND_FUNC:
>         case BTF_KIND_VAR:
> @@ -613,9 +687,6 @@ static int btf_dump_order_type(struct btf_dump *d, __=
u32 id, bool through_ptr)
>         }
>  }
>
> -static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
> -                                         const struct btf_type *t);
> -
>  static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
>                                      const struct btf_type *t);
>  static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
> @@ -649,73 +720,33 @@ static const char *btf_dump_ident_name(struct btf_d=
ump *d, __u32 id);
>  static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *nam=
e_map,
>                                  const char *orig_name);
>
> -static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
> -{
> -       const struct btf_type *t =3D btf__type_by_id(d->btf, id);
> -
> -       /* __builtin_va_list is a compiler built-in, which causes compila=
tion
> -        * errors, when compiling w/ different compiler, then used to com=
pile
> -        * original code (e.g., GCC to compile kernel, Clang to use gener=
ated
> -        * C header from BTF). As it is built-in, it should be already de=
fined
> -        * properly internally in compiler.
> -        */
> -       if (t->name_off =3D=3D 0)
> -               return false;
> -       return strcmp(btf_name_of(d, t->name_off), "__builtin_va_list") =
=3D=3D 0;
> -}
> -
>  /*
>   * Emit C-syntax definitions of types from chains of BTF types.
>   *
> - * High-level handling of determining necessary forward declarations are=
 handled
> - * by btf_dump_emit_type() itself, but all nitty-gritty details of emitt=
ing type
> + * All nitty-gritty details of emitting type
>   * declarations/definitions in C syntax  are handled by a combo of
>   * btf_dump_emit_type_decl()/btf_dump_emit_type_chain() w/ delegation to
>   * corresponding btf_dump_emit_*_{def,fwd}() functions.
>   *
> - * We also keep track of "containing struct/union type ID" to determine =
when
> - * we reference it from inside and thus can avoid emitting unnecessary f=
orward
> - * declaration.
> - *
>   * This algorithm is designed in such a way, that even if some error occ=
urs
>   * (either technical, e.g., out of memory, or logical, i.e., malformed B=
TF
>   * that doesn't comply to C rules completely), algorithm will try to pro=
ceed
>   * and produce as much meaningful output as possible.
>   */
> -static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_=
id)
> +static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
>  {
> -       struct btf_dump_type_aux_state *tstate =3D &d->type_states[id];
> -       bool top_level_def =3D cont_id =3D=3D 0;
>         const struct btf_type *t;
>         __u16 kind;
>
> -       if (tstate->emit_state =3D=3D EMITTED)
> -               return;
> -
>         t =3D btf__type_by_id(d->btf, id);
>         kind =3D btf_kind(t);
>
> -       if (tstate->emit_state =3D=3D EMITTING) {
> -               if (tstate->fwd_emitted)
> -                       return;
> -
> +       if (fwd) {
>                 switch (kind) {
>                 case BTF_KIND_STRUCT:
>                 case BTF_KIND_UNION:
> -                       /*
> -                        * if we are referencing a struct/union that we a=
re
> -                        * part of - then no need for fwd declaration
> -                        */
> -                       if (id =3D=3D cont_id)
> -                               return;
> -                       if (t->name_off =3D=3D 0) {
> -                               pr_warn("anonymous struct/union loop, id:=
[%u]\n",
> -                                       id);
> -                               return;
> -                       }
>                         btf_dump_emit_struct_fwd(d, id, t);
>                         btf_dump_printf(d, ";\n\n");
> -                       tstate->fwd_emitted =3D 1;
>                         break;
>                 case BTF_KIND_TYPEDEF:
>                         /*
> @@ -723,11 +754,8 @@ static void btf_dump_emit_type(struct btf_dump *d, _=
_u32 id, __u32 cont_id)
>                          * was emitted, but it can be used only for "weak=
"
>                          * references through pointer only, not for embed=
ding
>                          */
> -                       if (!btf_dump_is_blacklisted(d, id)) {
> -                               btf_dump_emit_typedef_def(d, id, t, 0);
> -                               btf_dump_printf(d, ";\n\n");
> -                       }
> -                       tstate->fwd_emitted =3D 1;
> +                       btf_dump_emit_typedef_def(d, id, t, 0);
> +                       btf_dump_printf(d, ";\n\n");
>                         break;
>                 default:
>                         break;
> @@ -739,36 +767,18 @@ static void btf_dump_emit_type(struct btf_dump *d, =
__u32 id, __u32 cont_id)
>         switch (kind) {
>         case BTF_KIND_INT:
>                 /* Emit type alias definitions if necessary */
> -               btf_dump_emit_missing_aliases(d, id, t);
> -
> -               tstate->emit_state =3D EMITTED;
> +               btf_dump_emit_missing_aliases(d, id, false);
>                 break;
>         case BTF_KIND_ENUM:
>         case BTF_KIND_ENUM64:
> -               if (top_level_def) {
> -                       btf_dump_emit_enum_def(d, id, t, 0);
> -                       btf_dump_printf(d, ";\n\n");
> -               }
> -               tstate->emit_state =3D EMITTED;
> -               break;
> -       case BTF_KIND_PTR:
> -       case BTF_KIND_VOLATILE:
> -       case BTF_KIND_CONST:
> -       case BTF_KIND_RESTRICT:
> -       case BTF_KIND_TYPE_TAG:
> -               btf_dump_emit_type(d, t->type, cont_id);
> -               break;
> -       case BTF_KIND_ARRAY:
> -               btf_dump_emit_type(d, btf_array(t)->type, cont_id);
> +               btf_dump_emit_enum_def(d, id, t, 0);
> +               btf_dump_printf(d, ";\n\n");
>                 break;
>         case BTF_KIND_FWD:
>                 btf_dump_emit_fwd_def(d, id, t);
>                 btf_dump_printf(d, ";\n\n");
> -               tstate->emit_state =3D EMITTED;
>                 break;
>         case BTF_KIND_TYPEDEF:
> -               tstate->emit_state =3D EMITTING;
> -               btf_dump_emit_type(d, t->type, id);
>                 /*
>                  * typedef can server as both definition and forward
>                  * declaration; at this stage someone depends on
> @@ -776,55 +786,14 @@ static void btf_dump_emit_type(struct btf_dump *d, =
__u32 id, __u32 cont_id)
>                  * through pointer), so unless we already did it,
>                  * emit typedef as a forward declaration
>                  */
> -               if (!tstate->fwd_emitted && !btf_dump_is_blacklisted(d, i=
d)) {
> -                       btf_dump_emit_typedef_def(d, id, t, 0);
> -                       btf_dump_printf(d, ";\n\n");
> -               }
> -               tstate->emit_state =3D EMITTED;
> +               btf_dump_emit_typedef_def(d, id, t, 0);
> +               btf_dump_printf(d, ";\n\n");
>                 break;
>         case BTF_KIND_STRUCT:
>         case BTF_KIND_UNION:
> -               tstate->emit_state =3D EMITTING;
> -               /* if it's a top-level struct/union definition or struct/=
union
> -                * is anonymous, then in C we'll be emitting all fields a=
nd
> -                * their types (as opposed to just `struct X`), so we nee=
d to
> -                * make sure that all types, referenced from struct/union
> -                * members have necessary forward-declarations, where
> -                * applicable
> -                */
> -               if (top_level_def || t->name_off =3D=3D 0) {
> -                       const struct btf_member *m =3D btf_members(t);
> -                       __u16 vlen =3D btf_vlen(t);
> -                       int i, new_cont_id;
> -
> -                       new_cont_id =3D t->name_off =3D=3D 0 ? cont_id : =
id;
> -                       for (i =3D 0; i < vlen; i++, m++)
> -                               btf_dump_emit_type(d, m->type, new_cont_i=
d);
> -               } else if (!tstate->fwd_emitted && id !=3D cont_id) {
> -                       btf_dump_emit_struct_fwd(d, id, t);
> -                       btf_dump_printf(d, ";\n\n");
> -                       tstate->fwd_emitted =3D 1;
> -               }
> -
> -               if (top_level_def) {
> -                       btf_dump_emit_struct_def(d, id, t, 0);
> -                       btf_dump_printf(d, ";\n\n");
> -                       tstate->emit_state =3D EMITTED;
> -               } else {
> -                       tstate->emit_state =3D NOT_EMITTED;
> -               }
> -               break;
> -       case BTF_KIND_FUNC_PROTO: {
> -               const struct btf_param *p =3D btf_params(t);
> -               __u16 n =3D btf_vlen(t);
> -               int i;
> -
> -               btf_dump_emit_type(d, t->type, cont_id);
> -               for (i =3D 0; i < n; i++, p++)
> -                       btf_dump_emit_type(d, p->type, cont_id);
> -
> +               btf_dump_emit_struct_def(d, id, t, 0);
> +               btf_dump_printf(d, ";\n\n");
>                 break;
> -       }
>         default:
>                 break;
>         }
> @@ -1037,19 +1006,21 @@ static const char *missing_base_types[][2] =3D {
>         { "__Poly128_t",        "unsigned __int128" },
>  };
>
> -static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
> -                                         const struct btf_type *t)
> +static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id, =
bool dry_run)

this dry_run approach look like a sloppy hack, tbh. Maybe just return
`const char *` of aliased name, and let caller handle whatever is
necessary (either making decision about the need for alias or actually
emitting `typedef %s %s`?

>  {
>         const char *name =3D btf_dump_type_name(d, id);
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(missing_base_types); i++) {
> -               if (strcmp(name, missing_base_types[i][0]) =3D=3D 0) {
> +               if (strcmp(name, missing_base_types[i][0]) !=3D 0)
> +                       continue;
> +               if (!dry_run)
>                         btf_dump_printf(d, "typedef %s %s;\n\n",
>                                         missing_base_types[i][1], name);
> -                       break;
> -               }
> +               return true;
>         }
> +
> +       return false;
>  }
>
>  static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
> --
> 2.34.1
>

