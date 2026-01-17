Return-Path: <bpf+bounces-79354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D87D38A75
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 01:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CCFA3055704
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706946B5;
	Sat, 17 Jan 2026 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnUR8yzI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A62500941
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768608380; cv=none; b=qEYiCg928OA0LNavEZ6Z7fvn7fCw1XvZtgU2AN+o8cawz6uWyfiIoncMtknRN4C6aPoOgQSvWc5oh7AXr3SagdPo9Fzcbrhpwpe+ml5k/6DLq9W6FKEOKTWB6sYYIrIwWvfYxQJatu2e7ZBo92ijMQMcSrd/eFqMU+O1+IrXjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768608380; c=relaxed/simple;
	bh=h2ln/wKX7SBUgPJweJrQtu4Q/2NKfeR1ErWvuLCA+Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdMLIw5BA+MPsfoJo9q6+b6viDU0Ebqe6JKxoEAi6Kwn7kTUp/JJjV7RHM+eXiq9b87c7Fk2tWLRfZYOjXxsRpBX5nzMsUoL1DPSUWnL4a0WR0noOPoJQlNz4QzoR1/QkapNaPWJuSJ7+b/87kUJVnLdnAIcwlu++3aeUzIbhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnUR8yzI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a110548cdeso18193645ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768608379; x=1769213179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R7MwkvY28w//a/lIqAt5KYCh6sv7mHBxNLr/F0AMTg=;
        b=cnUR8yzIhgstS/h+Off0A7KqT4k9eoLGX3DqZ3n5G/+4U7ZGGslspJHzPYHTfAmrQg
         aKuK6o7hELRJv/Fp2XQeQWDkGj4eQVhsYz/fcCC/KzzpqZXD0ToVpOaABw/L9Lb7lsEJ
         c5uMsC6iXJBLh4sVy9XgGEsfizt0E9ggYRu/pXfrk+oxWaemLgAy80jAh43V4u/5ag92
         zCmmRyBqYqYxszQGhZY6Q0B/itAMt4pQZWKoSMMuRQyUxSnE63chfbQcuHuVXCmDu2VD
         URxHZDI4G+TvVHYakWTuP7GUL2CtcK86965v7uCE7mICtIhg6gWdlMg0etjJCl8cwml1
         xHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768608379; x=1769213179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4R7MwkvY28w//a/lIqAt5KYCh6sv7mHBxNLr/F0AMTg=;
        b=epOcZgiV6BkJCmzPconwAuvDyiZGkcA6tjQRR6/+4hU23d46PicQkmHH8ERB6g7BtS
         J7X06Ghp/0Ze6IF7xqj4uI9AVQ8Lki3x5DY04+y4wR0zfxs68v5qmKdCRzzcTXEXl/rK
         v1EZWxpkBgRbn/1vhJ9Fkc1lSJVMJ2/u28Lm89YMbZ2kNojsr6Hxe1gIgJM1LyA0VDZp
         80vklxN0AT5FzyjxzvuqrIlJQN09SZQttFNyLT1RKSFkaVoIu//zsqwh6+cCsmB81P0P
         ovpjfSdXD2/jaBCBeiH/iO6LYrGfKDBZHBPx4TsZoOy8Dyv9oMaos5bYBjpZ5uqsnazx
         9LAA==
X-Forwarded-Encrypted: i=1; AJvYcCXwK/LvW/Ug4rWYrEKtelde7ukUsdQEiOZbc6enrP4jvPalFh7ZDvS34xP7nLHRc/rDokI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTo6HiWDPviJFJM7bM7rMVkrYY7COcEFN6u5iyS/maDnvVzKy
	6L0y+FWL0aR+ibM2zrVSzShLSssDmSBWEtz+otaj8KwfmKQHBJhHT/C2AKVPU1xNdxdBlHiwt4f
	NYf+iHSOjFMtnir0Y79FYAQ7zFe7NJII=
