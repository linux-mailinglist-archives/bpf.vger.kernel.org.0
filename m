Return-Path: <bpf+bounces-76204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F1BCA9D58
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 02:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B8D3106D0E
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 01:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B71DFE26;
	Sat,  6 Dec 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaVZZv6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5F18FDBE
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983609; cv=none; b=EUtLlsauh6KVgwgGtduf6YwK7sCB/YH7HE2aaoNVMAUbQnISIir6LFUEwkU09TFkOx6qseLB39GUY2fd3k6dnDkonP4KV2POTfuocrBGm7S33ReGD12+XC+UVNqBSCbENR4Ki2LR3X6U3txhims+ZJ9OE+b+qXU6gj1J7NBOSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983609; c=relaxed/simple;
	bh=W5kU1n6uSp8A+JH6e8b+QRpK2tLG6/YaTCSrL040JN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHEgCHGz9nGHq6vvRxE5f6toBuqyeDvf62PbfMTc+JXVUhb88pT7hyrz9WjS1E20xpUtc2f7GugCmzeb7cAsN0pB8opEvxaHWFRE0QaMNmXs/08lNj97ab+Agl8v37bhbJxR+H/uL6C0YuVgquE4y7OsOlC/MD+YUF5hGOwE/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaVZZv6m; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34374febdefso2846562a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 17:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764983606; x=1765588406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z68OUMZBgB1uY9jdKvswq3rr8qFxHBBmcDabYYOcvxs=;
        b=JaVZZv6mIV3NhuuOE578OlrtiQkAd6BkC6y49Yc5SCp/ETNqVFIXnmmxYEQFNU/WeE
         CPYcf18SG5RKNVjndWKShsztnyGyy5J7yR+PhHZMsj9NS9WwNuj9NxD/ZYxWJNgVEJ0c
         rr0q+D52A3pDRrCLCeiU76Y6rLqcWziMw7oiSzNlomKxe6x6y8Wm2b5W7UG+QSH7fvNb
         lEamPTg65+EngFpC5Bhgz+hke33ebdNHtNyNj+s78q4hCbUsAYh9tHbT9doyk3QDkO7g
         /AxnxvmpbiJ33LRCTKg13m6/bqD1/7mHHlBRKlTR3fi5SUoBe1OKA+YJI89HMdbdB/zi
         x0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764983606; x=1765588406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z68OUMZBgB1uY9jdKvswq3rr8qFxHBBmcDabYYOcvxs=;
        b=bH4ZpmkSOQpSUuy5kqf0zho8Z+xoN431G36WhFYEs97m8CUbbTQzYCS4CR3mqEwTku
         NcRaAEP7eJu6wc7BmMv9buBWP4wBRiMb+cdy3+YshfBqDdy07GwXBIjjTzljjJhrlGSt
         ilQ5TTqXdJZwDzJGrJCVp6MrilhaQA95oGp4EHeFcXAfwBbKTDagtrMz+3Ueu7p9EElo
         g9M5WS9vecSf8q/3snjrHxOnjHd3qD9h2LvigeGXiHhNWNDwVzezZtlgiz2asSApjSlm
         MdWbHLzpwnFK53/u9LwFMBagdNY8ZIhxogi/rzwFQ+IXbGRkf+IMDTlJdpj9GEfn/yE+
         QtfA==
X-Forwarded-Encrypted: i=1; AJvYcCX4v3DvcfxoE/fwQP+4G8+kogNWkR8rdqpg6o/8QjVtUt8v2fm/MNFyTgBy/lR76VHOqPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0YRqYY3KFU8pfcwCTq9o2PWragxzZnCc/PprgFSKcLCLit8/
	4mvpih/v58Vd/0zNYTFh3L+aSzUfSotsFl94KsX1uN9VJM7BwvXy9S1kfSfNxJpZhpF/3onC0lg
	m2rICt7tlfE66/rvX7A+JCaE3h/sAdYk=
