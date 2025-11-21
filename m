Return-Path: <bpf+bounces-75239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53622C7A972
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F162E349D2F
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24632D47E1;
	Fri, 21 Nov 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEYUNVE0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A42DC790
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739431; cv=none; b=lD2QpNA2Y3hWdARzBFR4X4U0awoQFMRBG7bsPIjn16XWp3MtGMq71iYRezpNUrnmIRSO9pm9wyeumof/RGhg06DqfqvNX1etvPJSfx7MjxhiXJA/kPkZKB1ZgNTcMQ++2hhwENsDPnuv9D4qWWD5AagVr1CJg3vJNpcbml6kydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739431; c=relaxed/simple;
	bh=2PmbohOF5Q74gGEFQbLTmt9H5YWfsP1DlIYjrSraWk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXQsashlWWDJKoSsaYBuKwg33cuqUwEcXUXUQTt3+6ZvtenNZNU0EhXDtYJ1kQntpIaVEUme6GfEvK2ArEfE3KgB3D2+PjnaZ0ZU2XJNyElBt+zzLUjuWMeBdYPyaPsm7iGG9yUMO0gRNRJyvNfKi06qj1xm95ghnMlhQKkhtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEYUNVE0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso2555087a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763739427; x=1764344227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV4X4h2RIMNsAciGrWRM00n4I6vK++3NmQB4ne1OCac=;
        b=JEYUNVE00Nlt4x39ylMKQ2o20tGZtWj/tM6epPX4VZMZrGxHUosmmtxtRKEfefQBpR
         DOMKjUjZH+gKzmF7ftCzWcSstAfGoT+HNtdLi/e1h6UCkh2Ojni3kINyHaXchzPOLgXF
         cYpN0fbScqPWSzy+zpwFufbcL7ScLAzsOOaZTG6W4Sa9fJpUEP7GL9/yfCcTNw6H0JBO
         y6HEhLImcwMNLKa8FhJYZWMhEOTDNAhO5/JvIUy9ar09hQbELaAHpiAOICpQS3v1WPCO
         uP+EmEvVp/MldSaQcWtiDnoaycbx3okjEl59t4pin7+NwCNo65gwkqW5Ga6/FnGYqdVF
         1u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763739427; x=1764344227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZV4X4h2RIMNsAciGrWRM00n4I6vK++3NmQB4ne1OCac=;
        b=iO4s9hrnCHEEREfcFr7GCLAHk2NtPfiWsaaCvG4Od2yxHoE8No3KILUp9RtCO4Rsa/
         4jfsTzgAkKK62ADk4VkGa4m+e6fqI+DNACj8Q7cvu6qE7PIMGklUpw4wPTJyfqnPzMlN
         Igpj8Q2Vl4FL0XMIKLuxBKVTNSUypfx7lglkkzFc8BspEMuKrCJp05+BFF1GUZ4WM5BQ
         4FGD7quJdd0Fi+OkR5VCeOLszlvbAb2p9TD45DZiqeONvhhfk8acDTR7HzVNW8uw4UF3
         VVkO4bzB/QMeeXfj16NATdpjw7i6D8awCedb1NLIfSIetk4jKjzN9VDKVhPmsjw7FxPc
         LuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMbnxmtfh0f4XiisTiv/7pNcx2moHiVSPbXdi0onwy58FO7OdZ01rWDk7eiSQVqevAOtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufvG4oUmh7da7i5UkskCcpQlA19dyXkzYngZi+2LpL04k5Rtj
	Bs4RaBLOR7piSv4ngo66Wtb5AABBcR9PlaWJYkJDsypN4KXgKgLjrdheXrv2s9hfZZzS7KnHYzg
	iz2lUbHIL7UdrMIXXCixdiWcOs0owico=
X-Gm-Gg: ASbGncteCeNcRG4iqLiVcKewwUIvmBI5N5c3rx1Kgk5xQhJCRvgVsHJAJcXjXmkiXYp
	IpT0t5h7msSXV4BM8R6GnOeG9qbJeaf/HI1/RII30GuAUMrwgjO2vZlAEmtkRyyW/FusMTy+gSz
	6uSdmlz6mNWWNKgS1IgE3JzG+tSDSA66BFa4H6H5XK37Z1G9Pfs6qVK7xDP4oV7ZM1HhmyBcxZn
	PKOIPuz1kTruOA9O3oOoeMfZYH6qSgVBeYNY/LpA8a0/emomPm0loUjyWt/qDnCG01EFwJEKDp+
	cDen0D8=