X-Gm-Gg: AY/fxX7NW0d1V+GlueXF756OiF71nEefALkjyyjZJe00cPQEosYlsb/3b40geKLms2W
	fAz13fGAjnErOStWjlX3OR1DcO2k+hgcfSdyQbitVtaj25zYJ2bI/lpsxBdZWWyCwE3xDDQ4NoJ
	D/NrLSC/7Wvrjm8YXpHBBExx1XihVKiRRSIxoNIpdai80D2idt4YiU2YbeExLqgvG+JHcTsF/k0
	qw3JENEyAoo+KI1o+u7MYhSXrndparpb4wbbbeWWNXHWcCtXviDC5u6RvZPKutRfyGjErVCOEEz
	hPub7P4YkZA=
X-Received: by 2002:a17:903:1c2:b0:29e:940c:2cdf with SMTP id
 d9443c01a7336-2a7175be339mr44924465ad.36.1768608378836; Fri, 16 Jan 2026
 16:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116201700.864797-1-ihor.solodrai@linux.dev> <20260116201700.864797-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 16:06:06 -0800
X-Gm-Features: AZwV_Qh51iktnNtGl5KEk_vgmlX67wbmJDnAVYb4S7SbBH-xy1X8CWy4GQT_EEo
Message-ID: <CAEf4BzbG=GMh0-1tT_2gdMtc-ZuV3X7hgoJZpt1RLCYgPMM3oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 12:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
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
>  tools/bpf/resolve_btfids/main.c | 383 ++++++++++++++++++++++++++++++++
>  1 file changed, 383 insertions(+)
>

[...]

