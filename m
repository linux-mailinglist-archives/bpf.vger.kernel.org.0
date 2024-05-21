Return-Path: <bpf+bounces-30180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93B8CB638
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8329E1F21DA5
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEFB149DFF;
	Tue, 21 May 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxgmLrGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338814A0BD
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332395; cv=none; b=cnpFeKXBmiTODNR8ToDT5CVXaTvNPdlUqtNriW14FSUPdA4z2Y6E44shZnR9HtzbPRin+cZT/M2h77kVcc+fY/s9wgzEA4fsKdwq08aYUbMQ+JWk0Qb6v6EmFODnBQUFYsnKBVe3QdtzBIkgQZPC/+W50WBxWDnh60tYC7VH/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332395; c=relaxed/simple;
	bh=Qkf+WjdMwVJE8ohLc88NT1D6coogcJqPXc77rnzyRmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/H5sgiPMAFg49FdjL/bQpIwzVGv6FApl0r4Szg51Fwn2lvaPt65/cN3WMMP7rMKMsxN3EI/3e7CJmqch9Vj2Xkvp3u7GGlX6yFEW07grLK2m4+WiftwYpqRuGozBS1qPMltUkVcH/x3IUK48EnKpNEYdsieNazrzEEUHWSTvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxgmLrGx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so943199466b.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716332392; x=1716937192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoWs5O4G5FHpPR3fSb44Wf4A70/dwyTbWBoYWSh7uis=;
        b=YxgmLrGxhIFqLbi+MThRB6yqD2KooxTSzPjPqGbfqjzGqZYHPqm8wcz/ySyGoKIwQ5
         TbLCCXO2erE957b/Z8L1qvIwWomBUGECLc1Ro4uXUuKaPzi88QdmsaD4mikP2UThPoAS
         iobpHHF9KnwMeyu+uwY27l0TxOmy17y1K8OjpPsaU3fRrDc9tEUSOwkxjMzKdsj6dSmy
         dUtotyD3wxdunTto33yCdEUWCyD7Ma5u8i11A7KV2jnoxXtfNPC/vh/qMT5sNMaOT6On
         Kom5AmpaPUYhJsh2FokzOtcLa81/U8giLVeOoNpsLJh0oLr+nHbeCcWzT3Al19mjwr58
         rwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716332392; x=1716937192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoWs5O4G5FHpPR3fSb44Wf4A70/dwyTbWBoYWSh7uis=;
        b=plgEHTiW/2yhWgm3w3E6MVfyBaao6jvUZhXrxRKnVPAHj/f2sJathdBHl6j/PYAUQt
         71aKqECMsi97HzhALYzt8LSPwRRXdK5krRCxptg7VoArbct3ic88Duk3rrz+ed9xYbF5
         n66FhtiDq2NntvBkjlJzyWArrEQN7th43ue3q+yZ3Qwu2eOC1psOTTAVZRkYCQZwztPe
         pX7xcOzX6lCiXCkUXaOYkUmvvju9P6PMn5wdI/z6I+smuhv0W4kNvk9DU1LraQn0tUeX
         yqIACRtZIrPqT9HQvRlw8iOZ2wxp7LfZ9WyEqQgXYo9wupzzGJTltgOlFV6rPAYq/HbR
         Fu7w==
X-Forwarded-Encrypted: i=1; AJvYcCUY7PBkjoLXCPgkEGNMtBE/m0sfvyiG0ZZYu+Qu4D4+IgdkW5peqwL/LY3TdWPopDILKjOPTk4ac9fzNEUcl0U+LeNi
X-Gm-Message-State: AOJu0YzWtg5QCHe5X68YDBOJcgFcdSNKBcsavC70jdZbiRddCKManJXp
	+OnlWc1si7aJtKkuObn87mwrjW3s+A1omK13kdRQnJb1o5r5Kyryv4zj+FmrbILyVIVGE7NrIUd
	eTTq1p5gnrEPJfBbofmEdMCklGz5mDA==
