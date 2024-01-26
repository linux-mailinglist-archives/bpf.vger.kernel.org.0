Return-Path: <bpf+bounces-20440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732883E72A
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11639287C82
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4015D8F7;
	Fri, 26 Jan 2024 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGsZrNyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43865916D
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312425; cv=none; b=Kf0o/x97IEyN1OEtGIEKuVk8kDj56JAy5/zQKanksUrxJ3JR9pQy1ScCIhepkXImY2m0tokgotm4xc4EFNjlnLHhawIRYPl7uKXxdk6Z2vrNxlAkfbO9RzL/8DyFMWz3BD8sazODGZYe1ybJluwQjM71Jso4xCKvXaCoVrWmayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312425; c=relaxed/simple;
	bh=SgdsPWnAAe+SESuCDcNrYmQj4eqFqqXwm+31ig7tSdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPWF0SB4lXyIR2isGJiIIG2dV3jYyf3f8heXbeu71yNW40BhOP3lIety1N8vFqZ5mYme0bgwrdA9OXCksjCBSYgc0BhztLb7PAGFm5qBBGYFS1S0FX0ZwNc8q4SSjE1zz1QGBs5ERWwTcuzEirGoyPbJma2LzDSEXI4ZbJyYlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGsZrNyn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so629305a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 15:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706312423; x=1706917223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVoVET4VuEJVHUXi3gvo5kz3ocK9Li7p6n4q0YGjboc=;
        b=lGsZrNynmaRCFzaHJLkJN1fwSyHPVAHJ4uYOgIQQt/crmvHRmbaDZ60YIUAvAQTAN8
         2tdQWtJ+458Gn7lk4DqcpCPDYtok3QO3pTWMxhvMfmEIxcxI1camvsZRC/kEzgHhGrpw
         E2B9FOw3E0xlEG3brDDq3a22lq420J/CpLUPFdtrkrcgX5WIIxsdq65nyty9yBrSSrK8
         q4cnyMYC9Orp7f8OGrm5V3GUklMu2v2ucKDFaAD+F6+M4SXqwovKR9cECKM3NKVCr3tS
         PyF7VxCfhc3E2yWvHgndPRU1tdddcRtQPN/J0i9qb5f5glYrLXYer9A8N+xVQ6wQetan
         +Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706312423; x=1706917223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVoVET4VuEJVHUXi3gvo5kz3ocK9Li7p6n4q0YGjboc=;
        b=mFK2LLRnANEbxeSbybp7xt9qm95hwjZr1CwElK/shkpMt3zWtzt0Q6NFXqWrfpvVfW
         PZpgEFzA1dhm2byV/5u3SxNjsRC4WqcAtMC5VzhSXe2RXC+rofeI33NL9hmjuMpJ5cZp
         LOI3rNT0PLMTGYdwr1EikbK4JPTL82px4zVTaVYNEuSvE2Bvrv/x0eoRUUj2FU7NY5iR
         ewI/emN1zRn3bqLWU8tzM+ganwFQG1AXA2wkQrIg6C6EsqMxr0BaA5+yrfadF2SeTsRx
         Nj98cUPC5f5ncge+W4JSnihYv9oZg8K5x8yTf0G/eMCrukpPNuhDwWh4vN8p8ODRtokv
         i9FQ==
X-Gm-Message-State: AOJu0Ywpe3ooq+7W6Zlt9v9PQAc9i6+u2DaE1mdwLfEP809eURSaUhdo
	DT1f4JYCKYRE8d5/v/1ZHrHisMfTPAHPTnI7nUNPO0eLLaVGsHiP6lUJuOaxPB/G4UypS5ruRId
	mD1WkctRKzEyE9+67fNBg9qu3Q3Q=
X-Google-Smtp-Source: AGHT+IHmwNWdqkyQDE4KhqdphWsn0re/L0bB+mcQ0v7uNjTn5LbEwMMqTLWkj5ZEObArMXVSwMTiRyNtEruvI8g4sxI=
X-Received: by 2002:a05:6a21:398e:b0:19c:8e2b:b5a3 with SMTP id
 ad14-20020a056a21398e00b0019c8e2bb5a3mr817758pzc.56.1706312422935; Fri, 26
 Jan 2024 15:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123120759.1865189-1-vmalik@redhat.com>