> +static int collect_decl_tags(struct btf2btf_context *ctx)
> +{
> +       const u32 type_cnt =3D btf__type_cnt(ctx->btf);
> +       struct btf *btf =3D ctx->btf;
> +       const struct btf_type *t;
> +       u32 *tags, *tmp;
> +       u32 nr_tags =3D 0;
> +
> +       tags =3D malloc(type_cnt * sizeof(u32));

waste of memory, really, see below

> +       if (!tags)
> +               return -ENOMEM;
> +
> +       for (u32 id =3D 1; id < type_cnt; id++) {
> +               t =3D btf__type_by_id(btf, id);
> +               if (!btf_is_decl_tag(t))
> +                       continue;
> +               tags[nr_tags++] =3D id;
> +       }
> +
> +       if (nr_tags =3D=3D 0) {
> +               ctx->decl_tags =3D NULL;
> +               free(tags);
> +               return 0;
> +       }
> +
> +       tmp =3D realloc(tags, nr_tags * sizeof(u32));
> +       if (!tmp) {
> +               free(tags);
> +               return -ENOMEM;
> +       }

This is an interesting realloc() usage pattern, it's quite
unconventional to preallocate too much memory, and then shrink (in C
world)

check libbpf's libbpf_add_mem(), that's a generic "primitive" inside
the libbpf. Do not reuse it as is, but it should give you an idea of a
common pattern: you start with NULL (empty data), when you need to add
a new element, you calculate a new array size which normally would be
some minimal value (to avoid going through 1 -> 2 -> 4 -> 8, many
small and wasteful steps; normally we just jump straight to 16 or so)
or some factor of previous size (doesn't have to be 2x,
libbpf_add_mem() expands by 25%, for instance).

This is a super common approach in C. Please utilize it here as well.

> +
> +       ctx->decl_tags =3D tmp;
> +       ctx->nr_decl_tags =3D nr_tags;
> +
> +       return 0;
> +}
> +
> +/*
> + * To find the kfunc flags having its struct btf_id (with ELF addresses)
> + * we need to find the address that is in range of a set8.
> + * If a set8 is found, then the flags are located at addr + 4 bytes.
> + * Return 0 (no flags!) if not found.
> + */
> +static u32 find_kfunc_flags(struct object *obj, struct btf_id *kfunc_id)
> +{
> +       const u32 *elf_data_ptr =3D obj->efile.idlist->d_buf;
> +       u64 set_lower_addr, set_upper_addr, addr;
> +       struct btf_id *set_id;
> +       struct rb_node *next;
> +       u32 flags;
> +       u64 idx;
> +
> +       next =3D rb_first(&obj->sets);
> +       while (next) {

for(next =3D rb_first(...); next; next =3D rb_next(next)) seems like a
good fit here, no?

> +               set_id =3D rb_entry(next, struct btf_id, rb_node);
> +               if (set_id->kind !=3D BTF_ID_KIND_SET8 || set_id->addr_cn=
t !=3D 1)
> +                       goto skip;
> +
> +               set_lower_addr =3D set_id->addr[0];
> +               set_upper_addr =3D set_lower_addr + set_id->cnt * sizeof(=
u64);
> +
> +               for (u32 i =3D 0; i < kfunc_id->addr_cnt; i++) {
> +                       addr =3D kfunc_id->addr[i];
> +                       /*
> +                        * Lower bound is exclusive to skip the 8-byte he=
ader of the set.
> +                        * Upper bound is inclusive to capture the last e=
ntry at offset 8*cnt.
> +                        */
> +                       if (set_lower_addr < addr && addr <=3D set_upper_=
addr) {
> +                               pr_debug("found kfunc %s in BTF_ID_FLAGS =
%s\n",
> +                                        kfunc_id->name, set_id->name);
> +                               goto found;

why goto, just do what needs to be done and return?

> +                       }
> +               }
> +skip:
> +               next =3D rb_next(next);
> +       }
> +
> +       return 0;
> +
> +found:
> +       idx =3D addr - obj->efile.idlist_addr;
> +       idx =3D idx / sizeof(u32) + 1;
> +       flags =3D elf_data_ptr[idx];
> +
> +       return flags;
> +}
> +
> +static s64 collect_kfuncs(struct object *obj, struct btf2btf_context *ct=
x)
> +{
> +       struct kfunc *kfunc, *kfuncs, *tmp;
> +       const char *tag_name, *func_name;
> +       struct btf *btf =3D ctx->btf;
> +       const struct btf_type *t;
> +       u32 flags, func_id;
> +       struct btf_id *id;
> +       s64 nr_kfuncs =3D 0;
> +
> +       if (ctx->nr_decl_tags =3D=3D 0)
> +               return 0;
> +
> +       kfuncs =3D malloc(ctx->nr_decl_tags * sizeof(*kfuncs));

ditto about realloc() usage pattern

> +       if (!kfuncs)
> +               return -ENOMEM;
> +

[...]

> +/*
> + * For a kfunc with KF_IMPLICIT_ARGS we do the following:
> + *   1. Add a new function with _impl suffix in the name, with the proto=
type
> + *      of the original kfunc.
> + *   2. Add all decl tags except "bpf_kfunc" for the _impl func.
> + *   3. Add a new function prototype with modified list of arguments:
> + *      omitting implicit args.
> + *   4. Change the prototype of the original kfunc to the new one.
> + *
> + * This way we transform the BTF associated with the kfunc from
> + *     __bpf_kfunc bpf_foo(int arg1, void *implicit_arg);
> + * into
> + *     bpf_foo_impl(int arg1, void *implicit_arg);
> + *     __bpf_kfunc bpf_foo(int arg1);
> + *
> + * If a kfunc with KF_IMPLICIT_ARGS already has an _impl counterpart
> + * in BTF, then it's a legacy case: an _impl function is declared in the
> + * source code. In this case, we can skip adding an _impl function, but =
we
> + * still have to add a func prototype that omits implicit args.
> + */
> +static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx,=
 struct kfunc *kfunc)
> +{

this logic looks good

> +       s32 idx, new_proto_id, new_func_id, proto_id;
> +       const char *param_name, *tag_name;
> +       const struct btf_param *params;
> +       enum btf_func_linkage linkage;
> +       char tmp_name[KSYM_NAME_LEN];
> +       struct btf *btf =3D ctx->btf;
> +       int err, len, nr_params;
> +       struct btf_type *t;
> +

[...]