X-Google-Smtp-Source: AGHT+IGUdK18qcdPDfW3T5n5ms+OEeief12kX74B0I1Au7JpwPNqFiuJwY09asZDzHmmJ997BVpa1XXk5dcaTrlLjR4=
X-Received: by 2002:a17:906:3a90:b0:a59:9b52:cfc5 with SMTP id
 a640c23a62f3a-a62280a05a2mr9277266b.37.1716332391977; Tue, 21 May 2024
 15:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com> <20240517102246.4070184-11-alan.maguire@oracle.com>
In-Reply-To: <20240517102246.4070184-11-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 15:59:36 -0700
Message-ID: <CAEf4BzYt7QwXXW41B6H5+OAQ81r7eCNf4YVYVd8wFHDceXJ4+g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 10/11] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 3:24=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Share relocation implementation with the kernel.  As part of this,
> we also need the type/string visitation functions so add them to a
> btf_common.c file that also gets shared with the kernel. Relocation
> code in kernel and userspace is identical save for the impementation

typo: implementation

> of the reparenting of split BTF to the relocated base BTF and
> retrieval of BTF header from "struct btf"; these small functions
> need separate user-space and kernel implementations.
>
> One other wrinkle on the kernel side is we have to map .BTF.ids in
> modules as they were generated with the type ids used at BTF encoding
> time. btf_relocate() optionally returns an array mapping from old BTF
> ids to relocated ids, so we use that to fix up these references where
> needed for kfuncs.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/btf.h          |  45 ++++++++++
>  kernel/bpf/Makefile          |   8 ++
>  kernel/bpf/btf.c             | 166 +++++++++++++++++++++++++----------
>  tools/lib/bpf/Build          |   2 +-
>  tools/lib/bpf/btf.c          | 130 ---------------------------
>  tools/lib/bpf/btf_common.c   | 143 ++++++++++++++++++++++++++++++

not a big fan of "btf_common" name, it tells nothing about what that
is about. Thinking a bit ahead, we are going to replace all those
callback-calling visitor helpers with iterators soon, so maybe we can
call this btf_iter.c (or at least btf_utils.c) for a more meaningful
name?

>  tools/lib/bpf/btf_relocate.c |  23 +++++
>  7 files changed, 341 insertions(+), 176 deletions(-)
>  create mode 100644 tools/lib/bpf/btf_common.c
>

[...]

