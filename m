Return-Path: <bpf+bounces-28390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D28B8F2F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C720283885
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A11384B1;
	Wed,  1 May 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl7XS+ad"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6E17C9B
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585661; cv=none; b=GHnuSUhvAdOenxc2AAZpTWsemr2ZFNSCdN3Cyds2pjARZUD0vUfXwGTJnCrlEY0+tVs3JQKMt/unlDhJHbLhYEvgbg9ZQbFFyfT/w0+dLyX+LOdT52ol7I58nt+bN3SK35NUBDhps5OeKwDBHR6WusvsGJBWftHi1Z8yRhDwcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585661; c=relaxed/simple;
	bh=B+Gfe1Xs52Y383atXVPCOaxDyHwFFSwZbN5oT2//qMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUeZRfBBpesU22pyDBLo0t7vgMXSip4EcJJBzxyok5ZaGt+YpV4VqexX4OWthNy5SLuX0D1cRq5doxvx691DP4N2h8gGqv2PJnNhpE51A5jI2nS7KzZnD/7I9rXvh6GuCIZLhaxPmcrmUBik0kLTdpwpmr/4fb+BMxdYJSxp/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl7XS+ad; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed112c64beso6507657b3a.1
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714585659; x=1715190459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtxACFHJ+F2YnGXqYruZ969IMDLYr4bqrpZVvTj2yXA=;
        b=Sl7XS+ad49ctJMFp6Tcpu6vJACVLQavA3ggql6F5Ne8T0B5ynb5A7bmhHYyRLQEWb6
         QY/y1gEn99vCHheK3Ji2I0NITzRbZIKJP/srRCq8AHx7Lcnhe+T8Sv856/CDm3co6eSl
         18/Ir0LlcNToLjIr2OZD7sSNBNYpav86rygPrlgdiyp5YvAbDzdN9J86bDwcfcP5eKj5
         PvjfreyIZTcMM9bUIPaEZYYvoyHnN32ERcriOfRRI4jRKItQ3OrVte2bXMxUEXlu2bvo
         mTDWN17kB/D2J2hVv86b8OGqOtC2J5TEx4YGPnRBT0Y3WAqccfR4zUo8KtQJ26eJqY9h
         QPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585659; x=1715190459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtxACFHJ+F2YnGXqYruZ969IMDLYr4bqrpZVvTj2yXA=;
        b=KqOiKEmThpD67i6b+M1nbSTaa6Eoi2f5uYRGO2oA6rirxkaSxpiWJ1fG+DuA95ay4d
         aJlYTN3Q3Rw4NUzvhVDwARzNfhNHviWktgu4YrVK9WPFN5jTCMC26bZLPNfiia1wCDKR
         hx51V5Fn/mAep1HToiwiCtdXrYyC38fMT72L7tQ+HZUYKYFe7wXyNJSNOVSg+GnomFnk
         6ts2DXv99WHmAchkakdkOHFk2KjiU+/cig/dd8UUEGrIcVG1TzpmnaMDuW6ORilJyAqZ
         6nF0r0eXgRVnbQM9tJBjll/07Ajmt8x0UaJdO2eXiQLZHCFuglylUwQ4bCa2Jp++YGTz
         9liQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL1ZrbXmnMY9nGCaI9EV2xYBKsSuTXdy8706KMpL0+oqp8HLQrIQItBmnijKkS/Xq1DsnK4EcUERmy8MFFFfB5it1i
X-Gm-Message-State: AOJu0YwkZ8hK78SxFi1voKBbST/DLB6Dl+FA5vJneBP2THbS0Nke48B4
	zeeqaMZm4cfYvmdGUmgesry0fAQJVpQB+7hEeTtRJMFsBg2xJGy2PnUSRljaGfw8mLpt6bQRFJc
	VSH3yQqRIFWqszlFpDqymctpmn0Y=
X-Google-Smtp-Source: AGHT+IGXev+lYc4PeezP7pUUNN6tVXkcsb5VxW/tDB7Xmli/QdDMthzFM7xvqAQ9AzJrHPrR6l1DjdGpinSVDRZlW0c=
X-Received: by 2002:a05:6a21:338f:b0:1af:66aa:f968 with SMTP id
 yy15-20020a056a21338f00b001af66aaf968mr4389280pzb.20.1714585658631; Wed, 01
 May 2024 10:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-5-alan.maguire@oracle.com> <CAEf4Bzau4J3UHKzz2QJgZsSSqCx=BxkG=Zf+SZXm5ESgzpcrHw@mail.gmail.com>
 <6831c4a0-9653-459a-a227-62daecc5c55f@oracle.com>
