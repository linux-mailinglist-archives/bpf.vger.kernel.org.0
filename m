Return-Path: <bpf+bounces-78423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67569D0C893
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2B530318F6
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F04339875;
	Fri,  9 Jan 2026 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKzZzN/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493A339B3B
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001129; cv=none; b=cdkAd1FyaXr5CjmX9nhpObs8MsN1bqZ2WDNE8w3bk6uzH8l140b67zviQG79DQA3BKgGbKc3Tu3y0sdpRe9FndKIH0eMcYiStM//5eQqFdCWuxllo203MNy71Kc78HEgdET9vOEsiDt43yaOCdAAGAU1XKTND2Svm0ilRWhno90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001129; c=relaxed/simple;
	bh=8FBCaCyqX/5p8ep+B0jVqiUxXqivjleWkIuWb9+6tdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trtcptOFi3S9dNoKBzC4W0Nt7ElgGtkMxLpgWIeWiExj5deEubERP+l4DfVt0XCVHAEOJAlii7DLEzR7I56kaFRbP4tEnKJ9K7Q36lSaK1Oo69fh067QnbbFDS+xrv8a8xNs3M/UEMQeF2v7II45pV0jFhXlGtg5yKBEjsmW3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKzZzN/h; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34abc7da414so2776174a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001127; x=1768605927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3smSj4yq761xJEdfeIzyD9mGpI5b5lkPuDabJ4mNTY=;
        b=jKzZzN/haYNFc878IpY0KXDpTSdhA1iia82Qyit79+CcOWwgVtbXwYjjf1G4fZ8GOm
         AzQaD9YaKOj684GIzj8sixapOgN09UzTuVPXbI++mxGla0DJ8smM2R0W7jBdbarmAz//
         QXfmHTbONPyXbT191v0Y+zX8IhEQmkR059O9nENnvq20EjpoYfSEbSYZfOakbbiltX9h
         hVEV2LYSBtZyvSk5fDI+8GgKDhtI7EtuUh6hMh5G0xB8N9BDoXmPIZALD8LJK+bDS8Dd
         vYUsq3mQ9KU1ehqfpDbBEWwtisVKKYXxLCNHHdfbErq0gZlLjSYCAk2qXpEjXZtECXgp
         girQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001127; x=1768605927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3smSj4yq761xJEdfeIzyD9mGpI5b5lkPuDabJ4mNTY=;
        b=na8EU4pACXEYRVjiPsV9Yk2HLaL/kmPcAgtAvbcpzTq2L2mNiYgP80/XwLj00C+Q4Y
         k8NFQO+FITi8dzajK84X2HV+Bee7ttP0NWnFKr316kbRnhRjdoIpiFCvCVHTpMbzNvu1
         3qhnksk3yoW1avbz5YUrRsXRb10SrNeszP9SPbKO4/LbtMM5dawwp0FUqwDJLOhNm/cx
         vg7t/IVHvqM9LKfiT8v9cDgcBRFAr5CxhiWcKsMIgKR58wQmvKBMxm1OgDLrhzAaL2K+
         j7cD2OLTK1gxOSsMfAHA6uqc+rdV6hkp4Wpnv6AFj+IvXz02irCaiwHOiWX0jCSb+3I0
         AcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKQ0Gm064/Q+VmwJmBGeM8U9KrUjlH/OsbkYZ3w0QMbM8iNPitwGtGstyxdchl/LydQ2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5oavFiKYou5+FHqwGXbe2rjS5NfoyoMv0A/DiPnwnvYJdoUL
	gEZMwwzoJd4Paf2bZolZTtTzWOVASwt2Ehs+0w6JjuyOWJmD+epXCDqdDYvhh2EDfknjvYOJB2P
	7+wGEfOYpDkfo8iCR0L3TyuUXvsh/erk=
X-Gm-Gg: AY/fxX6ntlx5X2qyKmnIT4cnxkUiItotBrBjLp1w3ieIWOfkBRS4ktqj9AyO6dreCfY
	qG0dbHpSJEf3KOlUyq6h3kYphojOBLDFQUxaAbbyiYyoZOBYTBDpYq7oa6Tbi8nVHHoljvJt+ts
	efxwaDIAmu0Uf6mf8p/XcHazzsP2Xaafe+oAunZSErpK6Q/xwCaaP5rkXyoliHdniyMjZXU29ey
	q1ZsYzZmV/PNY0bCtv3KmNmvg/7suuiOBvaTywj27PcnD0VqUT1YK2qlhv8dbfeLNYXnJ125bqF
	LCfbAC7q