X-Gm-Gg: ASbGncuZxuLlwXKVL05Y0oTw56QbZC6+sbu3hduX4JA4bHr1wWWgxLMUkuvml1YUo9h
	Y5dVTyzpxqZUA7FMa0CPl72IE6gl+tXq89LtrMsiqFNlD+9n3W1WXa4HclW0WKEYhMz1hNkEuSh
	p5uxWVDG3rk+857Ojijf/URCF1RY4kwZvHiSC2Ckncx1h4o+B4g6oZQZHnN2Z3iNRt3gTjypevg
	MX12MJ1qZRzB5e4Ia3qwME8jv6Eoil4e+hYYidoo8MQ9r8DQByXtZ/FkFcwPPE3yshH7JVPH8fg
	z3CI74b3934=
X-Google-Smtp-Source: AGHT+IFMuHxzooHJbvnUeMqtntxZfPb32E9viLhFVZ/g9cS/FNw2LtctyLC+FykONEatAPMB6BAu+I3JHpsl652BgR4=
X-Received: by 2002:a17:90b:4ad1:b0:340:b06f:712e with SMTP id
 98e67ed59e1d1-349a259131emr653690a91.19.1764983606241; Fri, 05 Dec 2025
 17:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205223046.4155870-6-ihor.solodrai@linux.dev> <20251205223554.4159772-1-ihor.solodrai@linux.dev>
In-Reply-To: <20251205223554.4159772-1-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 17:13:12 -0800
X-Gm-Features: AWmQ_bnGc7gfHGnPBuDysP_CmsKDfU49GtmuL2qA49FW48jQcmICBXe_6Uc7ds8
Message-ID: <CAEf4BzYz9jBG7njY4Vsu53aspzfp+1B++SdY5zYya0Sq_PEP8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] resolve_btfids: change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:36=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Currently resolve_btfids updates .BTF_ids section of an ELF file
> in-place, based on the contents of provided BTF, usually within the
> same input file, and optionally a BTF base.
>
> Change resolve_btfids behavior to enable BTF transformations as part
> of its main operation. To achieve this, in-place ELF write in
> resolve_btfids is replaced with generation of the following binaries:
>   * ${1}.BTF with .BTF section data
>   * ${1}.BTF_ids with .BTF_ids section data if it existed in ${1}
>   * ${1}.BTF.base with .BTF.base section data for out-of-tree modules
>
> The execution of resolve_btfids and consumption of its output is
> orchestrated by scripts/gen-btf.sh introduced in this patch.
>
> The motivation for emitting binary data is that it allows simplifying
> resolve_btfids implementation by delegating ELF update to the $OBJCOPY
> tool [1], which is already widely used across the codebase.
>
> There are two distinct paths for BTF generation and resolve_btfids
> application in the kernel build: for vmlinux and for kernel modules.
>
> For the vmlinux binary a .BTF section is added in a roundabout way to
> ensure correct linking. The patch doesn't change this approach, only
> the implementation is a little different.
>
> Before this patch it worked as follows:
>
>   * pahole consumed .tmp_vmlinux1 [2] and added .BTF section with
>     llvm-objcopy [3] to it
>   * then everything except the .BTF section was stripped from .tmp_vmlinu=
x1
>     into a .tmp_vmlinux1.bpf.o object [2], later linked into vmlinux
>   * resolve_btfids was executed later on vmlinux.unstripped [4],
>     updating it in-place
>
> After this patch gen-btf.sh implements the following:
>
>   * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
>     raw BTF data
>   * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
>     (potentially modified) .BTF, and .BTF_ids sections data
>   * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
>     BTF output of resolve_btfids
>   * .BTF_ids data gets embedded into vmlinux.unstripped in
>     link-vmlinux.sh by objcopy --update-section
>
> For kernel modules, creating a special .bpf.o file is not necessary,
> and so embedding of sections data produced by resolve_btfids is
> straightforward with objcopy.
>
> With this patch an ELF file becomes effectively read-only within
> resolve_btfids, which allows deleting elf_update() call and satellite
> code (like compressed_section_fix [5]).
>
> Endianness handling of .BTF_ids data is also changed. Previously the
> "flags" part of the section was bswapped in sets_patch() [6], and then
> Elf_Type was modified before elf_update() to signal to libelf that
> bswap may be necessary. With this patch we explicitly bswap entire
> data buffer on load and on dump.
>
> [1] https://lore.kernel.org/bpf/131b4190-9c49-4f79-a99d-c00fac97fa44@linu=
x.dev/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/link-vmlinux.sh?h=3Dv6.18#n110
> [3] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c?h=3Dv1.31#n1803
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/link-vmlinux.sh?h=3Dv6.18#n284
> [5] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.org/
> [6] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  MAINTAINERS                                   |   1 +
>  scripts/Makefile.btf                          |  17 +-
>  scripts/Makefile.modfinal                     |   5 +-
>  scripts/Makefile.vmlinux                      |   2 +-
>  scripts/gen-btf.sh                            | 157 ++++++++++++
>  scripts/link-vmlinux.sh                       |  46 +---
>  tools/bpf/resolve_btfids/main.c               | 228 +++++++++++-------
>  tools/testing/selftests/bpf/.gitignore        |   3 +
>  tools/testing/selftests/bpf/Makefile          |   9 +-
>  .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
>  10 files changed, 338 insertions(+), 134 deletions(-)
>  create mode 100755 scripts/gen-btf.sh
>