X-Google-Smtp-Source: AGHT+IGJI+XSmd20jjb9Yf88KbnCDN3idos7afRmmq3IOcECg7BkcdnjsqZgPQwv+EPgAb2Nhjf6nqs7ZPAJXNnl/aU=
X-Received: by 2002:a17:907:9811:b0:b73:1aba:2ebf with SMTP id
 a640c23a62f3a-b766ed83649mr396921566b.2.1763739427192; Fri, 21 Nov 2025
 07:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-4-dolinux.peng@gmail.com> <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
In-Reply-To: <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 21 Nov 2025 23:36:55 +0800
X-Gm-Features: AWmQ_bkL1Nu9K_11MUau_eVU25o8VJPOti6UJ2LJ2ZHgUaxzrVaTpJhUYl8VNOc
Message-ID: <CAErzpmvJ+D2c_3pLG-t5ZD2cj7kDJX=JDnJ0CxNUf5pYR24a+g@mail.gmail.com>
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 5:34=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 11/18/25 7:15 PM, Donglin Peng wrote:
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > This patch introduces a new --btf_sort option that leverages libbpf's
> > btf__permute interface to reorganize BTF layout. The implementation
> > sorts BTF types by name in ascending order, placing anonymous types at
> > the end to enable efficient binary search lookup.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  scripts/Makefile.btf            |   2 +
> >  scripts/Makefile.modfinal       |   1 +
> >  scripts/link-vmlinux.sh         |   1 +
> >  tools/bpf/resolve_btfids/main.c | 200 ++++++++++++++++++++++++++++++++
> >  4 files changed, 204 insertions(+)
> >
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index db76335dd917..d5eb4ee70e88 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -27,6 +27,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 130) +=3D=
 --btf_features=3Dattributes
> >
> >  ifneq ($(KBUILD_EXTMOD),)
> >  module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fea=
tures=3Ddistilled_base
> > +module-resolve_btfid-flags-y =3D --distilled_base
> >  endif
> >
> >  endif
> > @@ -35,3 +36,4 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)       =
       +=3D --lang_exclude=3Drust