>  #ifdef CONFIG_BPF_SYSCALL
>  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id=
);
> +void btf_set_base_btf(struct btf *btf, struct btf *base_btf);
> +int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **ma=
p_ids);
> +int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, =
void *ctx);
> +int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, =
void *ctx);
>  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
> +const char *btf_str_by_offset(const struct btf *btf, u32 offset);
>  struct btf *btf_parse_vmlinux(void);
>  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
>  u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
> @@ -543,6 +564,30 @@ static inline const struct btf_type *btf_type_by_id(=
const struct btf *btf,
>  {
>         return NULL;
>  }
> +
> +static inline void btf_set_base_btf(struct btf *btf, struct btf *base_bt=
f)
> +{
> +       return;
> +}
> +
> +static inline int btf_relocate(void *log, struct btf *btf, const struct =
btf *base_btf,
> +                              __u32 **map_ids)
> +{
> +       return 0;

-EOPNOTSUPP?

> +}
> +
> +static inline int btf_type_visit_type_ids(struct btf_type *t, type_id_vi=
sit_fn visit,
> +                                         void *ctx)
> +{
> +       return 0;

ditto

> +}
> +
> +static inline int btf_type_visit_str_offs(struct btf_type *t, str_off_vi=
sit_fn visit,
> +                                         void *ctx)
> +{
> +       return 0;

ditto

> +}
> +
>  static inline const char *btf_name_by_offset(const struct btf *btf,
>                                              u32 offset)
>  {
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7eb9ad3a3ae6..612eef1228ca 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -52,3 +52,11 @@ obj-$(CONFIG_BPF_PRELOAD) +=3D preload/
>  obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
>         $(call if_changed_rule,cc_o_c)
> +
> +obj-$(CONFIG_BPF_SYSCALL) +=3D btf_common.o
> +$(obj)/btf_common.o: $(srctree)/tools/lib/bpf/btf_common.c FORCE
> +       $(call if_changed_rule,cc_o_c)
> +
> +obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> +$(obj)/btf_relocate.o: $(srctree)/tools/lib/bpf/btf_relocate.c FORCE
> +       $(call if_changed_rule,cc_o_c)

I believe make should allow us to do this with one rule, see all those
magical % rules

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..ebc127da4d79 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -274,6 +274,7 @@ struct btf {
>         u32 start_str_off; /* first string offset (0 for base BTF) */
>         char name[MODULE_NAME_LEN];
>         bool kernel_btf;
> +       __u32 *base_map; /* map from distilled base BTF -> vmlinux BTF id=
s */

please point out that it's an ID map in the name, so base_id_map. map
by itself is confusing.

>  };
>
>  enum verifier_phase {
> @@ -530,6 +531,11 @@ static bool btf_type_is_decl_tag_target(const struct=
 btf_type *t)
>                btf_type_is_var(t) || btf_type_is_typedef(t);
>  }
>
> +static bool btf_is_vmlinux(const struct btf *btf)
> +{
> +       return btf->kernel_btf && !btf->base_btf;

there is actually a helper like this somewhere in the kernel. I can't
recall the name, but it checks the name ("vmlinux"), it would be nice
to avoid duplication of logic

> +}
> +
>  u32 btf_nr_types(const struct btf *btf)
>  {
>         u32 total =3D 0;
> @@ -772,7 +778,7 @@ static bool __btf_name_char_ok(char c, bool first)
>         return true;
>  }
>

[...]

> +struct btf *btf_parse_vmlinux(void)
> +{
> +       struct btf_verifier_env *env =3D NULL;
> +       struct bpf_verifier_log *log;
> +       struct btf *btf;
> +       int err;
> +
> +       env =3D kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
> +       if (!env)
> +               return ERR_PTR(-ENOMEM);
> +
> +       log =3D &env->log;
> +       log->level =3D BPF_LOG_KERNEL;
> +       btf =3D btf_parse_base(env, "vmlinux", __start_BTF, __stop_BTF - =
__start_BTF);
> +       if (!IS_ERR(btf)) {

nit: let's keep success case logic linear, instead of nesting it. It's
better to have a few goto err_out for error condition, but have a
linear unnested steps for success

> +               /* btf_parse_vmlinux() runs under bpf_verifier_lock */
> +               bpf_ctx_convert.t =3D btf_type_by_id(btf, bpf_ctx_convert=
_btf_id[0]);
> +               err =3D btf_alloc_id(btf);
> +               if (err) {
> +                       btf_free(btf);
> +                       btf =3D ERR_PTR(err);
> +               }
> +       }
> +       btf_verifier_env_free(env);
> +       return btf;
> +}
> +
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>
> -static struct btf *btf_parse_module(const char *module_name, const void =
*data, unsigned int data_size)
> +/* If .BTF_ids section was created with distilled base BTF, both base an=
d
> + * split BTF ids will need to be mapped to actual base/split ids for
> + * BTF now that it has been relocated.
> + */
> +static __u32 btf_id_map(const struct btf *btf, __u32 id)

... and this should be named "btf_map_id" (prefix + verb + subject),
IMO (or even better btf_remap_id or btf_relocate_id, actually)

>  {
> +       if (!btf->base_btf || !btf->base_map)
> +               return id;
> +       return btf->base_map[id];
> +}
> +

[...]