X-Google-Smtp-Source: AGHT+IGph+InObp8GZWAvDke/lgRnu3hqucWuw9wj4XP4b7Bo+rVtRgvL1z5U8Nhknv5ZSXf3xpcVYzY5A65utP8Gqw=
X-Received: by 2002:a17:90b:5867:b0:32e:e18a:3691 with SMTP id
 98e67ed59e1d1-34f68c47f70mr10911650a91.35.1768001127004; Fri, 09 Jan 2026
 15:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-5-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:25:12 -0800
X-Gm-Features: AQt7F2q4hGQ9ktOaWH95bMsFjqdRiC4JC3b0cbvTrYrLtv95_AHDkxtq0G5LotM
Message-ID: <CAEf4BzYcZ5pLCvfn8uWiKCjpBXBw9dxR_WZnKxVz1Bhf96xOGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Implement BTF modifications in resolve_btfids to support BPF kernel
> functions with implicit arguments.
>
> For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
> prototype is added to BTF that does not have implicit arguments. The
> kfunc's prototype is then updated to a new one in BTF. This prototype
> is the intended interface for the BPF programs.
>
> A <func_name>_impl function is added to BTF to make the original kfunc
> prototype searchable for the BPF verifier. If a <func_name>_impl
> function already exists in BTF, its interpreted as a legacy case, and
> this step is skipped.
>
> Whether an argument is implicit is determined by its type:
> currently only `struct bpf_prog_aux *` is supported.
>
> As a result, the BTF associated with kfunc is changed from
>
>     __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);
>
> into
>
>     bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
>     __bpf_kfunc bpf_foo(int arg1);
>
> For more context see previous discussions and patches [1][2].
>
> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@=
linux.dev/
> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@li=
nux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 282 ++++++++++++++++++++++++++++++++
>  1 file changed, 282 insertions(+)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index df39982f51df..b361e726fa36 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -152,6 +152,18 @@ struct object {
>         int nr_typedefs;
>  };
>
> +#define KF_IMPLICIT_ARGS (1 << 16)
> +#define KF_IMPL_SUFFIX "_impl"
> +#define MAX_BPF_FUNC_REG_ARGS 5
> +#define MAX_KFUNCS 256
> +#define MAX_DECL_TAGS (MAX_KFUNCS * 4)

can't we get that from include/linux/bpf.h? seems like
resolve_btfids's main.c include internal headers just fine, so why
duplicate definitions?

> +
> +struct btf2btf_context {
> +       struct btf *btf;
> +       u32 nr_decl_tags;
> +       s32 decl_tags[MAX_DECL_TAGS];
> +};
> +
>  static int verbose;
>  static int warnings;
>
> @@ -972,6 +984,273 @@ static int patch_btfids(const char *btfids_path, co=
nst char *elf_path)
>         return err;
>  }
>
> +static s64 collect_kfunc_ids_by_flags(struct object *obj,
> +                                     u32 flags,
> +                                     s32 kfunc_ids[],
> +                                     const u32 kfunc_ids_sz)
> +{
> +       Elf_Data *data =3D obj->efile.idlist;
> +       struct rb_node *next;
> +       s64 nr_kfuncs =3D 0;
> +       int i;
> +
> +       next =3D rb_first(&obj->sets);
> +       while (next) {
> +               struct btf_id_set8 *set8 =3D NULL;
> +               unsigned long addr, off;
> +               struct btf_id *id;
> +
> +               id =3D rb_entry(next, struct btf_id, rb_node);
> +
> +               if (id->kind !=3D BTF_ID_KIND_SET8)
> +                       goto skip;
> +
> +               addr =3D id->addr[0];
> +               off =3D addr - obj->efile.idlist_addr;
> +               set8 =3D data->d_buf + off;
> +
> +               for (i =3D 0; i < set8->cnt; i++) {
> +                       if (set8->pairs[i].flags & flags) {

invert condition and continue, reduce nesting?

> +                               if (nr_kfuncs >=3D kfunc_ids_sz) {

it's silly to set static limits like this: we are not in NMI, you have
memory allocator, use it

> +                                       pr_err("ERROR: resolve_btfids: to=
o many kfuncs with flags %u - limit %d\n",
> +                                              flags, kfunc_ids_sz);
> +                                       return -E2BIG;
> +                               }
> +                               kfunc_ids[nr_kfuncs++] =3D set8->pairs[i]=
.id;
> +                       }
> +               }
> +skip:
> +               next =3D rb_next(next);
> +       }
> +
> +       return nr_kfuncs;
> +}
> +
> +static const struct btf_type *btf__unqualified_type_by_id(const struct b=
tf *btf, s32 type_id)
> +{
> +       const struct btf_type *t =3D btf__type_by_id(btf, type_id);
> +
> +       while (btf_is_mod(t))
> +               t =3D btf__type_by_id(btf, t->type);
> +
> +       return t;
> +}
> +
> +/* Implicit BPF kfunc arguments can only be of particular types */
> +static bool btf__is_kf_implicit_arg(const struct btf *btf, const struct =
btf_param *p)