> >
> >  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> >  export MODULE_PAHOLE_FLAGS :=3D $(module-pahole-flags-y)
> > +export MODULE_RESOLVE_BTFID_FLAGS :=3D $(module-resolve_btfid-flags-y)
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 542ba462ed3e..4481dda2f485 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -40,6 +40,7 @@ quiet_cmd_btf_ko =3D BTF [M] $@
> >               printf "Skipping BTF generation for %s due to unavailabil=
ity of vmlinux\n" $@ 1>&2; \
> >       else                                                            \
> >               LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) =
$(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> > +             $(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $(MODULE_RESOLVE_=
BTFID_FLAGS) --btf_sort $@;    \
> >               $(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;             \
> >       fi;
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 433849ff7529..f21f6300815b 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -288,6 +288,7 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
> >       if is_enabled CONFIG_WERROR; then
> >               RESOLVE_BTFIDS_ARGS=3D" --fatal_warnings "
> >       fi
> > +     ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} --btf_sort "${VMLINUX}"
> >       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
> >  fi
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids=
/main.c
> > index d47191c6e55e..dc0badd6f375 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -768,6 +768,195 @@ static int symbols_patch(struct object *obj)
> >       return err < 0 ? -1 : 0;
> >  }
> >
> > +/* Anonymous types (with empty names) are considered greater than name=
d types
> > + * and are sorted after them. Two anonymous types are considered equal=
. Named
> > + * types are compared lexicographically.
> > + */
> > +static int cmp_type_names(const void *a, const void *b, void *priv)
> > +{
> > +     struct btf *btf =3D (struct btf *)priv;
> > +     const struct btf_type *ta =3D btf__type_by_id(btf, *(__u32 *)a);
> > +     const struct btf_type *tb =3D btf__type_by_id(btf, *(__u32 *)b);
> > +     const char *na, *nb;
> > +
> > +     if (!ta->name_off && tb->name_off)
> > +             return 1;
> > +     if (ta->name_off && !tb->name_off)
> > +             return -1;
> > +     if (!ta->name_off && !tb->name_off)
> > +             return 0;
> > +
> > +     na =3D btf__str_by_offset(btf, ta->name_off);
> > +     nb =3D btf__str_by_offset(btf, tb->name_off);
> > +     return strcmp(na, nb);
> > +}
> > +
> > +static int update_btf_section(const char *path, const struct btf *btf,
>
> Hi Dongling.
>
> Thanks for working on this, it's a great optimization. Just want to
> give you a heads up that I am preparing a patchset changing
> resolve_btfids behavior.

Thanks. I'm curious about the new behavior of resolve_btfids. Does it
replace pahole and generate the sorted .BTF data directly from the
DWARF data? Also, does its sorting method differ from the cmp_type_names
approach mentioned above =E2=80=94 specifically, does it place named types
before all anonymous types? I'm asking because the search method
needs to be compatible with this sorting approach.

>
> In particular, instead of updating the .BTF_ids section (and now with
> your and upcoming changes the .BTF section) *in-place*, resolve_btfids
> will only emit the data for the sections. And then it'll be integrated
> into vmlinux with objcopy and linker. We already do a similar thing
> with .BTF for vmlinux [1].
>
> For your patchset it means that the parts handling ELF update will be
> unnecessary.
>
> Also I think the --btf_sort flag is unnecessary. We probably want
> kernel BTF to always be sorted in this way. And if resolve_btfids will
> be handling more btf2btf transformation, we should avoid adding a
> flags for every one of them.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree=
/scripts/link-vmlinux.sh#n110
>
>
> > +                               const char *btf_secname)
> > +{
> > +     GElf_Shdr shdr_mem, *shdr;
> > +     Elf_Data *btf_data =3D NULL;
> > +     Elf_Scn *scn =3D NULL;
> > +     Elf *elf =3D NULL;
> > +     const void *raw_btf_data;
> > +     uint32_t raw_btf_size;
> > +     int fd, err =3D -1;
> > +     size_t strndx;
> > +
> > +     fd =3D open(path, O_RDWR);
> > +     if (fd < 0) {
> > +             pr_err("FAILED to open %s\n", path);
> > +             return -1;
> > +     }
> > +
> > +     if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
> > +             pr_err("FAILED to set libelf version");
> > +             goto out;
> > +     }
> > +
> > +     elf =3D elf_begin(fd, ELF_C_RDWR, NULL);
> > +     if (elf =3D=3D NULL) {
> > +             pr_err("FAILED to update ELF file");
> > +             goto out;
> > +     }
> > +
> > +     elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
> > +
> > +     elf_getshdrstrndx(elf, &strndx);
> > +     while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
> > +             char *secname;
> > +
> > +             shdr =3D gelf_getshdr(scn, &shdr_mem);
> > +             if (shdr =3D=3D NULL)
> > +                     continue;
> > +             secname =3D elf_strptr(elf, strndx, shdr->sh_name);
> > +             if (strcmp(secname, btf_secname) =3D=3D 0) {
> > +                     btf_data =3D elf_getdata(scn, btf_data);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
> > +
> > +     if (btf_data) {
> > +             if (raw_btf_size !=3D btf_data->d_size) {
> > +                     pr_err("FAILED: size mismatch");
> > +                     goto out;
> > +             }
> > +
> > +             btf_data->d_buf =3D (void *)raw_btf_data;
> > +             btf_data->d_type =3D ELF_T_WORD;
> > +             elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > +
> > +             if (elf_update(elf, ELF_C_WRITE) >=3D 0)
> > +                     err =3D 0;
> > +     }
> > +
> > +out:
> > +     if (fd !=3D -1)
> > +             close(fd);
> > +     if (elf)
> > +             elf_end(elf);
> > +     return err;
> > +}
> > +
> > +static int sort_update_btf(struct object *obj, bool distilled_base)
> > +{
> > +     struct btf *base_btf =3D NULL;
> > +     struct btf *btf =3D NULL;
> > +     int start_id =3D 1, nr_types, id;
> > +     int err =3D 0, i;
> > +     __u32 *permute_ids =3D NULL, *id_map =3D NULL, btf_size;
> > +     const void *btf_data;
> > +     int fd;
> > +
> > +     if (obj->base_btf_path) {
> > +             base_btf =3D btf__parse(obj->base_btf_path, NULL);
> > +             err =3D libbpf_get_error(base_btf);
> > +             if (err) {
> > +                     pr_err("FAILED: load base BTF from %s: %s\n",
> > +                            obj->base_btf_path, strerror(-err));
> > +                     return -1;
> > +             }
> > +     }
> > +
> > +     btf =3D btf__parse_elf_split(obj->path, base_btf);
> > +     err =3D libbpf_get_error(btf);
> > +     if (err) {
> > +             pr_err("FAILED: load BTF from %s: %s\n", obj->path, strer=
ror(-err));
> > +             goto out;
> > +     }
> > +
> > +     if (base_btf)
> > +             start_id =3D btf__type_cnt(base_btf);
> > +     nr_types =3D btf__type_cnt(btf) - start_id;
> > +     if (nr_types < 2)
> > +             goto out;
> > +
> > +     permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
> > +     if (!permute_ids) {
> > +             err =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     id_map =3D calloc(nr_types, sizeof(*id_map));
> > +     if (!id_map) {
> > +             err =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
> > +             permute_ids[i] =3D id;
> > +
> > +     qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_nam=
es, btf);
> > +
> > +     for (i =3D 0; i < nr_types; i++) {
> > +             id =3D permute_ids[i] - start_id;
> > +             id_map[id] =3D i + start_id;
> > +     }
> > +
> > +     err =3D btf__permute(btf, id_map, nr_types, NULL);
> > +     if (err) {
> > +             pr_err("FAILED: btf permute: %s\n", strerror(-err));
> > +             goto out;
> > +     }
> > +
> > +     if (distilled_base) {
> > +             struct btf *new_btf =3D NULL, *distilled_base =3D NULL;
> > +
> > +             if (btf__distill_base(btf, &distilled_base, &new_btf) < 0=
) {
> > +                     pr_err("FAILED to generate distilled base BTF: %s=
\n",
> > +                             strerror(errno));
> > +                     goto out;
> > +             }
> > +
> > +             err =3D update_btf_section(obj->path, new_btf, BTF_ELF_SE=
C);
> > +             if (!err) {
> > +                     err =3D update_btf_section(obj->path, distilled_b=
ase, BTF_BASE_ELF_SEC);
> > +                     if (err < 0)
> > +                             pr_err("FAILED to update '%s'\n", BTF_BAS=
E_ELF_SEC);
> > +             } else {
> > +                     pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
> > +             }
> > +
> > +             btf__free(new_btf);
> > +             btf__free(distilled_base);
> > +     } else {
> > +             err =3D update_btf_section(obj->path, btf, BTF_ELF_SEC);
> > +             if (err < 0) {
> > +                     pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +out:
> > +     free(permute_ids);
> > +     free(id_map);
> > +     btf__free(base_btf);
> > +     btf__free(btf);
> > +     return err;
> > +}
> > +
> >  static const char * const resolve_btfids_usage[] =3D {
> >       "resolve_btfids [<options>] <ELF object>",
> >       NULL
> > @@ -787,6 +976,8 @@ int main(int argc, const char **argv)
> >               .sets     =3D RB_ROOT,
> >       };
> >       bool fatal_warnings =3D false;
> > +     bool btf_sort =3D false;
> > +     bool distilled_base =3D false;
> >       struct option btfid_options[] =3D {
> >               OPT_INCR('v', "verbose", &verbose,
> >                        "be more verbose (show errors, etc)"),
> > @@ -796,6 +987,10 @@ int main(int argc, const char **argv)
> >                          "path of file providing base BTF"),
> >               OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
> >                           "turn warnings into errors"),
> > +             OPT_BOOLEAN(0, "btf_sort", &btf_sort,
> > +                         "sort BTF by name in ascending order"),
> > +             OPT_BOOLEAN(0, "distilled_base", &distilled_base,
> > +                         "distill base"),
> >               OPT_END()
> >       };
> >       int err =3D -1;
> > @@ -807,6 +1002,11 @@ int main(int argc, const char **argv)
> >
> >       obj.path =3D argv[0];
> >
> > +     if (btf_sort) {
> > +             err =3D sort_update_btf(&obj, distilled_base);
> > +             goto out;
> > +     }
> > +
> >       if (elf_collect(&obj))
> >               goto out;
> >
>