In-Reply-To: <6831c4a0-9653-459a-a227-62daecc5c55f@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 10:47:26 -0700
Message-ID: <CAEf4Bza8ip1VAsk28e1E7BJHG9z12PMifFxYSO+vvjvwfTbNtg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 10:43=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 30/04/2024 00:40, Andrii Nakryiko wrote:
> > On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Options cover existing parsing scenarios (ELF, raw, retrieving
> >> .BTF.ext) and also allow specification of the ELF section name
> >> containing BTF.  This will allow consumers to retrieve BTF from
> >> .BTF.base sections (BTF_BASE_ELF_SEC) also.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c      | 50 ++++++++++++++++++++++++++++-----------=
-
> >>  tools/lib/bpf/btf.h      | 32 +++++++++++++++++++++++++
> >>  tools/lib/bpf/libbpf.map |  1 +
> >>  3 files changed, 68 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index 419cc4fa2e86..9036c1dc45d0 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -1084,7 +1084,7 @@ struct btf *btf__new_split(const void *data, __u=
32 size, struct btf *base_btf)
> >>         return libbpf_ptr(btf_new(data, size, base_btf));
> >>  }
> >>
> >> -static struct btf *btf_parse_elf(const char *path, struct btf *base_b=
tf,
> >> +static struct btf *btf_parse_elf(const char *path, const char *btf_se=
c, struct btf *base_btf,
> >>                                  struct btf_ext **btf_ext)
> >>  {
> >>         Elf_Data *btf_data =3D NULL, *btf_ext_data =3D NULL;
> >> @@ -1146,7 +1146,7 @@ static struct btf *btf_parse_elf(const char *pat=
h, struct btf *base_btf,
> >>                                 idx, path);
> >>                         goto done;
> >>                 }
> >> -               if (strcmp(name, BTF_ELF_SEC) =3D=3D 0) {
> >> +               if (strcmp(name, btf_sec) =3D=3D 0) {
> >>                         btf_data =3D elf_getdata(scn, 0);
> >>                         if (!btf_data) {
> >>                                 pr_warn("failed to get section(%d, %s)=
 data from %s\n",
> >> @@ -1166,7 +1166,7 @@ static struct btf *btf_parse_elf(const char *pat=
h, struct btf *base_btf,
> >>         }
> >>
> >>         if (!btf_data) {
> >> -               pr_warn("failed to find '%s' ELF section in %s\n", BTF=
_ELF_SEC, path);
> >> +               pr_warn("failed to find '%s' ELF section in %s\n", btf=
_sec, path);
> >>                 err =3D -ENODATA;
> >>                 goto done;
> >>         }
> >> @@ -1212,12 +1212,12 @@ static struct btf *btf_parse_elf(const char *p=
ath, struct btf *base_btf,
> >>
> >>  struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext=
)
> >>  {
> >> -       return libbpf_ptr(btf_parse_elf(path, NULL, btf_ext));
> >> +       return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, NULL, btf_e=
xt));
> >>  }
> >>
> >>  struct btf *btf__parse_elf_split(const char *path, struct btf *base_b=
tf)
> >>  {
> >> -       return libbpf_ptr(btf_parse_elf(path, base_btf, NULL));
> >> +       return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, base_btf, N=
ULL));
> >>  }
> >>
> >>  static struct btf *btf_parse_raw(const char *path, struct btf *base_b=
tf)
> >> @@ -1293,7 +1293,8 @@ struct btf *btf__parse_raw_split(const char *pat=
h, struct btf *base_btf)
> >>         return libbpf_ptr(btf_parse_raw(path, base_btf));
> >>  }
> >>
> >> -static struct btf *btf_parse(const char *path, struct btf *base_btf, =
struct btf_ext **btf_ext)
> >> +static struct btf *btf_parse(const char *path, const char *btf_elf_se=
c, struct btf *base_btf,
> >> +                            struct btf_ext **btf_ext)
> >>  {
> >>         struct btf *btf;
> >>         int err;
> >> @@ -1301,23 +1302,42 @@ static struct btf *btf_parse(const char *path,=
 struct btf *base_btf, struct btf_
> >>         if (btf_ext)
> >>                 *btf_ext =3D NULL;
> >>
> >> -       btf =3D btf_parse_raw(path, base_btf);
> >> -       err =3D libbpf_get_error(btf);
> >> -       if (!err)
> >> -               return btf;
> >> -       if (err !=3D -EPROTO)
> >> -               return ERR_PTR(err);
> >> -       return btf_parse_elf(path, base_btf, btf_ext);
> >> +       if (!btf_elf_sec) {
> >> +               btf =3D btf_parse_raw(path, base_btf);
> >> +               err =3D libbpf_get_error(btf);
> >> +               if (!err)
> >> +                       return btf;
> >> +               if (err !=3D -EPROTO)
> >> +                       return ERR_PTR(err);
> >> +       }
> >> +       if (!btf_elf_sec)
> >> +               btf_elf_sec =3D BTF_ELF_SEC;
> >> +
> >> +       return btf_parse_elf(path, btf_elf_sec, base_btf, btf_ext);
> >
> > nit: btf_elf_sec ?: BTF_ELF_SEC
> >
>
> sure, will fix.
>
> >
> >> +}
> >> +
> >> +struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *=
opts)
> >> +{
> >> +       struct btf *base_btf;
> >> +       const char *btf_sec;
> >> +       struct btf_ext **btf_ext;
> >> +
> >> +       if (!OPTS_VALID(opts, btf_parse_opts))
> >> +               return libbpf_err_ptr(-EINVAL);
> >> +       base_btf =3D OPTS_GET(opts, base_btf, NULL);
> >> +       btf_sec =3D OPTS_GET(opts, btf_sec, NULL);
> >> +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> >> +       return libbpf_ptr(btf_parse(path, btf_sec, base_btf, btf_ext))=
;
> >>  }
> >>
> >>  struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
> >>  {
> >> -       return libbpf_ptr(btf_parse(path, NULL, btf_ext));
> >> +       return libbpf_ptr(btf_parse(path, NULL, NULL, btf_ext));
> >>  }
> >>
> >>  struct btf *btf__parse_split(const char *path, struct btf *base_btf)
> >>  {
> >> -       return libbpf_ptr(btf_parse(path, base_btf, NULL));
> >> +       return libbpf_ptr(btf_parse(path, NULL, base_btf, NULL));
> >>  }
> >>
> >>  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, boo=
l swap_endian);
> >> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> >> index 025ed28b7fe8..94dfdfdef617 100644
> >> --- a/tools/lib/bpf/btf.h
> >> +++ b/tools/lib/bpf/btf.h
> >> @@ -18,6 +18,7 @@ extern "C" {
> >>
> >>  #define BTF_ELF_SEC ".BTF"
> >>  #define BTF_EXT_ELF_SEC ".BTF.ext"
> >> +#define BTF_BASE_ELF_SEC ".BTF.base"
> >
> > Does libbpf code itself use this? If not, let's get rid of it.
> >
>
> We could, but I wonder would there be value to keeping it around as
> multiple consumers need to agree on this name (pahole, resolve_btfids,
> bpftool)?

Ok, I can see how it might be a bit more generic thing beyond just
kernel use, let's keep it then.

>
> >>  #define MAPS_ELF_SEC ".maps"
> >>
> >>  struct btf;
> >> @@ -134,6 +135,37 @@ LIBBPF_API struct btf *btf__parse_elf_split(const=
 char *path, struct btf *base_b
> >>  LIBBPF_API struct btf *btf__parse_raw(const char *path);
> >>  LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct =
btf *base_btf);
> >>
> >> +struct btf_parse_opts {
> >> +       size_t sz;
> >> +       /* use base BTF to parse split BTF */
> >> +       struct btf *base_btf;
> >> +       /* retrieve optional .BTF.ext info */
> >> +       struct btf_ext **btf_ext;
> >> +       /* BTF section name */
> >
> > let's mention that if not set, libbpf will default to trying to parse
> > data as raw BTF, and then will fallback to .BTF in ELF. If it is set
> > to non-NULL, we'll assume ELF and use that section to fetch BTF data.
> >
>
> sure, will do.
>
> >> +       const char *btf_sec;
> >> +       size_t:0;
> >
> > nit: size_t :0; (consistency)
> >
> >> +};
> >> +
> >> +#define btf_parse_opts__last_field btf_sec
> >> +
> >> +/* @brief **btf__parse_opts()** parses BTF information from either a
> >> + * raw BTF file (*btf_sec* is NULL) or from the specified BTF section=
,
> >> + * also retrieving  .BTF.ext info if *btf_ext* is non-NULL.  If
> >> + * *base_btf* is specified, use it to parse split BTF from the
> >> + * specified location.
> >> + *
> >> + * @return new BTF object instance which has to be eventually freed w=
ith
> >> + * **btf__free()**
> >> + *
> >> + * On error, error-code-encoded-as-pointer is returned, not a NULL. T=
o extract
> >
> > this is false, we don't encode error as pointer anymore. starting from
> > v1.0 it's always NULL + errno.
> >
>
> ah good catch, I must have cut-and-pasted this..
>
> Thanks again for all the review help!
>
> Alan
>
> >> + * error code from such a pointer `libbpf_get_error()` should be used=
. If
> >> + * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NUL=
L is
> >> + * returned on error instead. In both cases thread-local `errno` vari=
able is
> >> + * always set to error code as well.
> >> + */
> >> +
> >> +LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_p=
arse_opts *opts);
> >> +
> >>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
> >>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, =
struct btf *vmlinux_btf);
> >>
> >> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> >> index c4d9bd7d3220..a9151e31dfa9 100644
> >> --- a/tools/lib/bpf/libbpf.map
> >> +++ b/tools/lib/bpf/libbpf.map
> >> @@ -421,6 +421,7 @@ LIBBPF_1.5.0 {
> >>         global:
> >>                 bpf_program__attach_sockmap;
> >>                 btf__distill_base;
> >> +               btf__parse_opts;
> >>                 ring__consume_n;
> >>                 ring_buffer__consume_n;
> >>  } LIBBPF_1.4.0;
> >> --
> >> 2.31.1
> >>

