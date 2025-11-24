Return-Path: <bpf+bounces-75335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58910C806B9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DC034E4C99
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBEC3002A6;
	Mon, 24 Nov 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7jzVKAW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691A2FE584
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986486; cv=none; b=TXI1Dc8Hn9KVAashzPfvFUO+5jbhhyS2Hi04P20bpq/OP09xnCymBkA+gdHiQkcZCMvENoKNevBRiOiyuFa60GWi6R/8LdSMgk4yq4+5VN5rm86TEO2BTTKVviSF7OnS4sFx5qKN4yKpiRPK2HvvZpdAWcyzB1HaaGR+jwICY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986486; c=relaxed/simple;
	bh=33+zNkRvY4wagfQZLBALBVE1SwKVJQQNFifdWoyFOkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imiDejjD/hUAKncHO5GawnFxr5tt7AMWGkQPprPuC3XMk+9DKy6piO+8tUtcvBIWFCtPai0fvFDEynYwXTiopG9Qz2S1dm1a44vyDUrhwj0FsxXE+EH5/PVJ7U3pfxgc2h8oBxNzAC66uV34a0OeBHuPFynh8VPlwJKD41EMlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7jzVKAW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b713c7096f9so644278566b.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 04:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763986482; x=1764591282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+wZ2XtB8WOozaAIFhu6L5TvlD/Ho8ilDSwC7ipNw/A=;
        b=a7jzVKAWtFmyPNW7VgVvnVqazL6rbbrbBzBLl9MHhOMvxcJrdNrM191C/iVDfi+sBu
         uQEbhGoiNJNz6BLU0GEx6AiJXuyRvCiTQvXl03e9Ifus98cFJrgjElzzkdNsJdL6pOH8
         ANk1BglYSSidYecZYgB9Hyfpm+aBiI+HdLjtvl5eVJiP5ndF+pMp1Ri2JNwT1Dd/2dhf
         bU0q1+0h7XxpDGSnKlhbzDkrK2jYHgmy2HJZfGO17elIC1Z4NCzVqODBt2JLPkEslZuz
         QFM0UzSrkOhsHryilvGwVyD1J9VcMedDEOr//+0eCBVz1dR9yYTE4vJWIlt6QfVBCop/
         VvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763986482; x=1764591282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+wZ2XtB8WOozaAIFhu6L5TvlD/Ho8ilDSwC7ipNw/A=;
        b=TQ4OdV8XTBqqqEL448NF0DtNzuFmRASCK6Hz65BRxkK1hdFPOIYSYOZD8hjIQ9xMIY
         gMvyTd0MKzpE9ln2uL6AKrcHf9PtMKi/FxUclc5O1RfRIDG6iVu+CKr0yhPGlMvXMpuv
         uviXe33vpxBdhYRZL3h+SpUzgfIhCcZPKwIE6c7t4+gUShgMpP21pW7duRvhVNLtEE4/
         sgCYsevs+6CbUal8Ab1RyIIotbSvu3WPqo4d84C+wi4+BadNXVkv0EUHNSL/oQhtsNa3
         eyAkLCIS+e09K5Q77JM3Cp2N8GLntQnzMYZKhr1jjw8gzsRvMWHxyUdvquW/f7nLWzsU
         8JrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVof7TffU2UhmVpaRjgjb3mhOLhPyo4LgY7dBpsG64GqEjQIFW8T9bekaiZ4y3R0r5G8+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbtt4je6H/lAdyozQgmpvlSUId/Q3Gz+waCmw0UcY8oJhXL1t0
	J+ip9+XwZR5XbMMGnvvLELyAQsFrK+bi4rvJOHJeGfumkHjClRijV8xUI8kLj2ynM7U65ezhgI1
	0dZLYY2FN0dJJpAXyzpI2eABFypPLpMI=
X-Gm-Gg: ASbGncuYM1oYzsrcisFaY6j95WvAwSy8PKgoZIojMkwVYtg4wHg+U5Ey2KRqiPndFNW
	ERSROhSFZWTnQhE2XX96p9lU9lrSUJtq4DDmNBR5wmpHklWqkSP+bQxCb+ZI38GZGs1IKRJukNL
	H/DraOkhg7DBAa+KWKXqLwiyBsEpvKPS4IoaD1gSdFQa9gBPBTYYPQyEdLC/b11Bdm08ok5esxU
	CIELF/LljXYrIWwTJMt8QTli95oOCJAJVY3DxjWu6yQrtnrkt7fwEETcBYbYHxANlSsYvNN
X-Google-Smtp-Source: AGHT+IF+7ohZI4+Op+bel5kJzlaYJCoNPGaL19E0E8nDMig+yzOTXd7qPwYdsC2Z5byMRjddwE70q3vZBJBwvUZI2Cs=
X-Received: by 2002:a17:906:fe4e:b0:b73:4fd4:814f with SMTP id
 a640c23a62f3a-b76715ac4afmr1247521066b.21.1763986482237; Mon, 24 Nov 2025
 04:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-4-dolinux.peng@gmail.com> <7c04a6c3010ce41fc7ad0a6b26c94f43dde82593.camel@gmail.com>
In-Reply-To: <7c04a6c3010ce41fc7ad0a6b26c94f43dde82593.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 24 Nov 2025 20:14:28 +0800
X-Gm-Features: AWmQ_bnjZNCbMO8UWNOa9qpn7UN2K52BI9FDnTXDUhUChkyMG5VwzhfNTWO1Tns
Message-ID: <CAErzpmsgWK_RBv-DFa=jBvF8vqxUwU86yJhizXyYKc07k6Ys6w@mail.gmail.com>
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:18=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-11-19 at 11:15 +0800, Donglin Peng wrote:
>
> [...]
>
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
>                                   ^^^^^^^^^^^^^^^^
> This flag should be guarded by pahole version as well.  However, I'd
> suggest not adding this flag at all, but instead modify resolve_btfids
> to check for BTF_BASE_ELF_SEC section existence and acting accordingly.

Thanks, I will remove it in the next version.

>
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
>                                                                          =
     ^^^^^^^^^^
>                                              Agree with Ihor (and off-lis=
t discussion with Alexei),
>                                              this flag appears redundant.=
 Are there situations when
>                                              one would like to avoid sort=
ing kernel/module BTF?

Thanks, I will make sorting unconditional.

>
> >               $(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;             \
> >       fi;
>
> [...]
>
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids=
/main.c
> > index d47191c6e55e..dc0badd6f375 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
>
> [...]
>
> > +static int update_btf_section(const char *path, const struct btf *btf,
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
>
> `btf__raw_data()` can return NULL.

Thanks, I will fix it.

>
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
>
> [...]