Overall it looks good, but I'd like another pair of eyes on this :)
See some more minore nits below as well.

pw-bot: cr


> diff --git a/MAINTAINERS b/MAINTAINERS
> index e36689cd7cc7..fe6141c69708 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4673,6 +4673,7 @@ F:        net/sched/act_bpf.c
>  F:     net/sched/cls_bpf.c
>  F:     samples/bpf/
>  F:     scripts/bpf_doc.py
> +F:     scripts/gen-btf.sh
>  F:     scripts/Makefile.btf
>  F:     scripts/pahole-version.sh
>  F:     tools/bpf/
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 7c1cd6c2ff75..d067e91049cb 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -1,5 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +gen-btf-y                              =3D
> +gen-btf-$(CONFIG_DEBUG_INFO_BTF)       =3D $(srctree)/scripts/gen-btf.sh
> +
> +export GEN_BTF :=3D $(gen-btf-y)
> +

What's the point of GEN_BTF? It's just so that you don't have to have
$(srctree)/scripts/gen-btf.sh specified in three places? Between
obscure $(GEN_BTF) (and having to understand where it is set and how
it's exported) and explicit $(srctree)/scripts/gen-btf.sh in a few
places, I'd prefer the latter, as it is way more greppable and it's
not like we are going to rename or move this script frequently


>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
>  pahole-flags-y :=3D
>

[...]

> @@ -371,7 +348,7 @@ static int elf_collect(struct object *obj)
>
>         elf_version(EV_CURRENT);
>
> -       elf =3D elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
> +       elf =3D elf_begin(fd, ELF_C_READ_MMAP_PRIVATE, NULL);
>         if (!elf) {
>                 close(fd);
>                 pr_err("FAILED cannot create ELF descriptor: %s\n",
> @@ -434,21 +411,20 @@ static int elf_collect(struct object *obj)
>                         obj->efile.symbols_shndx =3D idx;
>                         obj->efile.strtabidx     =3D sh.sh_link;
>                 } else if (!strcmp(name, BTF_IDS_SECTION)) {
> +                       /*
> +                        * If target endianness differs from host, we nee=
d to bswap32
> +                        * the .BTF_ids section data on load, because .BT=
F_ids has
> +                        * Elf_Type =3D ELF_T_BYTE, and so libelf returns=
 data buffer in
> +                        * the target endiannes. We repeat this on dump.

gmail screams at me for "endianness"

> +                        */
> +                       if (obj->efile.encoding !=3D ELFDATANATIVE) {
> +                               pr_debug("bswap_32 .BTF_ids data from tar=
get to host endianness\n");
> +                               bswap_32_data(data->d_buf, data->d_size);

this looks like a violation of ELF_C_READ_MMAP_PRIVATE promise, no?...
would it be too create a copy here? for simplicity we can just always
malloc() a copy, regardless of bswap(), it can never be a huge amount
of data

> +                       }
>                         obj->efile.idlist       =3D data;
>                         obj->efile.idlist_shndx =3D idx;
>                         obj->efile.idlist_addr  =3D sh.sh_addr;
> -               } else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
> -                       /* If a .BTF.base section is found, do not resolv=
e
> -                        * BTF ids relative to vmlinux; resolve relative
> -                        * to the .BTF.base section instead.  btf__parse_=
split()
> -                        * will take care of this once the base BTF it is
> -                        * passed is NULL.
> -                        */
> -                       obj->base_btf_path =3D NULL;
>                 }
> -
> -               if (compressed_section_fix(elf, scn, &sh))
> -                       return -1;
>         }
>
>         return 0;
> @@ -552,6 +528,13 @@ static int symbols_collect(struct object *obj)
>         return 0;
>  }
>
> +static inline bool is_envvar_set(const char *var_name)
> +{
> +       const char *value =3D getenv(var_name);
> +
> +       return value && value[0] !=3D '\0';
> +}
> +