In-Reply-To: <20240123120759.1865189-1-vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 15:40:11 -0800
Message-ID: <CAEf4Bzb=eSCO=h4q1fqqGfEoo9Nf4BZL51_dYm2MHvEFzD_csw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix cross-compilation to
 non-host endianness
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 4:08=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
> build and afterwards patched by resolve_btfids with correct values.
> Since resolve_btfids always writes in host-native endianness, it relies
> on libelf to do the translation when the target ELF is cross-compiled to
> a different endianness (this was introduced in commit 61e8aeda9398
> ("bpf: Fix libelf endian handling in resolv_btfids")).
>
> Unfortunately, the translation will corrupt the flags fields of SET8
> entries because these were written during vmlinux compilation and are in
> the correct endianness already. This will lead to numerous selftests
> failures such as:
>
>     $ sudo ./test_verifier 502 502
>     #502/p sleepable fentry accept FAIL
>     Failed to load prog 'Invalid argument'!
>     bpf_fentry_test1 is not sleepable
>     verification time 34 usec
>     stack depth 0
>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states =
0 peak_states 0 mark_read 0
>     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
>
> Since it's not possible to instruct libelf to translate just certain
> values, let's manually bswap the flags in resolve_btfids when needed, so
> that libelf then translates everything correctly.
>
> Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF se=
ts")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 35 +++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 27a23196d58e..440d3d066ce4 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -646,18 +646,31 @@ static int cmp_id(const void *pa, const void *pb)
>         return *a - *b;
>  }
>
> +static int need_bswap(int elf_byte_order)
> +{
> +       return __BYTE_ORDER =3D=3D __LITTLE_ENDIAN && elf_byte_order !=3D=
 ELFDATA2LSB ||
> +              __BYTE_ORDER =3D=3D __BIG_ENDIAN && elf_byte_order !=3D EL=
FDATA2MSB;

return (__BYTE_ORDER =3D=3D __LITTLE_ENDIAN) !=3D (elf_byte_order =3D=3D EL=
FDATA2LSB);

?

> +}
> +
>  static int sets_patch(struct object *obj)
>  {
>         Elf_Data *data =3D obj->efile.idlist;
>         int *ptr =3D data->d_buf;
>         struct rb_node *next;
> +       GElf_Ehdr ehdr;
> +
> +       if (gelf_getehdr(obj->efile.elf, &ehdr) =3D=3D NULL) {
> +               pr_err("FAILED cannot get ELF header: %s\n",
> +                       elf_errmsg(-1));
> +               return -1;
> +       }

calculate needs_bswap() once here?

>
>         next =3D rb_first(&obj->sets);
>         while (next) {
> -               unsigned long addr, idx;
> +               unsigned long addr, idx, flags;
>                 struct btf_id *id;
>                 int *base;
> -               int cnt;
> +               int cnt, i;
>
>                 id   =3D rb_entry(next, struct btf_id, rb_node);
>                 addr =3D id->addr[0];
> @@ -679,6 +692,24 @@ static int sets_patch(struct object *obj)
>
>                 qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(=
int), cmp_id);
>
> +               /*
> +                * When ELF endianness does not match endianness of the h=
ost,
> +                * libelf will do the translation when updating the ELF. =
This,
> +                * however, corrupts SET8 flags which are already in the =
target
> +                * endianness. So, let's bswap them to the host endiannes=
s and
> +                * libelf will then correctly translate everything.
> +                */
> +               if (id->is_set8 && need_bswap(ehdr.e_ident[EI_DATA])) {
> +                       for (i =3D 0; i < cnt; i++) {
> +                               /*
> +                                * header and entries are 8-byte, flags i=
s the
> +                                * second half of an entry
> +                                */
> +                               flags =3D idx + (i + 1) * 2 + 1;
> +                               ptr[flags] =3D bswap_32(ptr[flags]);

we are dealing with struct btf_id_set8, right? Can't we #include
include/linux/btf_ids.h and use that type for all these offset
calculations?..

I have the same question for existing code, tbh, so maybe there was
some good reason, not sure...

> +                       }
> +               }
> +
>                 next =3D rb_next(next);
>         }
>         return 0;
> --
> 2.43.0
>
>