nit: not sure why you use double underscore convention, this is not
really an "API" of btf, it's just a helper... I'd just call it
"is_kf_implicit_arg", btf is just and input argument

> +{
> +       static const char *const kf_implicit_arg_types[] =3D {
> +               "bpf_prog_aux",
> +       };
> +       const struct btf_type *t;
> +       const char *name;
> +

[...]

> +       /* Copy all decl tags except "bpf_kfunc" from the original kfunc =
to the new one */
> +       for (int i =3D 0; i < ctx->nr_decl_tags; i++) {
> +               t =3D (struct btf_type *)btf__type_by_id(btf, ctx->decl_t=
ags[i]);
> +               if (t->type !=3D kfunc_id)
> +                       continue;
> +
> +               tag_name =3D btf__name_by_offset(btf, t->name_off);
> +               if (strcmp(tag_name, "bpf_kfunc") =3D=3D 0)
> +                       continue;
> +
> +               err =3D btf__add_decl_tag(btf, tag_name, new_func_id, -1)=
;

decl_tag can apply to arguments as well (that -1 will be actually >=3D
0), we should copy those as well, no?

> +               if (err < 0) {
> +                       pr_err("ERROR: resolve_btfids: failed to add decl=
 tag %s for %s\n",
> +                              tag_name, tmp_name);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +add_new_proto:
> +       /*
> +        * Drop the _impl suffix and point kfunc_name to the local buffer=
 for later use.
> +        * When BTF is modified the original pointer is invalidated.
> +        */
> +       tmp_name[name_len] =3D '\0';
> +       kfunc_name =3D tmp_name;
> +
> +       /* Load non-implicit args from the original prototype */
> +       t =3D (struct btf_type *)btf__type_by_id(btf, proto_id);
> +       params =3D btf_params(t);
> +       nr_params =3D 0;
> +       for (int i =3D 0; i < btf_vlen(t); i++) {
> +               if (btf__is_kf_implicit_arg(btf, &params[i]))
> +                       break;
> +               new_params[nr_params++] =3D params[i];
> +       }

this is unnecessary, just when you working with original prototype and
its arguments, just re-fetch it back from IDs, all those pointers will
be valid until next btf__add_xxx() invocation, no need for this
awkward local copies

> +
> +       new_proto_id =3D btf__add_func_proto(btf, t->type);
> +       if (new_proto_id < 0) {
> +               pr_err("ERROR: resolve_btfids: failed to add func proto f=
or %s\n", kfunc_name);
> +               return new_proto_id;
> +       }
> +
> +       /* Add non-implicit args to the new prototype */
> +       for (int i =3D 0; i < nr_params; i++) {
> +               param_name =3D btf__name_by_offset(btf, new_params[i].nam=
e_off);
> +               err =3D btf__add_func_param(btf, param_name, new_params[i=
].type);
> +               if (err < 0) {
> +                       pr_err("ERROR: resolve_btfids: failed to add para=
m %s for %s\n",
> +                              param_name, kfunc_name);
> +                       return err;
> +               }
> +       }
> +
> +       /* Finally change the prototype of the original kfunc to the new =
one */
> +       t =3D (struct btf_type *)btf__type_by_id(btf, kfunc_id);
> +       t->type =3D new_proto_id;
> +
> +       pr_debug("resolve_btfids: updated BTF for kfunc with implicit arg=
s %s\n", kfunc_name);
> +
> +       return 0;
> +}
> +
> +static s64 btf__collect_decl_tags(const struct btf *btf, s32 *decl_tags,=
 u32 decl_tags_sz)
> +{
> +       const u32 type_cnt =3D btf__type_cnt(btf);
> +       const struct btf_type *t;
> +       s64 nr_decl_tags =3D 0;
> +
> +       for (u32 id =3D 1; id < type_cnt; id++) {
> +               t =3D btf__type_by_id(btf, id);
> +               if (!btf_is_decl_tag(t))
> +                       continue;
> +               if (nr_decl_tags >=3D decl_tags_sz) {
> +                       pr_err("ERROR: resolve_btfids: too many decl tags=
 in BTF - limit %s\n",

realloc is your friend, no fixed-sized arrays

> +                               decl_tags_sz);
> +                       return -E2BIG;
> +               }
> +               decl_tags[nr_decl_tags++] =3D id;
> +       }
> +
> +       return nr_decl_tags;
> +}
> +

[...]