leftovers?

>  static int load_btf(struct object *obj)
>  {
>         struct btf *base_btf =3D NULL, *btf =3D NULL;
> @@ -578,6 +561,19 @@ static int load_btf(struct object *obj)
>         obj->base_btf =3D base_btf;
>         obj->btf =3D btf;
>
> +       if (obj->base_btf && obj->distill_base) {
> +               err =3D btf__distill_base(obj->btf, &base_btf, &btf);
> +               if (err) {
> +                       pr_err("FAILED to distill base BTF: %s\n", strerr=
or(errno));
> +                       goto out_err;
> +               }
> +
> +               btf__free(obj->btf);
> +               btf__free(obj->base_btf);
> +               obj->btf =3D btf;
> +               obj->base_btf =3D base_btf;
> +       }
> +
>         return 0;
>
>  out_err:

[...]

> +static int dump_raw_btf_ids(struct object *obj, const char *out_path)
> +{
> +       Elf_Data *data =3D obj->efile.idlist;
> +       int fd, err;
> +
> +       if (!data || !data->d_buf) {
> +               pr_debug("%s has no BTF_ids data to dump\n", obj->path);
> +               return 0;
> +       }
> +
> +       /*
> +        * If target endianness differs from host, we need to bswap32 the
> +        * .BTF_ids section data before dumping so that the output is in
> +        * target endianness.
> +        */
> +       if (obj->efile.encoding !=3D ELFDATANATIVE) {
> +               pr_debug("bswap_32 .BTF_ids data from host to target endi=
anness\n");
> +               bswap_32_data(data->d_buf, data->d_size);

same about modifying ELF data in-place for what is supposed to be read-only=
 use

> +       }
> +
> +       err =3D dump_raw_data(out_path, data->d_buf, data->d_size);
> +       if (err)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int dump_raw_btf(struct btf *btf, const char *out_path)
> +{
> +       const void *raw_btf_data;
> +       u32 raw_btf_size;
> +       int fd, err;
> +
> +       raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
> +       if (!raw_btf_data) {
> +               pr_err("btf__raw_data() failed\n");
> +               return -1;
> +       }

did you check that libbpf does proper byte swap as well?

> +
> +       err =3D dump_raw_data(out_path, raw_btf_data, raw_btf_size);
> +       if (err)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static inline int make_out_path(char *buf, const char *in_path, const ch=
ar *suffix)
> +{
> +       int len =3D snprintf(buf, PATH_MAX, "%s%s", in_path, suffix);

nit: normally you pass buffer and its size as input arguments instead
of assuming and hard-coding common PATH_MAX constant in two separate
places

> +
> +       if (len < 0 || len >=3D PATH_MAX) {
> +               pr_err("Output path is too long: %s%s\n", in_path, suffix=
);
> +               return -E2BIG;
>         }
>
> -       pr_debug("update %s for %s\n",
> -                err >=3D 0 ? "ok" : "failed", obj->path);
> -       return err < 0 ? -1 : 0;
> +       return 0;
>  }
>
>  static const char * const resolve_btfids_usage[] =3D {

[...]

